// The variant styling slice for the `button` component:
// [ButtonVariantStyle] and the fallback label text style.
//
// Registry-owned; CLI updates may replace this file. Re-exported through
// `button_style.dart`, so user-owned `button_theme.dart` files keep importing
// only `button_style.dart`. Not independently installable.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';

/// Fallback text style before the size table narrows the font size.
const TextStyle buttonDefaultTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

/// One variant's state-aware styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields.
class ButtonVariantStyle implements Mergeable<ButtonVariantStyle> {
  /// Creates a variant style slice.
  const ButtonVariantStyle({
    this.background,
    this.foreground,
    this.borderColor,
    this.borderWidth,
    this.decoration,
    this.padding,
    this.textStyle,
  });

  /// Per-state fill of the button surface.
  final StateValue<ThemedColor>? background;

  /// Per-state label/icon color.
  final StateValue<ThemedColor>? foreground;

  /// Per-state border color; null draws no border.
  final StateValue<ThemedColor>? borderColor;

  /// Border width used when [borderColor] resolves non-null.
  final double? borderWidth;

  /// Per-state [TextDecoration] (link underline); null draws none.
  final StateValue<TextDecoration>? decoration;

  /// Padding override; null falls back to the size table.
  final EdgeInsetsGeometry? padding;

  /// Text style override; its color is ignored (taken from [foreground]).
  final TextStyle? textStyle;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  ButtonVariantStyle merge(ButtonVariantStyle? fallback) {
    if (fallback == null) {
      return this;
    }
    return ButtonVariantStyle(
      background: background?.merge(fallback.background) ?? fallback.background,
      foreground: foreground?.merge(fallback.foreground) ?? fallback.foreground,
      borderColor:
          borderColor?.merge(fallback.borderColor) ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      decoration: decoration?.merge(fallback.decoration) ?? fallback.decoration,
      padding: padding ?? fallback.padding,
      // TextStyle.merge lets the argument win; merge fallback over this style
      // so the receiver's fields stay.
      textStyle: textStyle == null
          ? fallback.textStyle
          : (fallback.textStyle?.merge(textStyle) ?? textStyle),
    );
  }

  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static ButtonVariantStyle lerp(
    ButtonVariantStyle a,
    ButtonVariantStyle b,
    double t,
  ) {
    return ButtonVariantStyle(
      background: t < 0.5 ? a.background : b.background,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      decoration: t < 0.5 ? a.decoration : b.decoration,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ButtonVariantStyle &&
        other.background == background &&
        other.foreground == foreground &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.decoration == decoration &&
        other.padding == padding &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode => Object.hash(
    background,
    foreground,
    borderColor,
    borderWidth,
    decoration,
    padding,
    textStyle,
  );
}
