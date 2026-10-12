---
title: "Class: Basic"
description: "Leading / title / subtitle / content / trailing row with default text  styles applied to title and subtitle."
---

```dart
/// Leading / title / subtitle / content / trailing row with default text
/// styles applied to title and subtitle.
class Basic extends StatelessWidget {
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
  /// Main axis alignment for the overall layout.
  final MainAxisAlignment? mainAxisAlignment;
  /// Padding around the whole widget.
  final EdgeInsetsGeometry? padding;
  /// Creates a [Basic] layout.
  const Basic({super.key, this.leading, this.title, this.subtitle, this.content, this.trailing, this.leadingAlignment, this.trailingAlignment, this.titleAlignment, this.subtitleAlignment, this.contentAlignment, this.contentSpacing, this.titleSpacing, this.mainAxisAlignment, this.padding});
  Widget build(BuildContext context);
}
```
