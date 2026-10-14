// Touch hit-area expansion for desktop-density controls.
//
// Desktop kits size buttons and rows at 28-40 px; touch platforms require
// 44x44 (iOS) or 48x48 (Android). This wrapper adds transparent padding on
// touch platforms only, so the painted visuals never change and desktop
// layouts are pixel-identical. It intentionally grows layout (transparent
// space): apply it only where neighbours have room, never in dense grids,
// joined groups or stacked lists.

import 'package:flutter/widgets.dart';

import '../foundation/platform.dart';
import '../theme/theme.dart';

/// Minimum touch target edge per platform (iOS 44, Android 48).
double touchMinEdge(TargetPlatform platform) {
  return platform == TargetPlatform.iOS ? 44 : 48;
}

/// Adds transparent hit padding around [child] on touch platforms.
///
/// On Android/iOS wraps [child] in [EdgeInsets]-symmetric transparent
/// padding ([vertical]/[horizontal] per side); on desktop returns [child]
/// unchanged. Place inside the control's `Semantics` node so the larger
/// box is the reported tap target.
///
/// Opt out per app with `ThemeData(touchTargets: TouchTargets.shrinkWrap)`,
/// which returns [child] unchanged on every platform (the growth is
/// layout, not paint, so dense rows and joined groups should opt out).
class TouchHitArea extends StatelessWidget {
  /// Creates a touch hit area around [child].
  const TouchHitArea({
    super.key,
    this.vertical = 0,
    this.horizontal = 0,
    required this.child,
  });

  /// Transparent padding per side, top and bottom.
  final double vertical;

  /// Transparent padding per side, left and right.
  final double horizontal;

  /// The control.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (vertical <= 0 && horizontal <= 0) {
      return child;
    }
    if (Theme.of(context).touchTargets == TouchTargets.shrinkWrap) {
      return child;
    }
    if (!isMobile(Theme.of(context).platform)) {
      return child;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: child,
    );
  }
}
