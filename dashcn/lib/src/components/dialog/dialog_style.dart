import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../../theme/tokens.dart';

/// Named dialog widths (upstream `max-w-*` steps).
///
/// An explicit [DialogTheme.maxWidth] always wins; otherwise the card caps at
/// the size's width, so a small confirmation stays compact while a table or a
/// code pane can go wide.
enum DialogSize {
  /// Compact confirmations: 384 (`max-w-sm`).
  sm,

  /// Default dialogs: 512 (upstream `DialogContent` `max-w-lg`).
  md,

  /// Wide dialogs (tables, code panes): 768.
  lg,
}

/// Width in logical pixels of a [DialogSize].
double dialogSizeWidth(DialogSize size) => switch (size) {
  DialogSize.sm => 384,
  DialogSize.md => 512,
  DialogSize.lg => 768,
};

/// Theme of the modal dialog shell.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills the
/// gap from the next leg (defaults < app < scoped < widget). `borderRadius` and
/// `shadows` stay null in [dialogDefaults] because their real defaults come
/// from the ambient token set (`radiusLg` and `shadowLg`) and are therefore
/// resolved at build, not in this const.
class DialogTheme extends ComponentThemeData implements Mergeable<DialogTheme> {
  const DialogTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.background,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.insetPadding,
    this.barrierColor,
    this.maxWidth,
    this.size,
    this.transitionDuration,
    this.shadows,
  });

  /// Surface color of the dialog card. Default: the `card` token.
  final ThemedColor? background;

  /// Border color of the dialog card. Default: the `border` token.
  final ThemedColor? borderColor;

  /// Border width in logical pixels. Default: `1.0`; `0` hides the border.
  final double? borderWidth;

  /// Corner radius of the dialog card. Default: ambient `radiusLg`.
  final BorderRadiusGeometry? borderRadius;

  /// Padding between the card border and its content (upstream `p-6`).
  /// Resolved against the density content padding when it is a density
  /// padding. Default: `padMd` x density content padding (24px at default
  /// density). Full-screen dialogs keep this padding.
  final EdgeInsetsGeometry? padding;

  /// Padding between the screen edge and the card. Resolved against the
  /// density content padding when it is a density padding. Default:
  /// `padSm` x density content padding (16px at default density); a
  /// full-screen dialog uses `EdgeInsets.zero`.
  final EdgeInsetsGeometry? insetPadding;

  /// Color of the modal barrier behind the dialog. Default: black at 50%.
  final ThemedColor? barrierColor;

  /// Maximum width of the dialog card. `null` falls back to [size], then 512.
  final double? maxWidth;

  /// Named width step; an explicit [maxWidth] wins over it.
  final DialogSize? size;

  /// Duration of the open and close transitions. Default: 150ms.
  final Duration? transitionDuration;

  /// Drop shadows of the dialog card. Default: the `shadowLg` entry of the
  /// ambient shadow scale; `const []` removes them.
  final List<BoxShadow>? shadows;

  DialogTheme copyWith({
    ValueGetter<Density?>? themeDensity,
    ValueGetter<SpacingScale?>? themeSpacing,
    ValueGetter<ShadowScale?>? themeShadows,
    ValueGetter<ThemedColor?>? background,
    ValueGetter<ThemedColor?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<EdgeInsetsGeometry?>? insetPadding,
    ValueGetter<ThemedColor?>? barrierColor,
    ValueGetter<double?>? maxWidth,
    ValueGetter<DialogSize?>? size,
    ValueGetter<Duration?>? transitionDuration,
    ValueGetter<List<BoxShadow>?>? shadows,
  }) {
    return DialogTheme(
      themeDensity: themeDensity == null ? this.themeDensity : themeDensity(),
      themeSpacing: themeSpacing == null ? this.themeSpacing : themeSpacing(),
      themeShadows: themeShadows == null ? this.themeShadows : themeShadows(),
      background: background == null ? this.background : background(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
      insetPadding: insetPadding == null ? this.insetPadding : insetPadding(),
      barrierColor: barrierColor == null ? this.barrierColor : barrierColor(),
      maxWidth: maxWidth == null ? this.maxWidth : maxWidth(),
      size: size == null ? this.size : size(),
      transitionDuration: transitionDuration == null
          ? this.transitionDuration
          : transitionDuration(),
      shadows: shadows == null ? this.shadows : shadows(),
    );
  }

  /// Receiver wins per field; [fallback] only fills null cells.
  @override
  DialogTheme merge(DialogTheme? fallback) {
    if (fallback == null) return this;
    return DialogTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      background: background ?? fallback.background,
      borderColor: borderColor ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      borderRadius: borderRadius ?? fallback.borderRadius,
      padding: padding ?? fallback.padding,
      insetPadding: insetPadding ?? fallback.insetPadding,
      barrierColor: barrierColor ?? fallback.barrierColor,
      maxWidth: maxWidth ?? fallback.maxWidth,
      size: size ?? fallback.size,
      transitionDuration: transitionDuration ?? fallback.transitionDuration,
      shadows: shadows ?? fallback.shadows,
    );
  }

  /// Colors, geometry and durations step at `t = 0.5`; shadows and scalars
  /// interpolate.
  static DialogTheme lerp(DialogTheme a, DialogTheme b, double t) {
    return DialogTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      background: t < 0.5 ? a.background : b.background,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      borderRadius: t < 0.5 ? a.borderRadius : b.borderRadius,
      padding: t < 0.5 ? a.padding : b.padding,
      insetPadding: t < 0.5 ? a.insetPadding : b.insetPadding,
      barrierColor: t < 0.5 ? a.barrierColor : b.barrierColor,
      maxWidth: lerpDouble(a.maxWidth, b.maxWidth, t),
      size: t < 0.5 ? a.size : b.size,
      transitionDuration: t < 0.5 ? a.transitionDuration : b.transitionDuration,
      shadows:
          BoxShadow.lerpList(a.shadows, b.shadows, t) ??
          (t < 0.5 ? a.shadows : b.shadows),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DialogTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.background == background &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.insetPadding == insetPadding &&
        other.barrierColor == barrierColor &&
        other.maxWidth == maxWidth &&
        other.size == size &&
        other.transitionDuration == transitionDuration &&
        other.shadows == shadows;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    background,
    borderColor,
    borderWidth,
    borderRadius,
    padding,
    insetPadding,
    barrierColor,
    maxWidth,
    size,
    transitionDuration,
    Object.hashAll(shadows ?? const <BoxShadow>[]),
  );
}

