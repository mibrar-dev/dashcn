// Gallery preview for the `alpha` component: the checkerboard behind a
// translucent colour well, in light and dark.

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import 'alpha.dart';
import '../../foundation/component_preview.dart';

/// Renders the alpha gallery.
class AlphaPreview extends StatelessWidget {
  /// Creates the preview.
  const AlphaPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: DefaultTextStyle(
        style: TextStyle(color: theme.colors.foreground, fontSize: 13),
        child: ColoredBox(
          color: theme.colors.background,
          child: Center(
            child: SizedBox(
              width: 220,
              height: 48,
              child: Stack(
                children: <Widget>[
                  const Positioned.fill(
                    child: CustomPaint(painter: AlphaPainter()),
                  ),
                  Container(color: theme.colors.primary.withValues(alpha: 0.5)),
                  Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: theme.colors.background),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        child: Text(docsSample(context, 'Alpha grid')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
