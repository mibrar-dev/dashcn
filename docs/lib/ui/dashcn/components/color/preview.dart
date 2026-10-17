// Gallery preview for the `color` component: the ColorDerivative round
// trip shown as swatches, light and dark.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../theme/color_utils.dart';
import '../../theme/theme.dart';
import 'color.dart';

/// Renders the color-model gallery.
class ColorPreview extends StatelessWidget {
  /// Creates the preview.
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const base = Color(0xFF0080FF);
    final derivative = ColorDerivative.fromColor(base);
    final muted = derivative.changeToHSVSaturation(0.5);
    final shifted = derivative.changeToHSLHue(280);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: DefaultTextStyle(
        style: TextStyle(color: theme.colors.foreground, fontSize: 13),
        child: ColoredBox(
          color: theme.colors.background,
          child: Padding(
            padding: const EdgeInsets.all(24),
            // Wrap, not Row: the three swatches sit in one centred row on
            // wide screens and reflow instead of overflowing narrow phones
            // (the framed sweep gives centre content ~328 px on a 360 px
            // phone; the row measures ~300 px plus padding).
            child: Wrap(
              spacing: theme.spacing.md,
              runSpacing: theme.spacing.md,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                _Swatch(
                  label: colorToHex(derivative.toColor()),
                  color: derivative.toColor(),
                ),
                _Swatch(
                  label: colorToHex(muted.toColor()),
                  color: muted.toColor(),
                ),
                _Swatch(
                  label: colorToHex(shifted.toColor()),
                  color: shifted.toColor(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(width: 48, height: 48, color: color),
        Gap(Theme.of(context).spacing.xs),
        Text(label),
      ],
    );
  }
}
