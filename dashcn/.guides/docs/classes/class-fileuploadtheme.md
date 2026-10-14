---
title: "Class: FileUploadTheme"
description: "Styling of the file surfaces."
---

```dart
/// Styling of the file surfaces.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class FileUploadTheme extends ComponentThemeData implements Mergeable<FileUploadTheme> {
  /// Creates a file upload theme.
  const FileUploadTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.minHeight, this.gap});
  /// Tile fill; null draws no fill (the ambient background shows through).
  final ThemedColor? background;
  /// Tile border; null falls back to the `input` token.
  final ThemedColor? borderColor;
  /// Border width; null resolves 1.
  final double? borderWidth;
  /// Corner radius; null resolves the ambient `radiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Tile padding; null resolves `px-4 py-3` (16x12), density-scaled.
  final EdgeInsetsGeometry? padding;
  /// Tile minimum height; null resolves 48.
  final double? minHeight;
  /// Vertical rhythm between the surface, the rows and the errors.
  final double? gap;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  FileUploadTheme merge(FileUploadTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
