// Registry-owned theme data for the `button` component: the `ButtonVariant` /
// `ButtonSize` enums and the per-variant [ButtonTheme] container.
//
// User-owned overrides live in `button_theme.dart`, which imports only this
// file; the variant ([ButtonVariantStyle]) and status ([ButtonStatusStyle])
// slices are defined in their own files and re-exported here so override
// legs keep a single import. CLI updates may replace this file.
// `button.dart` re-exports the style surface.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'button_status_style.dart';
import 'button_variant_style.dart';

export 'button_status_style.dart';
export 'button_variant_style.dart';

/// Visual variants of the button component.
enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  link,
  text,
  destructive,
}

/// Fixed button sizes. Global density scales the size table's padding.
enum ButtonSize { xs, sm, md, lg, icon }

/// Per-variant theme container for the button component.
///
/// A leg may set only the variants/fields it cares about; [merge] lets the
/// receiver win per field. [forVariant] is an exhaustive switch over
/// [ButtonVariant].
class ButtonTheme extends ComponentThemeData implements Mergeable<ButtonTheme> {
  /// Creates a button theme with one nullable slice per variant.
  const ButtonTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.primary,
    this.secondary,
    this.outline,
    this.ghost,
    this.link,
    this.text,
    this.destructive,
    this.status,
  });

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

  /// Cross-variant async status visuals; null uses [buttonStatusDefaults].
  final ButtonStatusStyle? status;

  /// The slice for [variant], or null when this leg leaves it unset.
  ButtonVariantStyle? forVariant(ButtonVariant variant) {
    return switch (variant) {
      ButtonVariant.primary => primary,
      ButtonVariant.secondary => secondary,
      ButtonVariant.outline => outline,
      ButtonVariant.ghost => ghost,
      ButtonVariant.link => link,
      ButtonVariant.text => text,
      ButtonVariant.destructive => destructive,
    };
  }

  /// Returns a copy with the given rows replaced.
  ButtonTheme copyWith({
    ValueGetter<ButtonVariantStyle?>? primary,
    ValueGetter<ButtonVariantStyle?>? secondary,
    ValueGetter<ButtonVariantStyle?>? outline,
    ValueGetter<ButtonVariantStyle?>? ghost,
    ValueGetter<ButtonVariantStyle?>? link,
    ValueGetter<ButtonVariantStyle?>? text,
    ValueGetter<ButtonVariantStyle?>? destructive,
    ValueGetter<ButtonStatusStyle?>? status,
  }) {
    return ButtonTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      primary: primary == null ? this.primary : primary(),
      secondary: secondary == null ? this.secondary : secondary(),
      outline: outline == null ? this.outline : outline(),
      ghost: ghost == null ? this.ghost : ghost(),
      link: link == null ? this.link : link(),
      text: text == null ? this.text : text(),
      destructive: destructive == null ? this.destructive : destructive(),
      status: status == null ? this.status : status(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  ButtonTheme merge(ButtonTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return ButtonTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      primary: primary?.merge(fallback.primary) ?? fallback.primary,
      secondary: secondary?.merge(fallback.secondary) ?? fallback.secondary,
      outline: outline?.merge(fallback.outline) ?? fallback.outline,
      ghost: ghost?.merge(fallback.ghost) ?? fallback.ghost,
      link: link?.merge(fallback.link) ?? fallback.link,
      text: text?.merge(fallback.text) ?? fallback.text,
      destructive:
          destructive?.merge(fallback.destructive) ?? fallback.destructive,
      status: status?.merge(fallback.status) ?? fallback.status,
    );
  }

  /// Lerps each row; state scales step at t < 0.5.
  static ButtonTheme lerp(ButtonTheme a, ButtonTheme b, double t) {
    ButtonVariantStyle? row(ButtonVariantStyle? x, ButtonVariantStyle? y) {
      if (x == null) {
        return y;
      }
      if (y == null) {
        return x;
      }
      return ButtonVariantStyle.lerp(x, y, t);
    }

    ButtonStatusStyle? rowStatus(ButtonStatusStyle? x, ButtonStatusStyle? y) {
      if (x == null) {
        return y;
      }
      if (y == null) {
        return x;
      }
      return ButtonStatusStyle.lerp(x, y, t);
    }

    return ButtonTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      primary: row(a.primary, b.primary),
      secondary: row(a.secondary, b.secondary),
      outline: row(a.outline, b.outline),
      ghost: row(a.ghost, b.ghost),
      link: row(a.link, b.link),
      text: row(a.text, b.text),
      destructive: row(a.destructive, b.destructive),
      status: rowStatus(a.status, b.status),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ButtonTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.outline == outline &&
        other.ghost == ghost &&
        other.link == link &&
        other.text == text &&
        other.destructive == destructive &&
        other.status == status;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    primary,
    secondary,
    outline,
    ghost,
    link,
    text,
    destructive,
    status,
  );
}
