// The bridge between a field widget and the form controller.
//
// `FormEntry` publishes the [FormFieldHandle] that value-supplier widgets
// (input, checkbox, star rating, object form field, ...) report into, wires the
// field to the nearest controller and owns the per-field validity listenable
// that error builders read.
//
// The entry also owns the difference between "mounted with a value" and "the
// user changed the value": the first report of a field's life is not an edit,
// so the field stays in the controller's silent `initial` mode until a later
// report changes the value. That is what keeps a fresh form free of errors.
//
// Ported from the old `form` component's `FormEntry` + `FormEntryState`; the
// old two-system `SharedFormHandleAdapter` is gone because `form_core` is the
// single handle type now.

import 'dart:async';

import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import 'form_controller.dart';
import 'form_core.dart';
import 'validation.dart';

/// Attaches one field ([key] + [validator]) to the nearest form.
///
/// A `FormEntry` publishes itself as `Data<FormFieldHandle>`; value suppliers
/// below it (like `Input`) find it and report values, which run [validator]
/// through the controller and surface through the entry's `validity`.
class FormEntry<T> extends StatefulWidget {
  /// Creates a form entry for [key].
  const FormEntry({
    required FormKey<T> super.key,
    this.validator,
    required this.child,
  });

  /// The field's identity and value type.
  @override
  FormKey<T> get key => super.key as FormKey<T>;

  /// Validation for this field; null fields are value-only.
  final Validator<T>? validator;

  /// The field subtree.
  final Widget child;

  @override
  State<FormEntry<T>> createState() => _FormEntryState<T>();
}

class _FormEntryState<T> extends State<FormEntry<T>> with FormFieldHandle {
  FormController? _controller;
  final ValueNotifier<ValidationResult?> _validity =
      ValueNotifier<ValidationResult?>(null);
  T? _value;

  /// The last value this field reported to the controller.
  Object? _reportedValue;
  bool _hasReported = false;

  /// Whether reports that arrive now count as user edits.
  ///
  /// A supplier reports once while it mounts, and a value a parent seeds in
  /// `build` lands in that same first frame; counting those as edits would
  /// make every field dirty before the user touched it. The flag flips in a
  /// post-frame callback, once the field is settled.
  bool _acceptsEdits = false;

  @override
  FormKey get formKey => widget.key;

  @override
  ValueListenable<ValidationResult?>? get validity => _validity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _acceptsEdits = true;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final FormController? controller = Data.maybeOf<FormController>(context);
    if (controller == _controller) {
      return;
    }
    _controller?.removeListener(_pullValidity);
    _controller?.detach(this);
    _controller = controller;
    _controller?.addListener(_pullValidity);
    if (controller != null) {
      controller.attach(context, this, _value, widget.validator);
      _pullValidity();
    } else {
      _validity.value = null;
    }
  }

  @override
  void didUpdateWidget(covariant FormEntry<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.validator != oldWidget.validator) {
      _controller?.attach(context, this, _value, widget.validator);
      _pullValidity();
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_pullValidity);
    _controller?.detach(this);
    _validity.dispose();
    super.dispose();
  }

  void _pullValidity() {
    // The controller already decides what may be shown (an untouched field
    // stays silent), so the entry only mirrors that decision.
    _validity.value = _controller?.getDisplayError(widget.key);
  }

  @override
  FutureOr<ValidationResult?> reportNewFormValue<X>(X? value) {
    if (widget.key.type != X) {
      // A nested supplier with a different value type belongs to an enclosing
      // entry; forward the report instead of overwriting this field's value.
      final FormFieldHandle? parent = Data.maybeFind<FormFieldHandle>(context);
      if (parent != null && parent != this) {
        return parent.reportNewFormValue<X>(value);
      }
      return null;
    }
    // The first report of a field's life is the value it starts with, not an
    // edit; only a later report that actually changes the value is one.
    final bool edit = _acceptsEdits && _hasReported && _reportedValue != value;
    _hasReported = true;
    _reportedValue = value;
    _value = value as T?;
    final FormController? controller = _controller;
    if (controller == null) {
      return null;
    }
    return controller.attach(
      context,
      this,
      _value,
      widget.validator,
      dirty: edit,
    );
  }

  @override
  FutureOr<ValidationResult?> revalidate() {
    final FormController? controller = _controller;
    if (controller == null) {
      return null;
    }
    return controller.attach(
      context,
      this,
      _value,
      widget.validator,
      mode: FormValidationMode.submitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Data<FormFieldHandle>.inherit(data: this, child: widget.child);
  }
}
