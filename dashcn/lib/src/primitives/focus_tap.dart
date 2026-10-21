// Keyboard-focusable tap wrapper shared by player chrome (and any
// icon-only control).
//
// Mouse/touch users get the [GestureDetector]; keyboard users can Tab to the
// control (visible [FocusOutline] ring) and press Enter or Space. Keeps the
// [Semantics] label and the [TapTarget] minimum.
//
// Widgets-only; no Material/Cupertino. Layer 2 (primitives): may import
// foundation/theme plus Flutter non-Material libraries only.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'focus_outline.dart';
import 'tap_target.dart';

/// Wraps a visual in a focusable, labelled tap target.
class FocusableTap extends StatefulWidget {
  /// Creates a focusable tap wrapper.
  const FocusableTap({
    super.key,
    required this.label,
    required this.onTap,
    required this.child,
    this.minWidth = 48,
    this.minHeight = 48,
    this.circular = false,
    this.autofocus = false,
  });

  /// Accessible label.
  final String label;

  /// Called on tap, Enter or Space.
  final VoidCallback? onTap;

  /// The visual, painted at its own size.
  final Widget child;

  /// Minimum hit width.
  final double minWidth;

  /// Minimum hit height.
  final double minHeight;

  /// Circle ring (round buttons) instead of the rectangular one.
  final bool circular;

  /// Whether to request focus on first build (tests, dialogs).
  final bool autofocus;

  @override
  State<FocusableTap> createState() => _FocusableTapState();
}

class _FocusableTapState extends State<FocusableTap> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: (bool v) => setState(() => _focused = v),
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is! KeyDownEvent) return KeyEventResult.ignored;
        if (event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          widget.onTap?.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: FocusOutline(
        focused: _focused,
        shape: widget.circular ? BoxShape.circle : BoxShape.rectangle,
        child: Semantics(
          label: widget.label,
          button: true,
          child: TapTarget(
            minWidth: widget.minWidth,
            minHeight: widget.minHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onTap,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
