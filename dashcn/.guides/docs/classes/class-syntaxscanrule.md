---
title: "Class: SyntaxScanRule"
description: "Reference for SyntaxScanRule"
---

```dart
class SyntaxScanRule {
  const SyntaxScanRule(this.pattern, this.kind);
  /// The pattern to match.
  final RegExp pattern;
  /// The kind assigned to every match.
  final SyntaxTokenKind kind;
}
```
