// Dismiss button overlaid on an expanded gooey surface: tap, Enter/Space
// when focused, or Escape dismisses; focusing it pauses the countdown.
//
// The 24x24 box is the hit target; the visual is an 18px circle centred
// inside it, so the button reads quiet while staying tappable.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../clickable.dart';

/// Close button for an expanded gooey toast.
class GooeyCloseButton extends StatelessWidget {
  /// Creates a close button.
  const GooeyCloseButton({
    super.key,
    required this.onDismiss,
    this.onFocusChange,
  });

  /// Called to dismiss the toast.
  final VoidCallback onDismiss;

  /// Called when keyboard focus enters or leaves the button.
  final ValueChanged<bool>? onFocusChange;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.escape): onDismiss,
      },
      child: Semantics(
        button: true,
        label: 'Dismiss',
        child: Clickable(
          onPressed: onDismiss,
          onFocus: onFocusChange,
          behavior: HitTestBehavior.opaque,
          disableHoverEffect: true,
          child: SizedBox(
            width: 24,
            height: 24,
            child: Center(
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: colors.muted.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    LucideIcons.x,
                    size: 11,
                    color: colors.mutedForeground,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
