---
title: "Extension: FilterStateExtensions"
description: "Value helpers on [FilterState] (readability, counting, typed access)."
---

```dart
/// Value helpers on [FilterState] (readability, counting, typed access).
extension FilterStateExtensions on FilterState {
  /// Whether anything is filtered.
  bool get hasActiveFilters;
  /// How many filters are active (search, sort, date, chips, custom values).
  int get activeFilterCount;
  /// Returns a copy without the chip identified by [chipKey].
  FilterState withoutChip(String chipKey);
  /// Returns a copy with the parts selected by [policy] reset.
  FilterState cleared({FilterClearPolicy policy = const FilterClearPolicy()});
  /// The custom value stored under [key], or null when absent/mistyped.
  T? customValue<T>(String key);
  /// Stores [value] under [key]; inactive values remove the key.
  FilterState setCustomValue(String key, Object? value);
  /// The value selected for [field], or null.
  T? valueOf<T>(FilterField<T> field);
  /// Selects [value] for [field] (null clears it).
  FilterState setValue<T>(FilterField<T> field, T? value);
  /// The active matcher id of [field], falling back to its default/first.
  String? matcherIdOf<T>(FilterField<T> field);
  /// Selects a matcher id for [field]; unknown ids and empty option lists
  /// leave the state unchanged (the old code returned a copy that stored
  /// nothing).
  FilterState setMatcherIdOf<T>(FilterField<T> field, String? matcherId);
  /// The active matcher option of [field], or null when it has none.
  FilterMatcherOption<T>? matcherOptionOf<T>(FilterField<T> field);
  /// The matcher that applies to [field]: the selected option or [FilterField.matcher].
  FilterMatcher<T>? matcherOf<T>(FilterField<T> field);
  /// Whether [candidate] passes [field]'s active selection (unset matches all).
  bool matchesValue<T>(FilterField<T> field, Object? candidate);
  /// Whether [model] passes every binding.
  bool matchesModel<TModel>(TModel model, Iterable<FilterBinding<TModel>> bindings);
  /// The items of [source] that pass every binding.
  Iterable<TModel> whereMatches<TModel>(Iterable<TModel> source, Iterable<FilterBinding<TModel>> bindings);
}
```
