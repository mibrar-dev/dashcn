// Named examples for the `context_menu` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the menu is live — right-click the card to open it, and picking a row
// reports the action under the card.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../menu/menu.dart';
import 'context_menu.dart';

/// The right-click surface.
class _ContextMenuSurface extends StatefulWidget {
  const _ContextMenuSurface({this.withSubmenu = false});

  final bool withSubmenu;

  @override
  State<_ContextMenuSurface> createState() => _ContextMenuSurfaceState();
}

class _ContextMenuSurfaceState extends State<_ContextMenuSurface> {
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ContextMenu(
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
            child: Container(
              width: 220,
              padding: EdgeInsetsDensity.pxAll(32),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colors.border),
                borderRadius: theme.borderRadiusMd,
              ),
              child: Text(
                widget.withSubmenu
                    ? 'Right-click: the submenu row is enabled'
                    : 'Right-click anywhere on this card',
                style: TextStyle(color: theme.colors.mutedForeground),
              ),
            ),
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
    const _ContextMenuSurface(withSubmenu: true);

/// Named docs examples for `context_menu`; the first entry is the default.
const List<ComponentPreview> contextMenuPreviews = <ComponentPreview>[
  ComponentPreview('Default', _contextMenuDefault),
  ComponentPreview('With submenu', _contextMenuWithSubmenu),
];
