// Registry-owned theme data for the `fab` component: the component theme
// container ([FabTheme]) and the token-derived default rows.
//
// `fab_style.dart` re-exports this file, so callers keep a single import.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'fab_style.dart';

/// Component theme container for the floating action button.
class FabTheme extends ComponentThemeData implements Mergeable<FabTheme> {
  /// Creates a floating action button theme with one slice per shape.
  const FabTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.standard,
    this.extended,
    this.mini,
  });

  /// Style of the round (icon only) button.
  final FabStyle? standard;

  /// Style of the pill (icon plus label) button.
  final FabStyle? extended;

  /// Style of a speed-dial mini action.
  final FabStyle? mini;

  /// The slice for [shape], or null when this leg leaves it unset.
  FabStyle? forShape(FabShape shape) => switch (shape) {
    FabShape.standard => standard,
    FabShape.extended => extended,
    FabShape.mini => mini,
  };

  /// Returns a copy with the given fields replaced.
  FabTheme copyWith({
    ValueGetter<FabStyle?>? standard,
    ValueGetter<FabStyle?>? extended,
    ValueGetter<FabStyle?>? mini,
  }) {
    return FabTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      standard: standard == null ? this.standard : standard(),
      extended: extended == null ? this.extended : extended(),
      mini: mini == null ? this.mini : mini(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  FabTheme merge(FabTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return FabTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      standard: standard?.merge(fallback.standard) ?? fallback.standard,
      extended: extended?.merge(fallback.extended) ?? fallback.extended,
      mini: mini?.merge(fallback.mini) ?? fallback.mini,
    );
  }

  /// Lerps each row; state scales step at t < 0.5.
  static FabTheme lerp(FabTheme a, FabTheme b, double t) {
    FabStyle? row(FabStyle? x, FabStyle? y) {
      if (x == null) {
        return y;
      }
      if (y == null) {
        return x;
      }
      return FabStyle.lerp(x, y, t);
    }

    return FabTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      standard: row(a.standard, b.standard),
      extended: row(a.extended, b.extended),
      mini: row(a.mini, b.mini),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FabTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.standard == standard &&
        other.extended == extended &&
        other.mini == mini;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    standard,
    extended,
    mini,
  );
}

/// Default gap between the icon and the label of an extended button.
const double fabDefaultGap = 8;

/// Default label text style of an extended button.
const TextStyle fabDefaultTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

// ---------------------------------------------------------------------------
// Defaults (registry-owned, tokens only).
//
// Disabled states are intentionally absent: every `StateValue` falls back to
// its `rest` entry and the widget dims the whole button once.
// ---------------------------------------------------------------------------

const _primaryBg = StateValue(
  rest: ThemedColor.ref(ColorRef.primary),
  hovered: ThemedColor.ref(ColorRef.primary, alpha: 0.9),
  pressed: ThemedColor.ref(ColorRef.primary, alpha: 0.9),
);
const _primaryFg = StateValue(
  rest: ThemedColor.ref(ColorRef.primaryForeground),
  hovered: ThemedColor.ref(ColorRef.primaryForeground),
  pressed: ThemedColor.ref(ColorRef.primaryForeground),
);
const _secondaryBg = StateValue(
  rest: ThemedColor.ref(ColorRef.secondary),
  hovered: ThemedColor.ref(ColorRef.secondary, alpha: 0.8),
  pressed: ThemedColor.ref(ColorRef.secondary, alpha: 0.8),
);
const _secondaryFg = StateValue(
  rest: ThemedColor.ref(ColorRef.secondaryForeground),
  hovered: ThemedColor.ref(ColorRef.secondaryForeground),
  pressed: ThemedColor.ref(ColorRef.secondaryForeground),
);

const _standardRow = FabStyle(
  background: _primaryBg,
  foreground: _primaryFg,
  shadowColor: ThemedColor.ref(ColorRef.foreground, alpha: 0.25),
  elevation: 3,
);

const _extendedRow = FabStyle(
  background: _primaryBg,
  foreground: _primaryFg,
  shadowColor: ThemedColor.ref(ColorRef.foreground, alpha: 0.25),
  elevation: 3,
  gap: fabDefaultGap,
  textStyle: fabDefaultTextStyle,
);

const _miniRow = FabStyle(
  background: _secondaryBg,
  foreground: _secondaryFg,
  shadowColor: ThemedColor.ref(ColorRef.foreground, alpha: 0.2),
  elevation: 2,
);

/// Token-derived baseline rows; every unset override field falls through
/// here.
const FabTheme fabDefaults = FabTheme(
  standard: _standardRow,
  extended: _extendedRow,
  mini: _miniRow,
);
