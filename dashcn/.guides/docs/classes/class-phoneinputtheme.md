---
title: "Class: PhoneInputTheme"
description: "Theme data for the `phone_input` component."
---

```dart
/// Theme data for the `phone_input` component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class PhoneInputTheme extends ComponentThemeData implements Mergeable<PhoneInputTheme> {
  /// Creates a phone input theme.
  const PhoneInputTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.inputPadding, this.maxWidth, this.selectWidth, this.popupConstraints, this.flagWidth, this.flagHeight, this.flagGap, this.fieldGap, this.countryGap});
  /// Padding inside the number field; density-scaled (upstream `px-3 py-2`).
  final EdgeInsetsGeometry? inputPadding;
  /// Maximum width of the number field.
  final double? maxWidth;
  /// Width of the country selector (the popup is trigger-wide).
  final double? selectWidth;
  /// Constraints of the country popup.
  final BoxConstraints? popupConstraints;
  /// Flag width in the trigger and in popup rows.
  final double? flagWidth;
  /// Flag height in the trigger and in popup rows.
  final double? flagHeight;
  /// Gap between a flag and the dial code / country name.
  final double? flagGap;
  /// Gap between the country selector and the number field.
  ///
  /// The group is one joined box: half of this value pads each side of the
  /// hairline divider between the trigger and the field.
  final double? fieldGap;
  /// Gap between the country name and its dial code in popup rows.
  final double? countryGap;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  PhoneInputTheme merge(PhoneInputTheme? fallback);
  /// Dimensions are lerped; box constraints step at `t = 0.5`.
  static PhoneInputTheme lerp(PhoneInputTheme a, PhoneInputTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
