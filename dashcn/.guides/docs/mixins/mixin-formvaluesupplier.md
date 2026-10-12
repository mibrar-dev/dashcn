---
title: "Mixin: FormValueSupplier"
description: "Adds form participation to a `State`."
---

```dart
/// Adds form participation to a `State`.
///
/// Mix into the state of any widget that owns a form value. The mixin keeps the
/// value, registers with the nearest [FormFieldHandle] provided by a form, and
/// applies replacements when validation returns a [ReplaceResult].
///
/// Implementations only need [didReplaceFormValue]; read [formValue] to render
/// the current value and assign to it to push changes.
mixin FormValueSupplier<T, X extends StatefulWidget> on State<X> {
  /// The value currently reported to the form.
  T? get formValue;
  /// Sets the value and reports it, unless it is unchanged.
  set formValue(T? value);
  /// Called when validation returned a [ReplaceResult] for the current value.
  ///
  /// Runs after the current frame so the widget is safe to rebuild in.
  void didReplaceFormValue(T value);
  void didChangeDependencies();
}
```
