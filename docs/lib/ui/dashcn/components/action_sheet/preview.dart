import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import 'action_sheet.dart';

Widget _default(BuildContext context) => ActionSheet<void>(
  title: 'Actions',
  message: 'Choose an action',
  actions: const <ActionSheetAction<void>>[
    ActionSheetAction<void>(label: 'Edit', icon: Icon(LucideIcons.pencil)),
    ActionSheetAction<void>(label: 'Share', icon: Icon(LucideIcons.share)),
  ],
  cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
);

Widget _destructive(BuildContext context) => ActionSheet<void>(
  title: 'Delete item?',
  message: 'This cannot be undone.',
  actions: const <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: 'Delete',
      icon: Icon(LucideIcons.trash),
      isDestructive: true,
    ),
  ],
  cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
);

Widget _long(BuildContext context) => ActionSheet<void>(
  title: 'Many actions',
  actions: List<ActionSheetAction<void>>.generate(
    12,
    (int i) => ActionSheetAction<void>(label: 'Action ${i + 1}'),
  ),
  cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
);

Widget _customized(BuildContext context) => ActionSheet<void>(
  title: 'Customized',
  actions: const <ActionSheetAction<void>>[
    ActionSheetAction<void>(label: 'Do it'),
  ],
  theme: const ActionSheetTheme(),
);

const List<ComponentPreview> actionSheetPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Destructive', _destructive),
  ComponentPreview('Long', _long),
  ComponentPreview('Customized', _customized),
];
