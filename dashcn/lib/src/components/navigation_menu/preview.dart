// Named examples for the `navigation_menu` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Each example carries its own bounded width because
// the menu popover measures against an infinite max width.
//
// P7-C2: the items are live — plain links report the page, dropdown items open
// their content list on tap.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'navigation_menu.dart';

/// A menu bar with plain, dropdown and popover items.
class _NavigationMenuBar extends StatefulWidget {
  const _NavigationMenuBar();

  @override
  State<_NavigationMenuBar> createState() => _NavigationMenuBarState();
}

class _NavigationMenuBarState extends State<_NavigationMenuBar> {
  String _page = 'Home';

  @override
  Widget build(BuildContext context) {
    final theme = ShadcnTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Intrinsic width: a fixed box clipped the bar under real text metrics.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: NavigationMenu(
            children: <Widget>[
              NavigationMenuItem(
                onPressed: () => setState(() => _page = 'Home'),
                child: const Text('Home'),
              ),
              NavigationMenuItem(
                content: NavigationMenuContentList(
                  children: <Widget>[
                    NavigationMenuContent(
                      title: const Text('Web Apps'),
                      content: const Text('Ship in the browser'),
                    ),
                    NavigationMenuContent(
                      title: const Text('Mobile Apps'),
                      content: const Text('Ship on the go'),
                    ),
                  ],
                ),
                child: const Text('Products'),
              ),
              NavigationMenuItem(
                content: const Text('Company info here'),
                onPressed: () => setState(() => _page = 'About'),
                child: const Text('About'),
              ),
            ],
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'Viewing $_page',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// A standalone two-column content list.
Widget _contentList(BuildContext context) {
  return const SizedBox(
    width: 340,
    child: NavigationMenuContentList(
      crossAxisCount: 2,
      children: <Widget>[
        NavigationMenuContent(
          title: Text('Dashboard'),
          content: Text('Analytics and insights'),
        ),
        NavigationMenuContent(
          title: Text('Settings'),
          content: Text('Preferences'),
        ),
        NavigationMenuContent(
          title: Text('Billing'),
          content: Text('Plans and invoices'),
        ),
      ],
    ),
  );
}

Widget _bar(BuildContext context) => const _NavigationMenuBar();

/// Named docs examples for `navigation_menu`; the first entry is the default.
const List<ComponentPreview> navigationMenuPreviews = <ComponentPreview>[
  ComponentPreview('Bar', _bar),
  ComponentPreview('Content list', _contentList),
];
