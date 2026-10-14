// Registry-owned theme data for the `keyboard_shortcut` component: the
// [KeyboardShortcutTheme] cap styling and the token-derived
// [keyboardShortcutDefaults].
//
// upstream kbd: one small rounded cap per key on the `muted` surface with a
// `border` outline and no shadow, labelled in the mono face. User-owned
// overrides live in `keyboard_shortcut_theme.dart`.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';

/// Default horizontal gap between two caps (upstream `gap-1` = 4).
const double keyboardShortcutDefaultSpacing = 4;

/// Default padding inside one cap: upstream `px-1.5 py-0.5`, density-scaled.
///
/// Typed [EdgeInsets] (the value an override leg is compared against) but
/// built as an [EdgeInsetsDensity]: its stored sides are upstream-px multipliers
/// (6/16, 2/16), so [KeyboardKeyCap] resolves it against
/// `density.baseContentPadding * scaling` and a literal override passes
/// through unchanged.
///
/// With the `text-xs` label (12 px on a 16 px line) the cap measures
/// upstream's `h-5` (20 px) at the reference density.
const EdgeInsets keyboardShortcutDefaultKeyPadding =
    EdgeInsetsDensity.pxSymmetric(horizontal: 6, vertical: 2);

/// Fallback label text style: upstream `text-xs` = 12 px on a 16 px (`1rem`)
/// line.
const TextStyle keyboardShortcutDefaultTextStyle = TextStyle(
  fontSize: 12,
  height: 4 / 3,
  fontWeight: FontWeight.w500,
);

/// Fixed corner radius of a cap: upstream `rounded-md`-sized (4 px).
///
/// Hard-coded on purpose (P7-WC2): a preset-driven radius changes with every
/// theme, and a key hint reads as a key only when the rounding stays the
/// same. Override per app through the theme's `keyBorderRadius`.
const BorderRadius keyboardShortcutDefaultKeyRadius = BorderRadius.all(
  Radius.circular(4),
);

/// Fill variant of one key cap.
///
/// upstream paints a single kbd look (muted fill + `border` outline); the docs
/// search field asked for a version with no fill so a chord can sit on a
/// filled surface, so the fill is a choice with the subtle look as the
/// default.
enum KbdVariant {
  /// Muted fill with the `border` outline — the upstream kbd look.
  subtle,

  /// No fill: the cap blends into the surface behind it. The border stays,
  /// because a hint still has to read as a key.
  ghost,
}

