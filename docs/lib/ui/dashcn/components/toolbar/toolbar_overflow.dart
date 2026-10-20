// The responsive overflow of the `toolbar` component.
//
// When the items no longer fit the space the toolbar was given, the trailing
// ones move into an overflow menu and a "more" button takes their place. The
// helpers here decide how many items stay inline and how a child maps to a
// menu row.

import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../menu/menu.dart';
import 'toolbar_item.dart';
import 'toolbar_style.dart';
import 'toolbar_toggle_item.dart';

/// How many items stay inline; the rest move into the overflow menu.
///
/// [extents] holds the measured extent of every child; the overflow button's
/// own extent is stored under [overflowIndex]. Until every child has been
/// measured all of them stay inline and the next frame refines the split.
int toolbarVisibleCount({
  required int total,
  required Map<int, double> extents,
  required double available,
  required double gap,
  required int overflowIndex,
}) {
  if (total == 0) {
    return 0;
  }
  bool measured = true;
  for (int i = 0; i < total; i++) {
    if (!extents.containsKey(i)) {
      measured = false;
      break;
    }
  }
  if (!measured) {
    // Not measured yet: show everything, the next frame refines the split.
    return total;
  }
  double used = 0;
  for (int i = 0; i < total; i++) {
    used += (i == 0 ? 0 : gap) + (extents[i] ?? 0);
  }
  if (used <= available) {
    return total;
  }
  final double overflowExtent = extents[overflowIndex] ?? 40;
  double inline = 0;
  int count = 0;
  for (int i = 0; i < total; i++) {
    final double extent = extents[i] ?? 0;
    final double next = inline + (count == 0 ? 0 : gap) + extent;
    if (next + gap + overflowExtent > available) {
      break;
    }
    inline = next;
    count++;
  }
  return count;
}

/// Maps one toolbar child to a menu row.
///
/// A toggle becomes a checkable row and a plain item becomes a button row;
/// every other child is used as it is.
Widget toolbarMenuRow(Widget child) {
  if (child is ToolbarToggleItem) {
    return toolbarLabelledRow(
      child.semanticLabel ?? child.tooltip,
      MenuCheckboxItem(
        value: child.controller?.value ?? child.value,
        enabled: child.enabled,
        onChanged: (BuildContext context, bool value) {
          final ToolbarToggleController? controller = child.controller;
          if (controller != null) {
            controller.value = value;
          } else {
            child.onChanged?.call(value);
          }
        },
        child: child.label ?? child.child,
      ),
    );
  }
  if (child is ToolbarItem) {
    return toolbarLabelledRow(
      child.semanticLabel ?? child.tooltip,
      MenuButton(
        enabled: child.enabled,
        onPressed: (BuildContext context) => child.onPressed?.call(),
        child: child.label ?? child.child,
      ),
    );
  }
  return child;
}

/// Gives a menu row the name of the toolbar item it stands for.
///
/// A toolbar item is often an icon only, so the row in the overflow menu
/// would be announced as an unnamed button. The label is merged into the
/// row's own node, so the row keeps its button role.
Widget toolbarLabelledRow(String? label, Widget row) {
  if (label == null || label.isEmpty) {
    return row;
  }
  return MergeSemantics(
    child: Semantics(label: label, child: row),
  );
}

/// Builds the "more" button that stands in for the items that did not fit.
///
/// The button is a normal toolbar item, so it is wrapped in the same item
/// scope the other items get; it only carries the "focused" position of
/// [visible] so the roving focus can walk onto it.
Widget buildToolbarOverflowButton({
  required int visible,
  required Axis axis,
  required ToolbarStyle itemStyle,
  required ToolbarStyle groupStyle,
  required ToolbarStyle separatorStyle,
  required Map<LogicalKeySet, Intent> shortcuts,
  required Map<Type, Action<Intent>> actions,
  required Widget icon,
  required String tooltip,
  required String semanticLabel,
  required VoidCallback onPressed,
}) {
  final Widget button = ToolbarItem(
    tooltip: tooltip,
    semanticLabel: semanticLabel,
    onPressed: onPressed,
    child: icon,
  );
  return Data<ToolbarItemData>.inherit(
    data: ToolbarItemData(
      index: visible,
      axis: axis,
      itemStyle: itemStyle,
      groupStyle: groupStyle,
      separatorStyle: separatorStyle,
      focusedIndex: -1,
      shortcuts: shortcuts,
      actions: actions,
    ),
    child: button,
  );
}
