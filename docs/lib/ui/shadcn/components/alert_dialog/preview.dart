// Named examples for the `alert_dialog` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// The framed examples are live: Cancel closes the frame, the confirm action
// confirms, and a result strip reports what was chosen. The live-push example
// opens a real route over the WHOLE app (root navigator), never clipped to
// the stage. P7-WA: header icon sits on the title row (centred), the footer
// is right-aligned (`WrapAlignment.end`) and stacks full-width below 360px.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../foundation/gap.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'alert_dialog.dart';

/// A framed alert dialog whose buttons really act.
class _AlertFrame extends StatefulWidget {
  const _AlertFrame({
    required this.icon,
    required this.title,
    required this.description,
    this.confirmLabel = 'Continue',
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final String confirmLabel;
  final bool destructive;

  @override
  State<_AlertFrame> createState() => _AlertFrameState();
}

class _AlertFrameState extends State<_AlertFrame> {
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
                        child: Text(widget.confirmLabel),
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

/// Destructive delete-account confirmation.
Widget _deleteAccount(BuildContext context) => const _AlertFrame(
  icon: LucideIcons.circleAlert,
  title: 'Delete your account?',
  description:
      'This permanently deletes your account and all of its data. '
      'This action cannot be undone.',
  confirmLabel: 'Delete account',
  destructive: true,
);

/// Discard-changes confirmation.
Widget _discardChanges(BuildContext context) => const _AlertFrame(
  icon: LucideIcons.triangleAlert,
  title: 'Discard unsaved changes?',
  description:
      'You have unsaved changes to this document. '
      'Leaving now will lose them.',
  confirmLabel: 'Discard',
  destructive: true,
);

/// Session-expiring countdown with an explicit way out.
class _SessionFrame extends StatefulWidget {
  const _SessionFrame();

  @override
  State<_SessionFrame> createState() => _SessionFrameState();
}

class _SessionFrameState extends State<_SessionFrame> {
  static const int _total = 90;
  int _left = _total;
  Timer? _timer;
  String? _result;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _result != null) return;
      setState(() => _left = _left > 0 ? _left - 1 : 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _clock {
    final int m = _left ~/ 60;
    final int s = _left % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

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
                    icon: const Icon(LucideIcons.clock),
                    title: const Text('Session expiring'),
                    description: Text(
                      'Your session ends in $_clock. '
                      'Extend it to keep working.',
                    ),
                    actions: <Widget>[
                      Button(
                        size: ButtonSize.sm,
                        variant: ButtonVariant.outline,
                        onPressed: () => setState(() => _result = 'Signed out'),
                        child: const Text('Sign out'),
                      ),
                      Button(
                        size: ButtonSize.sm,
                        variant: ButtonVariant.primary,
                        onPressed: () => setState(() {
                          _left = _total;
                          _result = 'Session extended';
                        }),
                        child: const Text('Stay signed in'),
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
            onPressed: () => setState(() {
              _left = _total;
              _result = null;
            }),
            child: const Text('Show again'),
          ),
        ],
      ),
    );
  }
}

Widget _sessionExpiring(BuildContext context) => const _SessionFrame();

/// Success confirmation.
Widget _success(BuildContext context) => const _AlertFrame(
  icon: LucideIcons.circleCheck,
  title: 'Payment successful',
  description: 'Your subscription is active. A receipt was sent to your inbox.',
  confirmLabel: 'Done',
);

/// A live push through `showAlertDialog` over the whole app.
class _LivePush extends StatelessWidget {
  const _LivePush();

  @override
  Widget build(BuildContext context) {
    return Center(
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

Widget _livePush(BuildContext context) => const _LivePush();

/// Named docs examples for `alert_dialog`; the first entry is the default.
const List<ComponentPreview> alertDialogPreviews = <ComponentPreview>[
  ComponentPreview('Delete account', _deleteAccount),
  ComponentPreview('Discard changes', _discardChanges),
  ComponentPreview('Session expiring', _sessionExpiring),
  ComponentPreview('Success', _success),
  ComponentPreview('Live push', _livePush),
];
