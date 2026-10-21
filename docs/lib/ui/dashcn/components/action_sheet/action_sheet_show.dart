import 'package:flutter/widgets.dart';

import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../dialog/dialog.dart' as dialog_route;
import '../dialog/dialog_style.dart';
import '../drawer/drawer.dart';
import 'action_sheet.dart';

export 'action_sheet_action.dart';

/// Shows a density-sized action sheet.
///
/// Phones (< 600 px) get a full-width bottom sheet; wider screens get a
/// centered dialog capped at the token overlay max width (320 compact).
/// The open animation is the underlying route and honours reduced motion.
Future<T?> showActionSheet<T>({
  required BuildContext context,
  String? title,
  String? message,
  required List<ActionSheetAction<T>> actions,
  ActionSheetAction<T>? cancelAction,
  ActionSheetTheme? theme,
  DensityTokens? densityTokens,
  ActionSheetTitleBuilder? titleBuilder,
  ActionSheetMessageBuilder? messageBuilder,
  ActionSheetActionBuilder<T>? actionBuilder,
  ActionSheetDividerBuilder? dividerBuilder,
  bool useRootNavigator = true,
}) {
  final bool wide = MediaQuery.of(context).size.width >= 600;
  final Widget content = ActionSheet<T>(
    title: title,
    message: message,
    actions: actions,
    cancelAction: cancelAction,
    theme: theme,
    densityTokens: densityTokens,
    titleBuilder: titleBuilder,
    messageBuilder: messageBuilder,
    actionBuilder: actionBuilder,
    dividerBuilder: dividerBuilder,
  );
  if (wide) {
    final Duration? custom = theme?.transitionDuration;
    return dialog_route.showDialog<T>(
      context: context,
      builder: (_) => content,
      useRootNavigator: useRootNavigator,
      theme: custom == null ? null : DialogTheme(transitionDuration: custom),
    );
  }
  final bool reduced =
      (MediaQuery.maybeOf(context)?.disableAnimations ?? false) ||
      !Theme.of(context).motion.enabled;
  return openSheet<T>(
    context: context,
    builder: (_) => content,
    draggable: true,
    expands: false,
    maxSize: 340,
    barrierDismissible: true,
    useRootNavigator: useRootNavigator,
    theme: theme?.transitionDuration == null && !reduced
        ? const DrawerTheme(padding: EdgeInsets.zero)
        : DrawerTheme(
            padding: EdgeInsets.zero,
            transitionDuration:
                theme?.transitionDuration ?? (reduced ? Duration.zero : null),
          ),
  );
}
