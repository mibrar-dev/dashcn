// Named examples for the `tooltip` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import 'tooltip.dart';

/// Label tooltip after the default delay.
Widget _default(BuildContext context) {
  return _anchor(context, LucideIcons.info, docsSample(context, 'Details'));
}

/// Label tooltip with no delay.
Widget _instant(BuildContext context) {
  return _anchor(
    context,
    LucideIcons.zap,
    docsSample(context, 'Instant'),
    waitDuration: Duration.zero,
  );
}

/// Title plus description in one tooltip.
Widget _rich(BuildContext context) {
  return Tooltip(
    // The anchor carries the message as its semantic label so screen
    // readers announce it without waiting for the hover overlay.
    semanticLabel: docsSample(
      context,
      docsSample(context, 'Deployment. Ships when the checks pass.'),
    ),
    tooltip: (BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          docsSample(context, 'Deployment'),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(docsSample(context, 'Ships when the checks pass.')),
      ],
    ),
    child: Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        LucideIcons.rocket,
        size: 16,
        color: Theme.of(context).colors.foreground,
      ),
    ),
  );
}

/// The container on its own, without hover behaviour.
Widget _container(BuildContext context) {
  return TooltipContainer(child: Text(docsSample(context, 'Primary surface')));
}

Widget _anchor(
  BuildContext context,
  IconData icon,
  String label, {
  Duration waitDuration = kTooltipWaitDuration,
}) {
  final theme = Theme.of(context);
  // P7-TH1: the anchor hugs the trigger and sits in the middle of the stage.
  return Align(
    alignment: Alignment.center,
    child: Tooltip(
      waitDuration: waitDuration,
      // The anchor carries the message as its semantic label so screen
      // readers announce it without waiting for the hover overlay.
      semanticLabel: label,
      tooltip: (BuildContext context) => Text(docsSample(context, label)),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: theme.colors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: theme.colors.foreground),
      ),
    ),
  );
}

/// Named docs examples for `tooltip`; the first entry is the default.
List<ComponentPreview> get tooltipPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Instant'), _instant),
  ComponentPreview(docsSample(null, 'Rich content'), _rich),
  ComponentPreview(docsSample(null, 'Container'), _container),
];
