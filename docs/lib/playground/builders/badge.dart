// Playground builder for the `badge` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/badge/badge.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Badge] from playground values.
Widget buildBadgePlayground(BuildContext context, PlaygroundValues values) {
  return Badge(
    onPressed: values.getBoolOr('enabled', true) ? () {} : null,
    variant: BadgeVariant.values.byName(values.getEnum('variant') ?? 'primary'),
    showAsDot: values.getBoolOr('showAsDot', false),
    autofocus: values.getBoolOr('autofocus', false),
    child: Text(values.getStringOr('child', '')),
  );
}
