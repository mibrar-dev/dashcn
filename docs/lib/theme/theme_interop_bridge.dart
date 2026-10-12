// Web-theme import/export bridge for the Theme Studio (pure logic).
//
// Converts between the studio's [ThemeDocument] and the kit's [WebTheme]
// (the mirrored `ui/dashcn/theme/interop/` layer, used through its public
// `interop.dart` surface only), detects pasted/file sources (CSS,
// Tailwind v3 config, preset JSON) and renders the three web export formats.

import 'dart:convert';

import '../ui/dashcn/theme/interop/interop.dart';
import 'theme_document.dart';

/// The detected shape of an imported web-theme source.
enum WebImportFormat {
  /// `:root` + `.dark` CSS (v3 triplets, v4/modern, or Tailwind v4 `@theme`).
  css('CSS'),

  /// A Tailwind v3 config (`theme.extend.colors` object literal).
  tailwindV3('Tailwind v3 config'),

  /// A schema-v2 preset document (the JSON tab of Get Code).
  presetJson('Preset JSON');

  const WebImportFormat(this.label);

  /// Human readable format name for the import dialog.
  final String label;
}

/// One parsed import: the document to preview/apply, the report to show,
// and the detected format.
final class WebImportResult {
  /// Creates the result.
  const WebImportResult({
    required this.document,
    required this.report,
    required this.format,
  });

  /// The imported theme as a studio document (fallbacks already filled).
  final ThemeDocument document;

  /// What the import mapped, defaulted and ignored — never silent.
  final ImportReport report;

  /// The detected source shape.
  final WebImportFormat format;
}

/// The three web export formats of the Export tabs.
enum WebExportFormat {
  /// `:root` + `.dark` CSS.
  webCss('Web CSS (v4)', 'css', 'theme.css'),

  /// Tailwind v4 CSS with an `@theme inline` alias block.
  tailwind('Tailwind v4', 'css', 'theme.tailwind.css'),

  /// W3C DTCG `.tokens.json` (one token set per mode).
  dtcg('Tokens (DTCG)', 'json', 'theme.tokens.json');

  const WebExportFormat(this.label, this.language, this.filename);

  /// The Export tab label.
  final String label;

  /// The syntax-highlight language id.
  final String language;

  /// The download file name.
  final String filename;
}

/// Reads [document] (always schema-complete) as a kit [WebTheme].
WebTheme webThemeFromDocument(ThemeDocument document) =>
    webThemeFromPresetJson(document.toJson());

/// Reads a kit [theme] as a studio document with [id]/[name].
ThemeDocument documentFromWebTheme(
  WebTheme theme, {
  required String id,
  required String name,
}) {
  final Object? decoded = jsonDecode(
    presetJsonStringFromWebTheme(theme, id: id, name: name),
  );
  return ThemeDocument.fromJson(
    (decoded as Map).map(
      (Object? key, Object? value) => MapEntry(key.toString(), value),
    ),
  );
}

/// Renders [document] in [format] for the Export tabs.
String exportWebTheme(ThemeDocument document, WebExportFormat format) {
  final WebTheme theme = webThemeFromDocument(document);
  return switch (format) {
    WebExportFormat.webCss => writeWebCss(theme),
    WebExportFormat.tailwind => writeTailwindV4Theme(theme),
    WebExportFormat.dtcg => writeDtcgTokens(theme),
  };
}

/// Parses a pasted or picked web-theme [source] into a previewable document
/// plus its report. Never returns a partial document: parsers complete with
/// fallbacks and record every fill.
///
/// Throws [FormatException] on undecodable JSON-shaped input and
/// [ThemeDocumentException] on preset-shaped but invalid documents; CSS and
/// Tailwind v3 sources degrade into report entries instead.
WebImportResult parseWebThemeSource(
  String source, {
  String id = 'imported',
  String name = 'Imported web theme',
}) {
  final String trimmed = source.trim();
  if (trimmed.isEmpty) {
    throw const FormatException('Paste a CSS, JS or JSON theme first');
  }
  final ThemeDocument? preset = _tryPresetDocument(trimmed);
  if (preset != null) {
    return WebImportResult(
      document: preset,
      report: _presetReport(preset),
      format: WebImportFormat.presetJson,
    );
  }
  if (_looksLikeTailwindV3(trimmed)) {
    final TailwindV3Result parsed = parseTailwindV3Theme(source);
    return WebImportResult(
      document: documentFromWebTheme(parsed.theme, id: id, name: name),
      report: parsed.report,
      format: WebImportFormat.tailwindV3,
    );
  }
  final CssThemeResult parsed = parseCssTheme(source);
  return WebImportResult(
    document: documentFromWebTheme(parsed.theme, id: id, name: name),
    report: parsed.report,
    format: WebImportFormat.css,
  );
}

/// The preset document in [trimmed], or null when it is not preset-shaped.
///
/// Preset-shaped but invalid documents throw [ThemeDocumentException] (shown
/// verbatim by the dialog); anything else falls through to the CSS/v3 path.
ThemeDocument? _tryPresetDocument(String trimmed) {
  if (!trimmed.startsWith('{')) {
    return null;
  }
  Object? decoded;
  try {
    decoded = jsonDecode(trimmed);
  } on FormatException {
    return null;
  }
  if (decoded is! Map || !_isPresetMap(decoded)) {
    return null;
  }
  return ThemeDocument.fromJson(
    decoded.map(
      (Object? key, Object? value) => MapEntry(key.toString(), value),
    ),
  );
}

bool _isPresetMap(Map<Object?, Object?> map) =>
    map['schemaVersion'] == 2 && map['light'] is Map && map['dark'] is Map;

/// Whether [source] reads as a Tailwind v3 config rather than CSS.
bool _looksLikeTailwindV3(String source) =>
    source.contains('module.exports') ||
    source.contains('tailwind.config') ||
    (source.contains('extend') && source.contains('colors')) ||
    (source.contains('colors') && source.contains('DEFAULT')) ||
    (source.contains('colors:') && source.contains('{'));

/// A report for a preset-JSON import: every token came from the source, so
/// everything is `mapped` and nothing is defaulted or ignored.
ImportReport _presetReport(ThemeDocument document) {
  final ImportReport report = ImportReport();
  for (final String mode in const <String>['light', 'dark']) {
    for (final String token in document.light.keys) {
      report.mapped.add(MappedEntry('preset.$mode.$token', '$mode.$token'));
    }
  }
  for (final String scalar in const <String>[
    'radius',
    'spacing',
    'tracking.normal',
  ]) {
    report.mapped.add(MappedEntry('preset.$scalar', scalar));
  }
  for (final String slot in document.fonts.keys) {
    report.mapped.add(MappedEntry('preset.fonts.$slot', 'fonts.$slot'));
  }
  if (document.tracking.containsKey('tight')) {
    report.mapped.add(const MappedEntry('preset.tracking.tight', 'tracking'));
  }
  if (document.tracking.containsKey('wide')) {
    report.mapped.add(const MappedEntry('preset.tracking.wide', 'tracking'));
  }
  return report;
}
