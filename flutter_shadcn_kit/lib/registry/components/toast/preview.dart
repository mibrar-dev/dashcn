// Named examples for the `toast` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-WA: every trigger calls `showToast` on its own context, so the toast
// opens over the WHOLE app through the app-level `ToastLayer` (hosted in the
// docs shell) at the configured position — never clipped to the stage.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'toast.dart';

/// Centred trigger column.
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
        child: Text(label),
      ),
    );
  }
}

Widget _default(BuildContext context) => _Trigger(
  label: 'Show toast',
  onPressed: () => showToast(
    context,
    builder: (context) => const Text('Saved to your workspace.'),
  ),
);

Widget _destructive(BuildContext context) => _Trigger(
  label: 'Show destructive toast',
  onPressed: () => showToast(
    context,
    placement: ToastPlacement.bottomCenter,
    builder: (BuildContext toastContext) => Text(
      'Could not save the file.',
      style: TextStyle(
        color: ShadcnTheme.of(toastContext).colors.destructive,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);

/// Toast with a live inline action.
class _ActionTrigger extends StatelessWidget {
  const _ActionTrigger();

  @override
  Widget build(BuildContext context) {
    return _Trigger(
      label: 'Show toast with action',
      onPressed: () => showToast(
        context,
        placement: ToastPlacement.bottomTrailing,
        builder: (BuildContext toastContext) => Wrap(
          spacing: ShadcnTheme.of(toastContext).spacing.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Text('Deployment started.'),
            Button(
              variant: ButtonVariant.secondary,
              size: ButtonSize.sm,
              onPressed: () => toastControllerOf(toastContext)?.dismissAll(),
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _withAction(BuildContext context) => const _ActionTrigger();

/// One trigger per window position, all over the app.
Widget _positions(BuildContext context) {
  final double gap = ShadcnTheme.of(context).spacing.sm;
  return Center(
    child: Wrap(
      spacing: gap,
      runSpacing: gap,
      alignment: WrapAlignment.center,
      children: <Widget>[
        for (final ToastPlacement placement in ToastPlacement.values)
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => showToast(
              context,
              placement: placement,
              builder: (context) => Text('Toast at ${placement.name}.'),
            ),
            child: Text(placement.name),
          ),
      ],
    ),
  );
}

/// Named docs examples for `toast`; the first entry is the default.
const List<ComponentPreview> toastPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Destructive', _destructive),
  ComponentPreview('With action', _withAction),
  ComponentPreview('Positions', _positions),
];
