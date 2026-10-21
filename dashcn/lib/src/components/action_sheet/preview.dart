import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/density_tokens.dart';
import '../button/button.dart';
import 'action_sheet.dart';
import 'action_sheet_show.dart';

Widget _default(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.outline,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: 'Actions',
      message: 'Choose an action',
      actions: <ActionSheetAction<void>>[
        ActionSheetAction<void>(
          label: 'Edit',
          icon: const Icon(LucideIcons.pencil),
        ),
        ActionSheetAction<void>(
          label: 'Share',
          icon: const Icon(LucideIcons.share),
        ),
        ActionSheetAction<void>(
          label: 'Delete',
          icon: const Icon(LucideIcons.trash),
          isDestructive: true,
        ),
      ],
      cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
    ),
    child: const Text('Open action sheet'),
  ),
);

Widget _destructive(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.destructive,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: 'Delete item?',
      message: 'This cannot be undone.',
      actions: <ActionSheetAction<void>>[
        ActionSheetAction<void>(
          label: 'Delete',
          icon: const Icon(LucideIcons.trash),
          isDestructive: true,
        ),
      ],
      cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
    ),
    child: const Text('Delete item'),
  ),
);

Widget _long(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.secondary,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: 'Many actions',
      actions: List<ActionSheetAction<void>>.generate(
        12,
        (int i) => ActionSheetAction<void>(label: 'Action ${i + 1}'),
      ),
      cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
    ),
    child: const Text('Many actions'),
  ),
);

Widget _compact(BuildContext context) => ActionSheet<void>(
  densityTokens: DensityTokens.compact,
  title: 'Compact (default)',
  message: 'Row 40, icon 16, padding 12/6',
  actions: const <ActionSheetAction<void>>[
    ActionSheetAction<void>(label: 'Edit', icon: Icon(LucideIcons.pencil)),
    ActionSheetAction<void>(label: 'Share', icon: Icon(LucideIcons.share)),
  ],
  cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
);

Widget _comfortable(BuildContext context) => ActionSheet<void>(
  densityTokens: DensityTokens.comfortable,
  title: 'Comfortable',
  message: 'Row 40-44, icon 20, padding 14/8',
  actions: const <ActionSheetAction<void>>[
    ActionSheetAction<void>(label: 'Edit', icon: Icon(LucideIcons.pencil)),
    ActionSheetAction<void>(label: 'Share', icon: Icon(LucideIcons.share)),
  ],
  cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
);

Widget _customized(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.outline,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: 'Customized',
      actions: const <ActionSheetAction<void>>[
        ActionSheetAction<void>(label: 'Do it'),
      ],
      theme: const ActionSheetTheme(),
      cancelAction: const ActionSheetAction<void>(label: 'Dismiss'),
    ),
    child: const Text('Customized'),
  ),
);

Widget _builders(BuildContext context) => ActionSheet<void>(
  title: 'Builders',
  message: 'Custom title and row',
  titleBuilder: (BuildContext context, String title, TextStyle style) => Text(
    title.toUpperCase(),
    style: style.copyWith(fontWeight: FontWeight.w800),
    textAlign: TextAlign.center,
  ),
  actionBuilder:
      (
        BuildContext context,
        ActionSheetAction<void> action,
        Widget row,
        bool isCancel,
      ) => Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Color(0xFF888888), width: 2)),
        ),
        child: row,
      ),
  actions: const <ActionSheetAction<void>>[
    ActionSheetAction<void>(label: 'Edit', icon: Icon(LucideIcons.pencil)),
    ActionSheetAction<void>(label: 'Delete', isDestructive: true),
  ],
  cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
);

Widget _inline(BuildContext context) => ActionSheet<void>(
  title: 'Inline sheet',
  message: 'Embedded directly into a layout',
  actions: const <ActionSheetAction<void>>[
    ActionSheetAction<void>(label: 'Edit', icon: Icon(LucideIcons.pencil)),
    ActionSheetAction<void>(label: 'Share', icon: Icon(LucideIcons.share)),
  ],
  cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
);

const List<ComponentPreview> actionSheetPreviews = <ComponentPreview>[
  ComponentPreview('Trigger', _default),
  ComponentPreview('Destructive', _destructive),
  ComponentPreview('Long', _long),
  ComponentPreview('Compact', _compact),
  ComponentPreview('Comfortable', _comfortable),
  ComponentPreview('Customized', _customized),
  ComponentPreview('Builders', _builders),
  ComponentPreview('Inline', _inline),
];
