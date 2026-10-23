// Named examples for the `navigation_bar` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. The sidebar example carries its own bounded box
// because the rail/sidebar containers measure a vertical extent.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/radix_icons.dart';
import 'navigation_bar.dart';

/// Shared bar items for the horizontal examples.
List<NavigationBarItem> _barItems([BuildContext? context]) =>
    <NavigationBarItem>[
      NavigationItem(
        label: Text(docsSample(context, 'Home')),
        child: const Icon(RadixIcons.home),
      ),
      NavigationItem(
        label: Text(docsSample(context, 'Search')),
        child: const Icon(RadixIcons.magnifyingGlass),
      ),
      NavigationItem(
        label: Text(docsSample(context, 'Settings')),
        child: const Icon(RadixIcons.gear),
      ),
      NavigationItem(
        label: Text(docsSample(context, 'Disabled')),
        enabled: false,
        child: const Icon(RadixIcons.person),
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
      children: _barItems(context),
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
    return SizedBox(
      width: 260,
      height: 320,
      child: NavigationBar(
        container: NavigationContainerType.sidebar,
        index: _index,
        onSelected: (int value) => setState(() => _index = value),
        children: <NavigationBarItem>[
          NavigationLabel(child: Text(docsSample(context, 'Main'))),
          ..._barItems(context),
          const NavigationDivider(),
          NavigationGroup(
            label: Text(docsSample(context, 'Account')),
            children: <Widget>[
              NavigationCollapsible(
                label: Text(docsSample(context, 'Profile')),
                leading: const Icon(RadixIcons.person),
                initialExpanded: true,
                children: <Widget>[
                  NavigationItem(
                    index: 4,
                    label: Text(docsSample(context, 'Details')),
                    child: const Icon(RadixIcons.idCard),
                  ),
                  NavigationItem(
                    index: 5,
                    label: Text(docsSample(context, 'Security')),
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
List<ComponentPreview> get navigationBarPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'With labels'), _withLabels),
  ComponentPreview('Sidebar', _sidebar),
];
