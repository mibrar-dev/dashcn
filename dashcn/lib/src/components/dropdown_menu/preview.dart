// Named examples for the `dropdown_menu` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the inline surface's rows are live and report the pick, and the
// "Trigger" example opens a real anchored menu so the demo shows the dropdown
// the way an app uses it.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../primitives/overlay.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../menu/menu.dart';
import 'dropdown_menu.dart';

/// The menu surface, 220px wide like the docs page shows it.
class _DropdownMenuDropdown extends StatefulWidget {
  const _DropdownMenuDropdown({
    this.withShortcut = false,
    this.withCheckbox = false,
  });

  final bool withShortcut;
  final bool withCheckbox;

  @override
  State<_DropdownMenuDropdown> createState() => _DropdownMenuDropdownState();
}

class _DropdownMenuDropdownState extends State<_DropdownMenuDropdown> {
  String _lastAction = 'Pick a row';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // P7-TH1: centred column — the 220px menu stays centred through the
    // inner `Center`, and the status line centres under it (a `start`
    // column would strand the status at x=0 once the `Center` expands the
    // column to the full stage width).
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 220,
            child: DropdownMenu(
              children: <Widget>[
                MenuButton(
                  child: const Text('Profile'),
                  onPressed: (_) => _run('Opened the profile'),
                ),
                MenuButton(
                  child: const Text('Settings'),
                  onPressed: (_) => _run('Opened settings'),
                ),
                const MenuSeparator(),
                if (widget.withShortcut)
                  MenuButton(
                    trailing: const MenuShortcut(shortcut: '⌘Q'),
                    child: const Text('Sign out'),
                    onPressed: (_) => _run('Signed out'),
                  )
                else
                  MenuButton(
                    child: const Text('Sign out'),
                    onPressed: (_) => _run('Signed out'),
                  ),
                if (widget.withCheckbox) ...<Widget>[
                  const MenuSeparator(),
                  MenuButton(
                    trailing: Text(_statusBar ? 'on' : 'off'),
                    child: const Text('Show status bar'),
                    onPressed: (_) => setState(() => _statusBar = !_statusBar),
                  ),
                  MenuButton(
                    trailing: Text(_bookmarks ? 'on' : 'off'),
                    child: const Text('Show bookmarks bar'),
                    onPressed: (_) => setState(() => _bookmarks = !_bookmarks),
                  ),
                ],
              ],
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _lastAction,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }

  bool _statusBar = true;
  bool _bookmarks = false;

  void _run(String action) => setState(() => _lastAction = action);
}

/// A trigger that anchors the menu with `showDropdown`.
class _DropdownMenuTrigger extends StatelessWidget {
  const _DropdownMenuTrigger();

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.outline,
      size: ButtonSize.sm,
      onPressed: () => showDropdown<void>(
        context: context,
        children: <Widget>[
          MenuButton(
            child: const Text('Profile'),
            onPressed: (_) => closeOverlay(context, 'Profile'),
          ),
          MenuButton(
            child: const Text('Settings'),
            onPressed: (_) => closeOverlay(context, 'Settings'),
          ),
          const MenuSeparator(),
          MenuButton(
            trailing: const MenuShortcut(shortcut: '⌘Q'),
            child: const Text('Sign out'),
            onPressed: (_) => closeOverlay(context, 'Sign out'),
          ),
        ],
      ),
      child: const Text('Open menu'),
    );
  }
}

/// The default menu.
Widget _dropdownMenuDefault(BuildContext context) =>
    const _DropdownMenuDropdown();

/// A menu with keyboard shortcuts.
Widget _dropdownMenuWithShortcut(BuildContext context) =>
    const _DropdownMenuDropdown(withShortcut: true);

/// A menu with checkbox-style rows.
Widget _dropdownMenuWithCheckboxItem(BuildContext context) =>
    const _DropdownMenuDropdown(withCheckbox: true);

/// An anchored dropdown opened from a button.
Widget _dropdownMenuTriggerExample(BuildContext context) =>
    const _DropdownMenuTrigger();

/// Named docs examples for `dropdown_menu`; the first entry is the default.
const List<ComponentPreview> dropdownMenuPreviews = <ComponentPreview>[
  ComponentPreview('Default', _dropdownMenuDefault),
  ComponentPreview('With shortcut', _dropdownMenuWithShortcut),
  ComponentPreview('With checkbox item', _dropdownMenuWithCheckboxItem),
  ComponentPreview('Trigger', _dropdownMenuTriggerExample),
];
