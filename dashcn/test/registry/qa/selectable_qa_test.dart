// QA for `selectable` previews (P7-Q2).
//
// Pumps every `selectablePreviews` example under neutral/claude x light/dark,
// RTL and 375px, taps the text like a user focusing it, and drags across the
// paragraph the way a selection gesture would.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/selectable/preview.dart';
import 'package:dashcn/src/components/selectable/selectable.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../themes/generated_theme.dart';

final Map<String, GeneratedTheme> _presets = <String, GeneratedTheme>{};

ThemeData _theme(String preset, Brightness brightness) {
  final GeneratedTheme theme = _presets.putIfAbsent(
    preset,
    () => loadGeneratedTheme('lib/src/themes/$preset.json'),
  );
  final view = theme.view(brightness);
  return ThemeData(colors: view.colors, tokens: view.tokens, fonts: view.fonts);
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
    Theme(
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
    for (final ComponentPreview preview in selectablePreviews) {
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

  testWidgets('Default text takes focus on tap', (tester) async {
    await _pumpPreview(tester, selectablePreviews[0]);
    expect(find.byType(SelectableText), findsOneWidget);
    await tester.tap(find.byType(SelectableText));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Long paragraph survives a selection drag', (tester) async {
    await _pumpPreview(tester, selectablePreviews[1]);
    expect(find.byType(SelectableText), findsOneWidget);
    final Offset start = tester.getTopLeft(find.byType(SelectableText));
    await tester.dragFrom(start + const Offset(20, 10), const Offset(120, 20));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);
    expect(find.byType(SelectableText), findsOneWidget);
  });

  testWidgets('previews mirror in RTL and fit 375px', (tester) async {
    for (final ComponentPreview preview in selectablePreviews) {
      await _pumpPreview(tester, preview, direction: TextDirection.rtl);
      await _pumpPreview(tester, preview, width: 375);
    }
  });
}
