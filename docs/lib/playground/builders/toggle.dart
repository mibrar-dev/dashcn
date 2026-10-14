// Playground builder for the `toggle` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/toggle/toggle.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Toggle] from playground values.
///
/// A null `value` is coerced to false: the widget asserts a non-null value
/// unless a controller drives it.
Widget buildTogglePlayground(BuildContext context, PlaygroundValues values) {
  return Toggle(
    value: values.getBool('value') ?? false,
    size: ToggleSize.values.byName(values.getEnum('size') ?? 'md'),
    enabled: values.getBool('enabled'),
    autofocus: values.getBoolOr('autofocus', false),
    child: Text(values.textOr('child')),
  );
}
