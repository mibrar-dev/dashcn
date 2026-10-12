// Playground builder for the `button` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Button] from playground values.
Widget buildButtonPlayground(BuildContext context, PlaygroundValues values) {
  return Button(
    onPressed: values.getBoolOr('enabled', true) ? () {} : null,
    variant: ButtonVariant.values.byName(
      values.getEnum('variant') ?? 'primary',
    ),
    size: ButtonSize.values.byName(values.getEnum('size') ?? 'md'),
    autofocus: values.getBoolOr('autofocus', false),
    child: Text(values.textOr('child')),
  );
}
