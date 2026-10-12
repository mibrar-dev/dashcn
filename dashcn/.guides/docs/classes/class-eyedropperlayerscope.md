---
title: "Class: EyeDropperLayerScope"
description: "Eye-dropper sessions managed by an [EyeDropperLayer]."
---

```dart
/// Eye-dropper sessions managed by an [EyeDropperLayer].
abstract class EyeDropperLayerScope {
  /// Prompts the user to pick a colour from the wrapped subtree.
  ///
  /// Completes with the sampled colour, or null when the session is cancelled
  /// (Escape). When [historyStorage] is given the colour is also pushed to it.
  Future<Color?> promptPickColor([ColorHistoryStorage? historyStorage]);
  /// Finds the outermost [EyeDropperLayerScope] above [context].
  static EyeDropperLayerScope findRoot(BuildContext context);
  /// Finds the nearest [EyeDropperLayerScope] above [context].
  static EyeDropperLayerScope find(BuildContext context);
}
```
