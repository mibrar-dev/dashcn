// Status demos for the `button` component (`P7-S1`), used by `preview.dart`.
//
// Each demo rests at idle (settle-safe: no spinner or timer on the first
// frame) and drives the status machine on press. Not independently
// installable; ships inside the `button` component.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'button.dart';

/// Controlled loading demo: the mini-buttons drive `status:` while the main
/// button stays pressable (and disables itself while loading).
class ButtonLoadingPreview extends StatefulWidget {
  /// Creates the loading demo.
  const ButtonLoadingPreview({super.key});

  @override
  State<ButtonLoadingPreview> createState() => ButtonLoadingPreviewState();
}

/// State for [ButtonLoadingPreview].
class ButtonLoadingPreviewState extends State<ButtonLoadingPreview> {
  ButtonStatus _status = ButtonStatus.idle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Button(
            status: _status,
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ),
        Gap(theme.spacing.md),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: () => setState(() => _status = ButtonStatus.loading),
              child: const Text('Start loading'),
            ),
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.ghost,
              onPressed: () => setState(() => _status = ButtonStatus.idle),
              child: const Text('Reset'),
            ),
          ],
        ),
        Gap(theme.spacing.sm),
        Text(
          'status: ${_status.name}',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// Async success demo: press to run fake work; the button spins, shows the
/// check with its success label, then resets to idle.
class ButtonAsyncSuccessPreview extends StatefulWidget {
  /// Creates the async success demo.
  const ButtonAsyncSuccessPreview({super.key});

  @override
  State<ButtonAsyncSuccessPreview> createState() =>
      ButtonAsyncSuccessPreviewState();
}

/// State for [ButtonAsyncSuccessPreview].
class ButtonAsyncSuccessPreviewState extends State<ButtonAsyncSuccessPreview> {
  String _last = 'not pressed yet';

  Future<void> _save() {
    return Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Button(
            onPressedAsync: _save,
            successLabel: const Text('Saved'),
            onStatusChanged: (ButtonStatus status) =>
                setState(() => _last = 'last status: ${status.name}'),
            child: const Text('Save changes'),
          ),
        ),
        Gap(theme.spacing.sm),
        Text(
          _last,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// Async failure demo: the work throws, so the button shows the failure
/// glyph with its failure label and reports the error below.
class ButtonAsyncFailurePreview extends StatefulWidget {
  /// Creates the async failure demo.
  const ButtonAsyncFailurePreview({super.key});

  @override
  State<ButtonAsyncFailurePreview> createState() =>
      ButtonAsyncFailurePreviewState();
}

/// State for [ButtonAsyncFailurePreview].
class ButtonAsyncFailurePreviewState extends State<ButtonAsyncFailurePreview> {
  String _last = 'not pressed yet';

  Future<void> _pay() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    throw StateError('Card declined.');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Button(
            onPressedAsync: _pay,
            failureLabel: const Text('Failed — retry'),
            onAsyncError: (Object error, StackTrace _) =>
                setState(() => _last = '$error'),
            child: const Text('Pay now'),
          ),
        ),
        Gap(theme.spacing.sm),
        Text(
          _last,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// Controlled status demo: step the parent-owned status through the whole
/// machine and watch the button follow.
class ButtonControlledStatusPreview extends StatefulWidget {
  /// Creates the controlled status demo.
  const ButtonControlledStatusPreview({super.key});

  @override
  State<ButtonControlledStatusPreview> createState() =>
      ButtonControlledStatusPreviewState();
}

/// State for [ButtonControlledStatusPreview].
class ButtonControlledStatusPreviewState
    extends State<ButtonControlledStatusPreview> {
  ButtonStatus _status = ButtonStatus.idle;

  void _next() {
    setState(() {
      _status = ButtonStatus.values[(_status.index + 1) % 4];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Button(
            status: _status,
            onPressed: () {},
            child: const Text('Checkout'),
          ),
        ),
        Gap(theme.spacing.md),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: _next,
              child: const Text('Next state'),
            ),
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.ghost,
              onPressed: () => setState(() => _status = ButtonStatus.idle),
              child: const Text('Reset'),
            ),
          ],
        ),
        Gap(theme.spacing.sm),
        Text(
          'status: ${_status.name}',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}
