---
title: "Class: ImageTheme"
description: "One image box's visual contract."
---

```dart
/// One image box's visual contract.
///
/// Every field is nullable, so an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. `borderRadius` resolves at
/// build because its default follows the theme's radius token.
class ImageTheme extends ComponentThemeData implements Mergeable<ImageTheme> {
  /// Creates an image theme.
  const ImageTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderRadius, this.duration});
  /// Fill painted behind the image; also the default placeholder.
  final ThemedColor? background;
  /// Corner radius of the box; null resolves `radiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Fade-in duration of the decoded picture; null resolves 150 ms.
  final Duration? duration;
  /// Returns a copy with the given fields replaced.
  ImageTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<Duration?>? duration});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ImageTheme merge(ImageTheme? fallback);
  /// Discrete fields step at t < 0.5, matching the other component themes.
  static ImageTheme lerp(ImageTheme a, ImageTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
