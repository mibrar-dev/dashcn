// Per-frame composition of one gooey surface: the silhouette, the compact pill
// and the revealing body, interpolated from the open progress.
//
// Stateless on purpose: `gooey_surface.dart` owns the controllers and hands in
// a single `progress` value, so every frame of the morph is reproducible from
// the numbers below (that is also what the widget tests assert).

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import 'gooey_paint.dart';
import 'gooey_shape.dart';

/// Entry fade/scale duration.
const Duration kGooeyReadyDuration = Duration(milliseconds: 400);

/// Width of the compact pill/blob as the canvas widens into the full body.
const double kGooeyBodySlide = 6;

/// Expanded-body content animation profile.
@immutable
class GooeySurfaceBodyAnimation {
  /// Creates a profile.
  const GooeySurfaceBodyAnimation({
    this.slide = 0,
    this.scaleFrom = 1,
    this.instant = false,
  });

  /// Fades content in/out while the height opens/closes.
  static const GooeySurfaceBodyAnimation fade = GooeySurfaceBodyAnimation();

  /// Fades content while sliding from the toast seam.
  static const GooeySurfaceBodyAnimation fadeSlide = GooeySurfaceBodyAnimation(
    slide: kGooeyBodySlide,
  );

  /// Fades content while slightly scaling from compact to expanded.
  static const GooeySurfaceBodyAnimation fadeScale = GooeySurfaceBodyAnimation(
    scaleFrom: 0.96,
  );

  /// Shows content without extra opacity/transform animation.
  static const GooeySurfaceBodyAnimation none = GooeySurfaceBodyAnimation(
    instant: true,
  );

  /// Slide distance in logical px while the body fades in.
  final double slide;

  /// Starting scale of the body content.
  final double scaleFrom;

  /// Snaps the body in at the end of the open animation instead of fading.
  final bool instant;
}

/// One animation frame of a `GooeySurface`.
class GooeySurfaceFrame extends StatelessWidget {
  /// Creates a frame.
  const GooeySurfaceFrame({
    super.key,
    required this.progress,
    required this.width,
    required this.pillHeight,
    required this.pillBase,
    required this.targetHeight,
    required this.pillWidth,
    required this.pillX,
    required this.roundness,
    required this.color,
    required this.fillAlpha,
    required this.blur,
    required this.surfaceBlur,
    required this.enableGooeyBlur,
    required this.expandUp,
    required this.bodyAnimation,
    required this.ready,
    required this.pill,
    this.body,
    this.borderColor,
    this.shadowColor,
  });

  /// Open progress, `0` compact and `1` fully expanded.
  final double progress;

  /// Surface width.
  final double width;

  /// Content height of the compact pill; the seam the body grows from.
  final double pillHeight;

  /// Drawn pill height at rest, including the blur head-room.
  final double pillBase;

  /// Canvas height when fully open.
  final double targetHeight;

  /// Width of the compact pill.
  final double pillWidth;

  /// Left edge of the compact pill.
  final double pillX;

  /// Base corner roundness.
  final double roundness;

  /// Opaque surface colour.
  final Color color;

  /// Whole-surface opacity.
  final double fillAlpha;

  /// Blur sigma of the metaball pass.
  final double blur;

  /// Backdrop blur sigma clipped to the silhouette.
  final double surfaceBlur;

  /// Whether the metaball pass runs.
  final bool enableGooeyBlur;

  /// Whether the body grows upwards.
  final bool expandUp;

  /// Body content animation profile.
  final GooeySurfaceBodyAnimation bodyAnimation;

  /// Whether the entry fade/scale has finished.
  final bool ready;

  /// Compact pill content.
  final Widget pill;

  /// Expanded body content, or null when closed.
  final Widget? body;

  /// Border colour around the silhouette; null skips the border.
  final Color? borderColor;

