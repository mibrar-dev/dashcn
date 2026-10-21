// The container paint of the `toolbar` component.
//
// The toolbar's own box: the fill, the border and the padding around the
// items. The items' pressable paint lives in `toolbar_item_surface.dart`.

import 'package:flutter/widgets.dart';

import '../../primitives/surface.dart';
import '../../theme/theme.dart';
import 'toolbar_style.dart';

/// Builds the toolbar's container: the fill, the border and the padding.
///
/// The fill and the border come from [style]; the border is only painted
/// when a colour *and* a width are given.
Widget buildToolbarSurface({
  required BuildContext context,
  required ToolbarStyle style,
  required EdgeInsets padding,
  required Widget child,
}) {
  final ThemeData ambient = Theme.of(context);
  final Color? rawFill = style.background?.resolve(ambient.colors);
  // Frosted glass: the container fill carries the component surfaceOpacity
  // leg (ambient fallback) and the blur wraps the painted container — no
  // extra layer at the opaque default, so defaults render identical.
  final double? opacity = resolveSurfaceOpacity(
    context,
    component: style.surfaceOpacity,
  );
  final double? blur = resolveSurfaceBlur(
    context,
    component: style.surfaceBlur,
  );
  final Color? fill = rawFill == null ? null : surfaceColor(rawFill, opacity);
  final Color? border = style.borderColor?.resolve(ambient.colors);
  final double borderWidth = style.borderWidth ?? 0;
  final BorderRadiusGeometry radius =
      style.borderRadius ?? ambient.borderRadiusLg;
  return GlassSurface(
    surfaceBlur: blur,
    borderRadius: radius,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: radius,
        border: border == null || borderWidth <= 0
            ? null
            : Border.all(color: border, width: borderWidth),
      ),
      child: Padding(padding: padding, child: child),
    ),
  );
}
