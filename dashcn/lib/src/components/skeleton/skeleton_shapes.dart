// Shape placeholders for the `skeleton` component: [SkeletonBlock],
// [SkeletonLine] and [SkeletonAvatar].
//
// Each shape renders the shared shimmer sweep in the geometry of the real
// content (text lines, avatar) so loading states match content size. Sizes
// come from the density scale (compact default); every size is overridable
// per instance or through `SkeletonTheme`.

import 'package:flutter/widgets.dart';

import '../../primitives/localizations/localizations.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'skeleton.dart';

/// Builds one line bar of [SkeletonLine]; return a custom widget to swap
/// the default rounded bar (e.g. a pill or a square tile).
typedef SkeletonLineBuilder =
    Widget Function(
      BuildContext context,
      int index,
      bool isLast,
      Widget defaultBar,
    );

/// A generic rounded-box placeholder with an explicit size.
class SkeletonBlock extends StatelessWidget {
  /// Creates a block placeholder.
  const SkeletonBlock({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.theme,
    this.style,
    this.densityTokens,
    this.semanticsLabel,
    this.blockBuilder,
  });

  /// Box width; null fills the available width.
  final double? width;

  /// Box height; null uses one density body step (14 compact).
  final double? height;

  /// Corner radius override; null uses the theme leg then `radiusMd`.
  final BorderRadiusGeometry? borderRadius;

  /// Widget-leg theme override.
  final SkeletonTheme? theme;

  /// Per-instance style override, merged over [theme].
  final SkeletonStyle? style;

  /// Per-instance density tokens.
  final DensityTokens? densityTokens;

  /// Accessible label; null reads the locale `announcementLoading`.
  final String? semanticsLabel;

  /// Custom builder for the block; receives the default shimmer box.
  final Widget Function(BuildContext context, Widget defaultBlock)?
  blockBuilder;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final SkeletonTheme resolved = resolveSkeletonTheme(
      context,
      widgetTheme: theme,
      style: style,
    );
    final DensityTokens tokens = resolveSkeletonTokens(
      context,
      override:
          densityTokens ??
          theme?.themeDensityTokens ??
          style?.themeDensityTokens,
      widgetTheme: theme,
    );
    final double h = height ?? tokens.bodyTextSize * ambient.scaling;
    final Widget box = Skeleton(
      borderRadius: borderRadius,
      theme: resolved,
      densityTokens: tokens,
      semanticsLabel: semanticsLabel,
      child: SizedBox(width: width, height: h, child: const SizedBox.expand()),
    );
    return blockBuilder?.call(context, box) ?? box;
  }
}

/// A multi-line text placeholder: stacked rounded bars.
///
/// The last line renders short ([lastLineFraction]) like real copy:
///
/// ```dart
/// const SkeletonLine(lines: 3);
/// ```
class SkeletonLine extends StatelessWidget {
  /// Creates a text-line placeholder.
  const SkeletonLine({
    super.key,
    this.lines = 2,
    this.lastLineFraction = 0.6,
    this.lineHeight,
    this.lineGap,
    this.borderRadius,
    this.theme,
    this.style,
    this.densityTokens,
    this.semanticsLabel,
    this.lineBuilder,
  }) : assert(lines > 0, 'lines must be greater than zero'),
       assert(
         lastLineFraction > 0 && lastLineFraction <= 1,
         'lastLineFraction must be in (0, 1]',
       );

  /// Number of bars; single-line renders at full width.
  final int lines;

  /// Width fraction of the last bar (0, 1]; ignored for a single line.
  final double lastLineFraction;

  /// Bar height override; null uses the density body step.
  final double? lineHeight;

  /// Gap between bars; null uses the density gap.
  final double? lineGap;

  /// Corner radius override; null uses the theme leg then `radiusMd`.
  final BorderRadiusGeometry? borderRadius;

  /// Widget-leg theme override.
  final SkeletonTheme? theme;

  /// Per-instance style override, merged over [theme].
  final SkeletonStyle? style;

  /// Per-instance density tokens.
  final DensityTokens? densityTokens;

