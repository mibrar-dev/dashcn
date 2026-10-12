---
title: "Class: GooeyToastTheme"
description: "Visual and timing contract of a gooey toast."
---

```dart
/// Visual and timing contract of a gooey toast.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. The six `*Tone` fields are
/// direct (Studio-editable) theme fields, so a customised toast keeps its
/// identity across presets instead of following a token that changes hue.
class GooeyToastTheme extends ComponentThemeData implements Mergeable<GooeyToastTheme> {
  const GooeyToastTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.width, this.fill, this.roundness, this.titleStyle, this.descriptionStyle, this.descriptionColor, this.duration, this.animationStyle, this.shapeStyle, this.bodyAnimationStyle, this.enableGooeyBlur, this.compactMorph, this.successTone, this.loadingTone, this.errorTone, this.warningTone, this.infoTone, this.actionTone});
  final double? width;
  /// Surface fill. Default: main's light near-white (#F7F8FA), inverted from
  /// the dark site background so the toast reads as a light card.
  final ThemedColor? fill;
  final double? roundness;
  /// Compact title style; null uses `gooeyTitleTextStyle` in the state tone.
  final TextStyle? titleStyle;
  /// Expanded description style; null uses `gooeyDescriptionTextStyle`.
  final TextStyle? descriptionStyle;
  /// Expanded description colour, applied when the style carries none.
  /// Default: the `mutedForeground` token.
  final ThemedColor? descriptionColor;
  final Duration? duration;
  final GooeyToastAnimationStyle? animationStyle;
  final GooeyToastShapeStyle? shapeStyle;
  final GooeyToastBodyAnimationStyle? bodyAnimationStyle;
  final bool? enableGooeyBlur;
  /// Compact pill morph profile for in-place title/state changes.
  final GooeyCompactMorph? compactMorph;
  /// `success` accent. Default: the fixed [gooeySuccessTone] green.
  final ThemedColor? successTone;
  /// `loading` accent. Default: the fixed [gooeyLoadingTone] grey.
  final ThemedColor? loadingTone;
  /// `error` accent. Default: the fixed [gooeyErrorTone] red.
  final ThemedColor? errorTone;
  /// `warning` accent. Default: the fixed [gooeyWarningTone] amber.
  final ThemedColor? warningTone;
  /// `info` accent. Default: the fixed [gooeyInfoTone] blue.
  final ThemedColor? infoTone;
  /// `action` accent. Default: the fixed [gooeyActionTone] indigo.
  final ThemedColor? actionTone;
  /// Returns a copy with the given fields replaced.
  GooeyToastTheme copyWith({ValueGetter<double?>? width, ValueGetter<ThemedColor?>? fill, ValueGetter<double?>? roundness, ValueGetter<TextStyle?>? titleStyle, ValueGetter<TextStyle?>? descriptionStyle, ValueGetter<ThemedColor?>? descriptionColor, ValueGetter<Duration?>? duration, ValueGetter<GooeyToastAnimationStyle?>? animationStyle, ValueGetter<GooeyToastShapeStyle?>? shapeStyle, ValueGetter<GooeyToastBodyAnimationStyle?>? bodyAnimationStyle, ValueGetter<bool?>? enableGooeyBlur, ValueGetter<GooeyCompactMorph?>? compactMorph, ValueGetter<ThemedColor?>? successTone, ValueGetter<ThemedColor?>? loadingTone, ValueGetter<ThemedColor?>? errorTone, ValueGetter<ThemedColor?>? warningTone, ValueGetter<ThemedColor?>? infoTone, ValueGetter<ThemedColor?>? actionTone});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  GooeyToastTheme merge(GooeyToastTheme? fallback);
  /// Colours, styles and flags step at `t < 0.5`; dimensions interpolate.
  static GooeyToastTheme lerp(GooeyToastTheme a, GooeyToastTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
