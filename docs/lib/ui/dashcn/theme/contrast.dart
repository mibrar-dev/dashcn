// WCAG text-contrast helpers for the theme layer.
//
// `primitives/color_math.dart` owns the registry-wide `contrastRatio`, but the
// layer rules forbid `theme/` from importing `primitives/`, so the two small
// functions the muted-surface derivation needs live here instead. Names are
// deliberately distinct from the primitives versions so the barrels never
// collide.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// WCAG 2.1 contrast ratio between [foreground] and [background]: 1.0 for
/// equal colours, 21.0 for black against white. Alpha is ignored; both
/// colours count as opaque, matching the guideline math.
double textContrastRatio(Color foreground, Color background) {
  final double lighter = math.max(
    foreground.computeLuminance(),
    background.computeLuminance(),
  );
  final double darker = math.min(
    foreground.computeLuminance(),
    background.computeLuminance(),
  );
  return (lighter + 0.05) / (darker + 0.05);
}

/// Whether [foreground] meets [minRatio] on [background] (4.5:1, WCAG AA).
bool meetsTextContrast(
  Color foreground,
  Color background, {
  double minRatio = 4.5,
}) {
  return textContrastRatio(foreground, background) >= minRatio;
}

/// Blends [text] toward [towards] until it reaches [minRatio] on [surface].
///
/// Returns [text] untouched when it already passes, so passing presets stay
/// pixel-identical; otherwise walks 20 lerp steps toward [towards] (normally
/// the theme `foreground`). When no blend passes — a surface too close to the
/// text in both directions — falls back to whichever of black/white contrasts
/// more, which always reaches 4.5:1, so the return value is guaranteed to
/// pass [minRatio] on [surface].
Color ensureTextContrast(
  Color text, {
  required Color surface,
  required Color towards,
  double minRatio = 4.5,
}) {
  if (textContrastRatio(text, surface) >= minRatio) {
    return text;
  }
  for (var i = 1; i <= 20; i++) {
    final Color candidate = Color.lerp(text, towards, i / 20)!;
    if (textContrastRatio(candidate, surface) >= minRatio) {
      return candidate;
    }
  }
  const white = Color(0xFFFFFFFF);
  const black = Color(0xFF000000);
  return textContrastRatio(white, surface) >= textContrastRatio(black, surface)
      ? white
      : black;
}
