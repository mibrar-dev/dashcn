// The separator and the group of the `toolbar` component.

import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'toolbar_item.dart';
import 'toolbar_style.dart';

/// A divider between toolbar items.
class ToolbarSeparator extends StatelessWidget {
  /// Creates a toolbar separator.
  const ToolbarSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final ToolbarItemData? data = Data.maybeOf<ToolbarItemData>(context);
    final ToolbarStyle style =
        data?.separatorStyle ?? toolbarDefaults.separator!;
    final Color color =
        style.separatorColor?.resolve(ambient.colors) ?? ambient.colors.border;
    final double thickness = style.separatorThickness ?? 1;
    final bool vertical = (data?.axis ?? Axis.horizontal) == Axis.horizontal;
    return SizedBox(
      width: vertical ? thickness : null,
      height: vertical ? null : thickness,
      child: ColoredBox(color: color),
    );
  }
}

/// A group of toolbar items painted as one rounded cluster.
class ToolbarGroup extends StatelessWidget {
  /// Creates a toolbar group.
  const ToolbarGroup({super.key, required this.children});

  /// The items of the group.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final ToolbarItemData? data = Data.maybeOf<ToolbarItemData>(context);
    final ToolbarStyle style = data?.groupStyle ?? toolbarDefaults.group!;
    final Color? fill = style.groupBackground?.resolve(ambient.colors);
    final BorderRadiusGeometry? radius = style.groupBorderRadius;
    final EdgeInsets padding = resolveEdgeInsets(
      style.groupPadding ?? EdgeInsets.zero,
      ambient.density.baseContentPadding * ambient.scaling,
    ).resolve(Directionality.of(context));
    return DecoratedBox(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: radius ?? ambient.borderRadiusMd,
      ),
      child: Padding(padding: padding, child: _row(context)),
    );
  }

  Widget _row(BuildContext context) {
    final Axis axis =
        Data.maybeOf<ToolbarItemData>(context)?.axis ?? Axis.horizontal;
    if (axis == Axis.horizontal) {
      return Row(mainAxisSize: MainAxisSize.min, children: _withGaps(context));
    }
    return Column(mainAxisSize: MainAxisSize.min, children: _withGaps(context));
  }

  List<Widget> _withGaps(BuildContext context) {
    final ToolbarItemData? data = Data.maybeOf<ToolbarItemData>(context);
    final double gap = data?.groupStyle?.gap ?? 2;
    final List<Widget> result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      if (i > 0) {
        result.add(SizedBox(width: gap, height: gap));
      }
      result.add(children[i]);
    }
    return result;
  }
}
