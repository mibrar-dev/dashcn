---
title: "Class: GooeyToastOptions"
description: "Content and behaviour of one gooey toast."
---

```dart
/// Content and behaviour of one gooey toast.
///
/// The toast lifecycle is: enter as a compact pill, morph open after the
/// autopilot expand delay, stay expanded until the collapse delay, collapse
/// back to the pill, then leave when the `duration` expires (6s by default).
/// Hover, press or focus pauses the countdown; swipe in the slot's dismiss
/// direction, the close button, Escape while focused, or
/// `GooeyToastController.dismiss` dismisses early. A `loading` toast never
/// expands; show one, await the work, then show the settled state with
/// [GooeyToastNewToastBehavior.transition] for the promise pattern.
class GooeyToastOptions {
  /// Creates toast options.
  const GooeyToastOptions({required this.title, this.description, this.state = GooeyToastState.success, this.position = GooeyToastPosition.center, this.expandDirection = GooeyToastExpandDirection.bottom, this.duration, this.icon, this.stateTag, this.compactChild, this.expandedChild, this.action, this.autopilot = const GooeyAutopilot(), this.persistUntilDismissed = false, this.animationStyle, this.shapeStyle, this.bodyAnimationStyle, this.width, this.roundness, this.compactMorph, this.onExpansionChanged});
  final String title;
  final String? description;
  final GooeyToastState state;
  /// Horizontal anchor; `center` renders at the top-center window edge with
  /// the default expand direction.
  final GooeyToastPosition position;
  final GooeyToastExpandDirection expandDirection;
  final Duration? duration;
  final IconData? icon;
  /// Identity of the compact content: change it (with the same toast id) to
  /// morph the pill instead of replacing the toast.
  final Object? stateTag;
  /// Custom compact row replacing the default icon + title.
  final Widget? compactChild;
  final Widget? expandedChild;
  final GooeyToastAction? action;
  /// Auto expand/collapse policy; null leaves expansion to interaction.
  final GooeyAutopilot? autopilot;
  final bool persistUntilDismissed;
  /// Open/close profile override; falls back to the theme, then `sileo`.
  final GooeyToastAnimationStyle? animationStyle;
  /// Corner profile override; falls back to the theme, then `defaultShape`.
  final GooeyToastShapeStyle? shapeStyle;
  /// Body content profile override; falls back to the theme, then `fade`.
  final GooeyToastBodyAnimationStyle? bodyAnimationStyle;
  /// Surface width override; falls back to the theme, then `350`.
  final double? width;
  /// Base roundness override; falls back to the theme, then `18`.
  final double? roundness;
  /// Compact morph override; falls back to the theme, then the default.
  final GooeyCompactMorph? compactMorph;
  /// Called with `true` when the body starts opening and `false` when closed.
  final ValueChanged<bool>? onExpansionChanged;
}
```
