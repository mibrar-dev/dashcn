---
title: "Class: ColorHistoryStorage"
description: "In-memory store of recently used colours, listenable for changes."
---

```dart
/// In-memory store of recently used colours, listenable for changes.
///
/// Provide one with [RecentColorsScope], then read it with
/// [ColorHistoryStorage.of] from a builder below the scope.
abstract class ColorHistoryStorage implements Listenable {
  /// Adds [color] to the front of the history (most-recent first).
  ///
  /// A colour already present moves to the front instead of duplicating.
  void addHistory(Color color);
  /// Replaces the whole history (clamped to [capacity]).
  void setHistory(List<Color> colors);
  /// Removes every colour.
  void clear();
  /// Maximum number of stored colours.
  int get capacity;
  /// Colours, most-recent first.
  List<Color> get recentColors;
  /// The nearest storage above [context]; throws when absent.
  static ColorHistoryStorage of(BuildContext context);
}
```
