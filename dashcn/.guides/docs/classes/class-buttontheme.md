---
title: "Class: ButtonTheme"
description: "Per-variant theme container for the button component."
---

```dart
/// Per-variant theme container for the button component.
///
/// A leg may set only the variants/fields it cares about; [merge] lets the
/// receiver win per field. [forVariant] is an exhaustive switch over
/// [ButtonVariant].
class ButtonTheme extends ComponentThemeData implements Mergeable<ButtonTheme> {
  /// Creates a button theme with one nullable slice per variant.
  const ButtonTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.primary, this.secondary, this.outline, this.ghost, this.link, this.text, this.destructive});
  /// Style for [ButtonVariant.primary].
  final ButtonVariantStyle? primary;
  /// Style for [ButtonVariant.secondary].
  final ButtonVariantStyle? secondary;
  /// Style for [ButtonVariant.outline].
  final ButtonVariantStyle? outline;
  /// Style for [ButtonVariant.ghost].
  final ButtonVariantStyle? ghost;
  /// Style for [ButtonVariant.link].
  final ButtonVariantStyle? link;
  /// Style for [ButtonVariant.text].
  final ButtonVariantStyle? text;
  /// Style for [ButtonVariant.destructive].
  final ButtonVariantStyle? destructive;
  /// The slice for [variant], or null when this leg leaves it unset.
  ButtonVariantStyle? forVariant(ButtonVariant variant);
  /// Returns a copy with the given variant rows replaced.
  ButtonTheme copyWith({ValueGetter<ButtonVariantStyle?>? primary, ValueGetter<ButtonVariantStyle?>? secondary, ValueGetter<ButtonVariantStyle?>? outline, ValueGetter<ButtonVariantStyle?>? ghost, ValueGetter<ButtonVariantStyle?>? link, ValueGetter<ButtonVariantStyle?>? text, ValueGetter<ButtonVariantStyle?>? destructive});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ButtonTheme merge(ButtonTheme? fallback);
  /// Lerps each row; state scales step at t < 0.5.
  static ButtonTheme lerp(ButtonTheme a, ButtonTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
