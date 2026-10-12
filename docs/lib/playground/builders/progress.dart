// Playground builder for the `progress` component.

import 'package:docs/playground/builder.dart';
import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/progress/progress.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Progress] from playground values.
Widget buildProgressPlayground(BuildContext context, PlaygroundValues values) {
  return Progress(
    value: values.getDouble('value'),
    height: values.getDouble('height'),
    color: playgroundTokenColor(context, values.getToken('color')),
    backgroundColor: playgroundTokenColor(
      context,
      values.getToken('backgroundColor'),
    ),
    showSparks: values.getBool('showSparks'),
    disableAnimation: values.getBool('disableAnimation'),
    semanticsLabel: values.getString('semanticsLabel'),
    semanticsValue: values.getString('semanticsValue'),
  );
}
