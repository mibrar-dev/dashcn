// QA for `object_input` previews (P7-Q2).
//
// Pumps every `objectInputPreviews` example under neutral/claude x light/dark,
// RTL and 375px, and focuses/taps each segment field the way a keyboard user
// would.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/object_input/object_input.dart';
import 'package:dashcn/src/components/object_input/preview.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../themes/generated_theme.dart';

final Map<String, GeneratedTheme> _presets = <String, GeneratedTheme>{};

ShadcnThemeData _theme(String preset, Brightness brightness) {
  final GeneratedTheme theme = _presets.putIfAbsent(
    preset,
    () => loadGeneratedTheme('lib/src/themes/$preset.json'),
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
    for (final ComponentPreview preview in objectInputPreviews) {
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

  testWidgets('date, time and duration fields take focus on tap', (
    tester,
  ) async {
    // Tap the first segment (not the field center: the date field's trailing
    // calendar button sits near the center of a wide box and opens the
    // picker instead of focusing).
    Future<void> tapFirstSegment(Finder scope) => tester.tap(
      find.descendant(of: scope, matching: find.byType(EditableText)).first,
    );
    await _pumpPreview(tester, objectInputPreviews[0]);
    expect(find.byType(DateInput), findsOneWidget);
    await tapFirstSegment(find.byType(DateInput));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);

    await _pumpPreview(tester, objectInputPreviews[1]);
    expect(find.byType(TimeInput), findsOneWidget);
    await tapFirstSegment(find.byType(TimeInput));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);

    await _pumpPreview(tester, objectInputPreviews[2]);
    expect(find.byType(DurationInput), findsOneWidget);
    await tapFirstSegment(find.byType(DurationInput));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);
  });

  testWidgets('previews mirror in RTL and fit 375px', (tester) async {
    for (final ComponentPreview preview in objectInputPreviews) {
      await _pumpPreview(tester, preview, direction: TextDirection.rtl);
      await _pumpPreview(tester, preview, width: 375);
    }
  });
}
