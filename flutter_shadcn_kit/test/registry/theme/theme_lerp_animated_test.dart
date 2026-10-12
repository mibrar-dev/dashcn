import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/theme/color_tokens.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_shadcn_kit/registry/theme/tokens.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ShadcnColors.lerp endpoints return the inputs', () {
    const a = ShadcnColors.lightFallback;
    const b = ShadcnColors.darkFallback;
    expect(ShadcnColors.lerp(a, b, 0.0), a);
    expect(ShadcnColors.lerp(a, b, 1.0), b);
    expect(ShadcnColors.lerp(a, b, 0.0).brightness, Brightness.light);
    expect(ShadcnColors.lerp(a, b, 1.0).brightness, Brightness.dark);
  });

  test('ShadcnThemeData.lerp endpoints return the inputs', () {
    const a = ShadcnThemeData();
    const b = ShadcnThemeData(colors: ShadcnColors.darkFallback);
    expect(ShadcnThemeData.lerp(a, b, 0.0), a);
    expect(ShadcnThemeData.lerp(a, b, 1.0), b);
  });

  test('ShadcnThemeData.lerp reuses identical legs by identity', () {
    // A light/dark toggle changes colours only: the structural legs must not
    // be re-lerped (36 text styles, 8 shadow lists) on every animation frame.
    const light = ShadcnThemeData(colors: ShadcnColors.lightFallback);
    const dark = ShadcnThemeData(colors: ShadcnColors.darkFallback);
    final ShadcnThemeData mid = ShadcnThemeData.lerp(light, dark, 0.5);
    expect(identical(mid.typography, light.typography), isTrue);
    expect(identical(mid.tokens, light.tokens), isTrue);
    expect(identical(mid.fonts, light.fonts), isTrue);
    expect(identical(mid.iconTheme, light.iconTheme), isTrue);
    expect(identical(mid.density, light.density), isTrue);
    expect(identical(mid.spacing, light.spacing), isTrue);
    expect(identical(mid.tracking, light.tracking), isTrue);
    expect(mid.colors, isNot(light.colors));
    expect(mid.colors, isNot(dark.colors));
  });

  test('ShadcnThemeData.lerp lerps the legs that differ', () {
    const a = ShadcnThemeData();
    const b = ShadcnThemeData(tokens: ShadcnTokens(radius: 1));
    final ShadcnThemeData mid = ShadcnThemeData.lerp(a, b, 0.5);
    expect(identical(mid.tokens, a.tokens), isFalse);
    expect(mid.tokens.radius, 0.75);
    expect(identical(mid.typography, a.typography), isTrue);
    expect(identical(mid.colors, a.colors), isTrue);
  });

  testWidgets('AnimatedShadcnTheme animates a color', (tester) async {
    Color? seen;
    ShadcnThemeData dataFor(Color background) => ShadcnThemeData(
      colors: ShadcnColors.lightFallback.copyWith(background: background),
    );
    Widget frame(ShadcnThemeData data) => AnimatedShadcnTheme(
      duration: const Duration(milliseconds: 300),
      data: data,
      child: Builder(
        builder: (context) {
          seen = ShadcnTheme.of(context).colors.background;
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
