// The inner content of the `fab` component.
//
// The button is round when it only paints an icon and becomes a pill when it
// paints a label as well. [buildFabContent] lays the three slots out: the
// custom [content] (which replaces the icon and the label), the [icon] and
// the [label].

import 'package:flutter/widgets.dart';

import 'fab_style.dart';

/// Builds the inner content of a floating action button.
///
/// * [content] replaces the icon and the label when it is given;
/// * [icon] and [label] are the two slots otherwise;
/// * [box] is the size of the button box, so the content keeps the button's
///   minimum size;
/// * [gap] is the distance between the icon and the label.
Widget buildFabContent({
  required BuildContext context,
  required Widget? content,
  required Widget? icon,
  required Widget? label,
  required FabStyle resolved,
  required double box,
  required double gap,
}) {
  final Widget? custom = content;
  if (custom != null) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: box),
      child: custom,
    );
  }
  if (icon == null && label == null) {
    return SizedBox(width: box, height: box);
  }
  final EdgeInsetsGeometry labelPadding =
      resolved.labelPadding ?? EdgeInsetsDirectional.only(start: gap);
  final EdgeInsets resolvedLabelPadding = labelPadding.resolve(
    Directionality.of(context),
  );
  final EdgeInsets resolvedPadding = (resolved.padding ?? EdgeInsets.zero)
      .resolve(Directionality.of(context));
  if (icon == null) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: box),
      child: Padding(
        padding: resolvedPadding.add(resolvedLabelPadding),
        child: label,
      ),
    );
  }
  if (label == null) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: box, minHeight: box),
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Padding(padding: resolvedPadding, child: icon),
      ),
    );
  }
  return ConstrainedBox(
    constraints: BoxConstraints(minHeight: box),
    child: Padding(
      padding: resolvedPadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(widthFactor: 1, heightFactor: 1, child: icon),
          Padding(padding: resolvedLabelPadding, child: label),
        ],
      ),
    ),
  );
}
