---
title: "Class: RuleBasedErrorMapper"
description: "Tries [rules] in priority order, then [fallback]."
---

```dart
/// Tries [rules] in priority order, then [fallback].
class RuleBasedErrorMapper implements ErrorMapper {
  /// Creates a rule-based mapper.
  RuleBasedErrorMapper({required List<ErrorRule> rules, required this.fallback});
  /// Rules, sorted by priority.
  final List<ErrorRule> rules;
  /// Used when no rule matches.
  final AppError Function(Object error, StackTrace? stackTrace) fallback;
  AppError map(Object error, [StackTrace? stackTrace]);
}
```
