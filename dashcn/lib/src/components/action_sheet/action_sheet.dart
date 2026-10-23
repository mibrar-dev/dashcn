import 'package:flutter/widgets.dart';

import '../../foundation/platform.dart';
import '../../primitives/surface.dart';
import '../../primitives/touch_hit_area.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'action_sheet_action.dart';
import 'action_sheet_row.dart';
import 'action_sheet_style.dart';

export 'action_sheet_action.dart';
export 'action_sheet_row.dart';
export 'action_sheet_style.dart';

/// A density-sized action sheet: title + message + actions + cancel.
///
/// Compact by default ([DensityTokens.compact]): row height, icon size,
/// title/subtitle spacing and padding all resolve from the density tokens
/// (override per instance via [densityTokens] or the theme leg
/// `themeDensityTokens`). Desktop caps at the token overlay max width
/// (320 compact); phones show a full-width bottom sheet. The open animation
/// is the underlying dialog/sheet route and honours reduced motion.
class ActionSheet<T> extends StatelessWidget {
  const ActionSheet({
    super.key,
    this.title,
    this.message,
    required this.actions,
    this.cancelAction,
    this.theme,
    this.densityTokens,
    this.titleBuilder,
    this.messageBuilder,
    this.actionBuilder,
    this.dividerBuilder,
  });

  final String? title;
  final String? message;
  final List<ActionSheetAction<T>> actions;
  final ActionSheetAction<T>? cancelAction;
  final ActionSheetTheme? theme;

  /// Per-instance density tokens. Null resolves through the component theme
  /// legs (`themeDensityTokens`) then [ThemeData.densityTokens]; phone
  /// widths (< [kPhoneWidthBreakpoint]) use touch unless this is set.
  final DensityTokens? densityTokens;

  /// Swaps the title widget.
  final ActionSheetTitleBuilder? titleBuilder;

  /// Swaps the message widget.
  final ActionSheetMessageBuilder? messageBuilder;

  /// Swaps any action row.
  final ActionSheetActionBuilder<T>? actionBuilder;

  /// Swaps the dividers.
  final ActionSheetDividerBuilder? dividerBuilder;

  DensityTokens _tokens(BuildContext context, ActionSheetTheme resolved) {
    return densityTokens ??
        resolved.themeDensityTokens ??
        ComponentTheme.maybeOf<ActionSheetTheme>(context)?.themeDensityTokens ??
        ComponentThemes.maybeOf<ActionSheetTheme>(
          context,
        )?.themeDensityTokens ??
        resolveDensityTokens(context);
  }