  /// Drop shadow colour under the silhouette; null skips the shadow.
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final double open = progress.clamp(0.0, 1.0).toDouble();
    final double visualHeight =
        lerpDouble(
          pillHeight,
          targetHeight,
          open,
        )?.clamp(0.0, 4000.0).toDouble() ??
        pillHeight;
    final double bodyHeight = (targetHeight - pillHeight)
        .clamp(0.0, 1000.0)
        .toDouble();
    // The drawn pill carries blur head-room; squashing it back to the content
    // height while closed keeps the silhouette exactly one pill tall.
    final double pillScaleY = lerpDouble(pillHeight / pillBase, 1, open) ?? 1;
    final double bodyScaleY = Curves.easeInOut.transform(open);
    final double translateY = (expandUp ? -3.0 : 3.0) * open;
    final double headerScale = lerpDouble(1.0, 0.9, open) ?? 1.0;
    final double contentProgress = ((open - 0.35) / 0.65)
        .clamp(0.0, 1.0)
        .toDouble();
    final double contentEase = Curves.easeOutCubic.transform(contentProgress);
    final double contentOpacity = bodyAnimation.instant
        ? (contentProgress >= 0.999 ? 1.0 : 0.0)
        : contentEase;
    final double contentHeightFactor = bodyAnimation.instant
        ? (contentProgress >= 0.999 ? 1.0 : 0.0)
        : contentProgress;
    final double contentSlide = bodyAnimation.instant
        ? 0.0
        : (1 - contentEase) * bodyAnimation.slide * (expandUp ? 1.0 : -1.0);
    final double contentScale = bodyAnimation.instant
        ? 1.0
        : (lerpDouble(bodyAnimation.scaleFrom, 1.0, contentEase) ?? 1.0)
              .clamp(0.92, 1.04)
              .toDouble();
    final Matrix4 headerTransform = Matrix4.identity()
      ..translateByDouble(0.0, translateY, 0.0, 1.0)
      ..scaleByDouble(headerScale, headerScale, 1.0, 1.0);
    final GooeyShapeGeometry geometry = GooeyShapeGeometry(
      roundness: roundness,
      pillX: pillX,
      pillWidth: pillWidth,
      pillHeight: pillHeight,
      pillCanvasHeight: pillBase,
      pillScaleY: pillScaleY,
      bodyHeight: bodyHeight,
      bodyScaleY: bodyScaleY,
    );
    final Alignment contentAlignment = expandUp
        ? Alignment.bottomCenter
        : Alignment.topCenter;
    final Widget shape = GooeyShapeLayer(
      width: width,
      height: visualHeight,
      geometry: geometry,
      color: color,
      fillAlpha: fillAlpha,
      blur: blur,
      surfaceBlur: surfaceBlur,
      enableGooeyBlur: enableGooeyBlur,
      borderColor: borderColor,
      shadowColor: shadowColor,
    );
    return AnimatedOpacity(
      duration: kGooeyReadyDuration,
      curve: Curves.easeOut,
      opacity: ready ? 1 : 0,
      child: AnimatedScale(
        duration: kGooeyReadyDuration,
        curve: Curves.easeOutCubic,
        scale: ready ? 1 : 0.95,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeInOutCubic,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          child: SizedBox(
            width: width,
            height: visualHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  top: expandUp ? null : 0,
                  bottom: expandUp ? 0 : null,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.diagonal3Values(1, expandUp ? -1 : 1, 1),
                    child: shape,
                  ),
                ),
                Positioned(
                  left: pillX,
                  top: expandUp ? null : 0,
                  bottom: expandUp ? 0 : null,
                  child: Transform(
                    transform: headerTransform,
                    alignment: Alignment.center,
                    child: pill,
                  ),
                ),
                if (body != null)
                  Positioned(
                    left: 0,
                    top: expandUp ? 0 : pillHeight,
                    child: IgnorePointer(
                      ignoring: contentOpacity < 0.99,
                      child: ClipRect(
                        child: Align(
                          alignment: contentAlignment,
                          heightFactor: contentHeightFactor,
                          child: Opacity(
                            opacity: contentOpacity,
                            child: Transform.translate(
                              offset: Offset(0, contentSlide),
                              child: Transform.scale(
                                scale: contentScale,
                                alignment: contentAlignment,
                                child: body,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
