---
title: "Class: BasicTheme"
description: "Alignment, spacing and padding defaults for [Basic]/[BasicLayout]."
---

```dart
/// Alignment, spacing and padding defaults for [Basic]/[BasicLayout].
class BasicTheme extends ComponentThemeData implements Mergeable<BasicTheme> {
  /// Alignment for the leading widget.
  final AlignmentGeometry? leadingAlignment;
  /// Alignment for the trailing widget.
  final AlignmentGeometry? trailingAlignment;
  /// Alignment for the title widget.
  final AlignmentGeometry? titleAlignment;
  /// Alignment for the subtitle widget.
  final AlignmentGeometry? subtitleAlignment;
  /// Alignment for the content widget.
  final AlignmentGeometry? contentAlignment;
  /// Spacing between content elements. Defaults to `16 * scaling`.
  final double? contentSpacing;
  /// Spacing between title and subtitle. Defaults to `4 * scaling`.
  final double? titleSpacing;
  /// Main axis alignment for the overall layout.
  final MainAxisAlignment? mainAxisAlignment;
  /// Padding around the whole widget.
  final EdgeInsetsGeometry? padding;
  /// Creates a [BasicTheme].
  const BasicTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.leadingAlignment, this.trailingAlignment, this.titleAlignment, this.subtitleAlignment, this.contentAlignment, this.contentSpacing, this.titleSpacing, this.mainAxisAlignment, this.padding});
  /// Returns a copy with the given fields replaced.
  BasicTheme copyWith({ValueGetter<AlignmentGeometry?>? leadingAlignment, ValueGetter<AlignmentGeometry?>? trailingAlignment, ValueGetter<AlignmentGeometry?>? titleAlignment, ValueGetter<AlignmentGeometry?>? subtitleAlignment, ValueGetter<AlignmentGeometry?>? contentAlignment, ValueGetter<double?>? contentSpacing, ValueGetter<double?>? titleSpacing, ValueGetter<MainAxisAlignment?>? mainAxisAlignment, ValueGetter<EdgeInsetsGeometry?>? padding});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  BasicTheme merge(BasicTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
