// Named examples for the `select` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Each trigger carries its own bounded width because
// the trigger row measures an intrinsic width.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import 'select.dart';

/// A controlled fruit picker; the selection lives in this example's state.
class _FruitSelect extends StatefulWidget {
  const _FruitSelect();

  @override
  State<_FruitSelect> createState() => _FruitSelectState();
}

class _FruitSelectState extends State<_FruitSelect> {
  String? _fruit;

  static final List<String> _fruits = <String>[
    docsSample(null, 'Apple'),
    docsSample(null, 'Banana'),
    docsSample(null, 'Cherry'),
    docsSample(null, 'Date'),
    docsSample(null, 'Grape'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Select<String>(
        value: _fruit,
        onChanged: (String? value) => setState(() => _fruit = value),
        placeholder: Text(docsSample(context, 'Select a fruit')),
        itemBuilder: (BuildContext context, String value) =>
            Text(docsSample(context, value)),
        items: <Widget>[
          for (final String fruit in _fruits)
            SelectItem<String>(
              value: fruit,
              child: Text(docsSample(context, fruit)),
            ),
        ],
      ),
    );
  }
}

Widget _default(BuildContext context) => const _FruitSelect();

/// A picker grouping its rows under disabled header rows.
class _GroupedSelect extends StatefulWidget {
  const _GroupedSelect();

  @override
  State<_GroupedSelect> createState() => _GroupedSelectState();
}

class _GroupedSelectState extends State<_GroupedSelect> {
  String? _produce;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Select<String>(
        value: _produce,
        onChanged: (String? value) => setState(() => _produce = value),
        placeholder: Text(docsSample(context, 'Select produce')),
        itemBuilder: (BuildContext context, String value) =>
            Text(docsSample(context, value)),
        items: <Widget>[
          SelectItem<String>(
            value: '__fruits',
            enabled: false,
            child: Text(docsSample(context, 'Fruits')),
          ),
          SelectItem<String>(
            value: docsSample(context, 'Apple'),
            child: Text(docsSample(context, 'Apple')),
          ),
          SelectItem<String>(
            value: docsSample(context, 'Banana'),
            child: Text(docsSample(context, 'Banana')),
          ),
          SelectItem<String>(
            value: '__vegetables',
            enabled: false,
            child: Text(docsSample(context, 'Vegetables')),
          ),
          SelectItem<String>(
            value: docsSample(context, 'Carrot'),
            child: Text(docsSample(context, 'Carrot')),
          ),
          SelectItem<String>(
            value: docsSample(context, 'Lettuce'),
            child: Text(docsSample(context, 'Lettuce')),
          ),
        ],
      ),
    );
  }
}

Widget _withGroups(BuildContext context) => const _GroupedSelect();

/// A disabled picker showing its selected value.
Widget _disabled(BuildContext context) {
  return SizedBox(
    width: 220,
    child: Select<String>(
      value: docsSample(context, 'Apple'),
      onChanged: (String? value) {},
      enabled: false,
      placeholder: Text(docsSample(context, 'Select a fruit')),
      itemBuilder: (BuildContext context, String value) =>
          Text(docsSample(context, value)),
      items: <Widget>[
        SelectItem<String>(
          value: docsSample(context, 'Apple'),
          child: Text(docsSample(context, 'Apple')),
        ),
        SelectItem<String>(
          value: docsSample(context, 'Banana'),
          child: Text(docsSample(context, 'Banana')),
        ),
      ],
    ),
  );
}

/// Named docs examples for `select`; the first entry is the default.
List<ComponentPreview> get selectPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'With groups'), _withGroups),
  ComponentPreview(docsSample(null, 'Disabled'), _disabled),
];
