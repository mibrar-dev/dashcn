// The trailing action buttons behind a [SwipeActions] row.
//
// Each button scales and fades in with the reveal [progress], staggered from
// the trailing edge outward: the outermost action reaches full size first,
// the innermost last. Callers replace any button through
// `SwipeAction.builder`, which receives the same per-button progress.

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../button/button.dart';
import 'swipe_action.dart';

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
  });

  /// Trailing actions, laid out from the trailing edge inward.
  final List<SwipeAction> actions;

  /// Overall reveal progress (0 closed, 1 fully open).
  final double progress;

  /// Width of one action.
  final double actionExtent;

  /// Staggered progress of button [index] (0 = innermost).
  @visibleForTesting
  static double buttonProgress(double progress, int index, int count) {
    return (progress * count - (count - 1 - index)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
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
                    fallback: Button(
                      variant: actions[i].destructive
                          ? ButtonVariant.destructive
                          : ButtonVariant.secondary,
                      size: ButtonSize.sm,
                      onPressed: actions[i].onPressed,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (actions[i].icon != null) actions[i].icon!,
                          Text(
                            actions[i].label,
                            style: appTheme.typography.textSmall,
                          ),
                        ],
                      ),
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
