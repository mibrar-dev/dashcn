import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import 'list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _default(BuildContext context) => _wrap(
  const ListTile(
    leading: Icon(LucideIcons.user),
    title: Text('Title'),
    subtitle: Text('Subtitle'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _dense(BuildContext context) => _wrap(
  const ListTile(
    dense: true,
    leading: Icon(LucideIcons.user),
    title: Text('Dense tile'),
    subtitle: Text('Subtitle'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _threeLine(BuildContext context) => _wrap(
  const ListTile(
    isThreeLine: true,
    leading: Icon(LucideIcons.user),
    title: Text('Three-line title'),
    subtitle: Text('A longer subtitle that spans multiple lines in the tile.'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _selected(BuildContext context) => _wrap(
  const ListTile(
    selected: true,
    leading: Icon(LucideIcons.check),
    title: Text('Selected'),
    subtitle: Text('Selected state'),
  ),
);

Widget _disabled(BuildContext context) => _wrap(
  const ListTile(
    enabled: false,
    leading: Icon(LucideIcons.user),
    title: Text('Disabled'),
    subtitle: Text('Disabled state'),
  ),
);

Widget _customized(BuildContext context) => _wrap(
  ListTile(
    style: const ListTileTheme(
      tileColor: null,
      titleStyle: TextStyle(fontWeight: FontWeight.w700),
    ),
    leading: const Icon(LucideIcons.star),
    title: const Text('Customized'),
    subtitle: const Text('With style override'),
    trailing: const Icon(LucideIcons.heart),
  ),
);

const List<ComponentPreview> listTilePreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Dense', _dense),
  ComponentPreview('Three line', _threeLine),
  ComponentPreview('Selected', _selected),
  ComponentPreview('Disabled', _disabled),
  ComponentPreview('Customized', _customized),
];
