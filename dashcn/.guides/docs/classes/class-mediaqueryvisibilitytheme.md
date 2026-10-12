---
title: "Class: MediaQueryVisibilityTheme"
description: "Viewport bounds shared by every [MediaQueryVisibility] in a subtree."
---

```dart
/// Viewport bounds shared by every [MediaQueryVisibility] in a subtree.
///
/// Only breakpoint numbers live here; nothing about this theme is a token, so
/// the defaults are deliberately empty and the widget arguments stay the
/// primary way to set them.
class MediaQueryVisibilityTheme extends ComponentThemeData implements Mergeable<MediaQueryVisibilityTheme> {
  /// Creates a visibility theme.
  const MediaQueryVisibilityTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.minWidth, this.maxWidth});
  /// Narrowest viewport width (inclusive) that shows the main child.
  final double? minWidth;
  /// Widest viewport width (inclusive) that shows the main child.
  final double? maxWidth;
  /// Returns a copy with the given fields replaced.
  ///
  /// The density/spacing/shadow fields are carried over, which the old
  /// `MediaQueryVisibilityTheme.copyWith` did not do.
  MediaQueryVisibilityTheme copyWith({ValueGetter<double?>? minWidth, ValueGetter<double?>? maxWidth});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  MediaQueryVisibilityTheme merge(MediaQueryVisibilityTheme? fallback);
  /// Discrete fields step at t < 0.5.
  static MediaQueryVisibilityTheme lerp(MediaQueryVisibilityTheme a, MediaQueryVisibilityTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
