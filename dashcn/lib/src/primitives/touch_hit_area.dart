// Touch hit-area expansion for desktop-density controls.
//
// Desktop kits size buttons and rows at 28-40 px; touch platforms require
// 44x44 (iOS) or 48x48 (Android). This wrapper expands the reported
// semantics tap target (what the scorecards and screen readers measure) on
// touch platforms only, so the painted visuals never change and desktop
// layouts are pixel-identical.
//
// Two modes (see [TouchHitArea.growLayout]):
// - growing (default, buttons): transparent [Padding] so the layout grows to
//   the platform minimum (36 visual + 6 px/side = 48 layout on Android).
//   `tester.getSize` reports 48; neighbours must have room. Pinned by
//   `button_test` ("touch platforms grow the hit box") and `card_image_test`
//   (6 px inset).
// - non-growing (triggers that must align with inputs: select, date/time
//   pickers): same layout size as [child] (visual 36 stays 36), larger
//   semantics bounds and hit test via [_TouchHitExpander]. `tester.getSize`
//   stays at the sizing-scale height so side-by-side controls stay aligned,
//   while the scorecards still see 48. The popup anchor uses the visual box,
//   so anchored popups stay within 12 px.

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
/// On Android/iOS the semantics tap target grows to the platform minimum
/// while the painted visuals never change. On desktop returns [child]
/// unchanged. Place inside the control's `Semantics` node so the larger
/// box is the reported tap target.
///
/// When [growLayout] is true (default, buttons) the layout grows with
/// transparent [Padding]; when false (select, date/time triggers that sit
/// beside inputs) the layout stays at the visual size and only the semantics
/// bounds and hit test expand, so `tester.getSize` keeps reporting the
/// sizing-scale height and neighbours never shift.
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
    this.growLayout = true,
    required this.child,
  });

  /// Transparent expansion per side, top and bottom.
  final double vertical;

  /// Transparent expansion per side, left and right.
  final double horizontal;

  /// When true the layout grows with transparent padding (buttons); when
  /// false the layout stays at the visual size and only semantics/hit test
  /// expand (triggers beside inputs).
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
    if (growLayout) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: child,
      );
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
class _RenderTouchHitArea extends RenderProxyBox {
  /// Creates a hit-area proxy with per-side expansion.
  _RenderTouchHitArea({required double vertical, required double horizontal})
    // ignore: prefer_initializing_formals
    : _vertical = vertical,
      // ignore: prefer_initializing_formals
      _horizontal = horizontal;

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
