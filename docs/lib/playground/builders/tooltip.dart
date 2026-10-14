// Playground builder for the `tooltip` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/tooltip/tooltip.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Tooltip] from playground values.
///
/// The `tooltip` builder closure is owned here; its text comes from the
/// control of the same name.
Widget buildTooltipPlayground(BuildContext context, PlaygroundValues values) {
  final String tip = values.textOr('tooltip');
  return Tooltip(
    tooltip: (BuildContext context) => Text(tip),
    child: Text(values.textOr('child')),
  );
}
