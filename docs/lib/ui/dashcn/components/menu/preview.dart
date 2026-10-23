// Named examples for the `menu` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Menus render
// inline through `MenuPopup` (no overlay is opened), so the examples are
// shrink-wrapped with an exact popup width.
//
// P7-C2: every row is live and reports the action it ran, so the demo shows
// what a menu selection does.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'menu.dart';

/// Menu rows with a submenu and a disabled row.
class _MenuDefault extends StatefulWidget {
  const _MenuDefault();

  @override
  State<_MenuDefault> createState() => _MenuDefaultState();
}

class _MenuDefaultState extends State<_MenuDefault> {
  String _lastAction = docsSample(null, 'Pick a command');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuPopup(
          width: 240,
          children: <Widget>[
            MenuGroup(
              autofocus: false,
              children: <Widget>[
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
                MenuButton(
                  child: Text(docsSample(context, 'Paste')),
                  onPressed: (_) =>
                      _run(docsSample(context, 'Pasted from the clipboard')),
                ),
                const MenuSeparator(),
                MenuButton(
                  subMenu: <Widget>[
                    MenuButton(
                      child: Text(docsSample(context, 'Email')),
                      onPressed: (_) =>
                          _run(docsSample(context, 'Shared by email')),
                    ),
                    MenuButton(
                      child: Text(docsSample(context, 'Link')),
                      onPressed: (_) =>
                          _run(docsSample(context, 'Copied a share link')),
                    ),
                  ],
                  onPressed: (_) {},
                  child: Text(docsSample(context, 'Share')),
                ),
                MenuButton(
                  destructive: true,
                  onPressed: (_) =>
                      _run(docsSample(context, 'Deleted the selection')),
                  child: Text(docsSample(context, 'Delete')),
                ),
              ],
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

/// A labelled group with a live checkbox row.
class _CheckboxExample extends StatefulWidget {
  const _CheckboxExample();

  @override
  State<_CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<_CheckboxExample> {
  bool _toolbar = true;

  @override
  Widget build(BuildContext context) {
    return MenuPopup(
      width: 240,
      children: <Widget>[
        MenuGroup(
          autofocus: false,
          children: <Widget>[
            MenuLabel(child: Text(docsSample(context, 'Options'))),
            MenuCheckboxItem(
              value: _toolbar,
              onChanged: (BuildContext _, bool value) =>
                  setState(() => _toolbar = value),
              trailing: MenuShortcut(shortcut: '⌘T'),
              child: Text('Toolbar'),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _withCheckboxItem(BuildContext context) => const _CheckboxExample();

/// A live radio group.
class _RadioExample extends StatefulWidget {
  const _RadioExample();

  @override
  State<_RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<_RadioExample> {
  String _side = 'left';

  @override
  Widget build(BuildContext context) {
    return MenuPopup(
      width: 240,
      children: <Widget>[
        MenuGroup(
          autofocus: false,
          children: <Widget>[
            MenuRadioGroup<String>(
              value: _side,
              onChanged: (BuildContext _, String value) =>
                  setState(() => _side = value),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MenuRadioItem<String>(
                    value: 'left',
                    child: Text(docsSample(context, 'Left')),
                  ),
                  MenuRadioItem<String>(
                    value: 'right',
                    child: Text(docsSample(context, 'Right')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _withRadioGroup(BuildContext context) => const _RadioExample();

/// The default menu, with its live action line.
Widget _default(BuildContext context) => const _MenuDefault();

/// Named docs examples for `menu`; the first entry is the default.
List<ComponentPreview> get menuPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'With checkbox item'), _withCheckboxItem),
  ComponentPreview(docsSample(null, 'With radio group'), _withRadioGroup),
];
