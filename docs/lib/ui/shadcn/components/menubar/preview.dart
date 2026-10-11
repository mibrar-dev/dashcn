// Named examples for the `menubar` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Only the bar
// renders (submenus open on tap), so the examples shrink-wrap with no extra
// scaffolding.
//
// P7-C2: the rows are live — picking one reports the command under the bar.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../menu/menu.dart';
import 'menubar.dart';

/// File / Edit / View triggers, each with a submenu of menu rows.
class _MenubarDefault extends StatefulWidget {
  const _MenubarDefault();

  @override
  State<_MenubarDefault> createState() => _MenubarDefaultState();
}

class _MenubarDefaultState extends State<_MenubarDefault> {
  String _lastAction = 'Open a menu and pick a command';

  @override
  Widget build(BuildContext context) {
    final theme = ShadcnTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Menubar(
          children: <Widget>[
            MenuButton(
              subMenu: <Widget>[
                MenuButton(
                  child: const Text('New'),
                  onPressed: (_) => _run('New document'),
                ),
                MenuButton(
                  child: const Text('Open'),
                  onPressed: (_) => _run('Opened a document'),
                ),
                const MenuSeparator(),
                MenuButton(
                  trailing: const MenuShortcut(shortcut: '⌘S'),
                  child: const Text('Save'),
                  onPressed: (_) => _run('Saved the document'),
                ),
              ],
              child: const Text('File'),
            ),
            MenuButton(
              subMenu: <Widget>[
                MenuButton(
                  child: const Text('Cut'),
                  onPressed: (_) => _run('Cut the selection'),
                ),
                MenuButton(
                  child: const Text('Copy'),
                  onPressed: (_) => _run('Copied to the clipboard'),
                ),
              ],
              child: const Text('Edit'),
            ),
            MenuButton(
              subMenu: <Widget>[
                const MenuLabel(child: Text('Zoom')),
                MenuButton(
                  child: const Text('100%'),
                  onPressed: (_) => _run('Zoom 100%'),
                ),
                MenuButton(
                  child: const Text('150%'),
                  onPressed: (_) => _run('Zoom 150%'),
                ),
              ],
              child: const Text('View'),
            ),
          ],
        ),
        Gap(theme.spacing.md),
        Text(
          _lastAction,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// A nested submenu under the View trigger.
class _WithSubmenu extends StatelessWidget {
  const _WithSubmenu();

  @override
  Widget build(BuildContext context) {
    return Menubar(
      children: <Widget>[
        MenuButton(
          subMenu: <Widget>[
            const MenuLabel(child: Text('Zoom')),
            MenuSub(
              trigger: const Text('Zoom level'),
              children: <Widget>[
                MenuButton(child: const Text('100%'), onPressed: (_) {}),
                MenuButton(child: const Text('150%'), onPressed: (_) {}),
              ],
            ),
          ],
          child: const Text('View'),
        ),
      ],
    );
  }
}

/// The default bar with its live action line.
Widget _default(BuildContext context) => const _MenubarDefault();

/// A nested submenu under the View trigger.
Widget _withSubmenu(BuildContext context) => const _WithSubmenu();

/// Named docs examples for `menubar`; the first entry is the default.
const List<ComponentPreview> menubarPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('With submenu', _withSubmenu),
];
