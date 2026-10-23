// Named examples for the `text_area` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/theme.dart';
import 'text_area.dart';

/// The default three-line field.
Widget _default(BuildContext context) {
  return SizedBox(
    width: 320,
    child: TextArea(initialValue: docsSample(context, 'Hello, World!')),
  );
}

/// A taller field with placeholder text.
Widget _placeholder(BuildContext context) {
  return SizedBox(
    width: 320,
    child: TextArea(
      placeholder: Text(docsSample(context, 'Type your message here...')),
      minLines: 4,
    ),
  );
}

/// A field that grows with its content.
Widget _resizable(BuildContext context) {
  return SizedBox(
    width: 320,
    child: TextArea(
      hintText: docsSample(context, 'No cap: paste a long paragraph'),
      minLines: 2,
      maxLines: 8,
    ),
  );
}

/// A validating field; owns the typed value it echoes.
class _InvalidArea extends StatefulWidget {
  const _InvalidArea();

  @override
  State<_InvalidArea> createState() => _InvalidAreaState();
}

class _InvalidAreaState extends State<_InvalidArea> {
  String _code = 'abc';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextArea(
            initialValue: 'abc',
            minLines: 2,
            validator: (String? value) => (value ?? '').length < 8
                ? docsSample(context, 'At least 8 characters')
                : null,
            onChanged: (String value) => setState(() => _code = value),
          ),
          SizedBox(height: spacing.sm),
          Text(
            'typed: ${_code.isEmpty ? '(empty)' : _code}',
            style: TextStyle(color: Theme.of(context).colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

Widget _invalid(BuildContext context) => const _InvalidArea();

/// A disabled field.
Widget _disabled(BuildContext context) {
  return SizedBox(
    width: 320,
    child: TextArea(
      initialValue: docsSample(context, 'Disabled'),
      enabled: false,
    ),
  );
}

/// Named docs examples for `text_area`; the first entry is the default.
List<ComponentPreview> get textAreaPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Placeholder'), _placeholder),
  ComponentPreview('Resizable', _resizable),
  ComponentPreview(docsSample(null, 'Invalid'), _invalid),
  ComponentPreview(docsSample(null, 'Disabled'), _disabled),
];
