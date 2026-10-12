---
title: "Class: CodeSnippetTheme"
description: "Theme of the code snippet container."
---

```dart
/// Theme of the code snippet container.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget).
class CodeSnippetTheme extends ComponentThemeData implements Mergeable<CodeSnippetTheme> {
  /// Creates a code snippet theme.
  const CodeSnippetTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.padding});
  /// Container fill. Default: the `card` token.
  final ThemedColor? background;
  /// Border color. Default: the `border` token.
  final ThemedColor? borderColor;
  /// Border width, scaled. Default: 1.
  final double? borderWidth;
  /// Corner radius. Default: ambient `radiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding. Default: one density step on three sides, 3.5 on the
  /// right (room for the actions row).
  final EdgeInsetsGeometry? padding;
  /// Returns a copy with the given fields replaced.
  CodeSnippetTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding});
  /// Receiver wins per field; [fallback] only fills null cells.
  CodeSnippetTheme merge(CodeSnippetTheme? fallback);
  /// Scalars interpolate; the rest steps at `t = 0.5`.
  static CodeSnippetTheme lerp(CodeSnippetTheme a, CodeSnippetTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
