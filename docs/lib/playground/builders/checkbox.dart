// Playground builder for the `checkbox` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Checkbox] from playground values.
Widget buildCheckboxPlayground(BuildContext context, PlaygroundValues values) {
  final String? label = values.textOrNull('label');
  return Checkbox(
    value: CheckboxValue.values.byName(values.getEnum('value') ?? 'unchecked'),
    tristate: values.getBoolOr('tristate', false),
    enabled: values.getBool('enabled'),
    label: label == null ? null : Text(label),
    size: values.getDouble('size'),
    gap: values.getDouble('gap'),
    autofocus: values.getBoolOr('autofocus', false),
  );
}
