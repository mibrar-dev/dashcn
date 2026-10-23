// Reduced-motion resolution for the motion primitive set.
// Every animation in the kit collapses the same way: when the platform
// reports reduced motion (MediaQuery.disableAnimations) or the theme
// master switch (Theme.of(context).motion.enabled) is off, durations
// resolve to Duration.zero and widgets build their end value
// immediately, with no tickers or timers running.

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// Whether motion is reduced for [context].
///
/// True when the platform disables animations or the theme's
/// `motion.enabled` master switch is off.
bool motionReduced(BuildContext context) {
  final media = MediaQuery.maybeOf(context);
  if (media != null && media.disableAnimations) {
    return true;
  }
  return !Theme.of(context).motion.enabled;
}

/// Resolves [base] to zero under reduced motion, otherwise scales it by
/// the theme intensity multiplier.
///
/// Pass every component animation duration through this so the final state
/// stays identical with and without motion and the Theme Studio intensity
/// picker retimes the whole kit from one place.
Duration resolveMotionDuration(BuildContext context, Duration base) {
  if (motionReduced(context)) {
    return Duration.zero;
  }
  return Theme.of(context).motion.scaledDuration(base);
}

/// Opacity-only fade that overlays use under reduced motion. Reduced motion
/// removes movement and scale; the one remaining change is this fade, which
/// is at most 150 ms.
const Duration kOverlayReducedFade = Duration(milliseconds: 100);

/// Resolves an enter [offset] through the theme intensity enter offset.
///
/// Standard keeps the caller's slide, subtle halves it, expressive grows it
/// by half, custom scales by its explicit leg. Zero stays zero.
Offset resolveMotionOffset(BuildContext context, Offset base) {
  return Theme.of(context).motion.scaledOffset(base);
}

/// Resolves the press scale for [context] through the theme intensity.
///
/// Standard 0.96, subtle 0.98, expressive 0.94, custom the explicit leg.
double resolvePressScale(BuildContext context) {
  return Theme.of(context).motion.pressScale;
}
