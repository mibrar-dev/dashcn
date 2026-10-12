---
title: "Class: FilterMatchers"
description: "The built-in matcher factories."
---

```dart
/// The built-in matcher factories.
abstract class FilterMatchers {
  /// `candidate == selected`.
  static FilterMatcher<T> exact<T>();
  /// Substring match; case-insensitive by default.
  static FilterMatcher<String> contains({bool caseSensitive = false});
  /// SQL-LIKE match: `%` is any run, `_` one character.
  static FilterMatcher<String> like({bool caseSensitive = false});
  /// Prefix match; case-insensitive by default.
  static FilterMatcher<String> startsWith({bool caseSensitive = false});
  /// Suffix match; case-insensitive by default.
  static FilterMatcher<String> endsWith({bool caseSensitive = false});
  /// Membership in a stored collection.
  static FilterMatcher<Iterable<T>> anyOf<T>();
  /// Membership in a stored set.
  static FilterMatcher<Set<T>> inSet<T>();
  /// `candidate > selected`. A candidate of another type never matches (the
  /// old check accepted any `Comparable<Object>` and threw when the runtime
  /// types differed, e.g. an int selection against a String candidate).
  static FilterMatcher<T> greaterThan<T extends Comparable<Object>>();
  /// `candidate < selected`; see [greaterThan] for the type guard.
  static FilterMatcher<T> lessThan<T extends Comparable<Object>>();
}
```
