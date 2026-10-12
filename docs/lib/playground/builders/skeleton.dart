// Playground builder for the `skeleton` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/skeleton/skeleton.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Skeleton] from playground values.
Widget buildSkeletonPlayground(BuildContext context, PlaygroundValues values) {
  return Skeleton(
    enabled: values.getBoolOr('enabled', true),
    child: Text(values.getStringOr('child', '')),
  );
}
