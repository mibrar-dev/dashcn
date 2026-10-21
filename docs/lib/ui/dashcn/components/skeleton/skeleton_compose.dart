// Composed placeholders for the `skeleton` component: [SkeletonCard]
// and [SkeletonList].
//
// Each composes the shape primitives ([SkeletonAvatar], [SkeletonLine])
// into the geometry of a real card or list so loading states match
// content size. Sizes come from the density scale; [SkeletonCard] paints
// through the shared surface primitive like [Card].

import 'package:flutter/widgets.dart';

import '../../primitives/localizations/localizations.dart';
import '../../primitives/surface.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'skeleton_layout.dart';
import 'skeleton_shapes.dart';
import 'skeleton_style.dart';

/// A card-shaped loading placeholder with a frosted surface.
class SkeletonCard extends StatelessWidget {
  /// Creates a card placeholder.
  const SkeletonCard({
    super.key,
    this.showAvatar = true,
    this.contentLines = 2,
    this.showFooter = false,
    this.padding,
    this.borderRadius,
    this.theme,
    this.style,
    this.densityTokens,
    this.semanticsLabel,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.leadingBuilder,
    this.titleBuilder,
    this.contentBuilder,
    this.footerBuilder,
  });

  /// Whether the header avatar shows.
  final bool showAvatar;

  /// Number of content lines under the header.
  final int contentLines;

  /// Whether a footer bar shows.
  final bool showFooter;

  /// Inner padding; null uses the density horizontal padding.
  final EdgeInsetsGeometry? padding;

  /// Corner radius; null uses the ambient `radiusXl` like [Card].
  final BorderRadiusGeometry? borderRadius;

  /// Widget-leg theme override.
  final SkeletonTheme? theme;

  /// Per-instance style override.
  final SkeletonStyle? style;

  /// Per-instance density tokens.
  final DensityTokens? densityTokens;

  /// Accessible label; null reads the locale `announcementLoading`.
  final String? semanticsLabel;

  /// Surface opacity override; null follows the theme then ambient legs.
  final double? surfaceOpacity;

  /// Surface blur override; null follows the theme then ambient legs.
  final double? surfaceBlur;

  /// Builder slots for every visible part; null keeps the default shape.
  final Widget Function(BuildContext context, Widget defaultLeading)?
  leadingBuilder;

  /// Title lines builder slot.
  final Widget Function(BuildContext context, Widget defaultTitle)?
  titleBuilder;

  /// Content lines builder slot.
  final Widget Function(BuildContext context, Widget defaultContent)?
  contentBuilder;

  /// Footer bar builder slot.
  final Widget Function(BuildContext context, Widget defaultFooter)?
  footerBuilder;

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
    final double gap = tokens.gap * ambient.scaling;
    final BorderRadiusGeometry radius =
        borderRadius ?? resolved.borderRadius ?? ambient.borderRadiusXl;
    final Color base = ambient.colors.card;
    final Color fill = surfaceColor(
      base,
      surfaceOpacity ?? resolved.surfaceOpacity,
    );
    final double? blur = surfaceBlur ?? resolved.surfaceBlur;
    final double pad = tokens.horizontalPadding * ambient.scaling;
    final Widget leading = showAvatar ? const SkeletonAvatar() : _gapBox(gap);
    final Widget title = const SkeletonLine(lines: 2);
    final Widget content = SkeletonLine(lines: contentLines);
    final Widget body = Padding(
      padding: padding ?? EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: gap,
        children: <Widget>[
          Row(
            spacing: gap,
            children: <Widget>[
              leadingBuilder?.call(context, leading) ?? leading,
              Expanded(child: titleBuilder?.call(context, title) ?? title),
            ],
          ),
          contentBuilder?.call(context, content) ?? content,
          if (showFooter)
            footerBuilder?.call(context, const SkeletonLine(lines: 1)) ??
                const SkeletonLine(lines: 1),
        ],
      ),
    );
    return Semantics(
      label:
          semanticsLabel ??
          ComponentLocalizations.of(context).announcementLoading,
      child: GlassSurface(
        surfaceBlur: hasSurfaceBlur(resolveSurfaceBlur(context)) ? blur : null,
        borderRadius: radius is BorderRadius ? radius : null,
        child: DecoratedBox(
          decoration: BoxDecoration(color: fill, borderRadius: radius),
          child: body,
        ),
      ),
    );
  }
}

/// A list-shaped loading placeholder: repeated avatar + text rows.
class SkeletonList extends StatelessWidget {
  /// Creates a list placeholder.
  const SkeletonList({
    super.key,
    this.itemCount = 3,
    this.showAvatar = true,
    this.showTrailing = false,
    this.theme,
    this.style,
    this.densityTokens,
    this.semanticsLabel,
    this.leadingBuilder,
    this.titleBuilder,
    this.trailingBuilder,
    this.separatorBuilder,
  }) : assert(itemCount > 0, 'itemCount must be greater than zero');

  /// Number of rows.
  final int itemCount;

  /// Whether each row shows a leading avatar.
  final bool showAvatar;

  /// Whether each row shows a trailing block.
  final bool showTrailing;

  /// Widget-leg theme override.
  final SkeletonTheme? theme;

  /// Per-instance style override.
  final SkeletonStyle? style;

  /// Per-instance density tokens.
  final DensityTokens? densityTokens;

  /// Accessible label; null reads the locale `announcementLoading`.
  final String? semanticsLabel;

  /// Builder slots for every visible part.
  final Widget Function(BuildContext context, int index, Widget defaultLeading)?
  leadingBuilder;

  /// Title builder slot per row.
  final Widget Function(BuildContext context, int index, Widget defaultTitle)?
  titleBuilder;

  /// Trailing builder slot per row.
  final Widget Function(
    BuildContext context,
    int index,
    Widget defaultTrailing,
  )?
  trailingBuilder;

  /// Separator builder slot between rows.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

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
    final double gap = tokens.gap * ambient.scaling;
    final double rowH = skeletonRowHeight(tokens, resolved, ambient.scaling);
    return Semantics(
      label:
          semanticsLabel ??
          ComponentLocalizations.of(context).announcementLoading,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: gap,
        children: <Widget>[
          for (int i = 0; i < itemCount; i++) ...<Widget>[
            SizedBox(
              height: rowH + gap,
              child: Row(
                spacing: gap,
                children: <Widget>[
                  if (showAvatar)
                    leadingBuilder?.call(context, i, const SkeletonAvatar()) ??
                        const SkeletonAvatar(),
                  Expanded(
                    child:
                        titleBuilder?.call(
                          context,
                          i,
                          const SkeletonLine(lines: 2),
                        ) ??
                        const SkeletonLine(lines: 2),
                  ),
                  if (showTrailing)
                    trailingBuilder?.call(
                          context,
                          i,
                          const SkeletonBlock(width: 48),
                        ) ??
                        const SkeletonBlock(width: 48),
                ],
              ),
            ),
            if (i < itemCount - 1)
              separatorBuilder?.call(context, i) ??
                  Container(height: 1, color: ambient.colors.border),
          ],
        ],
      ),
    );
  }
}

/// Transparent spacer used when [SkeletonCard.showAvatar] is false so the
/// header row keeps its gap without painting a block.
Widget _gapBox(double gap) => SizedBox(width: gap, height: gap);