/// Styling of one key cap.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class KeyboardShortcutTheme extends ComponentThemeData
    implements Mergeable<KeyboardShortcutTheme> {
  /// Creates a keyboard-shortcut theme.
  const KeyboardShortcutTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.spacing,
    this.keyPadding,
    this.keyBackground,
    this.keyForeground,
    this.keyBorderColor,
    this.keyBorderWidth,
    this.keyBorderRadius,
    this.keyTextStyle,
    this.keyShadows,
    this.variant,
  });

  /// Horizontal gap between two caps; null resolves
  /// [keyboardShortcutDefaultSpacing].
  final double? spacing;

  /// Padding inside one cap; null resolves
  /// [keyboardShortcutDefaultKeyPadding] (density-scaled).
  final EdgeInsetsGeometry? keyPadding;

  /// Fill of one cap; null resolves per [variant]: the `muted` token for
  /// [KbdVariant.subtle] (the upstream kbd fill), nothing for
  /// [KbdVariant.ghost]. An explicit fill wins in both variants.
  final ThemedColor? keyBackground;

  /// Label colour of one cap; null resolves `mutedForeground`.
  final ThemedColor? keyForeground;

  /// Border colour of one cap; null resolves the `border` token. A width of
  /// `0` (via [keyBorderWidth]) hides the border.
  final ThemedColor? keyBorderColor;

  /// Border width of one cap; null resolves 1.
  final double? keyBorderWidth;

  /// Corner radius of one cap; null resolves
  /// [keyboardShortcutDefaultKeyRadius] — a fixed 4 px, chosen so a cap reads
  /// as a key on every theme (a preset radius would vary).
  final BorderRadiusGeometry? keyBorderRadius;

  /// Label text style; null resolves [keyboardShortcutDefaultTextStyle] in
  /// the ambient mono face.
  final TextStyle? keyTextStyle;

  /// Shadows under one cap; null draws none (the upstream look).
  final List<BoxShadow>? keyShadows;

  /// Fill variant of one cap; null resolves [KbdVariant.subtle].
  final KbdVariant? variant;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  KeyboardShortcutTheme merge(KeyboardShortcutTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return KeyboardShortcutTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      spacing: spacing ?? fallback.spacing,
      keyPadding: keyPadding ?? fallback.keyPadding,
      keyBackground: keyBackground ?? fallback.keyBackground,
      keyForeground: keyForeground ?? fallback.keyForeground,
      keyBorderColor: keyBorderColor ?? fallback.keyBorderColor,
      keyBorderWidth: keyBorderWidth ?? fallback.keyBorderWidth,
      keyBorderRadius: keyBorderRadius ?? fallback.keyBorderRadius,
      keyTextStyle: keyTextStyle == null
          ? fallback.keyTextStyle
          : (fallback.keyTextStyle?.merge(keyTextStyle) ?? keyTextStyle),
      keyShadows: keyShadows ?? fallback.keyShadows,
      variant: variant ?? fallback.variant,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is KeyboardShortcutTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.spacing == spacing &&
        other.keyPadding == keyPadding &&
        other.keyBackground == keyBackground &&
        other.keyForeground == keyForeground &&
        other.keyBorderColor == keyBorderColor &&
        other.keyBorderWidth == keyBorderWidth &&
        other.keyBorderRadius == keyBorderRadius &&
        other.keyTextStyle == keyTextStyle &&
        _shadowsEqual(other.keyShadows, keyShadows) &&
        other.variant == variant;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    spacing,
    keyPadding,
    keyBackground,
    keyForeground,
    keyBorderColor,
    keyBorderWidth,
    keyBorderRadius,
    keyTextStyle,
    Object.hashAll(keyShadows ?? const <BoxShadow>[]),
    variant,
  );

  static bool _shadowsEqual(List<BoxShadow>? a, List<BoxShadow>? b) {
    if (identical(a, b)) {
      return true;
    }
    if (a == null || b == null || a.length != b.length) {
      return false;
    }
    for (int i = 0; i < a.length; i++) {
      if (a[i].color != b[i].color ||
          a[i].offset != b[i].offset ||
          a[i].blurRadius != b[i].blurRadius ||
          a[i].spreadRadius != b[i].spreadRadius) {
        return false;
      }
    }
    return true;
  }
}

/// Token-derived baseline values; unset override fields fall through here.
///
/// `keyBackground` is deliberately unset: the fill depends on
/// [KbdVariant] (muted for `subtle`, none for `ghost`), which
/// [KeyboardKeyCap] resolves so an explicit override still wins in either
/// variant. `keyBorderRadius` is the fixed [keyboardShortcutDefaultKeyRadius]:
/// a preset-driven radius would make the cap round differently on every theme.
const KeyboardShortcutTheme keyboardShortcutDefaults = KeyboardShortcutTheme(
  spacing: keyboardShortcutDefaultSpacing,
  keyPadding: keyboardShortcutDefaultKeyPadding,
  keyForeground: ThemedColor.ref(ColorRef.mutedForeground),
  keyBorderColor: ThemedColor.ref(ColorRef.border),
  keyBorderWidth: 1,
  keyBorderRadius: keyboardShortcutDefaultKeyRadius,
  keyTextStyle: keyboardShortcutDefaultTextStyle,
  variant: KbdVariant.subtle,
);
