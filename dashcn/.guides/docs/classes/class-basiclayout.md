---
title: "Class: BasicLayout"
description: "Same structure as [Basic] but without applying default text styles."
---

```dart
/// Same structure as [Basic] but without applying default text styles.
class BasicLayout extends StatelessWidget {
  /// Leading widget (icon/avatar).
  final Widget? leading;
  /// Primary title.
  final Widget? title;
  /// Secondary subtitle below the title.
  final Widget? subtitle;
  /// Content below title/subtitle.
  final Widget? content;
  /// Trailing widget (icon/action).
  final Widget? trailing;
  /// Alignment for [leading].
  final AlignmentGeometry? leadingAlignment;
  /// Alignment for [trailing].
  final AlignmentGeometry? trailingAlignment;
  /// Alignment for [title].
  final AlignmentGeometry? titleAlignment;
  /// Alignment for [subtitle].
  final AlignmentGeometry? subtitleAlignment;
  /// Alignment for [content].
  final AlignmentGeometry? contentAlignment;
  /// Spacing between content elements.
  final double? contentSpacing;
  /// Spacing between title and subtitle.
  final double? titleSpacing;
  /// Optional constraints around the row.
  final BoxConstraints? constraints;
  /// Creates a [BasicLayout].
  const BasicLayout({super.key, this.leading, this.title, this.subtitle, this.content, this.trailing, this.leadingAlignment, this.trailingAlignment, this.titleAlignment, this.subtitleAlignment, this.contentAlignment, this.contentSpacing, this.titleSpacing, this.constraints});
  Widget build(BuildContext context);
}
```
