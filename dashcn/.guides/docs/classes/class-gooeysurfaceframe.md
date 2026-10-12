---
title: "Class: GooeySurfaceFrame"
description: "One animation frame of a `GooeySurface`."
---

```dart
/// One animation frame of a `GooeySurface`.
class GooeySurfaceFrame extends StatelessWidget {
  /// Creates a frame.
  const GooeySurfaceFrame({super.key, required this.progress, required this.width, required this.pillHeight, required this.pillBase, required this.targetHeight, required this.pillWidth, required this.pillX, required this.roundness, required this.color, required this.fillAlpha, required this.blur, required this.surfaceBlur, required this.enableGooeyBlur, required this.expandUp, required this.bodyAnimation, required this.ready, required this.pill, this.body, this.borderColor, this.shadowColor});
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
  Widget build(BuildContext context);
}
```
