// Playground builder for the `tabs` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/tabs/tabs.dart';
import 'package:flutter/widgets.dart';

/// Renders [Tabs] from playground values.
///
/// The tab items are builder-owned demo content; the `index` control owns
/// the active tab. Unexpanded, the strip scrolls horizontally like the
/// component's own default example, so three tabs never overflow a
/// 375-wide phone stage. Expanded, the strip sizes to the stage (its flex
/// children need the bounded width, so no scroll view wraps it).
Widget buildTabsPlayground(BuildContext context, PlaygroundValues values) {
  final Tabs tabs = Tabs(
    index: values.getInt('index') ?? 0,
    expand: values.getBoolOr('expand', false),
    children: const <TabItem>[
      TabItem(child: Text('Account')),
      TabItem(child: Text('Password')),
      TabItem(child: Text('Settings')),
    ],
  );
  if (values.getBoolOr('expand', false)) {
    return tabs;
  }
  return SingleChildScrollView(scrollDirection: Axis.horizontal, child: tabs);
}
