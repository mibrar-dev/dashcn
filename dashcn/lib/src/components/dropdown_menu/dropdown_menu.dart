// The `dropdown_menu` component: a menu surface anchored below the widget
// that opened it. Rows, traversal and the popup surface come from `menu`;
// this file adds the anchored show helper and the standalone surface.
//
// Sizing follows the density principles (DESIGN.md): compact by default,
// the menu hugs its content between 160 and 320 px wide
// (`kOverlayMinWidthCompact`/`kOverlayMaxWidthCompact`), and each row is the
// density row height (32 px compact via the menu rows).

import 'package:flutter/widgets.dart';

import '../../primitives/overlay.dart';
import '../../primitives/popover.dart';
import '../../primitives/sheet_overlay.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../menu/menu.dart';

/// A menu surface for a dropdown: the menu's rows inside a [MenuPopup],
/// dismissing the overlay it is shown in when a row closes the menu.
///
/// Inline surfaces never take focus on mount; overlay helpers pass
/// `autofocus: true` for the opened menu.
///
/// The surface hugs its content between [minWidth] (default 160 compact) and
/// [maxWidth] (default 320 compact) per the density principles; pass an
/// explicit width to pin it.
class DropdownMenu extends StatelessWidget {
  /// Creates a dropdown menu surface.
  const DropdownMenu({
    super.key,
    required this.children,
    this.theme,
    this.autofocus = false,
    this.width,
    this.minWidth = kOverlayMinWidthCompact,
    this.maxWidth = kOverlayMaxWidthCompact,
    this.maxHeight,
  });

  /// The menu rows.
  final List<Widget> children;

  /// Widget-leg surface override, merged over the popup theme legs.
  final MenuPopupTheme? theme;

  /// Whether the group takes focus on mount; true for opened overlays.
  final bool autofocus;

  /// Exact popup width; null hugs the content between [minWidth]-[maxWidth].
  final double? width;

  /// Minimum popup width; defaults to the compact overlay minimum (160).
  final double minWidth;

  /// Maximum popup width; defaults to the compact overlay maximum (320).
  final double maxWidth;

  /// Maximum popup height; null keeps the MenuPopup default (360).
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    // Inside a sheet overlay the menu keeps the sheet's horizontal gutter.
    final EdgeInsets itemPadding = SheetOverlayHandler.isSheetOverlay(context)
        ? EdgeInsets.symmetric(horizontal: ambient.spacing.sm)
        : EdgeInsets.zero;
    final MenuPopupTheme effectiveTheme = (theme ?? const MenuPopupTheme())
        .merge(const MenuPopupTheme(minWidth: kOverlayMinWidthCompact));
    return MenuPopup(
      theme: effectiveTheme,
      width: width,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      children: <Widget>[
        MenuGroup(
          autofocus: autofocus,
          itemPadding: itemPadding,
          subMenuOffset: const Offset(8, -4),
          onDismissed: () => closeOverlay(context),
          children: children,
        ),
      ],
    );
  }
}

/// Shows [children] as a dropdown menu anchored to [context].
///
/// The menu is non-modal: tapping outside closes it, taps do not reach the
/// content behind it while it is open, and submenu levels keep working
/// through the menu's own traversal engine. The opened menu takes focus so
/// keyboard traversal works immediately. Completes with the value passed
/// to [closeOverlay] or `null` when dismissed.
///
/// The popup hugs its content between 160 and 320 px wide (compact overlay
/// bounds); override with [width]/[maxWidth] when a wider menu is needed.
Future<T?> showDropdown<T>({
  required BuildContext context,
  required List<Widget> children,
  AlignmentGeometry alignment = AlignmentDirectional.topStart,
  AlignmentGeometry anchorAlignment = AlignmentDirectional.bottomStart,
  Offset offset = const Offset(0, 4),
  PopoverConstraint widthConstraint = PopoverConstraint.anchorFixedSize,
  PopoverConstraint heightConstraint = PopoverConstraint.flexible,
  MenuPopupTheme? theme,
  double? width,
  double maxWidth = kOverlayMaxWidthCompact,
  double? maxHeight,
  PopupAdaptive? adaptive,
}) {
  return showPopover<T>(
    context: context,
    handler: OverlayHandler.popover,
    alignment: alignment,
    anchorAlignment: anchorAlignment,
    offset: offset,
    widthConstraint: widthConstraint,
    heightConstraint: heightConstraint,
    modal: false,
    consumeOutsideTaps: false,
    dismissBackdropFocus: false,
    adaptive: adaptive,
    builder: (context) => DropdownMenu(
      autofocus: true,
      theme: theme,
      width: width,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      children: children,
    ),
  ).future;
}
