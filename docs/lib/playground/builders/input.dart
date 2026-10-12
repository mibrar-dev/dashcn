// Playground builder for the `input` component.

import 'package:docs/playground/builder.dart';
import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/input/input.dart';
import 'package:docs/ui/dashcn/primitives/form_core/form_core.dart';
import 'package:flutter/widgets.dart';

/// Renders an [Input] from playground values.
///
/// The builder resolves the framework line invariants (`expands` needs null
/// lines; obscured fields are single-line) so every control combination
/// pumps without throwing.
Widget buildInputPlayground(BuildContext context, PlaygroundValues values) {
  final bool expands = values.getBoolOr('expands', false);
  final bool obscure = values.getBoolOr('obscureText', false);
  return Input(
    initialValue: values.getString('initialValue'),
    placeholder: _textOrNull(values.getString('placeholder')),
    hintText: values.getString('hintText'),
    maxLines: expands ? null : (obscure ? 1 : values.getInt('maxLines')),
    minLines: expands ? null : values.getInt('minLines'),
    expands: expands,
    maxLength: values.getInt('maxLength'),
    obscureText: obscure,
    obscuringCharacter: values.getStringOr('obscuringCharacter', '•'),
    readOnly: values.getBoolOr('readOnly', false),
    enabled: values.getBoolOr('enabled', true),
    autofocus: values.getBoolOr('autofocus', false),
    autocorrect: values.getBoolOr('autocorrect', true),
    enableSuggestions: values.getBoolOr('enableSuggestions', true),
    cursorColor: playgroundTokenColor(context, values.getToken('cursorColor')),
    cursorWidth: values.getDouble('cursorWidth') ?? 2.0,
    cursorHeight: values.getDouble('cursorHeight'),
    filled: values.getBool('filled'),
    autovalidateMode: FormValidationMode.values.byName(
      values.getEnum('autovalidateMode') ?? 'changed',
    ),
    showFocusRing: values.getBoolOr('showFocusRing', true),
  );
}

Widget? _textOrNull(String? value) => value == null ? null : Text(value);
