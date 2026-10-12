// Theme Studio web-theme bridge tests: every P9-4a fixture parses with the
// pinned report counts, preset JSON round-trips losslessly, the Export tabs
// equal the kit writers' output, and garbage degrades into reports.

import 'dart:io';

import 'package:docs/generated/docs_preset_sources.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/theme/theme_document.dart';
import 'package:docs/theme/theme_interop_bridge.dart';
import 'package:docs/ui/dashcn/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

String _fixture(String name) => File(
  '${Directory.current.path}/../dashcn/test/registry/theme/interop/fixtures/$name',
).readAsStringSync();

void main() {
  group('fixture imports', () {
    test('v3 classic CSS', () {
      final WebImportResult result = parseWebThemeSource(
        _fixture('v3_classic.css'),
      );
      expect(result.format, WebImportFormat.css);
      expect(result.report.mapped.length, 65);
      expect(result.report.defaulted.length, 4);
      expect(result.report.ignored.length, 0);
      expect(result.document.light.length, 32);
      expect(result.document.dark.length, 32);
    });

    test('v4 modern CSS', () {
      final WebImportResult result = parseWebThemeSource(
        _fixture('v4_modern.css'),
      );
      expect(result.format, WebImportFormat.css);
      expect(result.report.mapped.length, 68);
      expect(result.report.defaulted.length, 4);
      expect(result.report.ignored.length, 0);
    });

    test('tweakcn-style CSS', () {
      final WebImportResult result = parseWebThemeSource(
        _fixture('tweakcn_style.css'),
      );
      expect(result.format, WebImportFormat.css);
      expect(result.report.mapped.length, 85);
      expect(result.report.defaulted.length, 4);
      expect(result.report.ignored.length, 15);
    });

    test('tailwind v4 @theme CSS', () {
      final WebImportResult result = parseWebThemeSource(
        _fixture('tailwind_v4_theme.css'),
      );
      expect(result.format, WebImportFormat.css);
      expect(result.report.mapped.length, 18);
      expect(result.report.defaulted.length, 58);
      expect(result.report.ignored.length, 5);
    });

    test('tailwind v3 config', () {
      final WebImportResult result = parseWebThemeSource(
        _fixture('tailwind_v3_config.js'),
      );
      expect(result.format, WebImportFormat.tailwindV3);
      expect(result.report.mapped.length, 1);
      expect(result.report.defaulted.length, 67);
      expect(result.report.ignored.length, 37);
    });
  });

  group('preset JSON imports', () {
    test('the neutral preset round-trips losslessly', () {
      final String source = kPresetSources['neutral']!.json;
      final WebImportResult result = parseWebThemeSource(source);
      expect(result.format, WebImportFormat.presetJson);
      expect(result.report.defaulted, isEmpty);
      expect(result.report.ignored, isEmpty);
      expect(result.report.mapped.length, greaterThanOrEqualTo(67));
      expect(result.document.json, source);
    });

    test('a preset-shaped but invalid document throws', () {
      expect(
        () => parseWebThemeSource(
          '{"id":"broken","schemaVersion":2,"light":{},"dark":{}}',
        ),
        throwsA(isA<ThemeDocumentException>()),
      );
    });
  });

  group('degraded input', () {
    test('empty input asks for a theme', () {
      expect(() => parseWebThemeSource('   '), throwsA(isA<FormatException>()));
    });

    test('garbage becomes defaults, never a throw', () {
      final WebImportResult result = parseWebThemeSource('{{{garbage(((;');
      expect(result.format, WebImportFormat.css);
      expect(result.report.mapped, isEmpty);
      expect(result.report.defaulted, isNotEmpty);
      expect(result.document.light.length, 32);
      expect(result.document.dark.length, 32);
    });

    test('unresolvable references are ignored with reasons', () {
      final WebImportResult result = parseWebThemeSource(
        ':root { --primary: var(--missing); --radius: 0.5rem; }',
      );
      expect(
        result.report.ignored.map((IgnoredEntry e) => e.variable),
        contains('--primary'),
      );
      expect(result.document.radius, 0.5);
    });
  });

  group('export payloads', () {
    test('each web tab equals its writer output', () {
      final DocsState state = DocsState(storage: MemoryDocsStorage());
      addTearDown(state.dispose);
      final ThemeDocument document = state.themeModel.document;
      final WebTheme theme = webThemeFromDocument(document);
      expect(
        exportWebTheme(document, WebExportFormat.webCss),
        writeWebCss(theme),
      );
      expect(
        exportWebTheme(document, WebExportFormat.tailwind),
        writeTailwindV4Theme(theme),
      );
      expect(
        exportWebTheme(document, WebExportFormat.dtcg),
        writeDtcgTokens(theme),
      );
    });

    test('paste-apply round-trips through the model', () {
      final DocsState state = DocsState(storage: MemoryDocsStorage());
      addTearDown(state.dispose);
      final WebImportResult result = parseWebThemeSource(
        _fixture('v4_modern.css'),
      );
      state.themeModel.applyDocument(result.document);
      expect(state.themeModel.document.json, result.document.json);
      expect(state.presetId, 'imported');
    });
  });
}
