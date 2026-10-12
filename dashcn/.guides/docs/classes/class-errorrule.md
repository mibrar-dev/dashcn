---
title: "Class: ErrorRule"
description: "One mapping rule; rules are tried in descending [priority]."
---

```dart
/// One mapping rule; rules are tried in descending [priority].
class ErrorRule {
  /// Creates a mapping rule.
  const ErrorRule({required this.matches, required this.build, this.priority = 0});
  /// Predicate.
  final ErrorMatch matches;
  /// Factory.
  final ErrorBuild build;
  /// Higher runs first.
  final int priority;
}
```