  Widget _divider(BuildContext context, Color color) {
    final ActionSheetDividerBuilder? custom = dividerBuilder;
    if (custom != null) return custom(context);
    return Container(height: 1, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final double scaling = ambient.scaling;
    final ActionSheetTheme resolved =
        resolveComponentStyle<ActionSheetTheme, ActionSheetTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: actionSheetDefaults,
        );
    final DensityTokens tokens = _tokens(context, resolved);
    final Color bg =
        (resolved.backgroundColor ?? ThemedColor.ref(ColorRef.card)).resolve(
          ambient.colors,
        );
    final Color divider =
        (resolved.dividerColor ?? ThemedColor.ref(ColorRef.border)).resolve(
          ambient.colors,
        );
    final double maxW = (resolved.maxWidth ?? tokens.overlayMaxWidth) * scaling;
    double effectiveMax = maxW;
    try {
      if (isPhoneWidth(MediaQuery.widthOf(context))) {
        effectiveMax = double.infinity;
      }
    } on FlutterError {
      // No MediaQuery: keep the desktop cap.
    }
    final EdgeInsetsGeometry padding =
        resolved.padding ??
        EdgeInsets.symmetric(
          // Outer sheet inset from the density tokens: gap x 2 is 16
          // compact (20 comfortable, 24 touch). Title/message carry their
          // own horizontal token inset below and rows carry their own 12px
          // horizontal (tokens.horizontalPadding), so row text sits 28px
          // from the edge in compact; dividers inset by the 16px shell
          // instead of touching the sheet borders.
          horizontal: tokens.gap * 2 * scaling,
          vertical: tokens.gap * 2 * scaling,
        );
    // Compact rows are 40 (Material dense list) rather than the generic
    // token 32: action rows are touch targets with 16px icons, so the
    // compact default is taller than a menu row but still denser than the
    // 48 touch rows phones resolve through [resolveDensityTokens].
    final double rowMin =
        (resolved.rowMinHeight ??
            (tokens.preset == DensityPreset.compact
                ? 40.0
                : tokens.rowMinHeight)) *
        scaling;
    final double iconSize = (resolved.iconSize ?? tokens.iconSize) * scaling;
    final double iconGap = tokens.gap * scaling;
    final double titleGap = (resolved.titleSpacing ?? tokens.gap / 2) * scaling;
    final double contentGap = (resolved.messageSpacing ?? tokens.gap) * scaling;

    final TextStyle titleStyle =
        (resolved.titleStyle ??
                TextStyle(
                  fontSize: tokens.bodyTextSize,
                  fontWeight: FontWeight.w600,
                ))
            .copyWith(color: ambient.colors.foreground);
    final TextStyle messageStyle =
        (resolved.messageStyle ?? TextStyle(fontSize: tokens.subtitleTextSize))
            .copyWith(color: ambient.colors.mutedForeground);
    final TextStyle labelBase =
        resolved.actionStyle ?? TextStyle(fontSize: tokens.bodyTextSize);

    Widget actionButton(ActionSheetAction<T> action, {bool isCancel = false}) {
      final Color color = action.isDestructive
          ? (resolved.destructiveColor ?? ThemedColor.ref(ColorRef.destructive))
                .resolve(ambient.colors)
          : (isCancel
                ? (resolved.cancelColor ??
                          ThemedColor.ref(ColorRef.mutedForeground))
                      .resolve(ambient.colors)
                : ambient.colors.foreground);
      final Widget row = ActionSheetRow<T>(
        action: action,
        isCancel: isCancel,
        rowMinHeight: rowMin,
        iconSize: iconSize,
        horizontalPadding: tokens.horizontalPadding * scaling,
        verticalPadding: tokens.verticalPadding * scaling,
        iconGap: iconGap,
        labelStyle: labelBase,
        color: color,
      );
      final double growth = isMobile(ambient.platform)
          ? (48 * scaling - rowMin).clamp(0.0, double.infinity).toDouble() / 2
          : 0.0;
      final Widget padded = growth > 0
          ? TouchHitArea(vertical: growth, child: row)
          : row;
      final ActionSheetActionBuilder<T>? custom = actionBuilder;
      if (custom != null) return custom(context, action, padded, isCancel);
      return padded;
    }

    final List<Widget> actionWidgets = <Widget>[];
    for (int i = 0; i < actions.length; i++) {
      actionWidgets.add(actionButton(actions[i]));
      if (i < actions.length - 1) {
        actionWidgets.add(_divider(context, divider));
      }
    }

    final double? opacity = resolved.surfaceOpacity ?? ambient.surfaceOpacity;
    final double? blur = resolved.surfaceBlur ?? ambient.surfaceBlur;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: effectiveMax.isFinite ? effectiveMax : double.infinity,
      ),
      child: GlassSurface(
        surfaceBlur: blur,
        borderRadius:
            resolved.borderRadius ??
            BorderRadius.circular(ambient.radiusXl * scaling),
        child: Container(
          decoration: BoxDecoration(
            color: surfaceColor(bg, opacity),
            borderRadius:
                resolved.borderRadius ??
                BorderRadius.circular(ambient.radiusXl * scaling),
          ),
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (title != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: tokens.horizontalPadding * scaling,
                    right: tokens.horizontalPadding * scaling,
                    bottom: titleGap,
                  ),
                  child:
                      titleBuilder?.call(context, title!, titleStyle) ??
                      Text(
                        title!,
                        style: titleStyle,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              if (message != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: tokens.horizontalPadding * scaling,
                    right: tokens.horizontalPadding * scaling,
                    bottom: contentGap,
                  ),
                  child:
                      messageBuilder?.call(context, message!, messageStyle) ??
                      Text(
                        message!,
                        style: messageStyle,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              if (actions.isNotEmpty)
                Flexible(
                  child: ListView(shrinkWrap: true, children: actionWidgets),
                ),
              if (cancelAction != null) ...<Widget>[
                SizedBox(height: contentGap),
                _divider(context, divider),
                actionButton(cancelAction!, isCancel: true),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
