// Named examples for the `scaffold` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Each shell carries its own bounded box because the
// scaffold stretches to its constraints.
//
// P7-C2: the app-bar actions are live — the ellipsis opens a real menu and the
// picked command is reported under the shell.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../dropdown_menu/dropdown_menu.dart';
import '../menu/menu.dart';
import 'scaffold.dart';

/// One icon action in the app bar: a real `Button` so it is keyboard reachable.
class _AppBarAction extends StatelessWidget {
  const _AppBarAction({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.ghost,
      onPressed: onPressed,
      child: Semantics(label: label, child: Icon(icon, size: 16)),
    );
  }
}

/// A shell whose header and footer actions report what they did.
class _ScaffoldDefault extends StatefulWidget {
  const _ScaffoldDefault();

  @override
  State<_ScaffoldDefault> createState() => _ScaffoldDefaultState();
}

class _ScaffoldDefaultState extends State<_ScaffoldDefault> {
  String _lastAction = 'Tap an app-bar action';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 360,
          height: 280,
          child: Scaffold(
            headers: <Widget>[
              AppBar(
                leading: <Widget>[
                  _AppBarAction(
                    icon: LucideIcons.chevronLeft,
                    label: 'Back',
                    onPressed: () => setState(() => _lastAction = 'Went back'),
                  ),
                ],
                title: const Text('My Application'),
                subtitle: const Text('Dashboard'),
                trailing: <Widget>[
                  _AppBarAction(
                    icon: LucideIcons.ellipsis,
                    label: 'More',
                    onPressed: _openMenu,
                  ),
                ],
              ),
            ],
            footers: <Widget>[
              AppBar(
                title: const Text('Status'),
                subtitle: const Text('All systems go'),
              ),
            ],
            child: const Center(child: Text('Main content area')),
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

  void _openMenu() {
    showDropdown<void>(
      context: context,
      children: <Widget>[
        MenuButton(
          child: const Text('Rename'),
          onPressed: (_) => _run('Rename chosen'),
        ),
        MenuButton(
          child: const Text('Duplicate'),
          onPressed: (_) => _run('Duplicated'),
        ),
        const MenuSeparator(),
        MenuButton(
          child: const Text('Archive'),
          onPressed: (_) => _run('Archived'),
        ),
      ],
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// A shell showing the loading bar over fetching content.
Widget _withLoading(BuildContext context) {
  return const SizedBox(
    width: 360,
    height: 200,
    child: Scaffold(
      headers: <Widget>[AppBar(title: Text('Syncing'))],
      loadingProgress: 0.4,
      showLoadingSparks: true,
      child: Center(child: Text('Fetching...')),
    ),
  );
}

Widget _default(BuildContext context) => const _ScaffoldDefault();

/// Named docs examples for `scaffold`; the first entry is the default.
const List<ComponentPreview> scaffoldPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('With loading', _withLoading),
];
