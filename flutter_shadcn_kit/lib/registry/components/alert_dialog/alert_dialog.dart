// The `alert_dialog` component: [AlertDialog], the shadcn title / description
// / action composition, and [showAlertDialog] which pushes it through the
// `dialog` component's route.
//
// The card, its padding, the radius, the shadow and the barrier come from
// `DialogTheme` (24px padding at default density, black barrier at 50%); this
// component only owns the header icon, the title/description typography and
// the spacing between them and the footer.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../dialog/dialog.dart';
import 'alert_dialog_style.dart';

export 'alert_dialog_style.dart';

/// Builds the header row: optional icon, then the title/description column.
class AlertDialog extends StatelessWidget {
  /// Creates an alert dialog body.
  ///
  /// Place it in the `builder` of [showAlertDialog]; the surrounding card,
  /// padding and barrier come from the `dialog` component.
  const AlertDialog({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.actions = const <Widget>[],
    this.theme,
  });

  /// Headline of the dialog. Typically a `Text`.
  final Widget? title;

  /// Supporting text below [title]. Typically a `Text`.
  final Widget? description;

  /// Leading glyph of the header, usually an `Icon`. It is tinted with
  /// `AlertDialogTheme.iconColor` (`mutedForeground` by default).
  final Widget? icon;

  /// Footer controls, usually buttons. They are laid out in a row aligned by
  /// `AlertDialogTheme.footerAlignment` (the end of the row by default) and
  /// separated by `actionGap`.
  final List<Widget> actions;

  /// Widget-leg override, merged over the component/app/defaults legs.
  final AlertDialogTheme? theme;

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData ambient = ShadcnTheme.of(context);
    final AlertDialogTheme style =
        resolveComponentStyle<AlertDialogTheme, AlertDialogTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: alertDialogDefaults,
        );
    final double iconGap = style.iconGap ?? 0;
    final double headerGap = style.headerGap ?? 0;
    final double footerGap = style.footerGap ?? 0;
    final double actionGap = style.actionGap ?? 0;

    final TextStyle titleStyle =
        (style.titleStyle ?? alertDialogDefaultTitleStyle).copyWith(
          color: style.titleStyle?.color ?? ambient.colors.foreground,
        );
    final TextStyle descriptionStyle =
        (style.descriptionStyle ?? alertDialogDefaultDescriptionStyle).copyWith(
          color:
              style.descriptionStyle?.color ?? ambient.colors.mutedForeground,
        );

    // shadcn `AlertDialogFooter`: `flex-col-reverse sm:flex-row
    // sm:justify-end gap-2`. Below ~360px the actions stack full-width;
    // above they sit in a right-aligned row. `LayoutBuilder` reads the
    // real card width so a 375px phone stacks while the 512px desktop
    // card keeps the row. Unbounded width (tests) falls back to the row.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool stacked =
            constraints.maxWidth.isFinite && constraints.maxWidth < 360;
        final Widget? header = stacked
            ? _buildHeaderStacked(titleStyle, descriptionStyle, headerGap)
            : _buildHeaderRow(
                context,
                style,
                titleStyle,
                descriptionStyle,
                iconGap,
                headerGap,
              );
        final Widget? footer = _buildFooter(
          style.footerAlignment ?? MainAxisAlignment.end,
          actionGap,
          stacked: stacked,
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          // `stretch` is the footer fix: with `start` the action `Wrap`
          // sized to its content and `WrapAlignment.end` aligned the
          // buttons to the content's own end (reading as LEFT-aligned,
          // flush to the border). Stretched, the row spans the card and
          // the actions truly sit at its end.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ?header,
            if (header != null && footer != null) Gap(footerGap),
            if (footer case final Widget widget) widget,
          ],
        );
      },
    );
  }

  /// Wide header: icon and title on one row, icon centred against the
  /// title line (not top-offset outside it).
  Widget? _buildHeaderRow(
    BuildContext context,
    AlertDialogTheme style,
    TextStyle titleStyle,
    TextStyle descriptionStyle,
    double iconGap,
    double headerGap,
  ) {
    if (title == null && description == null && icon == null) {
      return null;
    }
    final List<Widget> row = <Widget>[];
    if (icon != null) {
      row.add(
        IconTheme.merge(
          data: IconThemeData(
            size: 20 * ShadcnTheme.of(context).scaling,
            color: (style.iconColor ?? alertDialogDefaults.iconColor!).resolve(
              ShadcnTheme.of(context).colors,
            ),
          ),
          child: icon!,
        ),
      );
    }
    if (title != null || description != null) {
      if (row.isNotEmpty) {
        row.add(Gap(iconGap));
      }
      row.add(
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (title != null)
                DefaultTextStyle.merge(style: titleStyle, child: title!),
              if (title != null && description != null) Gap(headerGap),
              if (description != null)
                DefaultTextStyle.merge(
                  style: descriptionStyle,
                  child: description!,
                ),
            ],
          ),
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: row,
    );
  }

  /// Narrow header (centred on mobile): icon above the title, texts centred.
  Widget? _buildHeaderStacked(
    TextStyle titleStyle,
    TextStyle descriptionStyle,
    double headerGap,
  ) {
    if (title == null && description == null && icon == null) {
      return null;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ?icon,
        if (icon != null && (title != null || description != null))
          Gap(headerGap),
        if (title != null)
          DefaultTextStyle.merge(
            style: titleStyle,
            textAlign: TextAlign.center,
            child: title!,
          ),
        if (title != null && description != null) Gap(headerGap),
        if (description != null)
          DefaultTextStyle.merge(
            style: descriptionStyle,
            textAlign: TextAlign.center,
            child: description!,
          ),
      ],
    );
  }

  Widget? _buildFooter(
    MainAxisAlignment alignment,
    double actionGap, {
    required bool stacked,
  }) {
    if (actions.isEmpty) {
      return null;
    }
    // Mobile: stacked full-width actions (`flex-col`).
    if (stacked) {
      final List<Widget> column = <Widget>[];
      for (int i = 0; i < actions.length; i++) {
        if (i > 0) column.add(Gap(actionGap));
        column.add(actions[i]);
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: column,
      );
    }
    if (actions.length == 1) {
      return Align(
        alignment: switch (alignment) {
          MainAxisAlignment.start => AlignmentDirectional.centerStart,
          MainAxisAlignment.end => AlignmentDirectional.centerEnd,
          _ => AlignmentDirectional.center,
        },
        child: actions.first,
      );
    }
    return Wrap(
      alignment: switch (alignment) {
        MainAxisAlignment.start => WrapAlignment.start,
        MainAxisAlignment.end => WrapAlignment.end,
        MainAxisAlignment.center => WrapAlignment.center,
        MainAxisAlignment.spaceBetween => WrapAlignment.spaceBetween,
        MainAxisAlignment.spaceAround => WrapAlignment.spaceAround,
        MainAxisAlignment.spaceEvenly => WrapAlignment.spaceEvenly,
      },
      runAlignment: WrapAlignment.end,
      spacing: actionGap,
      runSpacing: actionGap,
      children: actions,
    );
  }
}

