---
title: "Class: Account02Data"
description: "Values submitted by [Account02]."
---

```dart
/// Values submitted by [Account02].
class Account02Data {
  /// Creates the submitted values.
  const Account02Data({required this.email, required this.push, required this.quietHours, required this.weeklyDigest});
  /// Per-channel email preferences, keyed by channel label.
  final Map<String, bool> email;
  /// Per-channel push preferences, keyed by channel label.
  final Map<String, bool> push;
  /// Whether quiet hours are on.
  final bool quietHours;
  /// Whether the weekly digest is on.
  final bool weeklyDigest;
  String toString();
}
```
