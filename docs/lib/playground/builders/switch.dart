// Playground builder for the `switch` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/switch/switch.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Switch] from playground values.
Widget buildSwitchPlayground(BuildContext context, PlaygroundValues values) {
  final String? label = values.textOrNull('label');
  return Switch(
    value: values.getBoolOr('value', false),
    enabled: values.getBool('enabled'),
    label: label == null ? null : Text(label),
    autofocus: values.getBoolOr('autofocus', false),
  );
}
