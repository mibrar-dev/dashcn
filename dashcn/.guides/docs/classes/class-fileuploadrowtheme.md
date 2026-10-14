---
title: "Class: FileUploadRowTheme"
description: "Styling of a [FileUploadRow]."
---

```dart
/// Styling of a [FileUploadRow].
class FileUploadRowTheme extends ComponentThemeData implements Mergeable<FileUploadRowTheme> {
  /// Creates a row theme.
  const FileUploadRowTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderRadius, this.padding, this.gap, this.iconColor, this.iconSize, this.thumbnailSize, this.thumbnailBackground, this.labelStyle, this.metaStyle, this.successColor, this.errorColor, this.mutedColor});
  /// Row fill; null draws no fill.
  final ThemedColor? background;
  /// Row border; null draws no border.
  final ThemedColor? borderColor;
  /// Corner radius; null resolves the ambient `radiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Row padding; null resolves 12.
  final double? padding;
  /// Space between the thumbnail and the text block; null resolves 12.
  final double? gap;
  /// Thumbnail/action colour; null resolves `mutedForeground`.
  final ThemedColor? iconColor;
  /// Thumbnail icon side; null resolves 20.
  final double? iconSize;
  /// Thumbnail box side; null resolves 40.
  final double? thumbnailSize;
  /// Thumbnail box fill; null resolves `muted` at 40% alpha.
  final ThemedColor? thumbnailBackground;
  /// File-name style; its colour is the ambient foreground.
  final TextStyle? labelStyle;
  /// Meta-line style; its colour falls back to the status colour.
  final TextStyle? metaStyle;
  /// Success status colour; null resolves `accent`.
  final ThemedColor? successColor;
  /// Error status colour; null resolves `destructive`.
  final ThemedColor? errorColor;
  /// Queued/uploading colour; null resolves `mutedForeground`.
  final ThemedColor? mutedColor;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  FileUploadRowTheme merge(FileUploadRowTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
