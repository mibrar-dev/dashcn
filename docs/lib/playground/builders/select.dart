// Playground builder for the `select` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/select/select.dart';
import 'package:flutter/widgets.dart';

const List<String> _fruits = <String>['Apple', 'Banana', 'Cherry'];

/// Renders a [Select] from playground values.
///
/// The generic value and item builders are builder-owned demo content.
/// `canUnselect`/`autoClose` only affect the open popup, so the trigger
/// carries them in its key and every control change rebuilds it.
Widget buildSelectPlayground(BuildContext context, PlaygroundValues values) {
  final bool canUnselect = values.getBoolOr('canUnselect', false);
  final bool autoClose = values.getBoolOr('autoClose', true);
  return SizedBox(
    width: 220,
    child: Select<String>(
      key: ValueKey<String>('select-$canUnselect-$autoClose'),
      enabled: values.getBool('enabled'),
      placeholder: _textOrNull(values.getString('placeholder')),
      canUnselect: canUnselect,
      autoClose: autoClose,
      itemBuilder: (BuildContext context, String value) => Text(value),
      items: <Widget>[
        for (final String fruit in _fruits)
          SelectItem<String>(value: fruit, child: Text(fruit)),
      ],
    ),
  );
}

Widget? _textOrNull(String? value) => value == null ? null : Text(value);
