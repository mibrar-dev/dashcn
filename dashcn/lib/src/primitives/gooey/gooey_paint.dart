// Painter, clipper and compositing of the gooey silhouette.
//
// Split out of `gooey_shape.dart` (which owns the geometry) so each file stays
// under the ~400-line rule. The border is stroked once around the merged
// contour, so it can never double up at the pill/body junction.

import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'gooey_shape.dart';

/// Clips the backdrop blur to the gooey silhouette.
class GooeyShapeClipper extends CustomClipper<Path> {
  /// Creates a clipper over [geometry].
  const GooeyShapeClipper(this.geometry);

  /// Silhouette to clip to.
  final GooeyShapeGeometry geometry;

  @override
  Path getClip(Size size) => geometry.buildSilhouette(size);

  @override
  bool shouldReclip(GooeyShapeClipper oldClipper) =>
      oldClipper.geometry != geometry;
}

/// Elevation of the token-driven drop shadow under the silhouette.
///
/// `Canvas.drawShadow` cannot represent the token `BoxShadow` offset/spread
/// atoms, so only the token shadow colour is used (resolved by the caller from
/// the shadow scale); the geometry stays a fixed material-style elevation.
const double kGooeyShadowElevation = 4;

/// Paints the single-contour gooey silhouette: an optional token-coloured
/// drop shadow, the opaque fill, and an optional 1px token border.
///
/// The border is stroked once around the merged contour — never per shape —
/// so it cannot double up at the pill/body junction. The open morph is
/// carried by the geometry (width/fillets/height), not by fading shapes.
class GooeyShapePainter extends CustomPainter {
  /// Creates a painter for [geometry] in [color].
  const GooeyShapePainter({
    required this.color,
    required this.geometry,
    this.borderColor,
    this.shadowColor,
    this.elevation = kGooeyShadowElevation,
  });

  /// Opaque surface colour; per-frame alpha is carried by the layer.
  final Color color;

  /// Silhouette to paint.
  final GooeyShapeGeometry geometry;

  /// Border colour stroked once around the merged silhouette; null skips it.
  final Color? borderColor;

  /// Drop shadow colour under the merged silhouette; null skips it.
  final Color? shadowColor;

  /// Material-style elevation of the drop shadow.
  final double elevation;

  @override
  void paint(Canvas canvas, Size size) {
    final Path silhouette = geometry.buildSilhouette(size);
    if (shadowColor != null) {
      canvas.drawShadow(silhouette, shadowColor!, elevation, false);
    }
    canvas.drawPath(
      silhouette,
      Paint()
        ..color = color
        ..isAntiAlias = true,
    );
    if (borderColor != null) {
      canvas.drawPath(
        silhouette,
        Paint()
          ..color = borderColor!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..isAntiAlias = true,
      );
    }
  }

  @override
  bool shouldRepaint(GooeyShapePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.geometry != geometry ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.shadowColor != shadowColor ||
      oldDelegate.elevation != elevation;
}

/// Paints the gooey-blurred fill plus the crisp shape, fading the composited
/// group uniformly.
///
/// The blurred copy is fill-only: stroking the border (or shadow) inside the
/// blur/threshold pass leaves a fringe around the crisp silhouette — the
/// visible "edges". Border and shadow are painted once, in the crisp copy.
class _GooeyShapeStack extends StatelessWidget {
  const _GooeyShapeStack({
    required this.fillAlpha,
    required this.fill,
    required this.crisp,
    required this.enableGooeyBlur,
    required this.blur,
  });

  final double fillAlpha;
  final Widget fill;
  final Widget crisp;
  final bool enableGooeyBlur;
  final double blur;

  @override
  Widget build(BuildContext context) {
    final Widget gooey;
    if (enableGooeyBlur && blur > 0) {
      gooey = Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          ColorFiltered(
            colorFilter: const ColorFilter.matrix(<double>[
              1,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
              0,
              0,
              0,
              0,
              20,
              -2550,
            ]),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: fill,
            ),
          ),
          crisp,
        ],
      );
    } else {
      gooey = crisp;
    }
    if (fillAlpha >= 1.0) {
      return gooey;
    }
    return Opacity(opacity: fillAlpha.clamp(0.0, 1.0), child: gooey);
  }
}

/// One gooey surface layer: optional backdrop blur behind the composited
/// shape layers.
class GooeyShapeLayer extends StatelessWidget {
  /// Creates a shape layer.
  const GooeyShapeLayer({
    super.key,
    required this.width,
    required this.height,
    required this.geometry,
    required this.color,
    this.fillAlpha = 1,
    this.blur = 0,
    this.surfaceBlur = 0,
    this.enableGooeyBlur = true,
    this.borderColor,
    this.shadowColor,
  });

  /// Canvas width.
  final double width;

  /// Canvas height.
  final double height;

  /// Silhouette geometry for the current animation frame.
  final GooeyShapeGeometry geometry;

  /// Opaque surface colour.
  final Color color;

  /// Whole-layer opacity; `1` paints fully opaque.
  final double fillAlpha;

  /// Blur sigma of the metaball pass; `0` skips it.
  final double blur;

  /// Backdrop blur sigma clipped to the silhouette; `0` skips it.
  final double surfaceBlur;

  /// Whether the metaball pass runs at all.
  final bool enableGooeyBlur;

  /// Border colour around the silhouette; null skips the border.
  final Color? borderColor;

  /// Drop shadow colour under the silhouette; null skips the shadow.
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final Size canvas = Size(width, height);
    final GooeyShapePainter fillPainter = GooeyShapePainter(
      color: color,
      geometry: geometry,
    );
    final GooeyShapePainter crispPainter = GooeyShapePainter(
      color: color,
      geometry: geometry,
      borderColor: borderColor,
      shadowColor: shadowColor,
    );
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          if (surfaceBlur > 0)
            ClipPath(
              clipper: GooeyShapeClipper(geometry),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: surfaceBlur,
                  sigmaY: surfaceBlur,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          _GooeyShapeStack(
            fillAlpha: fillAlpha,
            fill: RepaintBoundary(
              child: CustomPaint(size: canvas, painter: fillPainter),
            ),
            crisp: RepaintBoundary(
              child: CustomPaint(size: canvas, painter: crispPainter),
            ),
            enableGooeyBlur: enableGooeyBlur,
            blur: blur,
          ),
        ],
      ),
    );
  }
}
