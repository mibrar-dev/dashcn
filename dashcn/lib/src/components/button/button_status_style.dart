// The status styling slice for the `button` component (`P7-S1`):
// [ButtonStatusStyle], its defaults and the baseline [buttonStatusDefaults].
//
// Registry-owned; CLI updates may replace this file. Re-exported through
// `button_style.dart`, so user-owned `button_theme.dart` files keep importing
// only `button_style.dart`. Not independently installable.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';

/// Default success glyph (check) for async buttons.
const IconData buttonDefaultSuccessIcon = LucideIcons.check;

/// Default failure glyph (x) for async buttons.
const IconData buttonDefaultFailureIcon = LucideIcons.x;

/// Static loading glyph used instead of the spinner under reduced motion.
const IconData buttonDefaultLoadingIcon = LucideIcons.loaderCircle;

/// Default status icon size; matches the 16px leadings used in previews.
const double buttonDefaultStatusIconSize = 16;

/// Default spinner diameter inside buttons.
const double buttonDefaultSpinnerSize = 16;

/// Default icon/label cross-fade for status changes (150-200ms band).
const Duration buttonDefaultStatusTransition = Duration(milliseconds: 175);

/// Cross-variant status visuals for async buttons.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. Nulls resolve to the
/// button foreground — except [failureColor], which resolves to the
/// destructive token for non-destructive variants — and to the default
/// glyphs/sizes above.
class ButtonStatusStyle implements Mergeable<ButtonStatusStyle> {
  /// Creates a status style slice.
  const ButtonStatusStyle({
    this.spinnerSize,
    this.statusIconSize,
    this.successIcon,
    this.failureIcon,
    this.loadingIcon,
    this.successColor,
    this.failureColor,
    this.loadingColor,
    this.transitionDuration,
  });

  /// Loading spinner diameter; null uses [buttonDefaultSpinnerSize].
  final double? spinnerSize;

  /// Success/failure glyph size; null uses [buttonDefaultStatusIconSize].
  final double? statusIconSize;

  /// Success glyph; null uses [buttonDefaultSuccessIcon].
  final IconData? successIcon;

  /// Failure glyph; null uses [buttonDefaultFailureIcon].
  final IconData? failureIcon;

  /// Static loading glyph under reduced motion; null uses
  /// [buttonDefaultLoadingIcon].
  final IconData? loadingIcon;

  /// Success glyph color; null keeps the button foreground.
  final ThemedColor? successColor;

  /// Failure glyph color; null uses destructive (foreground for the
  /// destructive variant, which is already red).
  final ThemedColor? failureColor;

  /// Loading spinner color; null keeps the button foreground.
  final ThemedColor? loadingColor;

  /// Icon/label cross-fade; null uses [buttonDefaultStatusTransition].
  /// Zero (or ambient reduced motion) swaps instantly.
  final Duration? transitionDuration;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  ButtonStatusStyle merge(ButtonStatusStyle? fallback) {
    if (fallback == null) {
      return this;
    }
    return ButtonStatusStyle(
      spinnerSize: spinnerSize ?? fallback.spinnerSize,
      statusIconSize: statusIconSize ?? fallback.statusIconSize,
      successIcon: successIcon ?? fallback.successIcon,
      failureIcon: failureIcon ?? fallback.failureIcon,
      loadingIcon: loadingIcon ?? fallback.loadingIcon,
      successColor: successColor ?? fallback.successColor,
      failureColor: failureColor ?? fallback.failureColor,
      loadingColor: loadingColor ?? fallback.loadingColor,
      transitionDuration: transitionDuration ?? fallback.transitionDuration,
    );
  }

  /// Durations are lerped; glyphs and colors step at t < 0.5.
  static ButtonStatusStyle lerp(
    ButtonStatusStyle a,
    ButtonStatusStyle b,
    double t,
  ) {
    Duration? span(Duration? x, Duration? y) {
      if (x == null) {
        return y;
      }
      if (y == null) {
        return x;
      }
      return Duration(
        microseconds:
            (x.inMicroseconds + (y.inMicroseconds - x.inMicroseconds) * t)
                .round(),
      );
    }

    return ButtonStatusStyle(
      spinnerSize: lerpDouble(a.spinnerSize, b.spinnerSize, t),
      statusIconSize: lerpDouble(a.statusIconSize, b.statusIconSize, t),
      successIcon: t < 0.5 ? a.successIcon : b.successIcon,
      failureIcon: t < 0.5 ? a.failureIcon : b.failureIcon,
      loadingIcon: t < 0.5 ? a.loadingIcon : b.loadingIcon,
      successColor: t < 0.5 ? a.successColor : b.successColor,
      failureColor: t < 0.5 ? a.failureColor : b.failureColor,
      loadingColor: t < 0.5 ? a.loadingColor : b.loadingColor,
      transitionDuration: span(a.transitionDuration, b.transitionDuration),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ButtonStatusStyle &&
        other.spinnerSize == spinnerSize &&
        other.statusIconSize == statusIconSize &&
        other.successIcon == successIcon &&
        other.failureIcon == failureIcon &&
        other.loadingIcon == loadingIcon &&
        other.successColor == successColor &&
        other.failureColor == failureColor &&
        other.loadingColor == loadingColor &&
        other.transitionDuration == transitionDuration;
  }

  @override
  int get hashCode => Object.hash(
    spinnerSize,
    statusIconSize,
    successIcon,
    failureIcon,
    loadingIcon,
    successColor,
    failureColor,
    loadingColor,
    transitionDuration,
  );
}

/// Baseline status visuals; every unset override field falls through here.
const ButtonStatusStyle buttonStatusDefaults = ButtonStatusStyle();
