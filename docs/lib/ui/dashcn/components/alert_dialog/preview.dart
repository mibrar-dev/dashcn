// Named examples for the `alert_dialog` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// Every example is a centred trigger button; pressing it calls
// `showAlertDialog` (root navigator, barrier), so the dialog opens over the
// WHOLE app — exactly like the `dialog` previews — never clipped to the
// stage. P7-WA: header icon sits on the title row (top-aligned with the first
// line), the footer is right-aligned (`WrapAlignment.end`) and stacks
// full-width at or below a 480px card.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../button/button.dart';
import 'alert_dialog.dart';

/// Centred trigger button, like the `dialog` previews.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(docsSample(context, label)),
      ),
    );
  }
}

/// Confirm/cancel footer. Built from the dialog's own context: popping the
/// caller's context would pop the page under the dialog in apps with nested
/// navigators.
List<Widget> _confirmActions(
  BuildContext dialogContext, {
  required String confirmLabel,
  required ButtonVariant confirmVariant,
}) {
  return <Widget>[
    Button(
      size: ButtonSize.sm,
      variant: ButtonVariant.outline,
      onPressed: () => Navigator.of(dialogContext).pop(false),
      child: Text(docsSample(dialogContext, 'Cancel')),
    ),
    Button(
      size: ButtonSize.sm,
      variant: confirmVariant,
      onPressed: () => Navigator.of(dialogContext).pop(true),
      child: Text(docsSample(dialogContext, confirmLabel)),
    ),
  ];
}

/// Destructive delete-account confirmation.
Widget _deleteAccount(BuildContext context) => _Trigger(
  label: docsSample(context, 'Delete account'),
  onPressed: () => showAlertDialog<bool>(
    context: context,
    icon: const Icon(LucideIcons.circleAlert),
    title: Text(docsSample(context, 'Delete your account?')),
    description: Text(
      docsSample(
        context,
        docsSample(
          context,
          docsSample(context, 'This permanently deletes your account and all of its data. This action cannot be undone.'),
        ),
      ),
    ),
    actionsBuilder: (BuildContext dialogContext) => _confirmActions(
      dialogContext,
      confirmLabel: docsSample(context, 'Delete account'),
      confirmVariant: ButtonVariant.destructive,
    ),
  ),
);

/// Discard-changes confirmation.
Widget _discardChanges(BuildContext context) => _Trigger(
  label: docsSample(context, 'Discard changes'),
  onPressed: () => showAlertDialog<bool>(
    context: context,
    icon: const Icon(LucideIcons.triangleAlert),
    title: Text(docsSample(context, 'Discard unsaved changes?')),
    description: Text(
      docsSample(
        context,
        docsSample(
          context,
          docsSample(context, 'You have unsaved changes to this document. Leaving now will lose them.'),
        ),
      ),
    ),
    actionsBuilder: (BuildContext dialogContext) => _confirmActions(
      dialogContext,
      confirmLabel: docsSample(context, 'Discard'),
      confirmVariant: ButtonVariant.destructive,
    ),
  ),
);

/// Live countdown text of the session dialog; ticks while the dialog is open.
class _SessionCountdown extends StatefulWidget {
  const _SessionCountdown();

  @override
  State<_SessionCountdown> createState() => _SessionCountdownState();
}

class _SessionCountdownState extends State<_SessionCountdown> {
  static const int _total = 90;
  int _left = _total;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }
      setState(() => _left = _left > 0 ? _left - 1 : 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = _left ~/ 60;
    final String seconds = (_left % 60).toString().padLeft(2, '0');
    return Text(
      'Your session ends in $minutes:$seconds. Extend it to keep working.',
    );
  }
}

/// Session-expiring countdown with an explicit way out.
Widget _sessionExpiring(BuildContext context) => _Trigger(
  label: docsSample(context, 'Session expiring'),
  onPressed: () => showAlertDialog<bool>(
    context: context,
    icon: const Icon(LucideIcons.clock),
    title: Text(docsSample(context, 'Session expiring')),
    description: const _SessionCountdown(),
    actionsBuilder: (BuildContext dialogContext) => <Widget>[
      Button(
        size: ButtonSize.sm,
        variant: ButtonVariant.outline,
        onPressed: () => Navigator.of(dialogContext).pop(false),
        child: Text(docsSample(context, 'Sign out')),
      ),
      Button(
        size: ButtonSize.sm,
        variant: ButtonVariant.primary,
        onPressed: () => Navigator.of(dialogContext).pop(true),
        child: Text(docsSample(context, 'Stay signed in')),
      ),
    ],
  ),
);

/// Success confirmation.
Widget _success(BuildContext context) => _Trigger(
  label: docsSample(context, 'Show success'),
  onPressed: () => showAlertDialog<bool>(
    context: context,
    icon: const Icon(LucideIcons.circleCheck),
    title: Text(docsSample(context, 'Payment successful')),
    description: Text(
      docsSample(
        context,
        docsSample(
          context,
          docsSample(context, 'Your subscription is active. A receipt was sent to your inbox.'),
        ),
      ),
    ),
    actionsBuilder: (BuildContext dialogContext) => <Widget>[
      Button(
        size: ButtonSize.sm,
        variant: ButtonVariant.primary,
        onPressed: () => Navigator.of(dialogContext).pop(true),
        child: Text(docsSample(context, 'Done')),
      ),
    ],
  ),
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
          title: Text(docsSample(context, 'Delete this project?')),
          description: Text(
            docsSample(
              context,
              docsSample(context, 'This action cannot be undone. The project and its history is removed.'),
            ),
          ),
          actionsBuilder: (BuildContext dialogContext) => <Widget>[
            Button(
              variant: ButtonVariant.outline,
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(docsSample(context, 'Cancel')),
            ),
            Button(
              variant: ButtonVariant.destructive,
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(docsSample(context, 'Delete')),
            ),
          ],
        ),
        child: Text(docsSample(context, 'Show alert dialog')),
      ),
    );
  }
}

Widget _livePush(BuildContext context) => const _LivePush();

/// Named docs examples for `alert_dialog`; the first entry is the default.
List<ComponentPreview> get alertDialogPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Delete account'), _deleteAccount),
  ComponentPreview(docsSample(null, 'Discard changes'), _discardChanges),
  ComponentPreview(docsSample(null, 'Session expiring'), _sessionExpiring),
  ComponentPreview(docsSample(null, 'Success'), _success),
  ComponentPreview(docsSample(null, 'Live push'), _livePush),
];
