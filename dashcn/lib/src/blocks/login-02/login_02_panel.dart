// The `login-02` block, part 2: the testimonial panel. Imported by
// `login_02.dart`; a block never imports another block.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../../foundation/component_preview.dart';

/// The testimonial panel: muted fill edge to edge, a token-drawn dot
/// pattern, the product mark top-left and a quote anchored at the bottom.
/// No images, so it works offline and in every preset.
class Login02Panel extends StatelessWidget {
  /// Creates the panel.
  const Login02Panel({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double spacing = theme.spacing.xl;
    // Edge to edge: no radius, no border. The Row gives this half a tight
    // full height, so `max` + `spaceBetween` anchors the mark top-left and
    // the quote at the bottom; under unbounded height it shrink-wraps.
    return ColoredBox(
      color: theme.colors.card,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: _DotPainter(color: theme.colors.mutedForeground),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spacing * 1.5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: theme.colors.primary,
                        borderRadius: theme.borderRadiusSm,
                      ),
                      child: Icon(
                        LucideIcons.command,
                        size: 16,
                        color: theme.colors.primaryForeground,
                      ),
                    ),
                    Gap(theme.spacing.sm),
                    Text(
                      docsSample(context, 'Acme Inc'),
                      style: theme.typography.textSmall,
                    ),
                  ],
                ),
                Gap(theme.spacing.xl),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      docsSample(
                        context,
                        docsSample(
                          context,
                          '"The kit paid for itself the week we adopted it. Every screen ships on-brand, light or dark."',
                        ),
                      ),
                      style: theme.typography.textLarge,
                    ),
                    Gap(theme.spacing.md),
                    Text(
                      docsSample(context, 'Sofia Davis — Design lead, Acme'),
                      style: theme.typography.textSmall.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A subtle dot grid at 8% opacity of the muted-foreground token.
class _DotPainter extends CustomPainter {
  const _DotPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dot = Paint()..color = color.withValues(alpha: 0.08);
    const double step = 22;
    for (double y = step / 2; y < size.height; y += step) {
      for (double x = step / 2; x < size.width; x += step) {
        canvas.drawCircle(Offset(x, y), 1.2, dot);
      }
    }
  }

  @override
  bool shouldRepaint(_DotPainter oldDelegate) => oldDelegate.color != color;
}
