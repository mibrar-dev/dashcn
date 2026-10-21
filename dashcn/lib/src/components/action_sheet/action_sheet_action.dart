import 'package:flutter/widgets.dart';

/// One row in an `ActionSheet`.
class ActionSheetAction<T> {
  const ActionSheetAction({
    required this.label,
    this.value,
    this.icon,
    this.trailing,
    this.onPressed,
    this.isDestructive = false,
    this.isDefault = false,
  });

  /// Row label; truncates, never grows the row.
  final String label;

  /// Value passed to `Navigator.pop` on tap.
  final T? value;

  /// Leading icon; sized from the density tokens unless overridden.
  final Widget? icon;

  /// Trailing slot; null draws no trailing.
  final Widget? trailing;

  /// Called on tap before the sheet pops.
  final VoidCallback? onPressed;

  /// Whether the row uses the destructive colour.
  final bool isDestructive;

  /// Whether the label renders semibold.
  final bool isDefault;
}

/// Builds the title line; return any widget to replace the default text.
typedef ActionSheetTitleBuilder =
    Widget Function(BuildContext context, String title, TextStyle style);

/// Builds the message line.
typedef ActionSheetMessageBuilder =
    Widget Function(BuildContext context, String message, TextStyle style);

/// Builds one action row; [defaultRow] is the density-sized row.
typedef ActionSheetActionBuilder<T> =
    Widget Function(
      BuildContext context,
      ActionSheetAction<T> action,
      Widget defaultRow,
      bool isCancel,
    );

/// Builds a divider between rows.
typedef ActionSheetDividerBuilder = Widget Function(BuildContext context);
