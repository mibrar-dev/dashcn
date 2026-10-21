import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../primitives/clickable.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/density_tokens.dart';
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
    this.densityTokens,
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

  /// Per-instance density tokens. Null resolves through the component theme
  /// legs (`themeDensityTokens`) then [ThemeData.densityTokens]; phone
  /// widths (< [kPhoneWidthBreakpoint]) use touch unless this is set.
  final DensityTokens? densityTokens;

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
    final DensityTokens tokens =
        densityTokens ??
        container.themeDensityTokens ??
        ComponentTheme.maybeOf<ListTileTheme>(context)?.themeDensityTokens ??
        ComponentThemes.maybeOf<ListTileTheme>(context)?.themeDensityTokens ??
        resolveDensityTokens(context);
    final bool isDense = dense ?? resolved.dense ?? false;
    // Dense keeps the compact look: two px less vertical than the ambient
    // tokens (6 -> 4 at compact, preserving the old dense default).
    final double tokenVertical = isDense
        ? (tokens.verticalPadding - 2).clamp(2.0, tokens.verticalPadding)
        : tokens.verticalPadding;
    final double verticalPadding =
        resolved.minVerticalPadding ?? tokenVertical * ambient.scaling;
    final EdgeInsetsGeometry padding = resolveEdgeInsets(
      contentPadding ??
          resolved.padding ??
          EdgeInsets.symmetric(
            horizontal: tokens.horizontalPadding * ambient.scaling,
            vertical: verticalPadding,
          ),
      ambient.density.baseContentPadding * ambient.scaling,
    );
    final double hGap =
        (resolved.horizontalTitleGap ?? tokens.gap) * ambient.scaling;
    // Leading slot fits a density avatar (control 32/40/48) + 8 px breathing
    // room: 40 compact (back-compat), 48 comfortable, 56 touch.
    final double minLeading =
        (resolved.minLeadingWidth ?? (tokens.controlHeight + 8)) *
        ambient.scaling;

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
                TextStyle(
                  fontSize: tokens.bodyTextSize,
                  fontWeight: FontWeight.w400,
                ))
            .copyWith(
              color: resolvedTextColor,
              overflow: TextOverflow.ellipsis,
            );
    final TextStyle subtitleStyle =
        (resolved.subtitleStyle ?? TextStyle(fontSize: tokens.subtitleTextSize))
            .copyWith(
              color: resolvedSubtitleColor ?? ambient.colors.mutedForeground,
              overflow: TextOverflow.ellipsis,
            );

    Widget? leadingWidget = leading;
    if (leadingWidget != null) {
      leadingWidget = IconTheme.merge(
        data: IconThemeData(
          color: resolvedIconColor,
          size: tokens.iconSize * ambient.scaling,
        ),
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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: resolved.leadingWidth ?? minLeading,
                maxHeight: tokens.rowMaxHeight * ambient.scaling,
              ),
              child: SizedBox(
                width: resolved.leadingWidth ?? minLeading,
                child: leadingWidget,
              ),
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
                  Gap(
                    (isDense ? tokens.gap / 4 : tokens.gap / 2) *
                        ambient.scaling,
                  ),
                  subtitleWidget,
                ],
              ],
            ),
          ),
          if (trailing != null) ...<Widget>[
            Gap(hGap),
            Flexible(child: trailing!),
          ],
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
