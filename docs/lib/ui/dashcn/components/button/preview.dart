// Named examples for the `button` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-D1b: single-button examples use `Align.center` (not start) so the stage
// centres them on both axes.
//
// P7-C2: every example is live — a press is counted in the button's own label
// (or in a status line under the row), so the demo shows the callback firing.
//
// P7-S1: the status demos live in `preview_status.dart`; each rests at idle
// (settle-safe: no spinner or timer on the first frame).

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import 'button.dart';
import 'preview_status.dart';

/// One button whose label counts the presses the example owns.
class _PressableButton extends StatefulWidget {
  const _PressableButton({
    required this.label,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final ButtonVariant variant;

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Button(
        variant: widget.variant,
        onPressed: () => setState(() => _presses++),
        child: Text(
          _presses == 0 ? widget.label : '${widget.label} · $_presses',
        ),
      ),
    );
  }
}

/// One variant demo, centred with its press count in the label.
Widget _buttonExample(
  BuildContext context,
  ButtonVariant variant,
  String label,
) {
  return _PressableButton(variant: variant, label: label);
}

Widget _buttonDefault(BuildContext context) =>
    _buttonExample(context, ButtonVariant.primary, 'Button');

Widget _buttonSecondary(BuildContext context) =>
    _buttonExample(context, ButtonVariant.secondary, 'Secondary');

Widget _buttonOutline(BuildContext context) =>
    _buttonExample(context, ButtonVariant.outline, 'Outline');

Widget _buttonGhost(BuildContext context) =>
    _buttonExample(context, ButtonVariant.ghost, 'Ghost');

Widget _buttonLink(BuildContext context) =>
    _buttonExample(context, ButtonVariant.link, 'Link');

Widget _buttonDestructive(BuildContext context) =>
    _buttonExample(context, ButtonVariant.destructive, 'Delete');

/// Icon-only button (upstream `size="icon"`) with the press count beside it.
class _ButtonIcon extends StatefulWidget {
  const _ButtonIcon();

  @override
  State<_ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<_ButtonIcon> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Button(
          size: ButtonSize.icon,
          variant: ButtonVariant.outline,
          onPressed: () => setState(() => _presses++),
          child: const Icon(LucideIcons.settings, size: 16),
        ),
        Gap(theme.spacing.md),
        // Truncate on narrow touch viewports instead of overflowing the row.
        Flexible(
          child: Text(
            _presses == 0 ? 'not pressed yet' : 'pressed $_presses time(s)',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Leading and trailing icon buttons; both report the press below the row.
class _ButtonWithIcon extends StatefulWidget {
  const _ButtonWithIcon();

  @override
  State<_ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<_ButtonWithIcon> {
  String _last = 'not pressed yet';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.md,
          runSpacing: theme.spacing.sm,
          children: <Widget>[
            Button(
              leading: const Icon(LucideIcons.plus, size: 16),
              onPressed: () => setState(() => _last = 'Add item pressed'),
              child: const Text('Add item'),
            ),
            Button(
              variant: ButtonVariant.outline,
              trailing: const Icon(LucideIcons.chevronRight, size: 16),
              onPressed: () => setState(() => _last = 'Next pressed'),
              child: const Text('Next'),
            ),
          ],
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

/// The size scale in one row (upstream shows the sizes together).
class _ButtonSizes extends StatefulWidget {
  const _ButtonSizes();

  @override
  State<_ButtonSizes> createState() => _ButtonSizesState();
}

class _ButtonSizesState extends State<_ButtonSizes> {
  String _last = 'not pressed yet';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            for (final ButtonSize size in ButtonSize.values)
              if (size != ButtonSize.icon)
                Button(
                  size: size,
                  onPressed: () =>
                      setState(() => _last = '${size.name} button pressed'),
                  child: Text(size.name),
                ),
          ],
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

/// A disabled button.
Widget _buttonDisabled(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: Button(enabled: false, child: Text('Disabled')),
  );
}

Widget _buttonIcon(BuildContext context) => const _ButtonIcon();

Widget _buttonWithIcon(BuildContext context) => const _ButtonWithIcon();

Widget _buttonSizes(BuildContext context) => const _ButtonSizes();

Widget _buttonLoading(BuildContext context) => const ButtonLoadingPreview();

Widget _buttonAsyncSuccess(BuildContext context) =>
    const ButtonAsyncSuccessPreview();

Widget _buttonAsyncFailure(BuildContext context) =>
    const ButtonAsyncFailurePreview();

Widget _buttonControlledStatus(BuildContext context) =>
    const ButtonControlledStatusPreview();

/// Named docs examples for `button`; the first entry is the default.
const List<ComponentPreview> buttonPreviews = <ComponentPreview>[
  ComponentPreview('Default', _buttonDefault),
  ComponentPreview('Secondary', _buttonSecondary),
  ComponentPreview('Outline', _buttonOutline),
  ComponentPreview('Ghost', _buttonGhost),
  ComponentPreview('Link', _buttonLink),
  ComponentPreview('Destructive', _buttonDestructive),
  ComponentPreview('Icon', _buttonIcon),
  ComponentPreview('With icon', _buttonWithIcon),
  ComponentPreview('Sizes', _buttonSizes),
  ComponentPreview('Loading', _buttonLoading),
  ComponentPreview('Async (success)', _buttonAsyncSuccess),
  ComponentPreview('Async (failure)', _buttonAsyncFailure),
  ComponentPreview('Controlled status', _buttonControlledStatus),
  ComponentPreview('Disabled', _buttonDisabled),
];
