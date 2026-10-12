import 'package:flutter/widgets.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Port of the old `Theme._ensureReadableDarkTheme` behaviour: dark theme on
/// a dark background patches near-black foregrounds to readable fallbacks.
void main() {
  Future<ThemeData> themeOf(WidgetTester tester, ThemeData data) async {
    ThemeData? seen;
    await tester.pumpWidget(
      Theme(
        data: data,
        child: Builder(
          builder: (context) {
            seen = Theme.of(context);
            return const SizedBox();
          },
        ),
      ),
    );
    return seen!;
  }

  testWidgets('dark theme patches near-black foregrounds', (tester) async {
    const dark = ThemeColors.darkFallback;
    final data = ThemeData(
      colors: dark.copyWith(
        background: const Color(0xFF000000),
        foreground: const Color(0xFF111111),
        mutedForeground: const Color(0xFF111111),
        cardForeground: const Color(0xFF111111),
        popoverForeground: const Color(0xFF111111),
        sidebarForeground: const Color(0xFF111111),
      ),
    );
    final seen = await themeOf(tester, data);
    expect(seen.colors.foreground, dark.foreground);
    expect(seen.colors.mutedForeground, dark.mutedForeground);
    expect(seen.colors.cardForeground, dark.cardForeground);
    expect(seen.colors.popoverForeground, dark.popoverForeground);
    expect(seen.colors.sidebarForeground, dark.sidebarForeground);
  });

  testWidgets('readable dark theme passes through untouched', (tester) async {
    const data = ThemeData(colors: ThemeColors.darkFallback);
    final seen = await themeOf(tester, data);
    expect(seen, data);
  });

  testWidgets('light theme never patches', (tester) async {
    const data = ThemeData(colors: ThemeColors.lightFallback);
    final seen = await themeOf(
      tester,
      ThemeData(
        colors: ThemeColors.lightFallback.copyWith(
          background: const Color(0xFF000000),
          foreground: const Color(0xFF111111),
        ),
      ),
    );
    expect(seen.colors.foreground, const Color(0xFF111111));
    expect(data.colors.foreground, isNot(const Color(0xFF111111)));
  });
}
