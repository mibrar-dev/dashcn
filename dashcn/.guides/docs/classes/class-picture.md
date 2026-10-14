---
title: "Class: Picture"
description: "A themed image."
---

```dart
/// A themed image.
///
/// ```dart
/// Picture(image: NetworkImage(url), width: 200, aspectRatio: 1)
/// ```
///
/// Give the widget at least one of [width], [height] or [aspectRatio]: with
/// none of them an unconstrained parent collapses the box to zero.
class Picture extends StatefulWidget {
  /// Creates a themed image.
  ///
  /// Named `Picture` rather than `Image`: Flutter's `widgets.dart` also
  /// exports an `Image`, and a file importing both would not compile without a
  /// prefix. The prefix follows the same rule as `Theme`.
  const Picture({super.key, required this.image, this.width, this.height, this.aspectRatio, this.fit = BoxFit.cover, this.borderRadius, this.background, this.placeholder, this.errorBuilder, this.semanticLabel, this.duration, this.scale = 1.0, this.alignment = Alignment.center, this.theme});
  /// The bytes to decode.
  final ImageProvider<Object> image;
  /// Box width; null derives it from [height]/[aspectRatio].
  final double? width;
  /// Box height; null derives it from [width]/[aspectRatio].
  final double? height;
  /// Width / height of the box; upstream renders a square image.
  final double? aspectRatio;
  /// How the decoded image fills the box.
  final BoxFit fit;
  /// Corner radius override; null uses [ImageTheme.borderRadius] then
  /// `radiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Fill shown behind the image and as the default placeholder.
  final Color? background;
  /// Widget shown while the bytes load; null paints the background only.
  final Widget? placeholder;
  /// Widget shown when decoding fails; null keeps the background.
  final ImageErrorBuilder? errorBuilder;
  /// Accessible label; also marks the node as an image for screen readers.
  final String? semanticLabel;
  /// Fade-in duration; null uses [ImageTheme.duration].
  final Duration? duration;
  /// Logical-pixel scale of the decoded image.
  final double scale;
  /// Alignment of the decoded image inside the box.
  final AlignmentGeometry alignment;
  /// Widget-leg theme override, merged on top of the other legs.
  final ImageTheme? theme;
  State<Picture> createState();
}
```
