// Named examples for the `multi_select` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Each example
// owns its selection. The fixed width is inherent: the chip trigger wraps, so
// it needs a bounded box. Only the trigger renders (the popup opens on tap).

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import 'multi_select.dart';

List<String> _options = <String>[
  docsSample(null, 'Apple'),
  docsSample(null, 'Banana'),
  docsSample(null, 'Cherry'),
  docsSample(null, 'Date'),
  docsSample(null, 'Grape'),
];

/// A controlled picker with one fruit selected.
class _DefaultExample extends StatefulWidget {
  const _DefaultExample();

  @override
  State<_DefaultExample> createState() => _DefaultExampleState();
}

class _DefaultExampleState extends State<_DefaultExample> {
  Iterable<String>? _fruits = <String>[docsSample(null, 'Apple')];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: MultiSelect<String>(
        value: _fruits,
        onChanged: (Iterable<String>? value) => setState(() => _fruits = value),
        placeholder: Text(docsSample(context, 'Select fruits')),
        itemBuilder: (BuildContext context, String value) =>
            MultiSelectChip<String>(
              value: value,
              child: Text(docsSample(context, value)),
            ),
        items: <Widget>[
          for (final String fruit in _options)
            MultiSelectItem<String>(
              value: fruit,
              child: Text(docsSample(context, fruit)),
            ),
        ],
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultExample();

/// A controlled picker whose trigger wraps three removable chips.
class _BadgesExample extends StatefulWidget {
  const _BadgesExample();

  @override
  State<_BadgesExample> createState() => _BadgesExampleState();
}

class _BadgesExampleState extends State<_BadgesExample> {
  Iterable<String>? _fruits = <String>[
    docsSample(null, 'Apple'),
    docsSample(null, 'Cherry'),
    docsSample(null, 'Grape'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: MultiSelect<String>(
        value: _fruits,
        onChanged: (Iterable<String>? value) => setState(() => _fruits = value),
        placeholder: Text(docsSample(context, 'Select fruits')),
        itemBuilder: (BuildContext context, String value) =>
            MultiSelectChip<String>(
              value: value,
              child: Text(docsSample(context, value)),
            ),
        items: <Widget>[
          for (final String fruit in _options)
            MultiSelectItem<String>(
              value: fruit,
              child: Text(docsSample(context, fruit)),
            ),
        ],
      ),
    );
  }
}

Widget _withBadges(BuildContext context) => const _BadgesExample();

/// A disabled picker.
class _DisabledExample extends StatefulWidget {
  const _DisabledExample();

  @override
  State<_DisabledExample> createState() => _DisabledExampleState();
}

class _DisabledExampleState extends State<_DisabledExample> {
  Iterable<String>? _fruits = <String>[docsSample(null, 'Apple')];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: MultiSelect<String>(
        value: _fruits,
        onChanged: (Iterable<String>? value) => setState(() => _fruits = value),
        enabled: false,
        placeholder: Text(docsSample(context, 'Select fruits')),
        itemBuilder: (BuildContext context, String value) =>
            MultiSelectChip<String>(
              value: value,
              child: Text(docsSample(context, value)),
            ),
        items: <Widget>[
          for (final String fruit in _options)
            MultiSelectItem<String>(
              value: fruit,
              child: Text(docsSample(context, fruit)),
            ),
        ],
      ),
    );
  }
}

Widget _disabled(BuildContext context) => const _DisabledExample();

/// Named docs examples for `multi_select`; the first entry is the default.
List<ComponentPreview> get multiSelectPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'With badges'), _withBadges),
  ComponentPreview(docsSample(null, 'Disabled'), _disabled),
];
