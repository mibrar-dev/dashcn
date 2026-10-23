// The `signup-02` block, part 3: the full-height brand panel. Imported by
// `signup_02.dart`; a block never imports another block.

import 'package:flutter/widgets.dart';

import '../../components/divider/divider.dart';
import '../../components/progress/progress.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';
import '../../foundation/component_preview.dart';

/// The brand panel: muted fill edge to edge, the product mark top-left, the
/// trial summary in the middle and a quote anchored at the bottom. No
/// images, so it works offline and in every preset.
class Signup02Aside extends StatelessWidget {
  /// Creates the brand panel.
  const Signup02Aside({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    return ColoredBox(
      color: theme.colors.card,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: _Signup02Dots(color: theme.colors.mutedForeground),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(theme.spacing.xl * 1.5),
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
                    Text(strings.blockWhatYouGet, style: theme.typography.h3),
                    Gap(theme.spacing.lg),
                    for (final String line in <String>[
                      docsSample(
                        context,
                        docsSample(
                          context,
                          docsSample(context, 'Unlimited projects during the trial'),
                        ),
                      ),
                      docsSample(context, 'All component categories'),
                      docsSample(context, 'Priority support'),
                    ]) ...<Widget>[
                      _Signup02Bullet(line: line),
                      Gap(theme.spacing.md),
                    ],
                    Gap(theme.spacing.md),
                    const Divider(),
                    Gap(theme.spacing.lg),
                    const Progress(value: 1, height: 8),
                    Gap(theme.spacing.sm),
                    Text(
                      docsSample(context, '14 days left in your trial'),
                      style: theme.typography.textSmall.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                    Gap(theme.spacing.xl),
                    Text(
                      docsSample(
                        context,
                        docsSample(
                          context,
                          docsSample(context, '"We onboarded the whole team in an afternoon."'),
                        ),
                      ),
                      style: theme.typography.textLarge,
                    ),
                    Gap(theme.spacing.md),
                    Text(
                      docsSample(context, 'Ada Lovelace — Engineer, Acme'),
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

/// One trial bullet: a check icon plus the line.
class _Signup02Bullet extends StatelessWidget {
  /// Creates a bullet for [line].
  const _Signup02Bullet({required this.line});

  /// The bullet text.
  final String line;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(LucideIcons.check, size: 16, color: theme.colors.primary),
        Gap(theme.spacing.sm),
        Expanded(child: Text(line, style: theme.typography.textSmall)),
      ],
    );
  }
}

/// A subtle dot grid at 8% opacity of the muted-foreground token.
class _Signup02Dots extends CustomPainter {
  /// Creates the painter for [color].
  const _Signup02Dots({required this.color});

  /// The dot color before the opacity is applied.
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
  bool shouldRepaint(_Signup02Dots oldDelegate) => oldDelegate.color != color;
}
