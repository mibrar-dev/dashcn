import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../primitives/clickable.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'list_tile_style.dart';

export 'list_tile_style.dart';

/// A material-style list tile with leading/title/subtitle/trailing slots.
class ListTile extends StatelessWidget {
  const ListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.selected = false,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.contentPadding,
    this.style,
    this.theme,
    this.selectedTileColor,
    this.tileColor,
    this.iconColor,
    this.textColor,
    this.subtitleColor,
    this.shape,
    this.enableFeedback = true,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isThreeLine;
  final bool? dense;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? contentPadding;
  final ListTileStyle? style;
  final ListTileTheme? theme;
  final ThemedColor? selectedTileColor;
  final ThemedColor? tileColor;
  final ThemedColor? iconColor;
  final ThemedColor? textColor;
  final ThemedColor? subtitleColor;
  final ShapeBorder? shape;
  final bool enableFeedback;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final ListTileTheme container =
        resolveComponentStyle<ListTileTheme, ListTileTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: listTileDefaults,
        );
    final ListTileStyle resolved = (style ?? const ListTileStyle()).merge(
      container,
    );
    final bool isDense = dense ?? resolved.dense ?? false;
    final double verticalPadding =
        resolved.minVerticalPadding ?? (isDense ? 4.0 : 8.0) * ambient.scaling;
    final EdgeInsetsGeometry padding = resolveEdgeInsets(
      contentPadding ??
          resolved.padding ??
          EdgeInsets.symmetric(
            horizontal: 16 * ambient.scaling,
            vertical: verticalPadding,
          ),
      ambient.density.baseContentPadding * ambient.scaling,
    );
    final double hGap = (resolved.horizontalTitleGap ?? 16.0) * ambient.scaling;
    final double minLeading =
        (resolved.minLeadingWidth ?? 40.0) * ambient.scaling;

    final ThemedColor? effectiveTileColor = tileColor ?? resolved.tileColor;
    final ThemedColor? effectiveSelectedColor =
        selectedTileColor ?? resolved.selectedColor;
    final Color? bg = selected
        ? (effectiveSelectedColor ??
                  ThemedColor.ref(ColorRef.primary, alpha: 0.08))
              .resolve(ambient.colors)
        : effectiveTileColor?.resolve(ambient.colors);

    final Color? resolvedIconColor = (iconColor ?? resolved.iconColor)?.resolve(
      ambient.colors,
    );
    final Color? resolvedTextColor = (textColor ?? resolved.textColor)?.resolve(
      ambient.colors,
    );
    final Color? resolvedSubtitleColor =
        (subtitleColor ?? resolved.subtitleColor)?.resolve(ambient.colors);

    final TextStyle titleStyle =
        (resolved.titleStyle ??
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
            .copyWith(color: resolvedTextColor);
    final TextStyle subtitleStyle =
        (resolved.subtitleStyle ?? const TextStyle(fontSize: 14)).copyWith(
          color: resolvedSubtitleColor ?? ambient.colors.mutedForeground,
        );

    Widget? leadingWidget = leading;
    if (leadingWidget != null && resolvedIconColor != null) {
      leadingWidget = IconTheme.merge(
        data: IconThemeData(color: resolvedIconColor),
        child: leadingWidget,
      );
    }

    final Widget titleWidget = DefaultTextStyle.merge(
      style: titleStyle,
      child: title ?? const SizedBox.shrink(),
    );

    Widget? subtitleWidget;
    if (subtitle != null) {
      subtitleWidget = DefaultTextStyle.merge(
        style: subtitleStyle,
        child: subtitle!,
      );
    }

    final Widget content = Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: isThreeLine
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: <Widget>[
          if (leading != null) ...<Widget>[
            SizedBox(
              width: resolved.leadingWidth ?? minLeading,
              child: leadingWidget,
            ),
            Gap(hGap),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                titleWidget,
                if (subtitleWidget != null) ...<Widget>[
                  Gap(isDense ? 2 * ambient.scaling : 4 * ambient.scaling),
                  subtitleWidget,
                ],
              ],
            ),
          ),
          if (trailing != null) ...<Widget>[Gap(hGap), trailing!],
        ],
      ),
    );

    final Widget tile = Container(color: bg, child: content);

    return Clickable(
      enabled: enabled,
      onPressed: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      enableFeedback: enableFeedback && (resolved.enableFeedback ?? true),
      child: tile,
    );
  }
}

/// A grouped list of [ListTile]s separated by dividers.
class ListTileGroup extends StatelessWidget {
  const ListTileGroup({
    super.key,
    required this.children,
    this.dividerColor,
    this.padding,
  });

  final List<Widget> children;
  final ThemedColor? dividerColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final List<Widget> items = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i < children.length - 1) {
        items.add(
          Container(
            height: 1,
            color: (dividerColor ?? ThemedColor.ref(ColorRef.border)).resolve(
              ambient.colors,
            ),
          ),
        );
      }
    }
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items,
      ),
    );
  }
}
