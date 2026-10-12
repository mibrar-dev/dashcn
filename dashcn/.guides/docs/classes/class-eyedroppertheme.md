---
title: "Class: EyeDropperTheme"
description: "Styling of the magnified picker preview."
---

```dart
/// Styling of the magnified picker preview.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class EyeDropperTheme extends ComponentThemeData implements Mergeable<EyeDropperTheme> {
  /// Creates an eye-dropper theme.
  const EyeDropperTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.previewSize, this.previewScale, this.showPreview, this.borderColor, this.borderWidth, this.selectedBorderColor, this.selectedBorderWidth, this.backgroundColor});
  /// Size of the magnified preview. Default: 100x100 (scaled by the ambient
  /// `scaling` factor).
  final Size? previewSize;
  /// Magnification factor of the preview: one screen pixel covers
  /// `1 / previewScale` of the sampled area. Default: 8.
  final double? previewScale;
  /// Whether the magnified preview is shown at all. Default: true.
  final bool? showPreview;
  /// Outer ring colour of the preview circle. Default: the `border` token.
  final ThemedColor? borderColor;
  /// Outer ring width. Default: 1 (scaled by the ambient `scaling` factor).
  final double? borderWidth;
  /// Colour of the highlighted centre cell. Default: the `primary` token.
  final ThemedColor? selectedBorderColor;
  /// Width of the highlighted centre cell. Default: 2 (scaled).
  final double? selectedBorderWidth;
  /// Background behind the sampled cells. Default: the `background` token.
  final ThemedColor? backgroundColor;
  /// Returns a copy with the given fields replaced.
  EyeDropperTheme copyWith({ValueGetter<Size?>? previewSize, ValueGetter<double?>? previewScale, ValueGetter<bool?>? showPreview, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<ThemedColor?>? selectedBorderColor, ValueGetter<double?>? selectedBorderWidth, ValueGetter<ThemedColor?>? backgroundColor});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  EyeDropperTheme merge(EyeDropperTheme? fallback);
  /// Colours and flags step at `t = 0.5`; dimensions are lerped.
  static EyeDropperTheme lerp(EyeDropperTheme a, EyeDropperTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
