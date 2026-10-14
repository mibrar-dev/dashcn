---
title: "Class: RecentColorsScope"
description: "Provides a [ColorHistoryStorage] to descendants."
---

```dart
/// Provides a [ColorHistoryStorage] to descendants.
class RecentColorsScope extends StatefulWidget {
  /// Creates a scope.
  const RecentColorsScope({super.key, this.initialRecentColors = const <Color>[], this.maxRecentColors = 50, this.onRecentColorsChanged, required this.child});
  /// Seed colours.
  final List<Color> initialRecentColors;
  /// Maximum stored colours.
  final int maxRecentColors;
  /// Called whenever the list changes.
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  /// Content below the scope.
  final Widget child;
  State<RecentColorsScope> createState();
}
```
