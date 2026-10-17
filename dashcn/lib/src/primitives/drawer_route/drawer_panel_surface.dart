// The painted chrome of a drawer/sheet panel: fill, inner-edge border, rounded
// outer corners and an optional drag handle. Shared by the route shell
// (`drawer_shell.dart`) and the in-tree `swiper`, so both look identical and a
// `DrawerTheme` override applies to either.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../surface.dart';
import 'drawer_route.dart';

BorderRadius _innerRadius(BorderRadius radius, OverlayPosition position) {
  return switch (position) {
    OverlayPosition.left => BorderRadius.only(
      topRight: radius.topRight,
      bottomRight: radius.bottomRight,
    ),
    OverlayPosition.right => BorderRadius.only(
      topLeft: radius.topLeft,
      bottomLeft: radius.bottomLeft,
    ),
    OverlayPosition.top => BorderRadius.only(
      bottomLeft: radius.bottomLeft,
      bottomRight: radius.bottomRight,
    ),
    OverlayPosition.bottom => BorderRadius.only(
      topLeft: radius.topLeft,
      topRight: radius.topRight,
    ),
    OverlayPosition.start || OverlayPosition.end => radius,
  };
}

BoxBorder _innerBorder(Color color, double width, OverlayPosition position) {
  final BorderSide side = BorderSide(color: color, width: width);
  return Border(
    left: position == OverlayPosition.right ? side : BorderSide.none,
    right: position == OverlayPosition.left ? side : BorderSide.none,
    top: position == OverlayPosition.bottom ? side : BorderSide.none,
    bottom: position == OverlayPosition.top ? side : BorderSide.none,
  );
}

/// Paints a drawer/sheet panel around [child] from [theme].
class DrawerPanelSurface extends StatelessWidget {
  /// Creates a panel surface.
  const DrawerPanelSurface({
    super.key,
    required this.position,
    required this.theme,
    required this.child,
    this.showDragHandle = true,
    this.borderRadius,
  });

  /// Physical edge the panel is anchored to.
  final OverlayPosition position;

  /// Resolved panel style (`DrawerTheme` implements [DrawerRouteTheme]).
  final DrawerRouteTheme theme;

  /// Panel content.
  final Widget child;

  /// Whether the drag handle is drawn.
  final bool showDragHandle;

  /// Widget-leg radius override; null falls back to [theme].
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final ThemeColors colors = ambient.colors;

    // The drawer/sheet panel is a container: `theme.padding` defaults to a
    // density-multiplier value (see `drawerDefaultPadding`), so it is resolved
    // here, where it is painted. A plain `EdgeInsets` override (the shared
    // `swiper` chrome passes one) resolves unchanged.
    Widget content = Padding(
      padding: resolveEdgeInsets(
        theme.padding ?? EdgeInsets.zero,
        ambient.density.baseContentPadding * ambient.scaling,
      ),
      child: child,
    );
    if (showDragHandle) {
      final Size handleSize = theme.dragHandleSize ?? const Size(36, 4);
      final Color handleColor =
          (theme.dragHandleColor ?? ThemedColor.ref(ColorRef.muted)).resolve(
            colors,
          );
      content = Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              width: handleSize.width,
              height: handleSize.height,
              decoration: BoxDecoration(
                color: handleColor,
                borderRadius: BorderRadius.circular(handleSize.height / 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: content),
        ],
      );
    }

    final BorderRadius radius =
        borderRadius ?? theme.borderRadius ?? ambient.borderRadiusLg;
    final Color? borderColor = theme.borderColor?.resolve(colors);
    final double borderWidth = theme.borderWidth ?? 0;
    final List<BoxShadow> shadows =
        theme.shadows ??
        (theme.themeShadows ?? ambient.tokens.shadows).shadowLg;
    final BorderRadiusGeometry paintRadius = _innerRadius(radius, position);
    final Color? base = theme.background?.resolve(colors);
    // No theme fill stays transparent at the opaque default (exactly
    // today's rendering); under a glass theme the panel frosts with the
    // `background` token so the global opacity/blur reaches it too.
    final bool glass =
        (ambient.surfaceOpacity ?? 1) < 1 || (ambient.surfaceBlur ?? 0) > 0;
    final Color? fill = base == null
        ? (glass
              ? surfaceColor(colors.background, ambient.surfaceOpacity)
              : null)
        : surfaceColor(base, ambient.surfaceOpacity);
    return GlassSurface(
      surfaceBlur: ambient.surfaceBlur,
      borderRadius: paintRadius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: paintRadius,
          border: borderColor == null || borderWidth <= 0
              ? null
              : _innerBorder(borderColor, borderWidth, position),
          boxShadow: shadows.isEmpty ? null : shadows,
        ),
        child: content,
      ),
    );
  }
}
