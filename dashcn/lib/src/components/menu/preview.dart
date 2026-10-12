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
  String _lastAction = 'Pick a command';

  @override
  Widget build(BuildContext context) {
    final theme = ShadcnTheme.of(context);
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
                  child: const Text('Cut'),
                  onPressed: (_) => _run('Cut the selection'),
                ),
                MenuButton(
                  child: const Text('Copy'),
                  onPressed: (_) => _run('Copied to the clipboard'),
                ),
                MenuButton(
                  child: const Text('Paste'),
                  onPressed: (_) => _run('Pasted from the clipboard'),
                ),
                const MenuSeparator(),
                MenuButton(
                  subMenu: <Widget>[
                    MenuButton(
                      child: const Text('Email'),
                      onPressed: (_) => _run('Shared by email'),
                    ),
                    MenuButton(
                      child: const Text('Link'),
                      onPressed: (_) => _run('Copied a share link'),
                    ),
                  ],
                  onPressed: (_) {},
                  child: const Text('Share'),
                ),
                MenuButton(
                  enabled: false,
                  onPressed: null,
                  child: const Text('Delete'),
                ),
              ],
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
            const MenuLabel(child: Text('Options')),
            MenuCheckboxItem(
              value: _toolbar,
              onChanged: (BuildContext _, bool value) =>
                  setState(() => _toolbar = value),
              trailing: const MenuShortcut(shortcut: '⌘T'),
              child: const Text('Toolbar'),
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
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MenuRadioItem<String>(value: 'left', child: Text('Left')),
                  MenuRadioItem<String>(value: 'right', child: Text('Right')),
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
const List<ComponentPreview> menuPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('With checkbox item', _withCheckboxItem),
  ComponentPreview('With radio group', _withRadioGroup),
];
