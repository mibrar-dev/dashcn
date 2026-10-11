// An expandable metaball surface: a compact pill that morphs into an expanded
// body, with autopilot timing and hover/press interaction. Carved from the
// presentation half of the old `_GooeyToastState` in `overlay/gooey_toast`;
// the per-frame composition lives in `gooey_frame.dart`, the content pieces in
// `gooey_content.dart` and the silhouette in `gooey_shape.dart`.
//
// The surface knows nothing about toasts: it takes resolved content, styles
// and colours plus a timing policy, and reports expansion and interaction back
// to whoever hosts it. This file owns the public configuration; the state
// machine is `gooey_surface_state.dart`.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import 'gooey_content.dart';
import 'gooey_frame.dart';
import 'gooey_surface_state.dart';

/// Compact pill height; the pill never changes size with content.
const double kGooeySurfacePillHeight = 40;

/// Metaball blur sigma as a fraction of the roundness.
const double kGooeyBlurRatio = 0.5;

///
/// Expansion is driven by hover/press, by a tap on the pill and — when
/// [expandDelay] / [collapseDelay] are set — by an autopilot timer. The
/// component owns the queue and supplies resolved content, styles and colours.
class GooeySurface extends StatefulWidget {
  /// Creates a gooey surface.
  const GooeySurface({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.morphKey,
    required this.leading,
    this.description,
    this.descriptionStyle,
    this.body,
    this.action,
    this.expandable = true,
    this.width = 350,
    this.fill = const ThemedColor.ref(ColorRef.popover),
    this.fillAlpha = 1,
    this.roundness = 18,
    this.compactAlignment = Alignment.centerLeft,
    this.expandUp = false,
    this.enableGooeyBlur = true,
    this.surfaceBlur = 0,
    this.openDuration = const Duration(milliseconds: 600),
    this.openCurve = Curves.easeInOutCubic,
    this.bodyAnimation = GooeySurfaceBodyAnimation.fade,
    this.expandDelay,
    this.collapseDelay,
    this.pauseOnHover = true,
    this.shadows = const <BoxShadow>[],
    this.contentKey,
    this.compactMorph = const GooeyCompactMorph(),
    this.onInteractionChanged,
    this.onExpansionChanged,
  });

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

  @override
  State<GooeySurface> createState() => GooeySurfaceState();
}
