// Named examples for the `alert` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the compact alert carries a live trailing dismiss button, so the
// example shows the trailing slot doing something.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'alert.dart';

/// One alert, stretched to the stage width.
Widget _alert(
  BuildContext context,
  AlertVariant variant,
  String title,
  String content,
) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 512),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Alert(
          variant: variant,
          leading: const Icon(LucideIcons.info, size: 16),
          title: Text(title),
          content: Text(content),
        ),
      ],
    ),
  );
}

/// Default variant.
Widget _alertDefault(BuildContext context) => _alert(
  context,
  AlertVariant.base,
  'Heads up',
  'You can install components from the CLI.',
);

/// Destructive variant.
Widget _alertDestructive(BuildContext context) => _alert(
  context,
  AlertVariant.destructive,
  'Session expired',
  'Please log in again to continue.',
);

/// A compact alert whose trailing button dismisses it.
class _AlertCompact extends StatefulWidget {
  const _AlertCompact();

  @override
  State<_AlertCompact> createState() => _AlertCompactState();
}

class _AlertCompactState extends State<_AlertCompact> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 512),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (!_dismissed)
            Alert(
              title: const Text('Notification'),
              content: const Text('You have a new message.'),
              trailing: Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.ghost,
                onPressed: () => setState(() => _dismissed = true),
                child: const Icon(LucideIcons.x, size: 14),
              ),
            )
          else
            Text(
              'Notification dismissed.',
              style: TextStyle(color: theme.colors.mutedForeground),
            ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: () => setState(() => _dismissed = false),
            child: const Text('Show again'),
          ),
        ],
      ),
    );
  }
}

Widget _alertCompact(BuildContext context) => const _AlertCompact();

/// Named docs examples for `alert`; the first entry is the default.
const List<ComponentPreview> alertPreviews = <ComponentPreview>[
  ComponentPreview('Default', _alertDefault),
  ComponentPreview('Destructive', _alertDestructive),
  ComponentPreview('Compact', _alertCompact),
];
