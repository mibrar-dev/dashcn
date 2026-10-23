import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/density_tokens.dart';
import '../avatar/avatar.dart';
import 'list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _default(BuildContext context) => _wrap(
  ListTile(
    leading: Icon(LucideIcons.user),
    title: Text(docsSample(context, 'Title')),
    subtitle: Text(docsSample(context, 'Subtitle')),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _compact(BuildContext context) => _wrap(
  ListTile(
    densityTokens: DensityTokens.compact,
    leading: Icon(LucideIcons.user),
    title: Text(docsSample(context, 'Compact (default)')),
    subtitle: Text(docsSample(context, 'Row 32-36, icon 16')),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _comfortable(BuildContext context) => _wrap(
  ListTile(
    densityTokens: DensityTokens.comfortable,
    leading: Icon(LucideIcons.user),
    title: Text(docsSample(context, 'Comfortable')),
    subtitle: Text(docsSample(context, 'Row 40-44, icon 20')),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _avatar(BuildContext context) => _wrap(
  ListTile(
    leading: Avatar(initials: 'IB', size: 32),
    title: Text(docsSample(context, 'Avatar 32 (compact)')),
    subtitle: Text(docsSample(context, 'Avatar sizes follow density')),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _avatarComfortable(BuildContext context) => _wrap(
  ListTile(
    densityTokens: DensityTokens.comfortable,
    leading: Avatar(initials: 'IB', size: 40),
    title: Text(docsSample(context, 'Avatar 40 (comfortable)')),
    subtitle: Text(docsSample(context, 'Row 40-44, icon 20')),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _dense(BuildContext context) => _wrap(
  ListTile(
    dense: true,
    leading: Icon(LucideIcons.user),
    title: Text(docsSample(context, 'Dense tile')),
    subtitle: Text(docsSample(context, 'Subtitle')),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _threeLine(BuildContext context) => _wrap(
  ListTile(
    isThreeLine: true,
    leading: Icon(LucideIcons.user),
    title: Text(docsSample(context, 'Three-line title')),
    subtitle: Text(
      docsSample(
        context,
        docsSample(
          context,
          docsSample(
            context,
            'A longer subtitle that spans multiple lines in the tile.',
          ),
        ),
      ),
    ),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);

Widget _selected(BuildContext context) => _wrap(
  ListTile(
    selected: true,
    leading: Icon(LucideIcons.check),
    title: Text(docsSample(context, 'Selected')),
    subtitle: Text(docsSample(context, 'Selected state')),
  ),
);

Widget _disabled(BuildContext context) => _wrap(
  ListTile(
    enabled: false,
    leading: Icon(LucideIcons.user),
    title: Text(docsSample(context, 'Disabled')),
    subtitle: Text(docsSample(context, 'Disabled state')),
  ),
);

Widget _customized(BuildContext context) => _wrap(
  ListTile(
    style: const ListTileTheme(
      tileColor: null,
      titleStyle: TextStyle(fontWeight: FontWeight.w700),
    ),
    leading: const Icon(LucideIcons.star),
    title: Text(docsSample(context, 'Customized')),
    subtitle: Text(docsSample(context, 'With style override')),
    trailing: const Icon(LucideIcons.heart),
  ),
);

Widget _grouped(BuildContext context) => _wrap(
  ListTileGroup(
    children: <Widget>[
      ListTile(
        title: Text(docsSample(context, 'First')),
        leading: Icon(LucideIcons.user),
      ),
      ListTile(
        title: Text(docsSample(context, 'Second')),
        leading: Icon(LucideIcons.user),
      ),
      ListTile(
        title: Text(docsSample(context, 'Third')),
        leading: Icon(LucideIcons.user),
      ),
    ],
  ),
);

List<ComponentPreview> get listTilePreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Compact'), _compact),
  ComponentPreview(docsSample(null, 'Comfortable'), _comfortable),
  ComponentPreview('Avatar', _avatar),
  ComponentPreview(docsSample(null, 'Avatar comfortable'), _avatarComfortable),
  ComponentPreview(docsSample(null, 'Dense'), _dense),
  ComponentPreview(docsSample(null, 'Three line'), _threeLine),
  ComponentPreview(docsSample(null, 'Selected'), _selected),
  ComponentPreview(docsSample(null, 'Disabled'), _disabled),
  ComponentPreview(docsSample(null, 'Customized'), _customized),
  ComponentPreview(docsSample(null, 'Grouped'), _grouped),
];
