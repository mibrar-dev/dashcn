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
  String _lastAction = docsSample(null, 'Open a menu and pick a command');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Menubar(
          children: <Widget>[
            MenuButton(
              subMenu: <Widget>[
                MenuButton(
                  child: Text('New'),
                  onPressed: (_) => _run(docsSample(context, 'New document')),
                ),
                MenuButton(
                  child: Text(docsSample(context, 'Open')),
                  onPressed: (_) =>
                      _run(docsSample(context, 'Opened a document')),
                ),
                const MenuSeparator(),
                MenuButton(
                  trailing: MenuShortcut(shortcut: '⌘S'),
                  child: Text(docsSample(context, 'Save')),
                  onPressed: (_) =>
                      _run(docsSample(context, 'Saved the document')),
                ),
              ],
              child: Text(docsSample(context, 'File')),
            ),
            MenuButton(
              subMenu: <Widget>[
                MenuButton(
                  child: Text('Cut'),
                  onPressed: (_) =>
                      _run(docsSample(context, 'Cut the selection')),
                ),
                MenuButton(
                  child: Text(docsSample(context, 'Copy')),
                  onPressed: (_) =>
                      _run(docsSample(context, 'Copied to the clipboard')),
                ),
              ],
              child: Text(docsSample(context, 'Edit')),
            ),
            MenuButton(
              subMenu: <Widget>[
                MenuLabel(child: Text(docsSample(context, 'Zoom'))),
                MenuButton(
                  child: const Text('100%'),
                  onPressed: (_) => _run(docsSample(context, 'Zoom 100%')),
                ),
                MenuButton(
                  child: const Text('150%'),
                  onPressed: (_) => _run(docsSample(context, 'Zoom 150%')),
                ),
              ],
              child: Text(docsSample(context, 'View')),
            ),
          ],
        ),
        Gap(theme.spacing.md),
        Text(
          docsSample(context, _lastAction),
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
            MenuLabel(child: Text(docsSample(context, 'Zoom'))),
            MenuSub(
              trigger: Text(docsSample(context, 'Zoom level')),
              children: <Widget>[
                MenuButton(child: const Text('100%'), onPressed: (_) {}),
                MenuButton(child: const Text('150%'), onPressed: (_) {}),
              ],
            ),
          ],
          child: Text(docsSample(context, 'View')),
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
List<ComponentPreview> get menubarPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'With submenu'), _withSubmenu),
];
