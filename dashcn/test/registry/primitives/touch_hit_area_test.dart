import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/primitives/touch_hit_area.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui' as ui;

/// [TouchHitArea]: layout never grows; the invisible per-side expansion
/// applies to hit testing and the merged semantics tap target only.
void main() {
  Widget frame(ThemeData data, Widget child) {
    return Theme(
      data: data,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: child),
      ),
    );
  }

  testWidgets('layout stays at the visual size on every platform', (
    tester,
  ) async {
    const Widget padded = TouchHitArea(
      vertical: 6,
      horizontal: 4,
      child: SizedBox(width: 10, height: 10),
    );
    await tester.pumpWidget(frame(const ThemeData(), padded));
    expect(
      tester.getSize(find.byType(TouchHitArea)),
      const Size(10, 10),
      reason: 'Android: paint and layout stay 10x10 (SIZING.md)',
    );
    await tester.pumpWidget(
      frame(const ThemeData(platform: TargetPlatform.macOS), padded),
    );
    expect(tester.getSize(find.byType(TouchHitArea)), const Size(10, 10));
    await tester.pumpWidget(
      frame(const ThemeData(platform: TargetPlatform.iOS), padded),
    );
    expect(
      tester.getSize(find.byType(TouchHitArea)),
      const Size(10, 10),
      reason: 'iOS: layout never grows either',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('overflow taps hit and semantics reports the minimum', (
    tester,
  ) async {
    var tapped = false;
    await tester.pumpWidget(
      frame(
        const ThemeData(),
        TouchHitArea(
          vertical: 6,
          horizontal: 4,
          child: GestureDetector(
            onTap: () => tapped = true,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(width: 10, height: 10),
          ),
        ),
      ),
    );
    expect(tester.getSize(find.byType(TouchHitArea)), const Size(10, 10));
    // 3 px above the visual box (inside the 6 px vertical expansion).
    final Offset center = tester.getCenter(find.byType(TouchHitArea));
    await tester.tapAt(Offset(center.dx, center.dy - 5 - 3));
    await tester.pump();
    expect(tapped, isTrue, reason: 'overflow tap still presses the control');

    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pump();
    var saw48 = false;
    for (final RenderView view in tester.binding.renderViews) {
      final SemanticsNode? root = view.owner?.semanticsOwner?.rootSemanticsNode;
      void visit(SemanticsNode node) {
        final data = node.getSemanticsData();
        if (data.hasAction(ui.SemanticsAction.tap)) {
          final Size s = node.rect.size;
          if ((s.width - 18).abs() < 0.01 && (s.height - 22).abs() < 0.01) {
            saw48 = true;
          }
        }
        node.visitChildren((child) {
          visit(child);
          return true;
        });
      }

      if (root != null) {
        visit(root);
      }
    }
    handle.dispose();
    expect(saw48, isTrue, reason: 'merged tap target reports 18x22');
    expect(tester.takeException(), isNull);
  });

  testWidgets('shrinkWrap skips the expansion on every platform', (
    tester,
  ) async {
    const Widget padded = TouchHitArea(
      vertical: 6,
      horizontal: 4,
      child: SizedBox(width: 10, height: 10),
    );
    const ThemeData shrink = ThemeData(touchTargets: TouchTargets.shrinkWrap);
    await tester.pumpWidget(frame(shrink, padded));
    expect(tester.getSize(find.byType(TouchHitArea)), const Size(10, 10));
    await tester.pumpWidget(
      frame(shrink.copyWith(platform: () => TargetPlatform.iOS), padded),
    );
    expect(tester.getSize(find.byType(TouchHitArea)), const Size(10, 10));
    await tester.pumpWidget(
      frame(shrink.copyWith(platform: () => TargetPlatform.macOS), padded),
    );
    expect(tester.getSize(find.byType(TouchHitArea)), const Size(10, 10));
    expect(tester.takeException(), isNull);
  });

  test('touchTargets round-trips through copyWith, lerp and ==', () {
    const ThemeData base = ThemeData();
    expect(base.touchTargets, TouchTargets.padded);
    final ThemeData shrink = base.copyWith(
      touchTargets: () => TouchTargets.shrinkWrap,
    );
    expect(shrink.touchTargets, TouchTargets.shrinkWrap);
    expect(shrink, isNot(base));
    expect(
      ThemeData.lerp(base, shrink, 0.25).touchTargets,
      TouchTargets.padded,
    );
    expect(
      ThemeData.lerp(base, shrink, 0.75).touchTargets,
      TouchTargets.shrinkWrap,
    );
    expect(shrink.hashCode, isNot(base.hashCode));
  });

  test('touch minimum edge is 44 on iOS, 48 elsewhere', () {
    expect(touchMinEdge(TargetPlatform.iOS), 44);
    expect(touchMinEdge(TargetPlatform.android), 48);
    expect(touchMinEdge(TargetPlatform.macOS), 48);
  });
}
