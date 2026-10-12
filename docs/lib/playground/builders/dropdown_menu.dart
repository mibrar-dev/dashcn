// Playground builder for the `dropdown_menu` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import 'package:docs/ui/dashcn/components/menu/menu.dart';
import 'package:flutter/widgets.dart';

/// Renders a [DropdownMenu] surface from playground values.
///
/// The menu rows are builder-owned demo content.
Widget buildDropdownMenuPlayground(
  BuildContext context,
  PlaygroundValues values,
) {
  return DropdownMenu(
    autofocus: values.getBoolOr('autofocus', false),
    children: const <Widget>[
      MenuButton(child: Text('Profile')),
      MenuButton(child: Text('Settings')),
    ],
  );
}
