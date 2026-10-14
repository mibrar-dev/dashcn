// Playground builder for the `alert` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/alert/alert.dart';
import 'package:flutter/widgets.dart';

/// Renders an [Alert] from playground values.
Widget buildAlertPlayground(BuildContext context, PlaygroundValues values) {
  final String? title = values.textOrNull('title');
  final String? content = values.textOrNull('content');
  return Alert(
    title: title == null ? null : Text(title),
    content: content == null ? null : Text(content),
    variant: AlertVariant.values.byName(values.getEnum('variant') ?? 'base'),
  );
}
