// The `qr_code` component: [QrCode], a widgets-only QR code display with
// error-correction levels, quiet zone, module shapes, theme inks and an
// optional centre logo with a cleared area.
//
// Encoding comes from the pure-Dart `qr` package through [QrMatrix]
// (`qr_code_matrix.dart`); painting is a plain `CustomPainter` that scales
// the matrix to its box, so a 40-version code still cannot overflow.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';
import 'qr_code_matrix.dart';
import 'qr_code_style.dart';

export 'qr_code_matrix.dart';
export 'qr_code_style.dart';

/// Fallback side length when the incoming constraints are unbounded.
const double _qrCodeFallbackSize = 200;

/// Paints [matrix] plus [quietZone] modules of margin on every side, scaled
/// to fit. Public so a custom QR layout can reuse it.
class QrCodePainter extends CustomPainter {
  /// Creates a painter.
  const QrCodePainter({
    required this.matrix,
    required this.quietZone,
    required this.shape,
    required this.foreground,
    required this.background,
    this.clearFraction = 0,
  });

  /// Encoded modules.
  final QrMatrix matrix;

  /// Margin width in modules, painted in [background].
  final int quietZone;

  /// Shape of one dark module.
  final QrModuleShape shape;

  /// Dark-module ink.
  final Color foreground;

  /// Light-module and quiet-zone ink.
  final Color background;

  /// Side of the cleared centre square as a fraction of the QR side
  /// (0 disables the clear area).
  final double clearFraction;

  /// Modules per side including the quiet zone.
  int get totalModules => matrix.moduleCount + quietZone * 2;

  @override
  void paint(Canvas canvas, Size size) {
    final int total = totalModules;
    final double cell = math.min(size.width, size.height) / total;
    final double grid = cell * total;
    // Centres the grid when the box is not square.
    final double dx = (size.width - grid) / 2;
    final double dy = (size.height - grid) / 2;
    canvas.drawRect(Offset.zero & size, Paint()..color = background);
    final Rect clearRect = clearFraction <= 0
        ? Rect.zero
        : Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: cell * matrix.moduleCount * clearFraction,
            height: cell * matrix.moduleCount * clearFraction,
          );
    if (clearFraction > 0) {
      canvas.drawRect(clearRect, Paint()..color = background);
    }
    final Paint ink = Paint()..color = foreground;
    for (var row = 0; row < matrix.moduleCount; row++) {
      for (var col = 0; col < matrix.moduleCount; col++) {
        if (!matrix.isDark(row, col)) {
          continue;
        }
        final Rect module = Rect.fromLTWH(
          dx + (col + quietZone) * cell,
          dy + (row + quietZone) * cell,
          cell,
          cell,
        );
        if (clearFraction > 0 && module.overlaps(clearRect)) {
          continue;
        }
        switch (shape) {
          case QrModuleShape.square:
            canvas.drawRect(module, ink);
          case QrModuleShape.rounded:
            canvas.drawRRect(
              RRect.fromRectAndRadius(module, Radius.circular(cell * 0.3)),
              ink,
            );
          case QrModuleShape.dot:
            canvas.drawCircle(module.center, cell * 0.36, ink);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant QrCodePainter oldDelegate) {
    return oldDelegate.matrix != matrix ||
        oldDelegate.quietZone != quietZone ||
        oldDelegate.shape != shape ||
        oldDelegate.foreground != foreground ||
        oldDelegate.background != background ||
        oldDelegate.clearFraction != clearFraction;
  }
}

/// Displays a QR code for [data] (a URL, text or contact payload).
///
/// The matrix scales to its box: the widget takes the smaller of the
/// available width/height (or [size] when given), so it never overflows.
/// When [center] is provided, the modules behind it are cleared and the
/// widget paints the logo on top; keep [centerFraction] small (<= 0.25)
/// unless the error-correction level can absorb the damage.
///
/// ```dart
/// QrCode(data: 'https://example.com');
/// ```
class QrCode extends StatelessWidget {
  /// Creates a QR code display.
  const QrCode({
    super.key,
    required this.data,
    this.errorCorrectLevel = QrErrorCorrectionLevel.medium,
    this.quietZone = 4,
    this.moduleShape = QrModuleShape.square,
    this.foreground,
    this.background,
    this.size,
    this.center,
    this.centerFraction = 0.24,
    this.semanticsLabel,
    this.theme,
  }) : assert(quietZone >= 0, 'quietZone must be non-negative'),
       assert(
         centerFraction >= 0 && centerFraction <= 0.5,
         'centerFraction must be within 0..0.5',
       );

  /// Encoded payload; empty renders a blank placeholder grid.
  final String data;

  /// Error-correction level; higher survives more damage at more modules.
  final QrErrorCorrectionLevel errorCorrectLevel;

  /// Quiet-zone width in modules (the spec minimum is 4).
  final int quietZone;

  /// Shape of one dark module.
  final QrModuleShape moduleShape;

  /// Dark-module ink override; null resolves the theme's foreground.
  final Color? foreground;

  /// Light-module ink override; null resolves the theme's background.
  final Color? background;

  /// Fixed square side; null fits the available box.
  final double? size;

  /// Widget painted centred over the cleared area (typically a logo).
  final Widget? center;

  /// Cleared square side as a fraction of the QR side; 0 disables clearing.
  final double centerFraction;

  /// Accessible label; null reads `'QR code'`.
  final String? semanticsLabel;

  /// Widget-leg theme override, merged on top of the other legs.
  final QrCodeTheme? theme;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final QrCodeTheme style = resolveComponentStyle<QrCodeTheme, QrCodeTheme>(
      context,
      widget: theme,
      select: (t) => t,
      defaults: qrCodeDefaults,
    );
    final ThemeColors colors = themeData.colors;
    final Color resolvedForeground =
        foreground ??
        style.foreground?.resolve(colors) ??
        qrCodeDefaults.foreground!.resolve(colors);
    final Color resolvedBackground =
        background ??
        style.background?.resolve(colors) ??
        qrCodeDefaults.background!.resolve(colors);
    final QrMatrix matrix = QrMatrix.encode(data, level: errorCorrectLevel);
    final bool clears = center != null && centerFraction > 0;
    return Semantics(
      label: semanticsLabel ?? ComponentLocalizations.of(context).qrCodeLabel,
      image: true,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double side;
          if (size != null) {
            side = size!;
          } else {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;
            if (width.isFinite && height.isFinite) {
              side = math.min(width, height);
            } else if (width.isFinite) {
              side = width;
            } else if (height.isFinite) {
              side = height;
            } else {
              side = _qrCodeFallbackSize;
            }
          }
          final double logoSide =
              side *
              (matrix.moduleCount / (matrix.moduleCount + quietZone * 2)) *
              centerFraction;
          return SizedBox.square(
            dimension: side,
            child: Stack(
              children: <Widget>[
                CustomPaint(
                  size: Size.square(side),
                  painter: QrCodePainter(
                    matrix: matrix,
                    quietZone: quietZone,
                    shape: moduleShape,
                    foreground: resolvedForeground,
                    background: resolvedBackground,
                    clearFraction: clears ? centerFraction : 0,
                  ),
                ),
                if (center != null)
                  Center(
                    child: SizedBox.square(dimension: logoSide, child: center),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
