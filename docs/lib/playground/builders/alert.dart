// Playground builder for the `alert` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/alert/alert.dart';
import 'package:flutter/widgets.dart';

/// Renders an [Alert] from playground values.
Widget buildAlertPlayground(BuildContext context, PlaygroundValues values) {
  return Alert(
    title: _textOrNull(values.getString('title')),
    content: _textOrNull(values.getString('content')),
    variant: AlertVariant.values.byName(values.getEnum('variant') ?? 'base'),
  );
}

Widget? _textOrNull(String? value) => value == null ? null : Text(value);
