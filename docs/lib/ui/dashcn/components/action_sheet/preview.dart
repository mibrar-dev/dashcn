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
      title: docsSample(context, 'Actions'),
      message: docsSample(context, 'Choose an action'),
      actions: <ActionSheetAction<void>>[
        ActionSheetAction<void>(
          label: docsSample(context, 'Edit'),
          icon: const Icon(LucideIcons.pencil),
        ),
        ActionSheetAction<void>(
          label: docsSample(context, 'Share'),
          icon: const Icon(LucideIcons.share),
        ),
        ActionSheetAction<void>(
          label: docsSample(context, 'Delete'),
          icon: const Icon(LucideIcons.trash),
          isDestructive: true,
        ),
      ],
      cancelAction: ActionSheetAction<void>(
        label: docsSample(context, 'Cancel'),
      ),
    ),
    child: Text(docsSample(context, 'Open action sheet')),
  ),
);

Widget _destructive(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.destructive,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: docsSample(context, 'Delete item?'),
      message: docsSample(context, 'This cannot be undone.'),
      actions: <ActionSheetAction<void>>[
        ActionSheetAction<void>(
          label: docsSample(context, 'Delete'),
          icon: const Icon(LucideIcons.trash),
          isDestructive: true,
        ),
      ],
      cancelAction: ActionSheetAction<void>(
        label: docsSample(context, 'Cancel'),
      ),
    ),
    child: Text(docsSample(context, 'Delete item')),
  ),
);

Widget _long(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.secondary,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: docsSample(context, 'Many actions'),
      actions: List<ActionSheetAction<void>>.generate(
        12,
        (int i) => ActionSheetAction<void>(label: 'Action ${i + 1}'),
      ),
      cancelAction: ActionSheetAction<void>(
        label: docsSample(context, 'Cancel'),
      ),
    ),
    child: Text(docsSample(context, 'Many actions')),
  ),
);

Widget _compact(BuildContext context) => ActionSheet<void>(
  densityTokens: DensityTokens.compact,
  title: docsSample(context, 'Compact (default)'),
  message: docsSample(context, 'Row 40, icon 16, padding 12/6'),
  actions: <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: docsSample(context, 'Edit'),
      icon: Icon(LucideIcons.pencil),
    ),
    ActionSheetAction<void>(
      label: docsSample(context, 'Share'),
      icon: Icon(LucideIcons.share),
    ),
  ],
  cancelAction: ActionSheetAction<void>(label: docsSample(context, 'Cancel')),
);

Widget _comfortable(BuildContext context) => ActionSheet<void>(
  densityTokens: DensityTokens.comfortable,
  title: docsSample(context, 'Comfortable'),
  message: docsSample(context, 'Row 40-44, icon 20, padding 14/8'),
  actions: <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: docsSample(context, 'Edit'),
      icon: Icon(LucideIcons.pencil),
    ),
    ActionSheetAction<void>(
      label: docsSample(context, 'Share'),
      icon: Icon(LucideIcons.share),
    ),
  ],
  cancelAction: ActionSheetAction<void>(label: docsSample(context, 'Cancel')),
);

Widget _customized(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.outline,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: docsSample(context, 'Customized'),
      actions: <ActionSheetAction<void>>[
        ActionSheetAction<void>(label: docsSample(context, 'Do it')),
      ],
      theme: const ActionSheetTheme(),
      cancelAction: ActionSheetAction<void>(
        label: docsSample(context, 'Dismiss'),
      ),
    ),
    child: Text(docsSample(context, 'Customized')),
  ),
);

Widget _builders(BuildContext context) => ActionSheet<void>(
  title: docsSample(context, 'Builders'),
  message: docsSample(context, 'Custom title and row'),
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
  actions: <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: docsSample(context, 'Edit'),
      icon: Icon(LucideIcons.pencil),
    ),
    ActionSheetAction<void>(
      label: docsSample(context, 'Delete'),
      isDestructive: true,
    ),
  ],
  cancelAction: ActionSheetAction<void>(label: docsSample(context, 'Cancel')),
);

Widget _inline(BuildContext context) => ActionSheet<void>(
  title: docsSample(context, 'Inline sheet'),
  message: docsSample(context, 'Embedded directly into a layout'),
  actions: <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: docsSample(context, 'Edit'),
      icon: Icon(LucideIcons.pencil),
    ),
    ActionSheetAction<void>(
      label: docsSample(context, 'Share'),
      icon: Icon(LucideIcons.share),
    ),
  ],
  cancelAction: ActionSheetAction<void>(label: docsSample(context, 'Cancel')),
);

List<ComponentPreview> get actionSheetPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Trigger'), _default),
  ComponentPreview(docsSample(null, 'Destructive'), _destructive),
  ComponentPreview(docsSample(null, 'Long'), _long),
  ComponentPreview(docsSample(null, 'Compact'), _compact),
  ComponentPreview(docsSample(null, 'Comfortable'), _comfortable),
  ComponentPreview(docsSample(null, 'Customized'), _customized),
  ComponentPreview(docsSample(null, 'Builders'), _builders),
  ComponentPreview(docsSample(null, 'Inline'), _inline),
];
