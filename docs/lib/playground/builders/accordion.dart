// Playground builder for the `accordion` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/accordion/accordion.dart';
import 'package:flutter/widgets.dart';

/// Renders an [Accordion] from playground values.
///
/// The items list is the only parameter and a builder-owned widget slot, so
/// this builder has no editable controls yet.
Widget buildAccordionPlayground(BuildContext context, PlaygroundValues values) {
  return const Accordion(
    items: <Widget>[
      AccordionItem(
        trigger: Text('Getting started'),
        content: Text('Install the package and add your first component.'),
      ),
      AccordionItem(
        trigger: Text('Theming'),
        content: Text('Pick a preset or paste a web theme.'),
      ),
    ],
  );
}
