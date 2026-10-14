// Playground builder for the `pagination` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/pagination/pagination.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Pagination] from playground values.
///
/// Page turns are display-only (a no-op callback): the `page` control owns
/// the active page.
Widget buildPaginationPlayground(
  BuildContext context,
  PlaygroundValues values,
) {
  return Pagination(
    page: values.getInt('page') ?? 1,
    totalPages: values.getInt('totalPages') ?? 1,
    onPageChanged: (_) {},
    maxPages: values.getInt('maxPages') ?? 3,
    showSkipToFirstPage: values.getBoolOr('showSkipToFirstPage', true),
    showSkipToLastPage: values.getBoolOr('showSkipToLastPage', true),
    hidePreviousOnFirstPage: values.getBoolOr('hidePreviousOnFirstPage', false),
    hideNextOnLastPage: values.getBoolOr('hideNextOnLastPage', false),
    showLabel: values.getBool('showLabel'),
    gap: values.getDouble('gap'),
  );
}
