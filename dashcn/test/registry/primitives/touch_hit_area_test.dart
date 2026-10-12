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

  test('touch minimum edge is 44 on iOS, 48 elsewhere', () {
    expect(touchMinEdge(TargetPlatform.iOS), 44);
    expect(touchMinEdge(TargetPlatform.android), 48);
    expect(touchMinEdge(TargetPlatform.macOS), 48);
  });
}
