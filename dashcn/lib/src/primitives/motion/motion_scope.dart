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

/// Resolves [base] to zero under reduced motion, otherwise returns it.
///
/// Pass every component animation duration through this so the final state
/// stays identical with and without motion.
Duration resolveMotionDuration(BuildContext context, Duration base) {
  return motionReduced(context) ? Duration.zero : base;
}
