---
title: "Class: FileDiffViewerTheme"
description: "Geometry and colour of one diff viewer."
---

```dart
/// Geometry and colour of one diff viewer.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class FileDiffViewerTheme extends ComponentThemeData implements Mergeable<FileDiffViewerTheme> {
  /// Creates a diff viewer theme.
  const FileDiffViewerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.hunkBackground, this.additionColor, this.deletionColor, this.borderRadius, this.linePadding});
  /// Surface fill; null resolves the `card` token.
  final ThemedColor? background;
  /// Frame, gutter and split-line colour; null resolves `border`.
  final ThemedColor? borderColor;
  /// Hunk header fill; null resolves `accent`.
  final ThemedColor? hunkBackground;
  /// Addition accent; null resolves `chart2`.
  final ThemedColor? additionColor;
  /// Deletion accent; null resolves `destructive`.
  final ThemedColor? deletionColor;
  /// Outer corner radius; null resolves `radiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Row padding for lines, hunk headers and the file header; null resolves
  /// a density-based inset.
  final EdgeInsetsGeometry? linePadding;
  FileDiffViewerTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? borderColor, ValueGetter<ThemedColor?>? hunkBackground, ValueGetter<ThemedColor?>? additionColor, ValueGetter<ThemedColor?>? deletionColor, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? linePadding});
  /// Receiver wins per field.
  FileDiffViewerTheme merge(FileDiffViewerTheme? fallback);
  static FileDiffViewerTheme lerp(FileDiffViewerTheme a, FileDiffViewerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
