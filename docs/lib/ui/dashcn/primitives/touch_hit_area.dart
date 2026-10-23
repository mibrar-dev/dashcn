// Touch hit-area expansion for desktop-density controls.
//
// Desktop kits size buttons and rows at 28-40 px; touch platforms require
// 44x44 (iOS) or 48x48 (Android). This wrapper extends the hit-test region
// (and the reported semantics tap target, which the scorecards and screen
// readers measure) on touch platforms only, so the painted visuals never
// change, desktop layouts are pixel-identical, and the layout size never
// changes on any platform (SIZING.md: same sizes on desktop and mobile;
// touch comfort comes from an invisible hit area, never larger visuals).
//
// The layout always stays at the child's size (`tester.getSize` keeps
// reporting the sizing-scale height so side-by-side controls stay aligned).
// The invisible per-side expansion applies to hit testing (taps in the
// overflow still press the control) and to semantics (the merged tap target
// reports the platform minimum). The popup anchor uses the visual box, so
// anchored popups stay within 12 px.

// The render proxy uses public `vertical:`/`horizontal:` names with private
// mutable backing fields whose setters mark semantics dirty.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../foundation/platform.dart';
import '../theme/theme.dart';

/// Minimum touch target edge per platform (iOS 44, Android 48).
double touchMinEdge(TargetPlatform platform) {
  return platform == TargetPlatform.iOS ? 44 : 48;
}

/// Adds a transparent hit expansion around [child] on touch platforms.
///
/// On Android/iOS the hit-test region and the semantics tap target grow to
/// the platform minimum while the painted visuals and the layout size never
/// change. On desktop returns [child] unchanged. Place inside the control's
/// `Semantics` node so the larger box is the reported tap target.
///
/// The layout never grows: the proxy's size is always the child's size, so
/// `tester.getSize` keeps reporting the sizing-scale height and neighbours
/// never shift.
///
/// Opt out per app with `ThemeData(touchTargets: TouchTargets.shrinkWrap)`,
/// which returns [child] unchanged on every platform (dense rows and joined
/// groups should opt out).
class TouchHitArea extends StatelessWidget {
  /// Creates a touch hit area around [child].
  const TouchHitArea({
    super.key,
    this.vertical = 0,
    this.horizontal = 0,
    @Deprecated('Layout never grows; kept for API compatibility.')
    this.growLayout = true,
    required this.child,
  });

  /// Transparent expansion per side, top and bottom.
  final double vertical;

  /// Transparent expansion per side, left and right.
  final double horizontal;

  /// Ignored: the layout never grows (kept for API compatibility).
  final bool growLayout;

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
    return _TouchHitExpander(
      vertical: vertical,
      horizontal: horizontal,
      child: child,
    );
  }
}

/// Render-object expander: same layout size as [child], larger semantics and
/// hit test on touch platforms.
class _TouchHitExpander extends SingleChildRenderObjectWidget {
  /// Creates an expander with per-side [vertical]/[horizontal] growth.
  const _TouchHitExpander({
    required this.vertical,
    required this.horizontal,
    required super.child,
  });

  /// Expansion per side, top and bottom.
  final double vertical;

  /// Expansion per side, left and right.
  final double horizontal;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderTouchHitArea(vertical: vertical, horizontal: horizontal);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderTouchHitArea renderObject,
  ) {
    renderObject
      ..vertical = vertical
      ..horizontal = horizontal;
  }
}

/// Proxy whose layout size is the child's size, but whose semantics bounds
/// and hit test include the invisible per-side expansion.
///
/// A semantics container that merges non-container descendants (the tap from
/// `Clickable`/`GestureDetector`) into the expanded rect while leaving
/// container descendants (status live regions) as separate nodes, so the
/// scorecard tap guidelines see the platform minimum and announcements keep
/// their live-region flag.
class _RenderTouchHitArea extends RenderProxyBox
    with SemanticsAnnotationsMixin {
  /// Creates a hit-area proxy with per-side expansion.
  _RenderTouchHitArea({required double vertical, required double horizontal})
    // ignore: prefer_initializing_formals
    : _vertical = vertical,
      // ignore: prefer_initializing_formals
      _horizontal = horizontal {
    initSemanticsAnnotations(
      properties: const SemanticsProperties(),
      container: true,
      explicitChildNodes: false,
      excludeSemantics: false,
      blockUserActions: false,
      localeForSubtree: null,
      textDirection: null,
    );
  }

  double _vertical;

  /// Expansion per side, top and bottom.
  double get vertical => _vertical;

  /// Sets the vertical expansion and marks semantics layout dirty when it
  /// changes (the semantics rect derives from it).
  set vertical(double value) {
    if (_vertical == value) {
      return;
    }
    _vertical = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  double _horizontal;

  /// Expansion per side, left and right.
  double get horizontal => _horizontal;

  /// Sets the horizontal expansion and marks semantics layout dirty.
  set horizontal(double value) {
    if (_horizontal == value) {
      return;
    }
    _horizontal = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = constraints.smallest;
    }
  }

  /// Semantics bounds include the invisible expansion so the scorecard tap
  /// target guidelines (which read `SemanticsNode.rect`) see the platform
  /// minimum while `tester.getSize` still reports the visual size.
  @override
  Rect get semanticBounds {
    if (_vertical <= 0 && _horizontal <= 0) {
      return Offset.zero & size;
    }
    return Rect.fromLTWH(
      -_horizontal,
      -_vertical,
      size.width + _horizontal * 2,
      size.height + _vertical * 2,
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (_vertical <= 0 && _horizontal <= 0) {
      return super.hitTest(result, position: position);
    }
    final Rect expanded = Rect.fromLTWH(
      -_horizontal,
      -_vertical,
      size.width + _horizontal * 2,
      size.height + _vertical * 2,
    );
    if (!expanded.contains(position)) {
      return false;
    }
    if (child == null) {
      return false;
    }
    // Inside the visual box: normal hit test. In the invisible overflow:
    // forward to the nearest edge so padding taps still press the control.
    final Offset clamped = Offset(
      position.dx.clamp(0.0, size.width),
      position.dy.clamp(0.0, size.height),
    );
    return child!.hitTest(result, position: clamped);
  }
}
