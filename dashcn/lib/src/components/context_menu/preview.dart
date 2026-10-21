// Named examples for the `context_menu` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the menu is live — right-click the card on desktop (long-press on
// touch) to open it, and picking a row reports the action under the card.
// Every demo shows a visible gesture hint so the trigger is discoverable.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../menu/menu.dart';
import 'context_menu.dart';

/// Visible gesture hint: an icon plus the platform's open gesture.
///
/// Touch platforms read "Long-press …", desktop reads "Right-click …", and
/// the caption always names both so the demo is discoverable either way.
class _GestureHint extends StatelessWidget {
  const _GestureHint({required this.action});

  /// What the hinted surface does, e.g. 'this card'.
  final String action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool touch =
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    // Short lines on purpose: the hint must stay inside the 232px card
    // content on every font (widget-test fonts run wider than Inter).
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              touch ? LucideIcons.hand : LucideIcons.mousePointerClick,
              size: 14,
              color: theme.colors.foreground,
            ),
            SizedBox(width: theme.spacing.xs),
            Flexible(
              child: Text(
                '${touch ? 'Long-press' : 'Right-click'} $action',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        Text(
          'Desktop: right-click · touch: long-press',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

class _ContextMenuSurface extends StatefulWidget {
  const _ContextMenuSurface({
    this.hintAction = 'here',
    this.targetPadding = const EdgeInsets.all(8),
    this.minTargetSize = kContextMenuMinTargetSize,
    this.menuMinWidth,
    this.menuMaxWidth,
    this.popupTheme,
    this.withSubmenu = false,
    this.child,
    this.showTargetOutline = false,
  });

  final String hintAction;
  final EdgeInsetsGeometry targetPadding;
  final double? minTargetSize;
  final double? menuMinWidth;
  final double? menuMaxWidth;
  final MenuPopupTheme? popupTheme;
  final bool withSubmenu;
  final bool showTargetOutline;

  /// Custom trigger child; null draws the default card.
  final Widget? child;

  @override
  State<_ContextMenuSurface> createState() => _ContextMenuSurfaceState();
}

class _ContextMenuSurfaceState extends State<_ContextMenuSurface> {
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget trigger =
        widget.child ??
        Container(
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colors.border),
            borderRadius: theme.borderRadiusMd,
          ),
          child: _GestureHint(action: widget.hintAction),
        );
    if (widget.showTargetOutline) {
      // The muted wash marks the padded hit region around the child so the
      // expanded target is visible, not just larger.
      trigger = Container(
        padding: widget.targetPadding,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: theme.borderRadiusMd,
        ),
        child: trigger,
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Custom-child demos (e.g. the bare touch icon) label the trigger
          // with the same gesture hint the cards carry inside.
          if (widget.child != null) ...<Widget>[
            _GestureHint(action: widget.hintAction),
            SizedBox(height: theme.spacing.md),
          ],
          ContextMenu(
            targetPadding: widget.showTargetOutline
                ? EdgeInsets.zero
                : widget.targetPadding,
            minTargetSize: widget.minTargetSize,
            menuMinWidth: widget.menuMinWidth,
            menuMaxWidth: widget.menuMaxWidth,
            popupTheme: widget.popupTheme,
            semanticsLabel: 'Actions for ${widget.hintAction}',
            items: <Widget>[
              MenuButton(
                child: const Text('Back'),
                onPressed: (_) => _run('Went back'),
              ),
              MenuButton(
                child: const Text('Reload'),
                onPressed: (_) => _run('Reloaded the page'),
              ),
              MenuButton(
                trailing: const MenuShortcut(shortcut: '⌘C'),
                child: const Text('Copy link'),
                onPressed: (_) => _run('Copied the link'),
              ),
              const MenuSeparator(),
              MenuButton(
                trailing: const Icon(LucideIcons.chevronRight, size: 14),
                enabled: widget.withSubmenu,
                child: const Text('More tools'),
                onPressed: (_) {},
              ),
              MenuButton(
                enabled: false,
                child: const Text('Inspect'),
                onPressed: (_) {},
              ),
            ],
            child: trigger,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            _lastAction ?? 'Pick an action from the menu',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// The default context menu surface.
Widget _contextMenuDefault(BuildContext context) => const _ContextMenuSurface();

/// A surface whose menu row opens a submenu.
Widget _contextMenuWithSubmenu(BuildContext context) =>
    const _ContextMenuSurface(hintAction: 'this card', withSubmenu: true);

/// A 24px icon trigger: the 48px touch floor keeps it hittable on mobile.
Widget _contextMenuTouchTarget(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return _ContextMenuSurface(
    hintAction: 'the icon',
    // The 48px touch floor is the point of this demo: pass it explicitly.
    minTargetSize: kContextMenuMinTargetSize,
    child: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusSm,
      ),
      child: Icon(LucideIcons.hand, size: 14, color: theme.colors.foreground),
    ),
  );
}

/// The padded hit region, drawn as a muted wash around the card.
Widget _contextMenuExpandedTarget(BuildContext context) =>
    const _ContextMenuSurface(
      hintAction: 'the wash',
      targetPadding: EdgeInsets.all(28),
      showTargetOutline: true,
    );

/// A customized menu: clamped width plus a per-instance surface override.
Widget _contextMenuCompactMenu(BuildContext context) =>
    const _ContextMenuSurface(
      hintAction: 'this card',
      menuMinWidth: 200,
      menuMaxWidth: 240,
      popupTheme: MenuPopupTheme(padding: EdgeInsetsDensity.pxAll(8)),
    );

/// Named docs examples for `context_menu`; the first entry is the default.
const List<ComponentPreview> contextMenuPreviews = <ComponentPreview>[
  ComponentPreview('Default', _contextMenuDefault),
  ComponentPreview('With submenu', _contextMenuWithSubmenu),
  ComponentPreview('Touch target', _contextMenuTouchTarget),
  ComponentPreview('Expanded target', _contextMenuExpandedTarget),
  ComponentPreview('Compact menu', _contextMenuCompactMenu),
];
