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
import '../../theme/color_tokens.dart';
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
  String _lastAction = docsSample(null, 'Pick a row');

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
                  child: Text(docsSample(context, 'Profile')),
                  onPressed: (_) =>
                      _run(docsSample(context, 'Opened the profile')),
                ),
                MenuButton(
                  child: Text(docsSample(context, 'Settings')),
                  onPressed: (_) =>
                      _run(docsSample(context, 'Opened settings')),
                ),
                const MenuSeparator(),
                if (widget.withShortcut)
                  MenuButton(
                    trailing: MenuShortcut(shortcut: '⌘Q'),
                    child: Text(docsSample(context, 'Sign out')),
                    onPressed: (_) => _run(docsSample(context, 'Signed out')),
                  )
                else
                  MenuButton(
                    child: Text(docsSample(context, 'Sign out')),
                    onPressed: (_) => _run(docsSample(context, 'Signed out')),
                  ),
                if (widget.withCheckbox) ...<Widget>[
                  const MenuSeparator(),
                  MenuButton(
                    trailing: Text(_statusBar ? 'on' : 'off'),
                    child: Text(docsSample(context, 'Show status bar')),
                    onPressed: (_) => setState(() => _statusBar = !_statusBar),
                  ),
                  MenuButton(
                    trailing: Text(_bookmarks ? 'on' : 'off'),
                    child: Text(docsSample(context, 'Show bookmarks bar')),
                    onPressed: (_) => setState(() => _bookmarks = !_bookmarks),
                  ),
                ],
              ],
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          docsSample(context, _lastAction),
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
            child: Text(docsSample(context, 'Profile')),
            onPressed: (_) =>
                closeOverlay(context, docsSample(context, 'Profile')),
          ),
          MenuButton(
            child: Text(docsSample(context, 'Settings')),
            onPressed: (_) =>
                closeOverlay(context, docsSample(context, 'Settings')),
          ),
          const MenuSeparator(),
          MenuButton(
            trailing: MenuShortcut(shortcut: '⌘Q'),
            child: Text(docsSample(context, 'Sign out')),
            onPressed: (_) =>
                closeOverlay(context, docsSample(context, 'Sign out')),
          ),
        ],
      ),
      child: Text(docsSample(context, 'Open menu')),
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

/// A customized surface: widget-leg theme override (tinted fill).
Widget _dropdownMenuCustomized(BuildContext context) {
  return SizedBox(
    width: 220,
    child: DropdownMenu(
      theme: MenuPopupTheme(background: ThemedColor.value(Color(0xFFF0FDF4))),
      children: <Widget>[
        MenuButton(child: Text(docsSample(context, 'Profile'))),
        MenuButton(child: Text(docsSample(context, 'Settings'))),
      ],
    ),
  );
}

/// An anchored dropdown opened from a button.
Widget _dropdownMenuTriggerExample(BuildContext context) =>
    const _DropdownMenuTrigger();

/// Named docs examples for `dropdown_menu`; the first entry is the default.
List<ComponentPreview> get dropdownMenuPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _dropdownMenuDefault),
  ComponentPreview(
    docsSample(null, 'With shortcut'),
    _dropdownMenuWithShortcut,
  ),
  ComponentPreview(
    docsSample(null, 'With checkbox item'),
    _dropdownMenuWithCheckboxItem,
  ),
  ComponentPreview(docsSample(null, 'Trigger'), _dropdownMenuTriggerExample),
  ComponentPreview(docsSample(null, 'Customized'), _dropdownMenuCustomized),
];
