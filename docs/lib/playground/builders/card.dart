// Playground builder for the `card` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/card/card.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Card] from playground values.
Widget buildCardPlayground(BuildContext context, PlaygroundValues values) {
  return Card(
    borderWidth: values.getDouble('borderWidth'),
    child: Text(values.textOr('child')),
  );
}
