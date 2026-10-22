// The trailing action buttons behind a [SwipeActions] row.
//
// Each button scales and fades in with the reveal [progress], staggered from
// the trailing edge outward: the outermost action reaches full size first,
// the innermost last. Callers replace any button through
// `SwipeAction.builder`, which receives the same per-button progress.
// Sizes come from the density tokens (at least 64 px tile, 16 px icon,
// 12 px label): no oversized tiles.

import 'package:flutter/widgets.dart';

import '../../primitives/clickable.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'swipe_action.dart';
import 'swipe_actions_style.dart';

/// The revealed run of action buttons for a swipeable row.
///
/// [progress] is the overall reveal (0 closed, 1 fully open); each button
/// derives its own staggered progress from it. Transform/opacity only, so
/// the row layout never jumps while they appear.
class SwipeActionButtons extends StatelessWidget {
  /// Creates the action button run.
  const SwipeActionButtons({
    super.key,
    required this.actions,
    required this.progress,
    required this.actionExtent,
    this.densityTokens,
    this.theme,
  });

  /// Trailing actions, laid out from the trailing edge inward.
  final List<SwipeAction> actions;

  /// Overall reveal progress (0 closed, 1 fully open).
  final double progress;

  /// Width of one action.
  final double actionExtent;

  /// Per-instance density tokens; null resolves through the theme legs.
  final DensityTokens? densityTokens;

  /// Per-instance style override.
  final SwipeActionsTheme? theme;

  /// Staggered progress of button [index] (0 = innermost).
  @visibleForTesting
  static double buttonProgress(double progress, int index, int count) {
    return (progress * count - (count - 1 - index)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final SwipeActionsTheme resolved =
        resolveComponentStyle<SwipeActionsTheme, SwipeActionsTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: swipeActionsDefaults,
        );
    // Same visuals desktop/mobile: ambient tokens, no phone-width switch.
    final DensityTokens tokens =
        densityTokens ??
        resolved.themeDensityTokens ??
        ComponentTheme.maybeOf<SwipeActionsTheme>(
          context,
        )?.themeDensityTokens ??
        ComponentThemes.maybeOf<SwipeActionsTheme>(
          context,
        )?.themeDensityTokens ??
        Theme.of(context).densityTokens;
    final double scaling = appTheme.scaling;
    final double iconSize = (resolved.iconSize ?? tokens.iconSize) * scaling;
    // Labels stay at the subtitle token size (13 compact) for readability:
    // one step below body, never the 11-12 px caption floor.
    final TextStyle labelStyle =
        (resolved.labelStyle ?? TextStyle(fontSize: tokens.subtitleTextSize))
            .copyWith(
              fontSize:
                  (resolved.labelStyle?.fontSize ?? tokens.subtitleTextSize) *
                  scaling,
            );
    final double iconGap = (resolved.iconLabelGap ?? tokens.gap / 2) * scaling;
    final int count = actions.length;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    return Align(
      alignment: rtl ? Alignment.centerLeft : Alignment.centerRight,
      child: SizedBox(
        width: count * actionExtent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int i = 0; i < count; i++)
              SizedBox(
                width: actionExtent,
                child: Center(
                  child: _RevealButton(
                    progress: buttonProgress(progress, i, count),
                    action: actions[i],
                    direction: rtl ? -1 : 1,
                    fallback: _DensityTile(
                      action: actions[i],
                      iconSize: iconSize,
                      labelStyle: labelStyle,
                      iconGap: iconGap,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Density-sized default action tile: icon above label.
///
/// At least 64 px wide with a 16 px icon and readable subtitle-size label;
/// the label truncates so long names never widen the tile. The run uses
/// list-tile row heights (32 single / 48 two-line) so the reveal matches
/// the row. Keyboard reachable via [Clickable]; destructive tiles use the
/// destructive pair.
class _DensityTile extends StatelessWidget {
  const _DensityTile({
    required this.action,
    required this.iconSize,
    required this.labelStyle,
    required this.iconGap,
  });

  final SwipeAction action;
  final double iconSize;
  final TextStyle labelStyle;
  final double iconGap;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final bool destructive = action.destructive;
    final Color bg =
        (destructive
                ? ThemedColor.ref(ColorRef.destructive)
                : ThemedColor.ref(ColorRef.secondary))
            .resolve(appTheme.colors);
    final Color fg =
        (destructive
                ? ThemedColor.ref(ColorRef.destructiveForeground)
                : ThemedColor.ref(ColorRef.secondaryForeground))
            .resolve(appTheme.colors);
    return Clickable(
      onPressed: action.onPressed,
      decoration: WidgetStatePropertyAll<Decoration?>(BoxDecoration(color: bg)),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry?>(
        EdgeInsets.symmetric(
          horizontal: 4 * appTheme.scaling,
          vertical: 4 * appTheme.scaling,
        ),
      ),
      textStyle: WidgetStatePropertyAll<TextStyle?>(
        labelStyle.copyWith(color: fg),
      ),
      iconTheme: WidgetStatePropertyAll<IconThemeData?>(
        IconThemeData(color: fg, size: iconSize),
      ),
      child: Semantics(
        button: true,
        label: action.label,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (action.icon != null) action.icon!,
            if (action.icon != null) SizedBox(height: iconGap),
            Text(
              action.label,
              style: labelStyle.copyWith(color: fg),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// One button fading + scaling in with its staggered [progress].
class _RevealButton extends StatelessWidget {
  const _RevealButton({
    required this.progress,
    required this.action,
    required this.direction,
    required this.fallback,
  });

  final double progress;
  final SwipeAction action;
  final double direction;
  final Widget fallback;

  @override
  Widget build(BuildContext context) {
    final SwipeActionBuilder? builder = action.builder;
    final Widget child = builder?.call(context, progress) ?? fallback;
    if (progress >= 1.0) {
      return child;
    }
    if (progress <= 0.0) {
      return Opacity(opacity: 0, child: IgnorePointer(child: child));
    }
    return Opacity(
      opacity: progress,
      child: Transform.translate(
        offset: Offset(direction * (1 - progress) * 12, 0),
        child: Transform.scale(scale: 0.7 + 0.3 * progress, child: child),
      ),
    );
  }
}
