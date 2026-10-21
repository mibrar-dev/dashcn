// The `skeleton` component: a widgets-only loading placeholder with a
// repeating shimmer, replacing `package:skeletonizer` (banned).
//
// Shape placeholders ([SkeletonLine], [SkeletonAvatar]) render the shimmer
// in text-line and avatar shapes; composed placeholders ([SkeletonCard],
// [SkeletonList], [SkeletonTable]) cover card, list and table loading
// states; [SkeletonMirror] sizes a placeholder from the real child's box.
// All sizes come from the density scale (compact default), the sweep uses
// theme tokens and the theme motion legs, and reduced motion parks the
// sweep with no ticker.

import 'package:flutter/widgets.dart';

import '../../primitives/animation.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'skeleton_style.dart';

export 'skeleton_compose.dart';
export 'skeleton_layout.dart';
export 'skeleton_mirror.dart';
export 'skeleton_shapes.dart';
export 'skeleton_style.dart';
export 'skeleton_table.dart';

/// A shimmering placeholder shown while [child] is still loading.
///
/// The widget keeps the child's layout box, so swapping it in and out never
/// moves the surrounding page:
///
/// ```dart
/// Skeleton(
///   enabled: loading,
///   child: Text('Summary'),
/// );
/// ```
class Skeleton extends StatelessWidget {
  /// Creates a skeleton placeholder.
  const Skeleton({
    super.key,
    required this.child,
    this.enabled = true,
    this.borderRadius,
    this.theme,
    this.style,
    this.densityTokens,
    this.semanticsLabel,
  });

  /// The real content, laid out but painted only while [enabled] is false.
  final Widget child;

  /// Whether the placeholder is shown. A disabled skeleton paints [child].
  final bool enabled;

  /// Corner radius override; null uses `SkeletonTheme.borderRadius` and then
  /// the theme's `borderRadiusMd`.
  final BorderRadiusGeometry? borderRadius;

  /// Widget-leg theme override, merged on top of the other legs.
  final SkeletonTheme? theme;

  /// Per-instance style override; merged over [theme].
  final SkeletonStyle? style;

  /// Per-instance density tokens. Null resolves through the component theme
  /// legs then the ambient `ThemeData.densityTokens`; phone widths use touch
  /// unless this is set.
  final DensityTokens? densityTokens;

  /// Accessible label for the loading placeholder; null reads the locale `announcementLoading`.
  /// Set to null + `excludeSemantics` behaviour by passing empty? Null
  /// keeps the default label so screen readers announce the pending state.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final SkeletonTheme base =
        resolveComponentStyle<SkeletonTheme, SkeletonTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: skeletonDefaults,
        );
    final SkeletonTheme resolved = (style ?? const SkeletonTheme()).merge(base);
    final BorderRadius radius =
        (borderRadius ?? resolved.borderRadius ?? _defaultRadius(context))
            .resolve(Directionality.of(context));
    if (!enabled) {
      return ClipRRect(borderRadius: radius, child: child);
    }
    // Motion legs: the sweep duration scales with the theme intensity and
    // the curve falls back to the motion standard curve, so the Theme
    // Studio intensity picker retimes the shimmer with the rest of the kit.
    final ThemeData ambient = Theme.of(context);
    final Duration baseDuration = resolved.duration ?? kSkeletonSweepDuration;
    final Duration duration = ambient.motion.scaledDuration(baseDuration);
    final Curve curve = resolved.curve ?? ambient.motion.curves.standard;
    return Semantics(
      label:
          semanticsLabel ??
          ComponentLocalizations.of(context).announcementLoading,
      child: _Shimmer(
        from: resolved.fromColor,
        to: resolved.toColor,
        duration: motionReduced(context) ? Duration.zero : duration,
        curve: curve,
        borderRadius: radius,
        child: child,
      ),
    );
  }

  BorderRadius _defaultRadius(BuildContext context) {
    return Theme.of(context).borderRadiusMd;
  }
}

/// Repaints a sweeping gradient over [child] until the skeleton is replaced.
class _Shimmer extends StatelessWidget {
  const _Shimmer({
    required this.child,
    required this.borderRadius,
    required this.from,
    required this.to,
    required this.duration,
    required this.curve,
  });

  final Widget child;
  final BorderRadius borderRadius;
  final ThemedColor? from;
  final ThemedColor? to;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color fromColor = from?.resolve(theme.colors) ?? theme.colors.muted;
    final Color toColor = to?.resolve(theme.colors) ?? theme.colors.accent;
    final BoxDecoration staticDecoration = BoxDecoration(
      gradient: _sweep(fromColor, toColor, 0.5),
    );
    // Under reduced motion the sweep parks mid-way with no ticker.
    if (motionReduced(context) || duration == Duration.zero) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Container(decoration: staticDecoration, child: child),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: RepeatedAnimationBuilder(
        start: 0,
        end: 1,
        duration: duration,
        curve: curve,
        builder: (context, value, child) => Container(
          decoration: BoxDecoration(
            gradient: _sweep(fromColor, toColor, value),
          ),
          child: child,
        ),
        child: child,
      ),
    );
  }

  /// Sweep gradient for progress [value] (0..1).
  LinearGradient _sweep(Color fromColor, Color toColor, double value) {
    return LinearGradient(
      begin: Alignment(-1 - 2 * (1 - value), -1),
      end: Alignment(1 + 2 * (1 - value), 1),
      colors: <Color>[fromColor, toColor, fromColor],
      stops: const <double>[
        kSkeletonSweepHandover - kSkeletonSweepFade,
        kSkeletonSweepHandover,
        kSkeletonSweepHandover + kSkeletonSweepFade,
      ],
    );
  }
}
