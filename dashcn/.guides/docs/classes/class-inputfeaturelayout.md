---
title: "Class: InputFeatureLayout"
description: "Widgets/actions/shortcuts contributed by a field's visible features."
---

```dart
/// Widgets/actions/shortcuts contributed by a field's visible features.
class InputFeatureLayout {
  /// Creates a layout slice.
  const InputFeatureLayout({required this.leading, required this.trailing, required this.actions, required this.shortcuts});
  /// Leading widgets (focus traversal already applied).
  final List<Widget> leading;
  /// Trailing widgets (focus traversal already applied).
  final List<Widget> trailing;
  /// Actions contributed by features.
  final Map<Type, Action<Intent>> actions;
  /// Shortcuts contributed by features.
  final Map<ShortcutActivator, Intent> shortcuts;
}
```
