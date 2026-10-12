// State icon bubble and action chip of a gooey surface.
//
// Split out of `gooey_content.dart` so each file stays under the ~400-line
// rule; both pieces are widgets-only and take a resolved tone colour.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../animation.dart';

/// Circular icon bubble for the compact leading slot.
///
/// [loading] spins the glyph, replacing the old Material
/// `CircularProgressIndicator` in the gooey toast.
class GooeyStateIcon extends StatelessWidget {
  /// Creates a state icon.
  const GooeyStateIcon({
    super.key,
    required this.icon,
    required this.color,
    this.loading = false,
  });

  /// Glyph shown inside the bubble.
  final IconData icon;

  /// Bubble tint; the glyph uses it at full strength.
  final Color color;

  /// Whether to spin the glyph.
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final Widget glyph = Icon(icon, size: 16, color: color);
    // A fixed `size-6` envelope around the 16px glyph, like the button size
    // table's unscaled `minHeight`: not spacing.
    return SizedBox(
      width: 24,
      height: 24,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: loading
              ? RepeatedAnimationBuilder(
                  start: 0,
                  end: math.pi * 2,
                  duration: const Duration(milliseconds: 900),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.rotate(angle: value, child: child);
                  },
                  child: glyph,
                )
              : glyph,
        ),
      ),
    );
  }
}

/// Inline action chip for the expanded body.
///
/// Replaces the old Material `TextButton`; height 28, stadium shape, tinted
/// with the toast tone.
class GooeyActionChip extends StatelessWidget {
  /// Creates an action chip.
  const GooeyActionChip({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  /// Chip label.
  final String label;

  /// Tone colour of label, tint and border.
  final Color color;

  /// Called when the chip is tapped.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Hug the label (main's compact pill), even inside a stretching column.
    return Align(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: 1,
      child: Semantics(
        button: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPressed,
            child: Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Center(
                widthFactor: 1,
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1,
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
