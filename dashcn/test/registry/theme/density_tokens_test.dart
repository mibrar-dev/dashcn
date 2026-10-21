// Density + sizing foundation (DESIGN.md): tokens resolve per theme and
// per instance, touch applies on phone widths, and button + list_tile stay
// overflow-free at 375 px in every density.

import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/list_tile/list_tile.dart';
import 'package:dashcn/src/theme/density_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  required Widget child,
  ThemeData data = const ThemeData(),
  double width = 800,
}) {
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: const <ComponentThemeData>[],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: Center(child: child),
        ),
      ),
    ),
  );
}

void main() {
  test('compact is the default everywhere', () {
    expect(const ThemeData().densityTokens, DensityTokens.compact);
    expect(
      DensityTokens.fromPreset(DensityPreset.compact),
      DensityTokens.compact,
    );
    expect(
      DensityTokens.fromPreset(DensityPreset.comfortable),
      DensityTokens.comfortable,
    );
    expect(DensityTokens.fromPreset(DensityPreset.touch), DensityTokens.touch);
  });

  test('token values match DESIGN.md', () {
    expect(DensityTokens.compact.controlHeight, 32);
    expect(DensityTokens.compact.iconSize, 16);
    expect(DensityTokens.compact.rowMinHeight, 32);
    expect(DensityTokens.compact.rowMaxHeight, 36);
    expect(DensityTokens.comfortable.controlHeight, 40);
    expect(DensityTokens.comfortable.iconSize, 20);
    expect(DensityTokens.comfortable.rowMinHeight, 40);
    expect(DensityTokens.comfortable.rowMaxHeight, 44);
    expect(DensityTokens.touch.controlHeight, 48);
    expect(DensityTokens.touch.iconSize, 24);
    expect(DensityTokens.touch.rowMinHeight, 48);
    expect(DensityTokens.touch.rowMaxHeight, 56);
  });

  test('spacing scale is 4px base (4, 8, 12, 16, 24, 32)', () {
    expect(kSpacingScaleSteps, const <double>[4, 8, 12, 16, 24, 32]);
    expect(kSpace1, 4);
    expect(kSpace2, 8);
    expect(kSpace3, 12);
    expect(kSpace4, 16);
    expect(kSpace6, 24);
    expect(kSpace8, 32);
  });

  test('icon-size resolver is density-driven and capped at 60%', () {
    expect(resolveIconSize(DensityTokens.compact), 16);
    expect(resolveIconSize(DensityTokens.comfortable), 20);
    expect(resolveIconSize(DensityTokens.touch), 24);
    // 60% cap: all presets pass (16 < 19.2, 20 < 24, 24 < 28.8).
    expect(buttonIconSize(DensityTokens.compact), 16);
    expect(buttonIconSize(DensityTokens.comfortable), 20);
    expect(buttonIconSize(DensityTokens.touch), 24);
    expect(
      buttonIconSize(
        const DensityTokens(
          preset: DensityPreset.compact,
          controlHeight: 20,
          iconSize: 16,
          rowMinHeight: 20,
          rowMaxHeight: 24,
          horizontalPadding: 8,
          verticalPadding: 4,
          gap: 6,
          bodyTextSize: 13,
          subtitleTextSize: 12,
          overlayMinWidth: 160,
          overlayMaxWidth: 320,
        ),
      ),
      12, // 20 * 0.6 caps the 16px icon.
    );
  });

  test('DensityTokens lerp + copyWith', () {
    final DensityTokens mid = DensityTokens.lerp(
      DensityTokens.compact,
      DensityTokens.touch,
      0.5,
    );
    expect(mid.controlHeight, 40);
    expect(mid.iconSize, 20);
    expect(
      DensityTokens.compact.copyWith(controlHeight: 32),
      DensityTokens.compact,
    );
  });

  testWidgets('density resolves per theme', (tester) async {
    for (final DensityTokens tokens in const <DensityTokens>[
      DensityTokens.compact,
      DensityTokens.comfortable,
      DensityTokens.touch,
    ]) {
      await tester.pumpWidget(
        _frame(
          data: ThemeData(densityTokens: tokens),
          child: Builder(
            builder: (context) {
              // Wide viewport: ambient tokens win (no phone override).
              expect(Theme.of(context).densityTokens, tokens);
              expect(resolveDensityTokens(context), tokens);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    }
  });

  testWidgets('density resolves per instance (button + list_tile)', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        data: const ThemeData(
          densityTokens: DensityTokens.compact,
          platform: TargetPlatform.macOS,
        ),
        child: Builder(
          builder: (context) {
            expect(
              resolveDensityTokens(context, override: DensityTokens.touch),
              DensityTokens.touch,
            );
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Button(
                  densityTokens: DensityTokens.comfortable,
                  onPressed: null,
                  child: Text('per-instance'),
                ),
                ListTile(
                  densityTokens: DensityTokens.touch,
                  title: Text('per-instance tile'),
                ),
              ],
            );
          },
        ),
      ),
    );
    expect(find.text('per-instance'), findsOneWidget);
    // Comfortable md is the row max (44) on desktop (no touch hit growth).
    expect(tester.getSize(find.byType(Button)).height, 44);
    expect(tester.takeException(), isNull);
  });

  testWidgets('touch is used on phone widths automatically', (tester) async {
    await tester.pumpWidget(
      _frame(
        width: 375,
        child: Builder(
          builder: (context) {
            expect(resolveDensityTokens(context), DensityTokens.touch);
            expect(isPhoneWidth(375), isTrue);
            expect(isPhoneWidth(1280), isFalse);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    // Explicit override still wins on phones.
    await tester.pumpWidget(
      _frame(
        width: 375,
        child: Builder(
          builder: (context) {
            expect(
              resolveDensityTokens(context, override: DensityTokens.compact),
              DensityTokens.compact,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });

  testWidgets('button has no overflow at 375px in all densities', (
    tester,
  ) async {
    for (final DensityTokens tokens in const <DensityTokens>[
      DensityTokens.compact,
      DensityTokens.comfortable,
      DensityTokens.touch,
    ]) {
      await tester.pumpWidget(
        _frame(
          width: 375,
          data: ThemeData(densityTokens: tokens),
          child: SizedBox(
            width: 375,
            child: Center(
              child: Button(
                densityTokens: tokens,
                onPressed: () {},
                leading: const Text('L'),
                trailing: const Text('T'),
                child: const Text('Save changes'),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull, reason: '${tokens.preset}');
    }
  });

  testWidgets('list_tile has no overflow at 375px in all densities', (
    tester,
  ) async {
    for (final DensityTokens tokens in const <DensityTokens>[
      DensityTokens.compact,
      DensityTokens.comfortable,
      DensityTokens.touch,
    ]) {
      await tester.pumpWidget(
        _frame(
          width: 375,
          data: ThemeData(densityTokens: tokens),
          child: SizedBox(
            width: 375,
            child: ListTile(
              densityTokens: tokens,
              leading: const Text('L'),
              title: const Text(
                'A long title that truncates with ellipsis and never grows',
              ),
              subtitle: const Text('Subtitle truncates too, never overflows'),
              trailing: const Text('T'),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull, reason: '${tokens.preset}');
    }
  });
}
