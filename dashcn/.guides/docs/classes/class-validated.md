---
title: "Class: Validated"
description: "Wraps a field with its own validator and exposes the result to [builder]."
---

```dart
/// Wraps a field with its own validator and exposes the result to [builder].
///
/// Creates a private controller, so it works without an enclosing `FormScope`
/// (the old `validated` component wrapped a local `FormScope`; this is equivalent
/// without the extra widget).
class Validated<T> extends StatefulWidget {
  /// Creates a validated field.
  const Validated({super.key, required this.builder, required this.validator, this.child});
  /// Builds the field from its validation result.
  final ValidatedBuilder builder;
  /// The field's validator.
  final Validator<T> validator;
  /// The field subtree.
  final Widget? child;
  State<Validated<T>> createState();
}
```
