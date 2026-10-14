---
title: "Class: AdaptiveScaler"
description: "Applies [scaling] to the ambient theme for its subtree."
---

```dart
/// Applies [scaling] to the ambient theme for its subtree.
class AdaptiveScaler extends StatelessWidget {
  const AdaptiveScaler({super.key, required this.scaling, required this.child});
  /// Mobile scaling on iOS/Android, desktop elsewhere.
  static AdaptiveScaling defaultScalingOf(BuildContext context);
  /// Mobile scaling on iOS/Android, desktop elsewhere.
  static AdaptiveScaling defaultScaling(ThemeData theme);
  final AdaptiveScaling scaling;
  final Widget child;
  Widget build(BuildContext context);
}
```
