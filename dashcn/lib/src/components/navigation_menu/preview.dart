// Named examples for the `navigation_menu` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/text/text_extension.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'navigation_menu.dart';

/// Featured tile for the Getting-started panel (upstream's gradient card).
Widget _featuredTile(ThemeData theme, [BuildContext? context]) {
  return Button(
    variant: ButtonVariant.ghost,
    onPressed: () {},
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[theme.colors.muted, theme.colors.accent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('dashcn').small().medium(),
          Text(
            docsSample(context, 'Beautifully designed components'),
          ).muted().small(),
        ],
      ),
    ),
  );
}

/// Getting-started panel: featured tile plus three links.
Widget _gettingStarted(ThemeData theme, [BuildContext? context]) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 200, child: _featuredTile(theme, context)),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NavigationMenuContent(
              title: Text(docsSample(context, 'Introduction')),
              content: Text(
                docsSample(context, 'Re-usable components for your apps'),
              ),
              onPressed: _noop,
            ),
            NavigationMenuContent(
              title: Text(docsSample(context, 'Installation')),
              content: Text(
                docsSample(context, 'How to install dependencies and code'),
              ),
              onPressed: _noop,
            ),
            NavigationMenuContent(
              title: Text(docsSample(context, 'Typography')),
              content: Text(
                docsSample(context, 'Styles for headings and paragraphs'),
              ),
              onPressed: _noop,
            ),
          ],
        ),
      ),
    ],
  );
}

void _noop() {}

/// Components panel: two-column grid of six links.
Widget _componentsGrid([BuildContext? context]) {
  return NavigationMenuContentList(
    crossAxisCount: 2,
    children: <Widget>[
      NavigationMenuContent(
        title: Text('Alert Dialog'),
        content: Text(
          docsSample(context, 'A modal dialog that interrupts the user'),
        ),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Hover Card'),
        content: Text(
          docsSample(context, 'For sighted users to preview content'),
        ),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Progress'),
        content: Text(
          docsSample(context, 'Displays an indicator showing progress'),
        ),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text(docsSample(context, 'Scroll Area')),
        content: Text(
          docsSample(context, 'Visually separates content into sections'),
        ),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Tabs'),
        content: Text(
          docsSample(context, 'A set of layered sections of content'),
        ),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Tooltip'),
        content: Text(docsSample(context, 'A popup that displays information')),
        onPressed: _noop,
      ),
    ],
  );
}

/// Default bar: featured Getting-started panel, Components grid, Docs link.
class _DefaultBar extends StatefulWidget {
  const _DefaultBar();

  @override
  State<_DefaultBar> createState() => _DefaultBarState();
}

class _DefaultBarState extends State<_DefaultBar> {
  String _page = docsSample(null, 'Getting started');

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Intrinsic width: a fixed box clipped the bar under real text
        // metrics, and the bar is wider than the 375 phone stage.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: NavigationMenu(
            children: <Widget>[
              NavigationMenuItem(
                content: _gettingStarted(theme, context),
                child: Text(docsSample(context, 'Getting started')),
              ),
              NavigationMenuItem(
                content: _componentsGrid(context),
                child: Text(docsSample(context, 'Components')),
              ),
              NavigationMenuItem(
                onPressed: () => setState(
                  () => _page = docsSample(context, 'Documentation'),
                ),
                child: Text(docsSample(context, 'Docs')),
              ),
            ],
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          '${'Viewing '}${docsSample(context, _page)}',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// A standalone two-column content list.
Widget _contentList(BuildContext context) {
  return SizedBox(
    width: 360,
    child: NavigationMenuContentList(
      crossAxisCount: 2,
      children: <Widget>[
        NavigationMenuContent(
          title: Text(docsSample(context, 'Dashboard')),
          content: Text(docsSample(context, 'Analytics')),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          title: Text(docsSample(context, 'Settings')),
          content: Text(docsSample(context, 'Preferences')),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          title: Text(docsSample(context, 'Billing')),
          content: Text(docsSample(context, 'Plans')),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          title: Text(docsSample(context, 'Notifications')),
          content: Text(docsSample(context, 'Alerts')),
          onPressed: _noop,
        ),
      ],
    ),
  );
}

/// A standalone list with leading icons.
Widget _withIcons(BuildContext context) {
  return SizedBox(
    width: 300,
    child: NavigationMenuContentList(
      crossAxisCount: 1,
      children: <Widget>[
        NavigationMenuContent(
          leading: Icon(LucideIcons.layoutDashboard, size: 16),
          title: Text(docsSample(context, 'Dashboard')),
          content: Text(docsSample(context, 'Analytics')),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          leading: Icon(LucideIcons.settings, size: 16),
          title: Text(docsSample(context, 'Settings')),
          content: Text(docsSample(context, 'Preferences')),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          leading: Icon(LucideIcons.fileText, size: 16),
          title: Text(docsSample(context, 'Billing')),
          content: Text(docsSample(context, 'Invoices')),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          leading: Icon(LucideIcons.bell, size: 16),
          title: Text(docsSample(context, 'Notifications')),
          content: Text(docsSample(context, 'Alerts')),
          onPressed: _noop,
        ),
      ],
    ),
  );
}

Widget _defaultBar(BuildContext context) => const _DefaultBar();

/// Named docs examples for `navigation_menu`; the first entry is the default.
List<ComponentPreview> get navigationMenuPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _defaultBar),
  ComponentPreview(docsSample(null, 'Content list'), _contentList),
  ComponentPreview(docsSample(null, 'With icons'), _withIcons),
];