/// Effective max width of a resolved [DialogTheme]: an explicit `maxWidth`
/// wins, then the [DialogSize] step, then the upstream `sm:max-w-lg` default of
/// 512. Kept as a helper (instead of a non-null default) so a `size` leg can
/// still win over the 512 every other leg falls through to.
double dialogEffectiveMaxWidth(DialogTheme style) =>
    style.maxWidth ??
    (style.size == null ? 512.0 : dialogSizeWidth(style.size!));

/// Built-in dialog defaults. Every leg above this one overrides only the
/// fields it sets; the rest fall through to these values.
const DialogTheme dialogDefaults = DialogTheme(
  background: ThemedColor.ref(ColorRef.card),
  borderColor: ThemedColor.ref(ColorRef.border),
  borderWidth: 1.0,
  // upstream `p-6` inside the card, 16px (`padSm`) between card and screen edge.
  padding: EdgeInsetsDensity.all(padMd),
  insetPadding: EdgeInsetsDensity.all(padSm),
  barrierColor: ThemedColor.value(Color(0x80000000)),
  // upstream `sm:max-w-lg` = 512, via [dialogEffectiveMaxWidth] so a `size`
  // leg still applies; an explicit `maxWidth` on any leg wins over both.
  maxWidth: null,
  transitionDuration: kDefaultDuration,
);
