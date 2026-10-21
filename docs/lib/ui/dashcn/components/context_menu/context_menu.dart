// The `context_menu` component: a menu shown at the pointer on right-click
// (and a long-press on touch platforms). Rows, traversal and the popup
// surface come from `menu`; this file adds the pointer gesture, the enlarged
// touch target and the positioned show helper.

import 'package:flutter/widgets.dart';

import '../../primitives/overlay.dart';
import '../../primitives/popover.dart';
import '../../primitives/sheet_overlay.dart';
import '../../theme/theme.dart';
import '../menu/menu.dart';

/// Default minimum menu width for [showContextMenu]: compact by the density
/// scale, wide enough for a shortcut gutter without wrapping.
const double kContextMenuMinWidth = 160;

/// Default maximum menu width for [showContextMenu]: long labels wrap
/// instead of stretching the surface across the viewport.
const double kContextMenuMaxWidth = 320;

/// Default minimum trigger extent on touch platforms (48px tap target).
const double kContextMenuMinTargetSize = 48;

/// Wraps [child] so a secondary-click (and a long-press on touch platforms)
/// opens [items] as a menu at the pointer.
///
/// The trigger hit area is [child] expanded by [targetPadding], and on touch
/// platforms it is at least [minTargetSize] on each axis so the menu stays
/// easy to open with a finger. The menu itself is non-modal: tapping outside
/// closes it, and the rows use the menu's traversal engine (arrows,
/// Enter/Space, Escape, typeahead). A secondary click on a disabled menu
/// does nothing.
class ContextMenu extends StatelessWidget {
  /// Creates a context menu.
  const ContextMenu({
    super.key,
    required this.child,
    required this.items,
    this.behavior = HitTestBehavior.translucent,
    this.direction = Axis.vertical,
    this.enabled = true,
    this.theme = const MenuTheme(),
    this.popupTheme,
    this.adaptive,
    this.targetPadding = const EdgeInsets.all(8),
    this.minTargetSize = kContextMenuMinTargetSize,
    this.menuMinWidth,
    this.menuMaxWidth,
    this.semanticsLabel,
  });

  /// The widget that triggers the menu.
  final Widget child;

  /// The menu rows.
  final List<Widget> items;

  /// Hit-test behavior of the trigger area.
  final HitTestBehavior behavior;

  /// Row layout of the menu.
  final Axis direction;

  /// Whether the menu can open.
  final bool enabled;

  /// Widget-leg row theme override, applied inside the popup.
  final MenuTheme theme;

  /// Widget-leg surface override, merged over the popup theme legs.
  final MenuPopupTheme? popupTheme;

  /// Responsive adaptive mode; null resolves the theme token (auto).
  final PopupAdaptive? adaptive;

  /// Extra hit region around [child] that still opens the menu. Visual size
  /// is unchanged (the padding is transparent); it only widens the target.
  final EdgeInsetsGeometry targetPadding;

  /// Minimum trigger width/height on touch platforms (iOS, Android,
  /// Fuchsia); null disables the floor. Desktop keeps the author's layout
  /// because right-click targets are pointer-precise.
  final double? minTargetSize;

  /// Minimum menu width; null resolves `popupTheme.minWidth`, then
  /// [kContextMenuMinWidth] (compact default).
  final double? menuMinWidth;

  /// Maximum menu width; null resolves [kContextMenuMaxWidth].
  final double? menuMaxWidth;

  /// Screen-reader label for the trigger; null leaves semantics untouched.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    final bool touch =
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    void open(Offset position) {
      // The pointer offset is physical: mirror it in RTL so the menu still
      // opens just past the pointer on the reading side.
      final bool rtl = Directionality.of(context) == TextDirection.rtl;
      showContextMenu<void>(
        context: context,
        position: position + Offset(rtl ? -8 : 8, 0),
        children: items,
        direction: direction,
        theme: theme,
        popupTheme: popupTheme,
        adaptive: adaptive,
        minWidth: menuMinWidth,
        maxWidth: menuMaxWidth,
      );
    }

    Widget trigger = Padding(padding: targetPadding, child: child);
    final double? floor = touch ? minTargetSize : null;
    if (floor != null) {
      trigger = ConstrainedBox(
        constraints: BoxConstraints(minWidth: floor, minHeight: floor),
        child: trigger,
      );
    }
    Widget result = GestureDetector(
      behavior: behavior,
      onSecondaryTapDown: enabled
          ? (details) => open(details.globalPosition)
          : null,
      onLongPressStart: enabled && touch
          ? (details) => open(details.globalPosition)
          : null,
      child: trigger,
    );
    final String? label = semanticsLabel;
    if (label != null) {
      result = Semantics(
        label: label,
        button: true,
        enabled: enabled,
        child: result,
      );
    }
    return result;
  }
}

/// Shows [children] as a context menu at [position] (global coordinates).
///
/// The menu opens just right of the pointer, is non-modal, keeps submenu
/// levels working and completes when a row closes it or a tap lands outside.
/// The opened menu takes focus so keyboard traversal works immediately. The
/// popup width hugs the content between [minWidth] (default
/// [kContextMenuMinWidth]) and [maxWidth] (default [kContextMenuMaxWidth]);
/// an explicit `popupTheme.minWidth` still wins over the default when
/// [minWidth] is null.
Future<T?> showContextMenu<T>({
  required BuildContext context,
  required Offset position,
  required List<Widget> children,
  Axis direction = Axis.vertical,
  MenuTheme theme = const MenuTheme(),
  MenuPopupTheme? popupTheme,
  PopupAdaptive? adaptive,
  double? minWidth,
  double? maxWidth,
}) {
  final double resolvedMin =
      minWidth ?? popupTheme?.minWidth ?? kContextMenuMinWidth;
  final double resolvedMax = maxWidth ?? kContextMenuMaxWidth;
  final double effectiveMax = resolvedMax < resolvedMin
      ? resolvedMin
      : resolvedMax;
  final MenuPopupTheme effectivePopupTheme =
      (popupTheme ?? const MenuPopupTheme()).copyWith(
        minWidth: () => resolvedMin,
      );
  return showPopover<T>(
    context: context,
    handler: OverlayHandler.popover,
    // [position] already includes the reading-side gap applied by the caller.
    position: position,
    alignment: Alignment.topLeft,
    modal: false,
    consumeOutsideTaps: false,
    dismissBackdropFocus: false,
    follow: false,
    adaptive: adaptive,
    builder: (context) {
      final ThemeData ambient = Theme.of(context);
      final EdgeInsets itemPadding = SheetOverlayHandler.isSheetOverlay(context)
          ? EdgeInsets.symmetric(horizontal: ambient.spacing.sm)
          : EdgeInsets.zero;
      return MenuPopup(
        theme: effectivePopupTheme,
        maxWidth: effectiveMax,
        children: <Widget>[
          ComponentTheme<MenuTheme>(
            data: theme,
            child: MenuGroup(
              autofocus: true,
              direction: direction,
              itemPadding: itemPadding,
              subMenuOffset: const Offset(8, -4),
              onDismissed: () => closeOverlay(context),
              children: children,
            ),
          ),
        ],
      );
    },
  ).future;
}
