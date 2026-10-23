// Named examples for the `divider` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'divider.dart';

/// A plain horizontal rule.
Widget _dividerDefault(BuildContext context) => const Divider();

/// The labelled form, with the three label alignments.
Widget _dividerLabelled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Divider(label: Text(docsSample(context, 'or continue with'))),
      Gap(spacing.sm),
      Divider(
        labelAlignment: DividerLabelAlignment.start,
        label: Text(docsSample(context, 'New this week')),
      ),
      Gap(spacing.sm),
      Divider(
        labelAlignment: DividerLabelAlignment.end,
        label: Text(docsSample(context, 'Archived')),
      ),
    ],
  );
}

/// Vertical rule between two lines of text.
Widget _dividerVertical(BuildContext context) {
  return SizedBox(
    height: 72,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(docsSample(context, 'Inbox')),
        Divider(axis: Axis.vertical),
        Text(docsSample(context, 'Archive')),
      ],
    ),
  );
}

/// Named docs examples for `divider`; the first entry is the default.
List<ComponentPreview> get dividerPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _dividerDefault),
  ComponentPreview(docsSample(null, 'Labelled'), _dividerLabelled),
  ComponentPreview(docsSample(null, 'Vertical'), _dividerVertical),
];
