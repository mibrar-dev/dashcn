// Playground builder for the `form` component (label + form field).

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/form/form.dart';
import 'package:docs/ui/dashcn/components/input/input.dart';
import 'package:flutter/widgets.dart';

/// Renders a labelled [FormItem] in a [FormScope] from playground values.
///
/// The `child` text control owns the field label; the input itself is
/// builder-owned demo content.
Widget buildFormPlayground(BuildContext context, PlaygroundValues values) {
  return FormScope(
    child: FormItem<String>(
      key: const FormKey<String>('playground'),
      label: Text(values.textOr('child')),
      child: const Input(),
    ),
  );
}
