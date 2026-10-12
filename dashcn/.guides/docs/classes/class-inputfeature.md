---
title: "Class: InputFeature"
description: "One piece of input behaviour or decoration."
---

```dart
/// One piece of input behaviour or decoration.
abstract class InputFeature {
  /// Creates a feature.
  const InputFeature({this.visibility = InputFeatureVisibility.always, this.skipFocusTraversal = true});
  /// When the feature is shown.
  final InputFeatureCondition visibility;
  /// Whether the feature is skipped in focus traversal.
  final bool skipFocusTraversal;
  /// Leading widgets contributed while visible.
  Iterable<Widget> buildLeading(InputFeatureState state, BuildContext context);
  /// Trailing widgets contributed while visible.
  Iterable<Widget> buildTrailing(InputFeatureState state, BuildContext context);
  /// Wraps the decorated field (above/below and suggestion-menu features).
  Widget wrap(InputFeatureState state, Widget child);
  /// Called after the field text changes.
  void onTextChanged(InputFeatureState state, String text);
  /// Called the first time the field takes focus after a rebuild, and again
  /// whenever it regains focus.
  ///
  /// A feature whose content depends on the current text (a suggestion list,
  /// a validation preview) needs this: `onTextChanged` never fires for a field
  /// that starts out with text, nor for one the user focuses without typing.
  void onFocusGained(InputFeatureState state);
  /// Keyboard shortcuts contributed by this feature.
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts(InputFeatureState state);
  /// Actions contributed by this feature.
  Iterable<MapEntry<Type, Action<Intent>>> buildActions(InputFeatureState state);
  /// Called when the input is disposed or this feature is removed; dispose
  /// slot state (controllers) here.
  void dispose(InputFeatureState state);
  /// Whether [newFeature] can replace [oldFeature] without losing its slot.
  static bool canUpdate(InputFeature oldFeature, InputFeature newFeature);
}
```
