---
title: "Class: GooeyToastPayload"
description: "Reference for GooeyToastPayload"
---

```dart
class GooeyToastPayload {
  /// Creates a payload.
  const GooeyToastPayload({required this.id, required this.title, required this.state, required this.position, required this.expandDirection, required this.showDirection, required this.duration, required this.width, required this.roundness, required this.animationStyle, required this.shapeStyle, required this.bodyAnimationStyle, required this.compactMorph, required this.persistUntilDismissed, required this.fill, this.stateTag, this.description, this.icon, this.compactChild, this.expandedChild, this.action, this.autopilot, this.onExpansionChanged});
  /// Stable id of the toast this payload belongs to.
  final String id;
  /// Identity of the compact content; changing it morphs the pill in place.
  final Object? stateTag;
  final String title;
  final String? description;
  final GooeyToastState state;
  final GooeyToastPosition position;
  final GooeyToastExpandDirection expandDirection;
  /// Text direction of the show context, so an RTL layout mirrors the anchor.
  ///
  /// Captured at show time: the toast's overlay entry lives above every
  /// `Directionality` in the caller's subtree, so it cannot inherit theirs.
  final TextDirection showDirection;
  final Duration duration;
  final IconData? icon;
  final Widget? compactChild;
  final Widget? expandedChild;
  final GooeyToastAction? action;
  final double width;
  final double roundness;
  final GooeyAutopilot? autopilot;
  final GooeyToastAnimationStyle animationStyle;
  final GooeyToastShapeStyle shapeStyle;
  final GooeyToastBodyAnimationStyle bodyAnimationStyle;
  final GooeyCompactMorph compactMorph;
  final bool persistUntilDismissed;
  final ThemedColor fill;
  final ValueChanged<bool>? onExpansionChanged;
  /// Screen placement this payload anchors to.
  ToastPlacement get placement;
  /// Whether the body grows upwards.
  bool get expandUp;
  /// Whether the expanded body has anything to show.
  bool get hasBody;
  /// Copies with the given fields replaced; a nullable field is wiped only when
  /// it is explicitly passed as `null`, so `replace(description: null)` clears
  /// it while `replace()` keeps everything.
  GooeyToastPayload replace({Object? stateTag = _kUnset, String? title, GooeyToastState? state, Duration? duration, Object? description = _kUnset, Object? expandedChild = _kUnset, Object? action = _kUnset, Object? autopilot = _kUnset, Object? onExpansionChanged = _kUnset, GooeyCompactMorph? compactMorph, bool? persistUntilDismissed});
}
```
