---
title: "Class: GooeySurface"
description: "Expansion is driven by hover/press, by a tap on the pill and — when  [expandDelay] / [collapseDelay] are set — by an autopilot timer."
---

```dart
///
/// Expansion is driven by hover/press, by a tap on the pill and — when
/// [expandDelay] / [collapseDelay] are set — by an autopilot timer. The
/// component owns the queue and supplies resolved content, styles and colours.
class GooeySurface extends StatefulWidget {
  /// Creates a gooey surface.
  const GooeySurface({super.key, required this.title, required this.titleStyle, required this.morphKey, required this.leading, this.description, this.descriptionStyle, this.body, this.action, this.expandable = true, this.width = 350, this.fill = const ThemedColor.ref(ColorRef.popover), this.fillAlpha = 1, this.roundness = 18, this.compactAlignment = Alignment.centerLeft, this.expandUp = false, this.enableGooeyBlur = true, this.surfaceBlur = 0, this.openDuration = const Duration(milliseconds: 600), this.openCurve = Curves.easeInOutCubic, this.bodyAnimation = GooeySurfaceBodyAnimation.fade, this.expandDelay, this.collapseDelay, this.pauseOnHover = true, this.shadows = const <BoxShadow>[], this.contentKey, this.compactMorph = const GooeyCompactMorph(), this.onInteractionChanged, this.onExpansionChanged});
  final String title;
  final TextStyle titleStyle;
  /// Identity of the compact content, so title/state changes morph.
  final Object morphKey;
  /// Leading widget (state icon).
  final Widget? leading;
  final String? description;
  final TextStyle? descriptionStyle;
  final Widget? body;
  final Widget? action;
  /// Whether the body may expand; `false` keeps the pill shut.
  final bool expandable;
  final double width;
  /// Surface fill; resolves per build, so a preset switch restyles it.
  final ThemedColor fill;
  /// Whole-surface opacity.
  final double fillAlpha;
  final double roundness;
  /// Horizontal alignment of the compact pill.
  final Alignment compactAlignment;
  /// Whether the body grows upwards instead of downwards.
  final bool expandUp;
  /// Whether the metaball blur pass runs.
  final bool enableGooeyBlur;
  /// Backdrop blur sigma clipped to the silhouette.
  final double surfaceBlur;
  /// Open/close animation duration.
  final Duration openDuration;
  /// Open/close animation curve.
  final Curve openCurve;
  /// Body content animation profile.
  final GooeySurfaceBodyAnimation bodyAnimation;
  /// Delay before the autopilot expands the body; `null` disables it.
  final Duration? expandDelay;
  /// Delay before the autopilot collapses the body; `null` disables it.
  final Duration? collapseDelay;
  /// Whether hover/press pauses an enclosing toast countdown.
  final bool pauseOnHover;
  /// Token shadows under the silhouette (first layer's colour); empty: none.
  final List<BoxShadow> shadows;
  /// Identity of the current content for change detection.
  ///
  /// `body`/`action` widgets are rebuilt by callers on every build, so
  /// comparing them by identity reschedules the autopilot on no-op rebuilds
  /// (pushing collapse later, or re-expanding after a collapse). When either
  /// side sets a key, only the key plus the stable fields below drive
  /// rescheduling; otherwise the legacy widget-identity comparison applies.
  final Object? contentKey;
  /// Compact morph profile for in-place title/state changes.
  final GooeyCompactMorph compactMorph;
  /// Called when hover/press starts or stops, for the pause policy.
  final ValueChanged<bool>? onInteractionChanged;
  /// Called with `true` when the surface starts opening, `false` when closed.
  final ValueChanged<bool>? onExpansionChanged;
  State<GooeySurface> createState();
}
```
