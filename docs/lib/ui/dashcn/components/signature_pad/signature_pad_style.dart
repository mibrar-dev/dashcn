// Registry-owned theme data for the `signature_pad` component: the
// [SignaturePadTheme] container and the token-derived `signaturePadDefaults`.
//
// User-owned overrides live in `signature_pad_theme.dart`; CLI updates may
// replace this file. The widget reads the resolved theme through
// `resolveComponentStyle<SignaturePadTheme, SignaturePadTheme>` from
// `theme/theme.dart`.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Visual contract of the signature pad.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class SignaturePadTheme extends ComponentThemeData
    implements Mergeable<SignaturePadTheme> {
  /// Creates a signature pad theme.
  const SignaturePadTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.strokeColor,
    this.background,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.strokeWidth,
    this.minStrokeWidth,
    this.variableWidth,
  });

  /// Ink colour of the strokes; null resolves the `foreground` token.
  final ThemedColor? strokeColor;

  /// Pad surface; null resolves the `card` token.
  final ThemedColor? background;

  /// Pad outline; null resolves the `border` token.
  final ThemedColor? borderColor;

  /// Outline thickness in logical pixels (multiplied by `scaling`).
  final double? borderWidth;

  /// Corner radius in logical pixels (multiplied by `scaling`).
  final double? borderRadius;

  /// Stroke width at rest (slow movement) in logical pixels.
  final double? strokeWidth;

  /// Stroke width at speed (fast movement) in logical pixels.
  final double? minStrokeWidth;

  /// Whether pointer speed narrows the stroke; null enables it.
  final bool? variableWidth;

  /// Returns a copy with the given fields replaced.
  SignaturePadTheme copyWith({
    ValueGetter<ThemedColor?>? strokeColor,
    ValueGetter<ThemedColor?>? background,
    ValueGetter<ThemedColor?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<double?>? borderRadius,
    ValueGetter<double?>? strokeWidth,
    ValueGetter<double?>? minStrokeWidth,
    ValueGetter<bool?>? variableWidth,
  }) {
    return SignaturePadTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      strokeColor: strokeColor == null ? this.strokeColor : strokeColor(),
      background: background == null ? this.background : background(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      strokeWidth: strokeWidth == null ? this.strokeWidth : strokeWidth(),
      minStrokeWidth: minStrokeWidth == null
          ? this.minStrokeWidth
          : minStrokeWidth(),
      variableWidth: variableWidth == null
          ? this.variableWidth
          : variableWidth(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  SignaturePadTheme merge(SignaturePadTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return SignaturePadTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      strokeColor: strokeColor ?? fallback.strokeColor,
      background: background ?? fallback.background,
      borderColor: borderColor ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      borderRadius: borderRadius ?? fallback.borderRadius,
      strokeWidth: strokeWidth ?? fallback.strokeWidth,
      minStrokeWidth: minStrokeWidth ?? fallback.minStrokeWidth,
      variableWidth: variableWidth ?? fallback.variableWidth,
    );
  }

  /// Colours and the flag step at t < 0.5; dimensions are lerped.
  static SignaturePadTheme lerp(
    SignaturePadTheme a,
    SignaturePadTheme b,
    double t,
  ) {
    return SignaturePadTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      strokeColor: t < 0.5 ? a.strokeColor : b.strokeColor,
      background: t < 0.5 ? a.background : b.background,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      borderRadius: lerpDouble(a.borderRadius, b.borderRadius, t),
      strokeWidth: lerpDouble(a.strokeWidth, b.strokeWidth, t),
      minStrokeWidth: lerpDouble(a.minStrokeWidth, b.minStrokeWidth, t),
      variableWidth: t < 0.5 ? a.variableWidth : b.variableWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SignaturePadTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.strokeColor == strokeColor &&
        other.background == background &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.strokeWidth == strokeWidth &&
        other.minStrokeWidth == minStrokeWidth &&
        other.variableWidth == variableWidth;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    strokeColor,
    background,
    borderColor,
    borderWidth,
    borderRadius,
    strokeWidth,
    minStrokeWidth,
    variableWidth,
  );
}

/// Token-derived baseline for the pad.
const SignaturePadTheme signaturePadDefaults = SignaturePadTheme(
  strokeColor: ThemedColor.ref(ColorRef.foreground),
  background: ThemedColor.ref(ColorRef.card),
  borderColor: ThemedColor.ref(ColorRef.border),
  borderWidth: 1,
  borderRadius: 8,
  strokeWidth: 3,
  minStrokeWidth: 1,
  variableWidth: true,
);
