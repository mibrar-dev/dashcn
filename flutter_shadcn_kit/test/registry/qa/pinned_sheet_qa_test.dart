// QA for `pinned_sheet` previews (P7-Q2, updated for the P7-C1 examples).
//
// Pumps every `pinnedSheetPreviews` example under neutral/claude x light/dark,
// RTL and 375px, snaps between stages with the buttons, and drags the sheet
// like a user. Every example owns its bounded stage and a visible trigger row
// (`Open sheet` / `Half` / `Close`, plus a live `% open` readout where the
// example has snap points), so both paths assert on real state.

import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/pinned_sheet/pinned_sheet.dart';
import 'package:flutter_shadcn_kit/registry/components/pinned_sheet/preview.dart';
import 'package:flutter_shadcn_kit/registry/foundation/component_preview.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../themes/generated_theme.dart';

final Map<String, GeneratedTheme> _presets = <String, GeneratedTheme>{};

ShadcnThemeData _theme(String preset, Brightness brightness) {
  final GeneratedTheme theme = _presets.putIfAbsent(
    preset,
    () => loadGeneratedTheme('lib/registry/themes/$preset.json'),
  );
  final view = theme.view(brightness);
  return ShadcnThemeData(
    colors: view.colors,
    tokens: view.tokens,
    fonts: view.fonts,
  );
}

Future<void> _pumpPreview(
  WidgetTester tester,
  ComponentPreview preview, {
  String preset = 'neutral',
  Brightness brightness = Brightness.light,
  TextDirection direction = TextDirection.ltr,
  double width = 360,
}) async {
  await tester.pumpWidget(
    ShadcnTheme(
      data: _theme(preset, brightness),
      child: Directionality(
        textDirection: direction,
        child: Overlay.wrap(
          child: Center(
            child: SizedBox(
              width: width,
              child: Builder(builder: preview.builder),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
  expect(
    tester.takeException(),
    isNull,
    reason: 'preview "${preview.name}" threw',
  );
}

void main() {
  testWidgets('every preview pumps neutral/claude x light/dark', (
    tester,
  ) async {
    for (final ComponentPreview preview in pinnedSheetPreviews) {
      for (final String preset in const <String>['neutral', 'claude']) {
        for (final Brightness brightness in Brightness.values) {
          await _pumpPreview(
            tester,
            preview,
            preset: preset,
            brightness: brightness,
          );
        }
      }
    }
  });

  testWidgets('Default sheet drags between stages', (tester) async {
    await _pumpPreview(tester, pinnedSheetPreviews[0]);
    expect(find.byType(PinnedSheet), findsOneWidget);
    expect(find.text('Bottom sheet'), findsOneWidget);
    final double open = tester.getTopLeft(find.text('Bottom sheet')).dy;
    // The bottom sheet starts expanded, so its body fills the 220px stage;
    // dragging down past the stage snaps it to `closed` and it slides out.
    await tester.drag(find.byType(PinnedSheet), const Offset(0, 300));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.takeException(), isNull);
    final double closed = tester.getTopLeft(find.text('Bottom sheet')).dy;
    expect(closed, greaterThan(open));
    // Driving it back from the trigger row returns it to the expanded stage.
    await tester.tap(find.text('Open sheet'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.takeException(), isNull);
    expect(tester.getTopLeft(find.text('Bottom sheet')).dy, closeTo(open, 0.5));
  });

  testWidgets('Snapping buttons move the sheet without exceptions', (
    tester,
  ) async {
    // The snap-points example is the one with the live fraction readout.
    await _pumpPreview(tester, pinnedSheetPreviews[4]);
    expect(find.text('40% open'), findsOneWidget);
    for (final MapEntry<String, String> step
        in const <MapEntry<String, String>>[
          MapEntry<String, String>('Open sheet', '100% open'),
          MapEntry<String, String>('Half', '40% open'),
          MapEntry<String, String>('Close', '0% open'),
          MapEntry<String, String>('Open sheet', '100% open'),
        ]) {
      await tester.tap(find.text(step.key));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull, reason: step.key);
      expect(find.text(step.value), findsOneWidget, reason: step.key);
    }
    expect(find.text('Sheet content'), findsNothing);
    expect(find.text('Snap points'), findsOneWidget);
  });

  testWidgets('previews mirror in RTL and fit 375px', (tester) async {
    for (final ComponentPreview preview in pinnedSheetPreviews) {
      await _pumpPreview(tester, preview, direction: TextDirection.rtl);
      await _pumpPreview(tester, preview, width: 375);
    }
  });
}
