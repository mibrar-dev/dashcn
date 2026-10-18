// Registry-owned theme data for the `qr_code` component: the module
// [QrModuleShape], the [QrCodeTheme] container and the token-derived
// `qrCodeDefaults`.
//
// User-owned overrides live in `qr_code_theme.dart`; CLI updates may replace
// this file. The widget reads the resolved theme through
// `resolveComponentStyle<QrCodeTheme, QrCodeTheme>` from `theme/theme.dart`.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Shape of one dark module.
enum QrModuleShape {
  /// Solid squares (maximum scan reliability).
  square,

  /// Rounded squares.
  rounded,

  /// Separated dots.
  dot,
}

/// Visual contract of the QR code: the two inks. Every field is nullable: an
/// override leg sets only what it changes and [merge] keeps the lower leg's
/// remaining fields.
class QrCodeTheme extends ComponentThemeData implements Mergeable<QrCodeTheme> {
  /// Creates a QR code theme.
  const QrCodeTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.foreground,
    this.background,
  });

  /// Dark-module colour; null resolves the `foreground` token.
  final ThemedColor? foreground;

  /// Light-module and quiet-zone colour; null resolves `background`.
  final ThemedColor? background;

  /// Returns a copy with the given fields replaced.
  QrCodeTheme copyWith({
    ValueGetter<ThemedColor?>? foreground,
    ValueGetter<ThemedColor?>? background,
  }) {
    return QrCodeTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      foreground: foreground == null ? this.foreground : foreground(),
      background: background == null ? this.background : background(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  QrCodeTheme merge(QrCodeTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return QrCodeTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      foreground: foreground ?? fallback.foreground,
      background: background ?? fallback.background,
    );
  }

  /// Colours step at t < 0.5.
  static QrCodeTheme lerp(QrCodeTheme a, QrCodeTheme b, double t) {
    return QrCodeTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      background: t < 0.5 ? a.background : b.background,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is QrCodeTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.foreground == foreground &&
        other.background == background;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    foreground,
    background,
  );
}

/// Token-derived baseline: dark modules on the surface.
///
/// For print or guaranteed scanning, pin both inks to literal colours; the
/// defaults follow the ambient preset (including its dark mode).
const QrCodeTheme qrCodeDefaults = QrCodeTheme(
  foreground: ThemedColor.ref(ColorRef.foreground),
  background: ThemedColor.ref(ColorRef.background),
);
