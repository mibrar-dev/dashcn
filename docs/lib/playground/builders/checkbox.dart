// Playground builder for the `checkbox` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Checkbox] from playground values.
Widget buildCheckboxPlayground(BuildContext context, PlaygroundValues values) {
  return Checkbox(
    value: CheckboxValue.values.byName(values.getEnum('value') ?? 'unchecked'),
    tristate: values.getBoolOr('tristate', false),
    enabled: values.getBool('enabled'),
    label: _textOrNull(values.getString('label')),
    size: values.getDouble('size'),
    gap: values.getDouble('gap'),
    autofocus: values.getBoolOr('autofocus', false),
  );
}

Widget? _textOrNull(String? value) => value == null ? null : Text(value);
