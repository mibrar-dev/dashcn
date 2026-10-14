// Playground builder for the `breadcrumb` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/breadcrumb/breadcrumb.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Breadcrumb] from playground values.
///
/// The trail is builder-owned demo content; the `separator` control owns
/// the divider between crumbs.
Widget buildBreadcrumbPlayground(
  BuildContext context,
  PlaygroundValues values,
) {
  final String? separator = values.textOrNull('separator');
  return Breadcrumb(
    separator: separator == null ? null : Text(separator),
    children: const <Widget>[Text('Home'), Text('Docs'), Text('Playground')],
  );
}
