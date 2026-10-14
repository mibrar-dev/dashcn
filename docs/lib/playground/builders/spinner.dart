// Playground builder for the `spinner` component.

import 'package:docs/playground/builder.dart';
import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/spinner/spinner.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Spinner] from playground values.
Widget buildSpinnerPlayground(BuildContext context, PlaygroundValues values) {
  return Spinner(
    size: values.getDouble('size'),
    strokeWidth: values.getDouble('strokeWidth'),
    color: playgroundTokenColor(context, values.getToken('color')),
    semanticsLabel: values.textOrNull('semanticsLabel'),
  );
}
