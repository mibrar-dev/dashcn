---
title: "Class: OutlinedContainer"
description: "An animated, outlined surface."
---

```dart
/// An animated, outlined surface.
///
/// ```dart
/// OutlinedContainer(
///   padding: const EdgeInsets.all(16),
///   child: const Text('Card body'),
/// );
/// ```
class OutlinedContainer extends StatefulWidget {
  /// Creates an outlined container.
  const OutlinedContainer({super.key, required this.child, this.backgroundColor, this.borderColor, this.borderRadius, this.borderWidth, this.borderStyle, this.boxShadow, this.padding, this.clipBehavior = Clip.antiAlias, this.surfaceOpacity, this.surfaceBlur, this.width, this.height, this.duration, this.theme});
  /// Content inside the container.
  final Widget child;
  /// Surface fill override.
  final ThemedColor? backgroundColor;
  /// Border colour override.
  final ThemedColor? borderColor;
  /// Corner radius override.
  final BorderRadiusGeometry? borderRadius;
  /// Border width override.
  final double? borderWidth;
  /// Border style override.
  final BorderStyle? borderStyle;
  /// Elevation shadows override.
  final List<BoxShadow>? boxShadow;
  /// Inner padding override.
  final EdgeInsetsGeometry? padding;
  /// How the child is clipped to the decoration.
  final Clip clipBehavior;
  /// Multiplies the fill alpha.
  final double? surfaceOpacity;
  /// Backdrop blur sigma; null or <= 0 draws no blur.
  final double? surfaceBlur;
  /// Fixed width.
  final double? width;
  /// Fixed height.
  final double? height;
  /// Animation duration for decoration changes; null snaps.
  final Duration? duration;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final OutlinedContainerTheme? theme;
  State<OutlinedContainer> createState();
}
```
