import 'package:flutter/widgets.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ThemeColors.lerp endpoints return the inputs', () {
    const a = ThemeColors.lightFallback;
    const b = ThemeColors.darkFallback;
    expect(ThemeColors.lerp(a, b, 0.0), a);
    expect(ThemeColors.lerp(a, b, 1.0), b);
    expect(ThemeColors.lerp(a, b, 0.0).brightness, Brightness.light);
    expect(ThemeColors.lerp(a, b, 1.0).brightness, Brightness.dark);
  });

  test('ThemeData.lerp endpoints return the inputs', () {
    const a = ThemeData();
    const b = ThemeData(colors: ThemeColors.darkFallback);
    expect(ThemeData.lerp(a, b, 0.0), a);
    expect(ThemeData.lerp(a, b, 1.0), b);
  });

  testWidgets('AnimatedTheme animates a color', (tester) async {
    Color? seen;
    ThemeData dataFor(Color background) => ThemeData(
      colors: ThemeColors.lightFallback.copyWith(background: background),
    );
    Widget frame(ThemeData data) => AnimatedTheme(
      duration: const Duration(milliseconds: 300),
      data: data,
      child: Builder(
        builder: (context) {
          seen = Theme.of(context).colors.background;
          return const SizedBox();
        },
      ),
    );

    await tester.pumpWidget(frame(dataFor(const Color(0xFF000000))));
    expect(seen, const Color(0xFF000000));

    await tester.pumpWidget(frame(dataFor(const Color(0xFFFFFFFF))));
    await tester.pump(const Duration(milliseconds: 150));
    // Mid-animation: strictly between the two endpoints.
    expect(seen, isNot(const Color(0xFF000000)));
    expect(seen, isNot(const Color(0xFFFFFFFF)));

    await tester.pumpAndSettle();
    expect(seen, const Color(0xFFFFFFFF));
  });
}
