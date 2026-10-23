// Script-subset loader coverage: every locale the language switcher offers
// must either ride the bundled families (Geist covers its tables and the
// engine's global fallback chain handles the rest) or have a committed
// FontLoader subset that registers for its script — so no offered locale
// can ever boot into tofu if fonts.gstatic.com is unreachable.
//
// The manifest lockstep test keeps scripts/subset_script_fonts.py and
// lib/theme/script_fonts.dart in agreement: regenerating the subsets with
// a new locale table fails the gate until the constant map matches the
// committed manifest.

import 'dart:convert';
import 'dart:ui' show Locale;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:docs/state/docs_strings.dart';
import 'package:docs/theme/script_fonts.dart';
import 'package:docs/ui/dashcn/primitives/localizations/localizations.dart'
    show ComponentLocalizations;

/// The generator's TAG_TO_FONT table (scripts/subset_script_fonts.py).
const Map<String, String> kGeneratorTagToFont = <String, String>{
  'ar': 'arabic',
  'fa': 'arabic',
  'ps': 'arabic',
  'ur': 'arabic',
  'he': 'hebrew',
  'hi': 'devanagari',
  'mr': 'devanagari',
  'bn': 'bengali',
  'ta': 'tamil',
  'te': 'telugu',
  'th': 'thai',
  'ko': 'korean',
  'ja': 'japanese',
  'zh': 'chinese-sc',
  'zh_Hans': 'chinese-sc',
  'zh_Hant': 'chinese-tc',
};

/// Locales whose codepoints ride the bundled Geist cuts plus
/// [kDocsGlobalScriptFont]
const Set<String> kLatinLocaleTags = <String>{
  'en',
  'cs',
  'da',
  'de',
  'es',
  'fi',
  'fil',
  'fr',
  'hu',
  'id',
  'it',
  'ms',
  'nb',
  'nl',
  'pl',
  'pt',
  'pt_BR',
  'ro',
  'sk',
  'sv',
  'tr',
  'vi',
  // Cyrillic/Greek locales: their codepoints do not ship in Geist but the
  // always-loaded global subset (css2 `Noto Sans`) covers them.
  'bg',
  'el',
  'ru',
  'uk',
};

/// Same list for the per-tag maps: docsLocaleTag of these locales resolves
/// against the bundled families; the others ride the global subset.

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('every supported locale has glyph coverage without gstatic', () {
    for (final Locale locale in ComponentLocalizations.supportedLocales) {
      final String tag = docsLocaleTag(locale);
      final ScriptFontSpec? spec = docsScriptFontFor(locale);
      if (kLatinLocaleTags.contains(tag)) {
        continue; // Geist + the global subset cover these tables.
      }
      expect(
        spec,
        isNotNull,
        reason: 'script subset missing for the offered locale "$tag"',
      );
      final String family = spec!.family;
      expect(family, isNot('Roboto'), reason: 'no Material family bundling');
    }
  });

  test('loader tags mirror the generator table (lockstep)', () {
    expect(kDocsScriptFonts.keys.toSet(), kGeneratorTagToFont.keys.toSet());
    for (final MapEntry<String, ScriptFontSpec> entry
        in kDocsScriptFonts.entries) {
      final String key = kGeneratorTagToFont[entry.key]!;
      expect(
        fontFileStub[key],
        entry.value.asset.split('/').last,
        reason: 'tag ${entry.key} file must match the generator',
      );
      expect(entry.value.family, startsWith('DocsNoto'));
    }
  });

  test('the manifest agrees with the loader constants', () async {
    final ByteData manifestData = await rootBundle.load(
      'assets/fonts/script/manifest.json',
    );
    final Map<String, dynamic> manifest =
        jsonDecode(utf8.decode(manifestData.buffer.asUint8List()))
            as Map<String, dynamic>;
    final Map<String, dynamic> fonts =
        manifest['fonts'] as Map<String, dynamic>;

    // Every generated file the loader maps exists in the manifest with the
    // same Flutter family.
    for (final ScriptFontSpec spec in <ScriptFontSpec>[
      kDocsGlobalScriptFont,
      ...kDocsScriptFonts.values,
    ]) {
      final String file = spec.asset.split('/').last;
      final Map<String, dynamic>? entry = fonts.entries
          .map((MapEntry<String, dynamic> e) => e.value as Map<String, dynamic>)
          .cast<Map<String, dynamic>?>()
          .firstWhere(
            (Map<String, dynamic>? e) => (e!['file'] as String) == file,
            orElse: () => null,
          );
      expect(entry, isNotNull, reason: 'manifest missing "$file"');
      expect(
        entry!['family'] as String,
        spec.family,
        reason: 'family mismatch for "$file"',
      );
      expect((entry['bytes'] as int), greaterThan(1000));
    }

    // And every manifest font the loader maps by tag: same family per tag.
    for (final MapEntry<String, dynamic> name in fonts.entries) {
      final Map<String, dynamic> entry = name.value as Map<String, dynamic>;
      if (name.key == 'global') {
        continue;
      }
      final List<String> tags = (entry['locales'] as List<dynamic>)
          .cast<String>();
      for (final String tag in tags) {
        final ScriptFontSpec? spec = kDocsScriptFonts[tag];
        expect(spec, isNotNull, reason: 'manifest tag "$tag" unmapped');
        expect(
          spec!.family,
          (entry['family'] as String),
          reason: 'family mismatch for tag "$tag"',
        );
        expect(spec.asset.split('/').last, entry['file'] as String);
      }
    }
  });

  test('committed subsets exist, are non-empty and parse as woff2', () async {
    final Set<String> assets = <String>{
      kDocsGlobalScriptFont.asset,
      ...kDocsScriptFonts.values.map((ScriptFontSpec spec) => spec.asset),
    };
    for (final String asset in assets) {
      final ByteData data = await rootBundle.load(asset);
      expect(data.lengthInBytes, greaterThan(1000), reason: '$asset truncated');
      // woff2 magic ("wOF2"): a corrupt copy fails the gate instead of boot.
      final List<int> magic = data.buffer.asUint8List().take(4).toList();
      expect(magic, <int>[0x77, 0x4F, 0x46, 0x32], reason: asset);
    }
  });
}

/// The generator's output file names (keys of FONT_FILE).
final Map<String, String> fontFileStub = <String, String>{
  'arabic': 'arabic.woff2',
  'hebrew': 'hebrew.woff2',
  'devanagari': 'devanagari.woff2',
  'bengali': 'bengali.woff2',
  'tamil': 'tamil.woff2',
  'telugu': 'telugu.woff2',
  'thai': 'thai.woff2',
  'korean': 'korean.woff2',
  'japanese': 'japanese.woff2',
  'chinese-sc': 'chinese-sc.woff2',
  'chinese-tc': 'chinese-tc.woff2',
};