  /// Accessible label; null reads the locale `announcementLoading`.
  final String? semanticsLabel;

  /// Custom builder for each bar; receives the default shimmer bar.
  final SkeletonLineBuilder? lineBuilder;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final SkeletonTheme resolved = resolveSkeletonTheme(
      context,
      widgetTheme: theme,
      style: style,
    );
    final DensityTokens tokens = resolveSkeletonTokens(
      context,
      override:
          densityTokens ??
          theme?.themeDensityTokens ??
          style?.themeDensityTokens,
      widgetTheme: theme,
    );
    final double h =
        (lineHeight ?? resolved.lineHeight ?? tokens.bodyTextSize) *
        ambient.scaling;
    final double gap =
        (lineGap ?? resolved.lineGap ?? tokens.gap) * ambient.scaling;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    return Semantics(
      label:
          semanticsLabel ??
          ComponentLocalizations.of(context).announcementLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: gap,
        children: <Widget>[
          for (int i = 0; i < lines; i++)
            _bar(context, i, i == lines - 1, h, rtl, resolved, tokens),
        ],
      ),
    );
  }

  Widget _bar(
    BuildContext context,
    int index,
    bool isLast,
    double h,
    bool rtl,
    SkeletonTheme resolved,
    DensityTokens tokens,
  ) {
    final Widget bar = Skeleton(
      borderRadius: borderRadius,
      theme: resolved,
      densityTokens: tokens,
      child: SizedBox(height: h, child: const SizedBox.expand()),
    );
    final Widget shaped = isLast && lines > 1
        ? Align(
            alignment: rtl
                ? AlignmentDirectional.centerEnd
                : AlignmentDirectional.centerStart,
            child: FractionallySizedBox(
              widthFactor: lastLineFraction,
              child: bar,
            ),
          )
        : bar;
    return lineBuilder?.call(context, index, isLast, shaped) ?? shaped;
  }
}

/// Avatar shape of the skeleton: circle by default, tile when [circle]
/// is false.
class SkeletonAvatar extends StatelessWidget {
  /// Creates an avatar placeholder.
  const SkeletonAvatar({
    super.key,
    this.size,
    this.circle = true,
    this.borderRadius,
    this.theme,
    this.style,
    this.densityTokens,
    this.semanticsLabel,
    this.avatarBuilder,
  });

  /// Diameter override; null uses the density control height (32 compact).
  final double? size;

  /// Circle when true, rounded tile when false.
  final bool circle;

  /// Corner radius override for the tile shape; ignored for circles.
  final BorderRadiusGeometry? borderRadius;

  /// Widget-leg theme override.
  final SkeletonTheme? theme;

  /// Per-instance style override, merged over [theme].
  final SkeletonStyle? style;

  /// Per-instance density tokens.
  final DensityTokens? densityTokens;

  /// Accessible label; null reads the locale `announcementLoading`.
  final String? semanticsLabel;

  /// Custom builder for the avatar; receives the default shimmer disc.
  final Widget Function(BuildContext context, Widget defaultAvatar)?
  avatarBuilder;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final SkeletonTheme resolved = resolveSkeletonTheme(
      context,
      widgetTheme: theme,
      style: style,
    );
    final DensityTokens tokens = resolveSkeletonTokens(
      context,
      override:
          densityTokens ??
          theme?.themeDensityTokens ??
          style?.themeDensityTokens,
      widgetTheme: theme,
    );
    final double d =
        (size ?? resolved.avatarSize ?? tokens.controlHeight) * ambient.scaling;
    final BorderRadiusGeometry radius = circle
        ? BorderRadius.circular(d / 2)
        : (borderRadius ?? resolved.borderRadius ?? ambient.borderRadiusMd);
    final Widget disc = Skeleton(
      borderRadius: radius,
      theme: resolved,
      densityTokens: tokens,
      semanticsLabel: semanticsLabel,
      child: SizedBox(width: d, height: d),
    );
    return avatarBuilder?.call(context, disc) ?? disc;
  }
}
