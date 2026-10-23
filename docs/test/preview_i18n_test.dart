// Preview i18n tests: the sample-string table, locale fallback, RTL scoping and
// completeness of the JSON sources in docs/i18n/samples/.

import 'dart:convert';
import 'dart:io';

import 'package:docs/generated/docs_sample_table.dart';
import 'package:docs/state/docs_sample_strings.dart';
import 'package:docs/ui/dashcn/foundation/component_preview.dart';
import 'package:docs/widgets/preview_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const Locale _zhHant = Locale.fromSubtags(
  languageCode: 'zh',
  scriptCode: 'Hant',
);
const Locale _zhHans = Locale.fromSubtags(
  languageCode: 'zh',
  scriptCode: 'Hans',
);
const Locale _ar = Locale('ar');
const Locale _de = Locale('de');
const Locale _en = Locale('en');

/// Keys every translated locale must cover (the visual check uses these).
const List<String> _spotKeys = <String>[
  'Settings',
  'Profile',
  'Show popup',
  'Open action sheet',
  'Cancel',
  'Save',
  'Minimum Payout Amount',
  'Notes',
];

Map<String, String> _readJson(String name) {
  final Object? decoded = jsonDecode(
    File('i18n/samples/$name.json').readAsStringSync(),
  );
  return (decoded as Map<String, Object?>).map(
    (String k, Object? v) => MapEntry(k, v as String),
  );
}

void main() {
  setUp(installDocsSampleResolver);

  group('sample-string table', () {
    test('translated locales return their own text', () {
      expect(docsSampleString(_zhHant, 'Settings'), '設定');
      expect(docsSampleString(_ar, 'Settings'), 'الإعدادات');
      expect(docsSampleString(_de, 'Settings'), 'Einstellungen');
    });

    test('a key without a translation falls back to English', () {
      expect(docsSampleString(_zhHans, 'Settings'), 'Settings');
      expect(docsSampleString(const Locale('ur'), 'Settings'), 'Settings');
      expect(docsSampleString(const Locale('fa'), 'Settings'), 'Settings');
      expect(docsSampleString(const Locale('ps'), 'Settings'), 'Settings');
    });

    test('an unknown key returns itself', () {
      expect(docsSampleString(_de, 'No such sample key'), 'No such sample key');
    });

    test('Traditional Chinese never leaks into Simplified Chinese', () {
      for (final String key in _spotKeys) {
        expect(
          docsSampleString(_zhHans, key),
          isNot(docsSampleString(_zhHant, key)),
          reason: key,
        );
      }
    });
  });

  group('locale switching', () {
    testWidgets('switching the locale changes the listed strings', (
      WidgetTester tester,
    ) async {
      Widget preview(Locale locale) => PreviewScope(
        locale: locale,
        child: Builder(
          builder: (BuildContext context) => Column(
            children: <Widget>[
              for (final String key in _spotKeys)
                Text(docsSample(context, key), key: ValueKey<String>(key)),
            ],
          ),
        ),
      );

      final Map<String, String> seen = <String, String>{};
      for (final Locale locale in <Locale>[_en, _zhHant, _ar, _de]) {
        await tester.pumpWidget(preview(locale));
        seen[locale.toLanguageTag()] = tester
            .widget<Text>(find.byKey(const ValueKey<String>('Settings')))
            .data!;
      }
      expect(seen['en'], 'Settings');
      expect(seen['zh-Hant'], '設定');
      expect(seen['ar'], 'الإعدادات');
      expect(seen['de'], 'Einstellungen');
      expect(seen.values.toSet().length, 4, reason: 'every locale differs');
    });

    testWidgets('Arabic is laid out right to left, German left to right', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        PreviewScope(
          locale: _ar,
          child: Builder(
            builder: (BuildContext context) =>
                Text(Directionality.of(context).name),
          ),
        ),
      );
      expect(
        Directionality.of(tester.element(find.byType(Text))),
        TextDirection.rtl,
      );

      await tester.pumpWidget(
        PreviewScope(
          locale: _de,
          child: Builder(
            builder: (BuildContext context) => const SizedBox.shrink(),
          ),
        ),
      );
      expect(
        Directionality.of(tester.element(find.byType(SizedBox))),
        TextDirection.ltr,
      );
    });
  });

  group('completeness', () {
    final Map<String, String> english = _readJson('en');

    test('every locale file only uses keys from en.json', () {
      final Directory dir = Directory('i18n/samples');
      for (final FileSystemEntity entity in dir.listSync()) {
        final String name = entity.uri.pathSegments.last;
        if (!name.endsWith('.json') || name == 'en.json') {
          continue;
        }
        final Map<String, String> table = _readJson(
          name.substring(0, name.length - '.json'.length),
        );
        expect(
          english.keys.toSet().containsAll(table.keys),
          isTrue,
          reason: '$name has keys that are not in en.json',
        );
        for (final MapEntry<String, String> entry in table.entries) {
          expect(entry.value.trim(), isNotEmpty, reason: '$name: ${entry.key}');
        }
      }
    });

    test('zh_Hant, ar and de translate every sample key', () {
      for (final String tag in <String>['zh_Hant', 'ar', 'de']) {
        final Map<String, String> table = _readJson(tag);
        expect(
          table.keys.toSet(),
          english.keys.toSet(),
          reason: '$tag is missing keys',
        );
      }
    });

    test('the generated table matches the JSON sources', () {
      for (final String tag in <String>['zh_Hant', 'ar', 'de']) {
        final Map<String, String> json = _readJson(tag);
        expect(docsSampleTable[tag], json, reason: tag);
      }
    });
  });
}
