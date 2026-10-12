// P7-TS1 bugs 1+2: walk the picker popups in the real app shell and assert
// each committed select lands in the model.
//
// Bug 1 (tapping BLACK/GREY selected RED) is pinned by walking every swatch
// of the Base and Theme colour grids; bug 2 (chart pick) by tapping a chart
// seed and asserting chart1..5 changed in the document AND in the resolved
// theme (which is what the charts paint from).

import 'package:docs/routing/docs_router.dart';
import 'package:docs/theme/theme_document.dart';
import 'package:docs/theme/theme_palette.dart';
import 'package:docs/ui/shadcn/components/menu/menu.dart';
import 'package:docs/ui/shadcn/theme/theme.dart';
import 'package:docs/widgets/rail_pickers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

Future<DocsRouterDelegate> _delegate(WidgetTester tester) =>
    pumpDocsApp(tester, platformBrightness: Brightness.dark).then((
      DocsRouterDelegate d,
    ) async {
      await goTo(tester, d, '/themes');
      return d;
    });

Future<void> _openRow(WidgetTester tester, String key) async {
  await tester.tap(find.byKey(ValueKey<String>(key)));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  expect(find.byType(MenuPopup), findsOneWidget, reason: 'popup for $key');
}

Future<void> _closePopup(WidgetTester tester) async {
  await tester.sendKeyEvent(LogicalKeyboardKey.escape);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  expect(find.byType(MenuPopup), findsNothing);
}

/// Taps the swatch whose fill is [color]. The panel surface and a black
/// seed swatch share a fill, so `RailSeedSwatch`'s 40x40 box disambiguates.
Future<void> _tapSwatch(WidgetTester tester, Color color) async {
  await tester.tap(
    find.descendant(
      of: find.byType(MenuPopup),
      matching: find.byWidgetPredicate(
        (Widget widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color == color &&
            widget.constraints?.maxWidth == 40 &&
            widget.constraints?.maxHeight == 40,
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
}

void main() {
  group('colour pickers commit the tapped swatch', () {
    testWidgets('every Theme colour swatch selects itself', (tester) async {
      // One pump only: a second pumpWidget reuses the shell element while
      // the harness global moves on, so the rail would commit to a stale
      // model (see ts1_transition_test.dart).
      await goTo(tester, await _delegate(tester), '/themes');
      await _openRow(tester, 'rail-row-accent');

      for (final Color seed in kDocsSeedSwatches) {
        // The committed document must equal the derivation for the tapped
        // seed exactly (equality, not change: tapping the already-derived
        // seed is a silent no-op by design, never a fallback to red).
        final ThemeDocument expected = applyAccentColor(
          docsState.themeModel.document,
          seed,
        );
        await _tapSwatch(tester, seed);
        expect(
          docsState.themeModel.document.json,
          expected.json,
          reason:
              'swatch 0x${seed.toARGB32().toRadixString(16)} must commit '
              'its own derivation',
        );

        // Bug 1: a neutral swatch must resolve to a neutral primary, and the
        // rail row must label it Neutral — never Red.
        final Color primary = docsColorOf(
          docsState.themeModel.document.light['primary']!,
        );
        final bool neutral = HSLColor.fromColor(primary).saturation < 0.1;
        expect(
          neutral,
          HSLColor.fromColor(seed).saturation < 0.1,
          reason: 'neutrality of the derived accent must follow the seed',
        );
        if (HSLColor.fromColor(seed).saturation < 0.1) {
          expect(docsColorName(primary), 'Neutral');
        }

        // Re-open: the popup closed on the pick.
        expect(find.byType(MenuPopup), findsNothing);
        await _openRow(tester, 'rail-row-accent');
      }
      expect(tester.takeException(), isNull);
      await _closePopup(tester);
    });

    testWidgets('every Base colour swatch selects itself', (tester) async {
      // One pump only: a second pumpWidget reuses the shell element while
      // the harness global moves on, so the rail would commit to a stale
      // model (see ts1_transition_test.dart).
      await goTo(tester, await _delegate(tester), '/themes');
      await _openRow(tester, 'rail-row-base');

      for (final Color seed in kDocsSeedSwatches) {
        final ThemeDocument expected = applyBaseColor(
          docsState.themeModel.document,
          seed,
        );
        await _tapSwatch(tester, seed);
        expect(
          docsState.themeModel.document.json,
          expected.json,
          reason:
              'swatch 0x${seed.toARGB32().toRadixString(16)} must commit '
              'its own derivation',
        );
        // The base row owns the neutral family's hue: a chromatic seed
        // tints `muted`, an achromatic one keeps it neutral.
        final Color muted = docsColorOf(
          docsState.themeModel.document.light['muted']!,
        );
        final HSLColor hsl = HSLColor.fromColor(muted);
        if (HSLColor.fromColor(seed).saturation < 0.1) {
          expect(
            hsl.saturation,
            lessThan(0.1),
            reason: 'a neutral base seed must keep the family neutral',
          );
        } else {
          expect(
            hsl.saturation,
            greaterThan(0.1),
            reason: 'a chromatic base seed must tint the family',
          );
          // Circular distance: hues wrap at 360 (a 357° seed and a 0°
          // derivation are 3° apart, not 357°).
          final double seedHue = HSLColor.fromColor(seed).hue;
          final double drift = ((hsl.hue - seedHue + 540) % 360) - 180;
          expect(
            drift.abs(),
            lessThan(25),
            reason: 'the derived hue must follow the seed',
          );
        }
        expect(find.byType(MenuPopup), findsNothing);
        await _openRow(tester, 'rail-row-base');
      }
      expect(tester.takeException(), isNull);
      await _closePopup(tester);
    });

    testWidgets('every Chart colours swatch selects itself site-wide', (
      tester,
    ) async {
      // One pump only: a second pumpWidget reuses the shell element while
      // the harness global moves on, so the rail would commit to a stale
      // model (see ts1_transition_test.dart).
      await goTo(tester, await _delegate(tester), '/themes');
      await _openRow(tester, 'rail-row-chart');

      for (final Color seed in kDocsSeedSwatches) {
        final ThemeDocument expected = applyChartColors(
          docsState.themeModel.document,
          seed,
        );
        await _tapSwatch(tester, seed);
        expect(
          docsState.themeModel.document.json,
          expected.json,
          reason:
              'swatch 0x${seed.toARGB32().toRadixString(16)} must commit '
              'its own chart derivation',
        );
        // Bug 2: the pick must reach the resolved theme the charts (home,
        // studio and dashboard blocks) all paint from — not just the JSON.
        final ShadcnThemeData theme = docsState.themeModel.themeFor(
          docsState.brightness,
        );
        for (int i = 0; i < kDocsChartTokenKeys.length; i += 1) {
          expect(
            theme.colors.chartColors[i],
            docsColorOf(expected.light[kDocsChartTokenKeys[i]]!),
            reason: 'chart${i + 1} must follow the pick site-wide',
          );
        }
        expect(find.byType(MenuPopup), findsNothing);
        await _openRow(tester, 'rail-row-chart');
      }
      expect(tester.takeException(), isNull);
      await _closePopup(tester);
    });
  });
}
