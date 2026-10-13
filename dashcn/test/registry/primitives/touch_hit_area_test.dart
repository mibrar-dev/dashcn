import 'package:flutter/widgets.dart';
import 'package:dashcn/src/primitives/touch_hit_area.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// [TouchHitArea]: transparent growth on touch platforms, passthrough
/// everywhere else.
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

  testWidgets('pads on Android, passes through on desktop', (tester) async {
    const Widget padded = TouchHitArea(
      vertical: 6,
      horizontal: 4,
      child: SizedBox(width: 10, height: 10),
    );
    await tester.pumpWidget(frame(const ThemeData(), padded));
    expect(tester.getSize(find.byType(TouchHitArea)), const Size(18, 22));
    await tester.pumpWidget(
      frame(const ThemeData(platform: TargetPlatform.macOS), padded),
    );
    expect(tester.getSize(find.byType(TouchHitArea)), const Size(10, 10));
    await tester.pumpWidget(
      frame(const ThemeData(platform: TargetPlatform.iOS), padded),
    );
    expect(tester.getSize(find.byType(TouchHitArea)), const Size(18, 22));
    expect(tester.takeException(), isNull);
  });

  testWidgets('shrinkWrap skips the growth on every platform', (tester) async {
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
