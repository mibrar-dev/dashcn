import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../dialog/dialog.dart';
import '../drawer/drawer.dart';
import 'action_sheet_style.dart';

export 'action_sheet_style.dart';

class ActionSheetAction<T> {
  const ActionSheetAction({
    required this.label,
    this.value,
    this.icon,
    this.onPressed,
    this.isDestructive = false,
    this.isDefault = false,
  });

  final String label;
  final T? value;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool isDestructive;
  final bool isDefault;
}

class ActionSheet<T> extends StatelessWidget {
  const ActionSheet({
    super.key,
    this.title,
    this.message,
    required this.actions,
    this.cancelAction,
    this.theme,
  });

  final String? title;
  final String? message;
  final List<ActionSheetAction<T>> actions;
  final ActionSheetAction<T>? cancelAction;
  final ActionSheetTheme? theme;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final ActionSheetTheme resolved =
        resolveComponentStyle<ActionSheetTheme, ActionSheetTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: actionSheetDefaults,
        );
    final Color bg =
        (resolved.backgroundColor ?? ThemedColor.ref(ColorRef.background))
            .resolve(ambient.colors);
    final Color divider =
        (resolved.dividerColor ?? ThemedColor.ref(ColorRef.border)).resolve(
          ambient.colors,
        );
    final double maxW = (resolved.maxWidth ?? 640) * ambient.scaling;
    final EdgeInsetsGeometry padding = resolveEdgeInsets(
      resolved.padding ?? const EdgeInsets.all(16),
      ambient.density.baseContentPadding * ambient.scaling,
    );

    Widget actionButton(ActionSheetAction<T> action, {bool isCancel = false}) {
      final Color color = action.isDestructive
          ? (resolved.destructiveColor ?? ThemedColor.ref(ColorRef.destructive))
                .resolve(ambient.colors)
          : (isCancel
                ? (resolved.cancelColor ??
                          ThemedColor.ref(ColorRef.mutedForeground))
                      .resolve(ambient.colors)
                : ambient.colors.foreground);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          action.onPressed?.call();
          Navigator.of(context).pop(action.value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: <Widget>[
              if (action.icon != null) ...<Widget>[
                action.icon!,
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  action.label,
                  style: (resolved.actionStyle ?? const TextStyle(fontSize: 16))
                      .copyWith(
                        color: color,
                        fontWeight: action.isDefault
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final List<Widget> actionWidgets = <Widget>[];
    for (int i = 0; i < actions.length; i++) {
      actionWidgets.add(actionButton(actions[i]));
      if (i < actions.length - 1) {
        actionWidgets.add(Container(height: 1, color: divider));
      }
    }

    final Widget body = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxW),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius:
              resolved.borderRadius ??
              BorderRadius.circular(12 * ambient.scaling),
        ),
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  title!,
                  style:
                      resolved.titleStyle ??
                      const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  message!,
                  style: resolved.messageStyle ?? const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            if (actions.isNotEmpty)
              Flexible(
                child: ListView(shrinkWrap: true, children: actionWidgets),
              ),
            if (cancelAction != null) ...<Widget>[
              const SizedBox(height: 8),
              Container(height: 1, color: divider),
              actionButton(cancelAction!, isCancel: true),
            ],
          ],
        ),
      ),
    );

    return body;
  }
}

Future<T?> showActionSheet<T>({
  required BuildContext context,
  String? title,
  String? message,
  required List<ActionSheetAction<T>> actions,
  ActionSheetAction<T>? cancelAction,
  ActionSheetTheme? theme,
  bool useRootNavigator = true,
}) {
  final bool wide = MediaQuery.of(context).size.width >= 600;
  final Widget content = ActionSheet<T>(
    title: title,
    message: message,
    actions: actions,
    cancelAction: cancelAction,
    theme: theme,
  );
  if (wide) {
    return showDialog<T>(
      context: context,
      builder: (_) => content,
      useRootNavigator: useRootNavigator,
    );
  }
  return openSheet<T>(
    context: context,
    builder: (_) => content,
    draggable: true,
    barrierDismissible: true,
    useRootNavigator: useRootNavigator,
  );
}
