---
title: "Class: FormController"
description: "Coordinates every field inside a `FormScope`."
---

```dart
/// Coordinates every field inside a `FormScope`.
///
/// Fields attach when they mount (through `FormEntry`), report values, run
/// their validators and detach when they unmount. The controller never touches
/// widgets: it stores values, results and pending futures, and notifies
/// listeners after the current frame so validation started inside `build` is
/// safe.
class FormController extends ChangeNotifier {
  /// Called by [submit] after a successful validation.
  ///
  /// The `FormScope` widget installs its `onSubmit` callback here while attached.
  FormSubmitCallback? onSubmit;
  /// The nearest controller, or null outside a form.
  static FormController? maybeOf(BuildContext context);
  /// The nearest controller; asserts outside a form.
  static FormController of(BuildContext context);
  /// Current values of every attached field.
  FormMapValues get values;
  /// The latest validation result per field (may be a pending future).
  Map<FormKey, FutureOr<ValidationResult?>> get validities;
  /// Failures keyed by field; pending validations read as a [WaitingResult].
  Map<FormKey, ValidationResult> get errors;
  /// Validations still in flight, keyed by field.
  Map<FormKey, Future<ValidationResult?>> get pending;
  /// Whether no field currently reports a failure or a pending check.
  bool get isValid;
  /// The value stored for [key], or null when absent.
  T? getValue<T>(FormKey<T> key);
  /// Whether [key] has a non-null value.
  bool hasValue(FormKey key);
  /// The latest result for [key], pending future included.
  FutureOr<ValidationResult?>? getError(FormKey key);
  /// The synchronous result for [key]; a pending check reads as waiting.
  ValidationResult? getSyncError(FormKey key);
  /// Registers [handle] with [value] and runs [validator].
  ///
  /// The first attach uses [FormValidationMode.initial], later value reports
  /// use `changed`, and [mode] overrides both (revalidation uses `submitted`).
  /// Fields whose validators declare a dependency on this key re-run too.
  FutureOr<ValidationResult?> attach(BuildContext context, FormFieldHandle handle, Object? value, Validator<Object?>? validator, {FormValidationMode? mode});
  /// Removes [handle] and its validation state.
  void detach(FormFieldHandle handle);
  /// Re-runs every attached validator.
  void revalidateAll(BuildContext context, {FormValidationMode mode = FormValidationMode.submitted});
  /// Revalidates everything, awaits pending checks and reports the outcome.
  ///
  /// Calls [onSubmit] with the values when the form is valid.
  Future<SubmissionResult> submit(BuildContext context);
  void dispose();
}
```
