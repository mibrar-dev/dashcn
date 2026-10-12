// Playground builder for the `text_area` component.

import 'package:docs/playground/builder.dart';
import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/text_area/text_area.dart';
import 'package:docs/ui/dashcn/primitives/form_core/form_core.dart';
import 'package:flutter/widgets.dart';

/// Renders a [TextArea] from playground values.
///
/// The builder resolves the framework line invariant (`expands` needs null
/// lines) so every control combination pumps without throwing.
Widget buildTextAreaPlayground(BuildContext context, PlaygroundValues values) {
  final bool expands = values.getBoolOr('expands', false);
  final String? placeholder = values.textOrNull('placeholder');
  return TextArea(
    initialValue: values.textOrNull('initialValue'),
    hintText: values.textOrNull('hintText'),
    placeholder: placeholder == null ? null : Text(placeholder),
    minLines: expands ? null : values.getInt('minLines'),
    maxLines: expands ? null : values.getInt('maxLines'),
    expands: expands,
    maxLength: values.getInt('maxLength'),
    filled: values.getBool('filled'),
    readOnly: values.getBoolOr('readOnly', false),
    enabled: values.getBoolOr('enabled', true),
    autofocus: values.getBoolOr('autofocus', false),
    autocorrect: values.getBoolOr('autocorrect', true),
    enableSuggestions: values.getBoolOr('enableSuggestions', true),
    cursorColor: playgroundTokenColor(context, values.getToken('cursorColor')),
    autovalidateMode: FormValidationMode.values.byName(
      values.getEnum('autovalidateMode') ?? 'changed',
    ),
  );
}
