---
title: "Class: InputHintFeature"
description: "Shows a hint popover, optionally bound to F1."
---

```dart
/// Shows a hint popover, optionally bound to F1.
class InputHintFeature extends InputIconFeature {
  /// Creates a hint button.
  const InputHintFeature({required this.popupBuilder, super.position, super.visibility, this.icon, this.enableShortcuts = true});
  /// Builds the hint popover content.
  final WidgetBuilder popupBuilder;
  /// Custom icon; defaults to `LucideIcons.info`.
  final Widget? icon;
  /// Whether F1 opens the hint.
  final bool enableShortcuts;
  Widget buildIcon(BuildContext context);
  void onPressed(InputFeatureState state, BuildContext context);
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts(InputFeatureState state);
  Iterable<MapEntry<Type, Action<Intent>>> buildActions(InputFeatureState state);
  void dispose(InputFeatureState state);
}
```
