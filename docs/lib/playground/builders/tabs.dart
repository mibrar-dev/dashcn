// Playground builder for the `tabs` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/tabs/tabs.dart';
import 'package:flutter/widgets.dart';

/// Renders [Tabs] from playground values.
///
/// The tab items are builder-owned demo content; the `index` control owns
/// the active tab.
Widget buildTabsPlayground(BuildContext context, PlaygroundValues values) {
  return Tabs(
    index: values.getInt('index') ?? 0,
    expand: values.getBoolOr('expand', false),
    children: const <TabItem>[
      TabItem(child: Text('Account')),
      TabItem(child: Text('Password')),
      TabItem(child: Text('Settings')),
    ],
  );
}
