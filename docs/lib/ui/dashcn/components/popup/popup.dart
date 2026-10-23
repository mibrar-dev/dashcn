// The `popup` component: an anchored floating surface for arbitrary
// content. The surface itself is the menu component's `MenuPopup`
// (re-exported here); this file adds the generic show helper with Escape
// and outside-tap dismissal.
//
// Sizing follows the density principles (DESIGN.md): compact by default,
// the popup hugs its content between 160 and 320 px wide
// (`kOverlayMinWidthCompact`/`kOverlayMaxWidthCompact`) unless the caller
// pins [width] or overrides [maxWidth]/[maxHeight].

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/density.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../../primitives/overlay.dart';
import '../../primitives/popover.dart';
import '../menu/menu.dart';

export '../menu/menu.dart' show MenuPopup, MenuPopupTheme, menuPopupDefaults;

/// Shows [builder]'s content on a [MenuPopup] surface anchored to [context].
///
/// This is the generic popup: unlike `showMenu` the content is not a
/// menu (no roving focus, no rows), and unlike [showContextMenu] it is
/// anchored rather than pointer-positioned. Escape and an outside tap close
/// it while [modal] keeps the content behind non-interactive.
///
/// The surface hugs its content between 160 and 320 px wide (compact overlay
/// bounds); pass [width] to pin it or [maxWidth] to allow a wider panel.
Future<T?> showPopup<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  AlignmentGeometry alignment = Alignment.topCenter,
  AlignmentGeometry? anchorAlignment,
  Offset offset = const Offset(0, 4),
  PopoverConstraint widthConstraint = PopoverConstraint.flexible,
  PopoverConstraint heightConstraint = PopoverConstraint.flexible,
  bool modal = true,
  bool consumeOutsideTaps = true,
  MenuPopupTheme? theme,
  double? width,
  double? maxWidth,
  double? maxHeight,
  PopupAdaptive? adaptive,
}) {
  // SIZING.md: popups with free content carry 8 px inner padding (menus
  // with rows keep the 4 px surface padding); the surface still draws the
  // single 1 px border from the popup theme.
  final MenuPopupTheme effectiveTheme = (theme ?? const MenuPopupTheme()).merge(
    const MenuPopupTheme(
      minWidth: kOverlayMinWidthCompact,
      padding: EdgeInsetsDensity.pxAll(8),
    ),
  );
  return showPopover<T>(
    context: context,
    handler: OverlayHandler.popover,
    alignment: alignment,
    anchorAlignment: anchorAlignment,
    offset: offset,
    widthConstraint: widthConstraint,
    heightConstraint: heightConstraint,
    modal: modal,
    consumeOutsideTaps: consumeOutsideTaps,
    adaptive: adaptive,
    builder: (context) => Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          DismissIntent: CallbackAction<DismissIntent>(
            onInvoke: (_) {
              closeOverlay(context);
              return null;
            },
          ),
        },
        child: MenuPopup(
          theme: effectiveTheme,
          width: width,
          maxWidth: maxWidth ?? kOverlayMaxWidthCompact,
          maxHeight: maxHeight,
          children: <Widget>[
            Focus(autofocus: true, child: Builder(builder: builder)),
          ],
        ),
      ),
    ),
  ).future;
}
