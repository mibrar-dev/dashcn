// Named examples for the `autocomplete` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../primitives/input_features/input_features.dart';
import '../../theme/theme.dart';
import '../input/input.dart';
import 'autocomplete.dart';

List<String> _autocompleteFruits = <String>[
  docsSample(null, 'Apple'),
  docsSample(null, 'Apricot'),
  docsSample(null, 'Avocado'),
  docsSample(null, 'Banana'),
  docsSample(null, 'Cherry'),
  docsSample(null, 'Grape'),
  docsSample(null, 'Kiwi'),
  docsSample(null, 'Lemon'),
  docsSample(null, 'Mango'),
  docsSample(null, 'Orange'),
  docsSample(null, 'Peach'),
  docsSample(null, 'Pear'),
  docsSample(null, 'Pineapple'),
  docsSample(null, 'Strawberry'),
  docsSample(null, 'Watermelon'),
];

Iterable<String> _autocompleteFilter(String query) {
  final String needle = query.toLowerCase();
  if (needle.isEmpty) {
    return const <String>[];
  }
  return _autocompleteFruits.where(
    (fruit) => fruit.toLowerCase().contains(needle),
  );
}

/// One completion field, plus the example's own selection echo.
class _AutocompleteAutoCompleteField extends StatefulWidget {
  const _AutocompleteAutoCompleteField({
    required this.hint,
    this.mode,
    this.completer,
    this.itemBuilder,
  });

  final String hint;
  final AutoCompleteMode? mode;
  final AutoCompleteCompleter? completer;
  final Widget Function(BuildContext context, String suggestion, bool selected)?
  itemBuilder;

  @override
  State<_AutocompleteAutoCompleteField> createState() =>
      _AutocompleteAutoCompleteFieldState();
}

class _AutocompleteAutoCompleteFieldState
    extends State<_AutocompleteAutoCompleteField> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Input(
            hintText: 'Type a fruit - ${widget.hint}',
            features: <InputFeature>[
              AutoCompleteFeature(
                suggestions: _autocompleteFilter,
                mode: widget.mode,
                completer: widget.completer ?? (String s) => s,
                itemBuilder: widget.itemBuilder,
                onSuggestionSelected: (String value) =>
                    setState(() => _selected = value),
              ),
            ],
          ),
          Gap(theme.spacing.md),
          Text(
            'Last selected: ${_selected.isEmpty ? '-' : _selected}',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

/// The default replacement mode.
Widget _autocompleteDefault(BuildContext context) =>
    _AutocompleteAutoCompleteField(
      hint: docsSample(context, 'replaces the word'),
    );

/// Append mode: the suggestion is inserted at the caret.
Widget _autocompleteAppend(BuildContext context) =>
    _AutocompleteAutoCompleteField(
      hint: docsSample(context, 'appended at the caret'),
      mode: AutoCompleteMode.append,
    );

/// Replace-all mode: the whole field is replaced.
Widget _autocompleteReplaceAll(BuildContext context) =>
    _AutocompleteAutoCompleteField(
      hint: docsSample(context, 'replaces the whole field'),
      mode: AutoCompleteMode.replaceAll,
    );

/// A custom completer plus a custom row builder.
Widget _autocompleteCustomRow(BuildContext context) =>
    _AutocompleteAutoCompleteField(
      hint: docsSample(context, 'with a padded completion'),
      completer: _autocompletePad,
      itemBuilder: _autocompleteBoldWhenSelected,
    );

String _autocompletePad(String suggestion) => '$suggestion ';

Widget _autocompleteBoldWhenSelected(
  BuildContext context,
  String suggestion,
  bool selected,
) => Text(
  suggestion,
  style: TextStyle(fontWeight: selected ? FontWeight.w600 : FontWeight.w400),
);

/// Named docs examples for `autocomplete`; the first entry is the default.
List<ComponentPreview> get autocompletePreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _autocompleteDefault),
  ComponentPreview(docsSample(null, 'Append'), _autocompleteAppend),
  ComponentPreview(docsSample(null, 'Replace all'), _autocompleteReplaceAll),
  ComponentPreview(docsSample(null, 'Custom row'), _autocompleteCustomRow),
];
