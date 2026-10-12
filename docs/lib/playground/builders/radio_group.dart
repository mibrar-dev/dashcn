// Playground builder for the `radio_group` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/radio_group/radio_group.dart';
import 'package:flutter/widgets.dart';

/// Renders a [RadioSet] from playground values.
///
/// Only `enabled` is an editable control; the items, value and direction
/// are builder-owned demo content (generics and the framework `Axis` enum
/// have no control mapping).
Widget buildRadioGroupPlayground(
  BuildContext context,
  PlaygroundValues values,
) {
  return RadioSet<String>(
    enabled: values.getBool('enabled'),
    items: const <Widget>[
      RadioCard<String>(value: 'apple', child: Text('Apple')),
      RadioCard<String>(value: 'banana', child: Text('Banana')),
      RadioCard<String>(value: 'cherry', child: Text('Cherry')),
    ],
  );
}
