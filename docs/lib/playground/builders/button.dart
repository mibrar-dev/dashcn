// Playground builder for the `button` component.
//
// Synthetic controls (`hasIcon`/`iconPosition`/`fullWidth`) are
// playground-only: the generator injects them, this builder renders them
// (default leading/trailing icons, full-width wrapper) and `code.dart`
// emits them as `leading:`/`trailing:` plus a `SizedBox` wrapper.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Button] from playground values.
Widget buildButtonPlayground(BuildContext context, PlaygroundValues values) {
  final bool hasIcon = values.getBoolOr('hasIcon', false);
  final String iconPosition = values.getEnum('iconPosition') ?? 'leading';
  final bool fullWidth = values.getBoolOr('fullWidth', false);
  final String? statusName = values.getEnum('status');
  final ButtonStatus? status = statusName == null
      ? null
      : ButtonStatus.values.byName(statusName);
  final Widget? leading = hasIcon && iconPosition == 'leading'
      ? const Icon(LucideIcons.plus, size: 16)
      : null;
  final Widget? trailing = hasIcon && iconPosition == 'trailing'
      ? const Icon(LucideIcons.chevronRight, size: 16)
      : null;
  final Widget button = Button(
    onPressed: values.getBoolOr('enabled', true) ? () {} : null,
    variant: ButtonVariant.values.byName(
      values.getEnum('variant') ?? 'primary',
    ),
    size: ButtonSize.values.byName(values.getEnum('size') ?? 'md'),
    status: status,
    autofocus: values.getBoolOr('autofocus', false),
    leading: leading,
    trailing: trailing,
    child: Text(values.textOr('child')),
  );
  if (fullWidth) {
    return SizedBox(width: double.infinity, child: button);
  }
  return button;
}
