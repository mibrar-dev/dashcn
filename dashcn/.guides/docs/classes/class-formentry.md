---
title: "Class: FormEntry"
description: "Attaches one field ([key] + [validator]) to the nearest form."
---

```dart
/// Attaches one field ([key] + [validator]) to the nearest form.
///
/// A `FormEntry` publishes itself as `Data<FormFieldHandle>`; value suppliers
/// below it (like `Input`) find it and report values, which run [validator]
/// through the controller and surface through the entry's `validity`.
class FormEntry<T> extends StatefulWidget {
  /// Creates a form entry for [key].
  const FormEntry({required FormKey<T> super.key, this.validator, required this.child});
  /// The field's identity and value type.
  FormKey<T> get key;
  /// Validation for this field; null fields are value-only.
  final Validator<T>? validator;
  /// The field subtree.
  final Widget child;
  State<FormEntry<T>> createState();
}
```
