// Named examples for the `alert_dialog` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the framed examples are live — Cancel closes the frame, the
// destructive action confirms, and a result strip reports what was chosen.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../foundation/gap.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'alert_dialog.dart';

/// A framed alert dialog whose buttons really act.
class _AlertDialogFrame extends StatefulWidget {
  const _AlertDialogFrame({
    required this.icon,
    required this.title,
    required this.description,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool destructive;

  @override
  State<_AlertDialogFrame> createState() => _AlertDialogFrameState();
}

class _AlertDialogFrameState extends State<_AlertDialogFrame> {
  String? _result;

  @override
  Widget build(BuildContext context) {
    final theme = ShadcnTheme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (_result == null)
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colors.background,
                borderRadius: theme.borderRadiusLg,
                border: Border.all(color: theme.colors.border),
                boxShadow: theme.tokens.shadows.shadowLg,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: EdgeInsetsDensity.pxAll(24),
                  child: AlertDialog(
                    icon: Icon(widget.icon),
                    title: Text(widget.title),
                    description: Text(widget.description),
                    actions: <Widget>[
                      Button(
                        size: ButtonSize.sm,
                        variant: ButtonVariant.outline,
                        onPressed: () => setState(() => _result = 'Cancelled'),
                        child: const Text('Cancel'),
                      ),
                      Button(
                        size: ButtonSize.sm,
                        variant: widget.destructive
                            ? ButtonVariant.destructive
                            : ButtonVariant.primary,
                        onPressed: () => setState(() => _result = 'Confirmed'),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Text(
              '$_result.',
              style: TextStyle(color: theme.colors.mutedForeground),
            ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: () => setState(() => _result = null),
            child: const Text('Show again'),
          ),
        ],
      ),
    );
  }
}

/// The default dialog.
Widget _alertDialogDefault(BuildContext context) => const _AlertDialogFrame(
  icon: LucideIcons.circleAlert,
  title: 'Are you absolutely sure?',
  description: 'This permanently deletes the account.',
);

/// The destructive dialog.
Widget _alertDialogDestructive(BuildContext context) => const _AlertDialogFrame(
  icon: LucideIcons.triangleAlert,
  title: 'Delete this project?',
  description:
      'This action cannot be undone. The project and its history is removed.',
  destructive: true,
);

/// A live push through `showAlertDialog`.
class _AlertDialogPushedDialog extends StatelessWidget {
  const _AlertDialogPushedDialog();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Button(
        onPressed: () => showAlertDialog<bool>(
          context: context,
          icon: const Icon(LucideIcons.triangleAlert),
          title: const Text('Delete this project?'),
          description: const Text(
            'This action cannot be undone. The project and its history is '
            'removed.',
          ),
          actionsBuilder: (BuildContext dialogContext) => <Widget>[
            Button(
              variant: ButtonVariant.outline,
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            Button(
              variant: ButtonVariant.destructive,
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
        child: const Text('Show alert dialog'),
      ),
    );
  }
}

Widget _alertDialogPushed(BuildContext context) =>
    const _AlertDialogPushedDialog();

/// Named docs examples for `alert_dialog`; the first entry is the default.
const List<ComponentPreview> alertDialogPreviews = <ComponentPreview>[
  ComponentPreview('Default', _alertDialogDefault),
  ComponentPreview('Destructive', _alertDialogDestructive),
  ComponentPreview('Live push', _alertDialogPushed),
];
