// Preset-string sharing tests: the Get Code `Preset string` tab prints the
// live `dcn1_` string of the builder document, the string round-trips to
// identical tokens, it updates on every token change, and both `--preset`
// commands carry it prefilled.

import 'dart:convert';

import 'package:docs/generated/docs_preset_sources.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/theme/preset_share.dart';
import 'package:docs/theme/theme_document.dart';
import 'package:docs/ui/dashcn/theme/interop/interop.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

void main() {
  group('preset share payloads', () {
    test('the string carries the dcn1_ prefix and decodes identically', () {
      final DocsState state = DocsState(storage: MemoryDocsStorage());
      addTearDown(state.dispose);
      final ThemeDocument document = state.themeModel.document;
      final String preset = presetStringFromDocument(document);
      expect(preset, startsWith(kPresetStringPrefix));
      expect(decodePresetString(preset), document.toJson());
    });

    test('the string updates on every token change', () {
      final DocsState state = DocsState(storage: MemoryDocsStorage());
      addTearDown(state.dispose);
      final String before = presetStringFromDocument(state.themeModel.document);
      state.themeModel.setRadiusPx(0);
      final String after = presetStringFromDocument(state.themeModel.document);
      expect(after, isNot(before));
      expect(after, startsWith(kPresetStringPrefix));
      expect(decodePresetString(after), state.themeModel.document.toJson());
    });

    test('both commands carry the string prefilled', () {
      const String preset = 'dcn1_example';
      expect(presetApplyCommand(preset), 'dashcn apply --preset dcn1_example');
      expect(
        presetUpdateCommand(preset),
        'dashcn update --preset dcn1_example',
      );
      final DocsState state = DocsState(storage: MemoryDocsStorage());
      addTearDown(state.dispose);
      final String guide = presetShareGuide(state.themeModel.document);
      final String live = presetStringFromDocument(state.themeModel.document);
      expect(guide, contains(live));
      expect(guide, contains(presetApplyCommand(live)));
      expect(guide, contains(presetUpdateCommand(live)));
    });

    test('every registry preset string decodes to identical tokens', () {
      for (final DocsPresetSource source in kPresetSources.values) {
        final ThemeDocument document = ThemeDocument.fromJson(
          (jsonDecode(source.json) as Map).map(
            (Object? key, Object? value) => MapEntry(key.toString(), value),
          ),
        );
        expect(
          decodePresetString(presetStringFromDocument(document)),
          document.toJson(),
          reason: source.id,
        );
      }
    });
  });

  group('Get Code preset tab', () {
    testWidgets('shows the live string and both prefilled commands', (
      WidgetTester tester,
    ) async {
      final List<String> copied = <String>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall call) async {
          if (call.method == 'Clipboard.setData') {
            copied.add(
              (call.arguments as Map<Object?, Object?>)['text']! as String,
            );
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );

      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/themes');
      await tester.tap(
        find.byKey(const ValueKey<String>('theme-rail-get-code')),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Preset string'));
      await tester.pumpAndSettle();

      final String live = presetStringFromDocument(
        docsState.themeModel.document,
      );
      expect(live, startsWith('dcn1_'));
      expect(find.text(live), findsOneWidget);
      expect(find.text(presetApplyCommand(live)), findsOneWidget);
      expect(find.text(presetUpdateCommand(live)), findsOneWidget);

      // The in-pane copy button writes exactly the string.
      await tester.tap(
        find.byKey(const ValueKey<String>('preset-string-copy')),
      );
      await tester.pump();
      expect(copied.last, live);

      // A rail edit while the dialog is open updates the string live.
      docsState.themeModel.setRadiusPx(0);
      await tester.pumpAndSettle();
      final String updated = presetStringFromDocument(
        docsState.themeModel.document,
      );
      expect(updated, isNot(live));
      expect(find.text(updated), findsOneWidget);
    });
  });
}
