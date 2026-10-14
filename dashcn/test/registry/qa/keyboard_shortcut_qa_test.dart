// QA for `keyboard_shortcut` previews (P7-Q2, P7-WC).
//
// Pumps every `keyboardShortcutPreviews` example under neutral/claude x
// light/dark, RTL and 375px. The component is display-only; this file pins
// that activator chords, explicit key rows, sequences, the menu-item hint
// and scoped labels all render centred.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/keyboard_shortcut/keyboard_shortcut.dart';
import 'package:dashcn/src/components/keyboard_shortcut/preview.dart';
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
    for (final ComponentPreview preview in keyboardShortcutPreviews) {
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

  testWidgets('the default chord renders ⌘K', (tester) async {
    await _pumpPreview(tester, keyboardShortcutPreviews[0]);
    expect(find.byType(KeyboardShortcut), findsOneWidget);
    expect(find.byType(KeyboardKeyCap), findsNWidgets(2));
    expect(find.text('K'), findsOneWidget);
  });

  testWidgets('the modifiers chord renders Ctrl Shift P in order', (
    tester,
  ) async {
    await _pumpPreview(tester, keyboardShortcutPreviews[1]);
    expect(find.byType(KeyboardShortcut), findsOneWidget);
    expect(find.byType(KeyboardKeyCap), findsNWidgets(3));
    expect(find.text('Ctrl'), findsOneWidget);
    expect(find.text('Shift'), findsOneWidget);
    expect(find.text('P'), findsOneWidget);
    expect(
      tester.getRect(find.text('Ctrl')).left,
      lessThan(tester.getRect(find.text('P')).left),
    );
  });

  testWidgets('the sequence renders G then H as separate chords', (
    tester,
  ) async {
    await _pumpPreview(tester, keyboardShortcutPreviews[2]);
    expect(find.byType(KeyboardShortcut), findsNWidgets(2));
    expect(find.text('G'), findsOneWidget);
    expect(find.text('H'), findsOneWidget);
    expect(find.text('then'), findsOneWidget);
  });

  testWidgets('the menu item trails its ⌘K hint', (tester) async {
    await _pumpPreview(tester, keyboardShortcutPreviews[3]);
    expect(find.text('Open command palette'), findsOneWidget);
    expect(find.byType(KeyboardShortcut), findsOneWidget);
  });

  testWidgets('scoped preview uses the custom uppercase labels', (
    tester,
  ) async {
    await _pumpPreview(tester, keyboardShortcutPreviews[4]);
    // Alt + F through the scope builder render as uppercase text.
    expect(find.text('ALT'), findsOneWidget);
    expect(find.text('F'), findsOneWidget);
  });

  testWidgets('the ghost preview paints the same chord with no fill', (
    tester,
  ) async {
    // P7-WC2: the fill-free variant used for hints on filled surfaces.
    await _pumpPreview(tester, keyboardShortcutPreviews[6]);
    expect(find.byType(KeyboardShortcut), findsOneWidget);
    expect(find.byType(KeyboardKeyCap), findsNWidgets(2));
    expect(find.text('K'), findsOneWidget);
  });

  testWidgets('previews mirror in RTL and fit 375px', (tester) async {
    for (final ComponentPreview preview in keyboardShortcutPreviews) {
      await _pumpPreview(tester, preview, direction: TextDirection.rtl);
      await _pumpPreview(tester, preview, width: 375);
    }
  });
}
