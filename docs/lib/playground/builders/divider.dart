// Playground builder for the `divider` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/divider/divider.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Divider] from playground values.
Widget buildDividerPlayground(BuildContext context, PlaygroundValues values) {
  return Divider(
    thickness: values.getDouble('thickness'),
    extent: values.getDouble('extent'),
    indent: values.getDouble('indent'),
    endIndent: values.getDouble('endIndent'),
    label: _textOrNull(values.getString('label')),
    labelAlignment: _byNameOrNull(
      DividerLabelAlignment.values,
      values.getEnum('labelAlignment'),
    ),
  );
}

Widget? _textOrNull(String? value) => value == null ? null : Text(value);

T? _byNameOrNull<T extends Enum>(List<T> values, String? name) {
  if (name == null) {
    return null;
  }
  for (final T value in values) {
    if (value.name == name) {
      return value;
    }
  }
  return null;
}
