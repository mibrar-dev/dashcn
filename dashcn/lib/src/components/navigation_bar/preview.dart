// Named examples for the `navigation_bar` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. The sidebar example carries its own bounded box
// because the rail/sidebar containers measure a vertical extent.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/radix_icons.dart';
import '../../theme/theme.dart';
import 'navigation_bar.dart';

/// Shared bar items for the horizontal examples.
List<NavigationBarItem> _barItems() => <NavigationBarItem>[
  const NavigationItem(label: Text('Home'), child: Icon(RadixIcons.home)),
  const NavigationItem(
    label: Text('Search'),
    child: Icon(RadixIcons.magnifyingGlass),
  ),
  const NavigationItem(label: Text('Settings'), child: Icon(RadixIcons.gear)),
  const NavigationItem(
    label: Text('Disabled'),
    enabled: false,
    child: Icon(RadixIcons.person),
  ),
];

/// An interactive horizontal bar; selection lives in this example's state.
class _InteractiveBar extends StatefulWidget {
  const _InteractiveBar({this.labelType});

  final NavigationLabelType? labelType;

  @override
  State<_InteractiveBar> createState() => _InteractiveBarState();
}

class _InteractiveBarState extends State<_InteractiveBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      index: _index,
      onSelected: (int value) => setState(() => _index = value),
      labelType: widget.labelType,
      children: _barItems(),
    );
  }
}

/// The default bar: only the selected item shows its label.
Widget _default(BuildContext context) =>
    const _InteractiveBar(labelType: NavigationLabelType.selected);

/// A bar with every label visible.
Widget _withLabels(BuildContext context) =>
    const _InteractiveBar(labelType: NavigationLabelType.all);

/// A bounded sidebar with a label, a divider and a grouped collapsible.
class _SidebarDemo extends StatefulWidget {
  const _SidebarDemo();

  @override
  State<_SidebarDemo> createState() => _SidebarDemoState();
}

class _SidebarDemoState extends State<_SidebarDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Tall enough for the header, both groups, the expanded collapsible
    // children and the footer with no scrolling.
    return SizedBox(
      width: 256,
      height: 420,
      child: NavigationBar(
        container: NavigationContainerType.sidebar,
        index: _index,
        onSelected: (int value) => setState(() => _index = value),
        header: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Text(
              'Acme Inc',
              style: theme.typography.small.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        footer: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Text(
              'v1.0.0',
              style: theme.typography.xSmall.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
          ),
        ],
        children: <NavigationBarItem>[
          const NavigationLabel(child: Text('Main')),
          ..._barItems(),
          const NavigationDivider(),
          NavigationGroup(
            label: const Text('Account'),
            children: <Widget>[
              NavigationCollapsible(
                label: const Text('Profile'),
                leading: const Icon(RadixIcons.person),
                initialExpanded: true,
                children: <Widget>[
                  NavigationItem(
                    index: 4,
                    label: const Text('Details'),
                    child: const Icon(RadixIcons.idCard),
                  ),
                  NavigationItem(
                    index: 5,
                    label: Text('Security'),
                    child: const Icon(RadixIcons.lockClosed),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _sidebar(BuildContext context) => const _SidebarDemo();

/// Named docs examples for `navigation_bar`; the first entry is the default.
const List<ComponentPreview> navigationBarPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('With labels', _withLabels),
  ComponentPreview('Sidebar', _sidebar),
];
