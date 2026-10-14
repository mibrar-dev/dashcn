// Theme Studio import/export widget tests: paste → preview → apply,
// invalid input leaves the theme untouched, and every Export tab copies its
// writer's payload.

import 'package:docs/routing/docs_router.dart';
import 'package:docs/theme/theme_interop_bridge.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/components/text_area/text_area.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

const String _kSampleCss =
    ':root { '
    '--background: #ffffff; --foreground: #0a0a0a; --radius: 0.5rem; } '
    '.dark { --background: #0a0a0a; --foreground: #fafafa; }';

Future<DocsRouterDelegate> _openThemes(WidgetTester tester) async {
  final DocsRouterDelegate delegate = await pumpDocsApp(tester);
  await goTo(tester, delegate, '/themes');
  return delegate;
}

void _pasteImport(WidgetTester tester, String source) {
  final TextArea area = tester.widget<TextArea>(
    find.byKey(const ValueKey<String>('theme-import-input')),
  );
  area.controller!.text = source;
}

void main() {
  group('Import dialog', () {
    testWidgets('paste shows a live preview, report and applies', (
      WidgetTester tester,
    ) async {
      await _openThemes(tester);
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();
      expect(find.text('Import Web Theme'), findsOneWidget);

      // Empty paste: Apply is disabled.
      expect(
        tester
            .widget<Button>(
              find.byKey(const ValueKey<String>('theme-import-apply')),
            )
            .onPressed,
        isNull,
      );

      _pasteImport(tester, _kSampleCss);
      await tester.pumpAndSettle();

      expect(
        tester
            .widget<Button>(
              find.byKey(const ValueKey<String>('theme-import-apply')),
            )
            .onPressed,
        isNotNull,
      );

      expect(
        find.byKey(const ValueKey<String>('theme-import-preview')),
        findsOneWidget,
      );
      expect(find.textContaining('mapped 5 ·'), findsOneWidget);
      expect(find.textContaining('IgnoredEntry'), findsNothing);

      await tester.tap(
        find.byKey(const ValueKey<String>('theme-import-apply')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Import Web Theme'), findsNothing);
      expect(docsState.presetId, 'imported');
      expect(docsState.themeModel.document.radius, 0.5);
    });

    testWidgets('an invalid preset paste shows the reason', (
      WidgetTester tester,
    ) async {
      await _openThemes(tester);
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();

      _pasteImport(
        tester,
        '{"id":"broken","schemaVersion":2,"light":{},"dark":{}}',
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('preset.'), findsOneWidget);
      expect(docsState.presetId, 'neutral', reason: 'theme untouched');
    });
  });

  group('Export tabs', () {
    testWidgets('every web tab copies its writer payload', (
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

      await _openThemes(tester);
      await tester.tap(
        find.byKey(const ValueKey<String>('theme-rail-get-code')),
      );
      await tester.pumpAndSettle();

      for (final (String label, WebExportFormat format)
          in <(String, WebExportFormat)>[
            ('Web CSS (v4)', WebExportFormat.webCss),
            ('Tailwind v4', WebExportFormat.tailwind),
            ('Tokens (DTCG)', WebExportFormat.dtcg),
          ]) {
        await tester.ensureVisible(find.text(label));
        await tester.pumpAndSettle();
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Copy'));
        await tester.pump();
        expect(
          copied.last,
          exportWebTheme(docsState.themeModel.document, format),
        );
      }
      expect(
        find.byKey(const ValueKey<String>('get-code-download')),
        findsOneWidget,
      );

      // The CLI tab is a guide, so it has no download button.
      await tester.tap(find.text('CLI'));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey<String>('get-code-download')),
        findsNothing,
      );
    });
  });
}
