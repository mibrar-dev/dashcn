// Shared density/size resolution for the `skeleton` component.
//
// Every shape placeholder derives its sizes from the density scale (compact
// default): text lines are one body step tall, avatars one control tall,
// rows one row step tall. Callers may override any size per instance or
// through `SkeletonTheme`; null always falls back to the ambient tokens so
// phone widths (< 600 px) grow every shape to touch density together.

import 'package:flutter/widgets.dart';

import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'skeleton_style.dart';

/// Resolves the effective density tokens for skeleton shapes.
///
/// Precedence: per-instance override, then the three theme legs
/// (widget `theme`, scoped `ComponentTheme`, app `ComponentThemes`), then
/// the ambient `ThemeData.densityTokens` (touch on phone widths).
DensityTokens resolveSkeletonTokens(
  BuildContext context, {
  DensityTokens? override,
  SkeletonTheme? widgetTheme,
}) {
  if (override != null) {
    return override;
  }
  final SkeletonTheme container =
      resolveComponentStyle<SkeletonTheme, SkeletonTheme>(
        context,
        widget: widgetTheme,
        select: (t) => t,
        defaults: skeletonDefaults,
      );
  final DensityTokens? leg =
      widgetTheme?.themeDensityTokens ??
      ComponentTheme.maybeOf<SkeletonTheme>(context)?.themeDensityTokens ??
      ComponentThemes.maybeOf<SkeletonTheme>(context)?.themeDensityTokens ??
      container.themeDensityTokens;
  if (leg != null) {
    return leg;
  }
  return resolveDensityTokens(context);
}

/// Resolves the full [SkeletonTheme] including the per-instance [style].
SkeletonTheme resolveSkeletonTheme(
  BuildContext context, {
  SkeletonTheme? widgetTheme,
  SkeletonStyle? style,
}) {
  final SkeletonTheme base =
      resolveComponentStyle<SkeletonTheme, SkeletonTheme>(
        context,
        widget: widgetTheme,
        select: (t) => t,
        defaults: skeletonDefaults,
      );
  return (style ?? const SkeletonTheme()).merge(base);
}

/// Height of one text-line bar for [tokens] and [theme].
double skeletonLineHeight(
  DensityTokens tokens,
  SkeletonTheme theme,
  double scaling,
) {
  return (theme.lineHeight ?? tokens.bodyTextSize) * scaling;
}

/// Gap between text-line bars.
double skeletonLineGap(
  DensityTokens tokens,
  SkeletonTheme theme,
  double scaling,
) {
  return (theme.lineGap ?? tokens.gap) * scaling;
}

/// Diameter of the avatar placeholder.
double skeletonAvatarSize(
  DensityTokens tokens,
  SkeletonTheme theme,
  double scaling,
) {
  return (theme.avatarSize ?? tokens.controlHeight) * scaling;
}

/// Minimum height of list/table rows.
double skeletonRowHeight(
  DensityTokens tokens,
  SkeletonTheme theme,
  double scaling,
) {
  return (theme.rowHeight ?? tokens.rowMinHeight) * scaling;
}
