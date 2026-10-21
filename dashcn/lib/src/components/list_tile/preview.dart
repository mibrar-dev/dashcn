import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/density_tokens.dart';
import '../avatar/avatar.dart';
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

Widget _compact(BuildContext context) => _wrap(
  const ListTile(
    densityTokens: DensityTokens.compact,
    leading: Icon(LucideIcons.user),
    title: Text('Compact (default)'),
    subtitle: Text('Row 32-36, icon 16'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _comfortable(BuildContext context) => _wrap(
  const ListTile(
    densityTokens: DensityTokens.comfortable,
    leading: Icon(LucideIcons.user),
    title: Text('Comfortable'),
    subtitle: Text('Row 40-44, icon 20'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _avatar(BuildContext context) => _wrap(
  const ListTile(
    leading: Avatar(initials: 'IB', size: 32),
    title: Text('Avatar 32 (compact)'),
    subtitle: Text('Avatar sizes follow density'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _avatarComfortable(BuildContext context) => _wrap(
  const ListTile(
    densityTokens: DensityTokens.comfortable,
    leading: Avatar(initials: 'IB', size: 40),
    title: Text('Avatar 40 (comfortable)'),
    subtitle: Text('Row 40-44, icon 20'),
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

Widget _grouped(BuildContext context) => _wrap(
  const ListTileGroup(
    children: <Widget>[
      ListTile(title: Text('First'), leading: Icon(LucideIcons.user)),
      ListTile(title: Text('Second'), leading: Icon(LucideIcons.user)),
      ListTile(title: Text('Third'), leading: Icon(LucideIcons.user)),
    ],
  ),
);

const List<ComponentPreview> listTilePreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Compact', _compact),
  ComponentPreview('Comfortable', _comfortable),
  ComponentPreview('Avatar', _avatar),
  ComponentPreview('Avatar comfortable', _avatarComfortable),
  ComponentPreview('Dense', _dense),
  ComponentPreview('Three line', _threeLine),
  ComponentPreview('Selected', _selected),
  ComponentPreview('Disabled', _disabled),
  ComponentPreview('Customized', _customized),
  ComponentPreview('Grouped', _grouped),
];
