---
title: "Class: TypedFilterBinding"
description: "A binding that reads a value out of the model and matches it through a  [FilterField]."
---

```dart
/// A binding that reads a value out of the model and matches it through a
/// [FilterField].
class TypedFilterBinding<TModel, TValue> extends FilterBinding<TModel> {
  /// Creates a typed binding.
  const TypedFilterBinding({required this.field, required this.selector});
  /// Field holding the selected value.
  final FilterField<TValue> field;
  /// Reads the candidate value from the model.
  final TValue? Function(TModel model) selector;
  bool matches(FilterState state, TModel model);
}
```
