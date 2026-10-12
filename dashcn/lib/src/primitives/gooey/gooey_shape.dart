// Metaball ("gooey") silhouette geometry.
//
// Ported verbatim from the working `main` renderer (`_buildGooeyShapePath`,
// `_buildGooeyBodyPath`, `_buildGooeyShoulderBlendPath`): the surface is the
// union of three sub-paths — the compact pill rounded-rect, the expanded body
// rounded-rect (morphing from the pill width to the canvas width and scaled in
// from the seam), and two small concave "shoulder" ovals that blend the narrow
// pill into the wider body. The metaball blur+threshold pass merges them into
// one silhouette; there is no stroke, so overlapping sub-paths never show a
// seam. Copy the numbers, do not re-derive: `seamOverlap = 4`, blend radius
// `roundness * 0.62`, body seam at `pillHeight - seamOverlap`.

import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Overlap of the body rect across the pill seam, so the contour never folds
/// where the two widths differ. Matches the reference's `seamOverlap`.
const double kGooeySeamOverlap = 4;

/// Silhouette of one gooey surface for a single animation frame.
@immutable
class GooeyShapeGeometry {
  /// Creates a geometry snapshot.
  const GooeyShapeGeometry({
    this.roundness = 18,
    this.pillX = 0,
    this.pillWidth = 350,
    this.pillHeight = 40,
    this.pillCanvasHeight = 40,
    this.pillScaleY = 1,
    this.bodyHeight = 0,
    this.bodyScaleY = 0,
  });

  /// Corner roundness of the pill, fillets and body (already shape-resolved).
  final double roundness;

  /// Left edge of the compact pill inside the surface canvas.
  final double pillX;

  /// Width of the compact pill.
  final double pillWidth;

  /// Content height of the pill; also the seam the body grows from.
  final double pillHeight;

  /// Drawn pill height including the blur head-room, before [pillScaleY].
  final double pillCanvasHeight;

  /// Vertical scale of the drawn pill: content/padded while closed, `1` open.
  final double pillScaleY;

  /// Height of the expanded body; `0` keeps the surface closed.
  final double bodyHeight;

  /// Opening progress of the expanded body (`0..1`).
  final double bodyScaleY;

  /// Whether the expanded body is drawn at all this frame.
  bool get _bodyVisible => bodyHeight > 0 && bodyScaleY > 0.04;

  /// Compact pill rounded-rect for this frame.
  ///
  /// Height is `pillCanvasHeight * pillScaleY`: the pill carries blur head-room
  /// squashed back to the content height while closed, so the silhouette is
  /// exactly one pill tall at rest and grows smoothly while opening.
  Path _pillPath(double roundness) {
    final double height = (pillCanvasHeight * pillScaleY)
        .clamp(0.0, pillCanvasHeight)
        .toDouble();
    final double width = pillWidth.clamp(0.0, double.infinity).toDouble();
    return Path()..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(pillX, 0, width, height),
        Radius.circular(roundness),
      ),
    );
  }

  /// Expanded body rounded-rect, width morphing pill→canvas with an emphasized
  /// cubic, then translated to the seam and scaled in vertically.
  Path _bodyPath(Size size, double roundness) {
    if (!_bodyVisible) {
      return Path();
    }
    const double seamOverlap = kGooeySeamOverlap;
    final double normalized = ((bodyScaleY - 0.04) / 0.96)
        .clamp(0.0, 1.0)
        .toDouble();
    final double t = Curves.easeInOutCubicEmphasized.transform(normalized);
    final double morphWidth =
        (lerpDouble(pillWidth, size.width, t) ?? size.width)
            .clamp(0.0, size.width)
            .toDouble();
    final double maxLeft = (size.width - morphWidth)
        .clamp(0.0, size.width)
        .toDouble();
    final double morphLeft = (lerpDouble(pillX, 0.0, t) ?? 0.0)
        .clamp(0.0, maxLeft)
        .toDouble();
    final Path body = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(morphLeft, 0, morphWidth, bodyHeight + seamOverlap),
          Radius.circular(roundness),
        ),
      );
    final Matrix4 transform = Matrix4.identity()
      ..translateByDouble(0.0, pillHeight - seamOverlap, 0.0, 1.0)
      ..scaleByDouble(1.0, bodyScaleY, 1.0, 1.0);
    return body.transform(transform.storage);
  }

  /// Two small concave shoulder ovals at the seam that blend the narrow pill
  /// into the wider body; they grow a little as the body opens.
  Path _shoulderPath(Size size, double roundness) {
    if (bodyScaleY <= 0.04) {
      return Path();
    }
    const double seamOverlap = kGooeySeamOverlap;
    final double t = bodyScaleY.clamp(0.0, 1.0).toDouble();
    final double blendRadius = ((roundness * 0.62) * t)
        .clamp(0.0, 24.0)
        .toDouble();
    if (blendRadius <= 0) {
      return Path();
    }
    final double inset = (blendRadius * 0.24)
        .clamp(0.0, pillWidth / 2)
        .toDouble();
    final double blendY = (pillHeight - seamOverlap) + (blendRadius * 0.35);
    final Offset leftCenter = Offset(
      (pillX + inset).clamp(0.0, size.width).toDouble(),
      blendY,
    );
    final Offset rightCenter = Offset(
      (pillX + pillWidth - inset).clamp(0.0, size.width).toDouble(),
      blendY,
    );
    return Path()
      ..addOval(Rect.fromCircle(center: leftCenter, radius: blendRadius))
      ..addOval(Rect.fromCircle(center: rightCenter, radius: blendRadius));
  }

  /// Merged metaball silhouette: the pill, body and shoulder ovals unioned.
  Path buildSilhouette(Size size) {
    final Path path = _pillPath(roundness);
    path.addPath(_bodyPath(size, roundness), Offset.zero);
    path.addPath(_shoulderPath(size, roundness), Offset.zero);
    return path;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is GooeyShapeGeometry &&
        other.roundness == roundness &&
        other.pillX == pillX &&
        other.pillWidth == pillWidth &&
        other.pillHeight == pillHeight &&
        other.pillCanvasHeight == pillCanvasHeight &&
        other.pillScaleY == pillScaleY &&
        other.bodyHeight == bodyHeight &&
        other.bodyScaleY == bodyScaleY;
  }

  @override
  int get hashCode => Object.hash(
    roundness,
    pillX,
    pillWidth,
    pillHeight,
    pillCanvasHeight,
    pillScaleY,
    bodyHeight,
    bodyScaleY,
  );
}
