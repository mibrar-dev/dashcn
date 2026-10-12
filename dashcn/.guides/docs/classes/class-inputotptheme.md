---
title: "Class: InputOtpTheme"
description: "Visual contract of the OTP slots."
---

```dart
/// Visual contract of the OTP slots.
class InputOtpTheme extends ComponentThemeData implements Mergeable<InputOtpTheme> {
  /// Creates an input-otp theme.
  const InputOtpTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.textStyle, this.boxSize, this.spacing, this.separatorTextStyle, this.cursorColor});
  /// Per-state fill of a slot; null resolves `input` at 30% alpha.
  final StateValue<ThemedColor>? background;
  /// Per-state slot border; null resolves the `input` token.
  final StateValue<ThemedColor>? borderColor;
  /// Border width used when [borderColor] resolves; null resolves 1.
  final double? borderWidth;
  /// Corner radius; null resolves `borderRadiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding; null resolves 6 x 0 (`px-1.5 py-0`), density-scaled
  /// through [inputOtpDefaultPadding].
  final EdgeInsetsGeometry? padding;
  /// Slot label style; its colour is ignored (taken from the foreground).
  final TextStyle? textStyle;
  /// Slot box size; null resolves the theme's `typography.small` line height.
  final double? boxSize;
  /// Gap between two slots; null resolves the density base gap.
  final double? spacing;
  /// Style of the optional [InputOtp.separator].
  final TextStyle? separatorTextStyle;
  /// Caret colour of the focused slot; null resolves `ring`.
  final ThemedColor? cursorColor;
  /// Returns a copy with the given fields replaced.
  InputOtpTheme copyWith({ValueGetter<StateValue<ThemedColor>?>? background, ValueGetter<StateValue<ThemedColor>?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<TextStyle?>? textStyle, ValueGetter<double?>? boxSize, ValueGetter<double?>? spacing, ValueGetter<TextStyle?>? separatorTextStyle, ValueGetter<ThemedColor?>? cursorColor});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  InputOtpTheme merge(InputOtpTheme? fallback);
  /// State scales step at t < 0.5; dimensions lerp.
  static InputOtpTheme lerp(InputOtpTheme a, InputOtpTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