/// Pushes an [AlertDialog] on the navigator and returns the route result.
///
/// Thin composition over the `dialog` component: the route, the focus trap,
/// the Escape key and the live theme all come from
/// [showShadcnDialog], so the alert stays restyled by a light/dark or preset
/// change while it is open.
///
/// ```dart
/// final confirmed = await showAlertDialog<bool>(
///   context: context,
///   title: const Text('Delete this project?'),
///   description: const Text('This cannot be undone.'),
///   // Build actions from the DIALOG's context: popping the caller's context
///   // would pop the page under the dialog in apps with nested navigators.
///   actionsBuilder: (dialogContext) => <Widget>[
///     Button(
///       variant: ButtonVariant.outline,
///       onPressed: () => Navigator.pop(dialogContext, false),
///       child: const Text('Cancel'),
///     ),
///     Button(
///       variant: ButtonVariant.destructive,
///       onPressed: () => Navigator.pop(dialogContext, true),
///       child: const Text('Delete'),
///     ),
///   ],
/// );
/// ```
Future<T?> showAlertDialog<T>({
  required BuildContext context,
  Widget? title,
  Widget? description,
  Widget? icon,
  List<Widget> Function(BuildContext dialogContext)? actionsBuilder,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  ThemedColor? barrierColor,
  AlertDialogTheme? theme,
  AlignmentGeometry alignment = Alignment.center,
  RouteSettings? routeSettings,
}) {
  return showShadcnDialog<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    alignment: alignment,
    routeSettings: routeSettings,
    builder: (context) => AlertDialog(
      title: title,
      description: description,
      icon: icon,
      actions: actionsBuilder?.call(context) ?? const <Widget>[],
      theme: theme,
    ),
  );
}
