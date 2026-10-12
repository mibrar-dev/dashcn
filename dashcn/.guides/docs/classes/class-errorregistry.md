---
title: "Class: ErrorRegistry"
description: "A mutable [ErrorRule] list features can register into at runtime."
---

```dart
/// A mutable [ErrorRule] list features can register into at runtime.
class ErrorRegistry {
  /// Creates a registry, optionally seeded with [rules].
  ErrorRegistry({List<ErrorRule>? rules});
  /// An unmodifiable view of the registered rules.
  List<ErrorRule> get rules;
  /// Registers one rule.
  void add(ErrorRule rule);
  /// Registers several rules.
  void addAll(Iterable<ErrorRule> rules);
  /// Removes every rule.
  void clear();
}
```
