import 'package:flutter/widgets.dart';

import '../../primitives/clickable.dart';
import 'action_sheet_action.dart';

/// One density-sized action row: leading icon + label + trailing.
///
/// Enforces the token row min-height with density padding; the label
/// truncates so the row never grows. Keyboard reachable via [Clickable].
class ActionSheetRow<T> extends StatelessWidget {
  const ActionSheetRow({
    super.key,
    required this.action,
    required this.isCancel,
    required this.rowMinHeight,
    required this.iconSize,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.iconGap,
    required this.labelStyle,
    required this.color,
  });

  final ActionSheetAction<T> action;
  final bool isCancel;
  final double rowMinHeight;
  final double iconSize;
  final double horizontalPadding;
  final double verticalPadding;
  final double iconGap;
  final TextStyle labelStyle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: action.label,
      child: Clickable(
        onPressed: () {
          action.onPressed?.call();
          final NavigatorState? navigator = Navigator.maybeOf(context);
          if (navigator?.canPop() ?? false) {
            navigator!.pop(action.value);
          }
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: rowMinHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Row(
              children: <Widget>[
                if (action.icon != null) ...<Widget>[
                  IconTheme.merge(
                    data: IconThemeData(size: iconSize),
                    child: action.icon!,
                  ),
                  SizedBox(width: iconGap),
                ],
                Expanded(
                  child: Text(
                    action.label,
                    style: labelStyle.copyWith(
                      color: color,
                      fontWeight: action.isDefault
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (action.trailing != null) ...<Widget>[
                  SizedBox(width: iconGap),
                  Flexible(child: action.trailing!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
