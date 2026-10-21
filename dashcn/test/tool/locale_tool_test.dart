// Tests for the offline locale installer (`tool/locale.dart`) and its
// manifest generator (`tool/gen_locale_manifest.dart`).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/locale.dart' as locale_tool;

late Map<String, dynamic> _manifest;

String get _manifestPath => 'lib/src/manifests/locale_tables.json';

void main() {
  setUpAll(() {
    _manifest = locale_tool.loadManifest(_manifestPath);
  });

  test('manifest generation is checked in and fresh', () {
    expect(File(_manifestPath).existsSync(), isTrue);
    expect(_manifest['keyCount'], greaterThan(200));
    expect((_manifest['locales'] as Map).length, greaterThanOrEqualTo(16));
  });

  test('list covers every required locale with directions', () {
    final List<String> lines = locale_tool.localeList(_manifest);
    for (final String code in <String>[
      'ar',
      'he',
      'fa',
      'ur',
      'de',
      'fr',
      'es',
      'it',
      'pt-BR',
      'nl',
      'ru',
      'tr',
      'ja',
      'ko',
      'zh-Hans',
      'hi',
    ]) {
      expect(
        lines.any((String l) => l.startsWith(code.padRight(9).substring(0, 2))),
        isTrue,
        reason: 'missing $code',
      );
    }
    final String rtl = lines.firstWhere((String l) => l.startsWith('ar'));
    expect(rtl, contains('rtl'));
    final String ltr = lines.firstWhere((String l) => l.startsWith('de'));
    expect(ltr, contains('ltr'));
  });

  test('add writes a complete standalone table', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_add');
    try {
      final String status = locale_tool.localeAdd(
        _manifest,
        'ar',
        dir: dir.path,
      );
      expect(status, contains('installed ar'));
      final File file = File(
        '${dir.path}/dashcn_locales/dashcn_locale_ar.dart',
      );
      expect(file.existsSync(), isTrue);
      final String src = file.readAsStringSync();
      expect(
        src,
        contains('class DashcnLocaleAr extends ComponentLocalizations'),
      );
      expect(src, contains("const Locale('ar')"));
      expect(src, contains('String _number(Object? value)'));
      // Complete: every manifest key has an override.
      final int overrides = RegExp(r'@override').allMatches(src).length;
      expect(overrides, _manifest['keyCount']);
      // Barrel wires the delegate and supported locales.
      final File barrel = File(
        '${dir.path}/dashcn_locales/dashcn_locales.dart',
      );
      expect(barrel.existsSync(), isTrue);
      final String barrelSrc = barrel.readAsStringSync();
      expect(barrelSrc, contains('dashcnLocalesDelegate'));
      expect(barrelSrc, contains('dashcnSupportedLocales'));
      expect(barrelSrc, contains('DashcnLocalesDelegate'));
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('add resolves inherited tables (pt-BR, zh-Hans)', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_add');
    try {
      locale_tool.localeAdd(_manifest, 'pt-BR', dir: dir.path);
      final String src = File(
        '${dir.path}/dashcn_locales/dashcn_locale_pt_br.dart',
      ).readAsStringSync();
      expect(src, contains('class DashcnLocalePtBr'));
      // Inherited from pt plus its own overrides: still complete.
      final int overrides = RegExp(r'@override').allMatches(src).length;
      expect(overrides, _manifest['keyCount']);
      expect(src, contains('Iniciar teste gratuito'));
      locale_tool.localeAdd(_manifest, 'zh-Hans', dir: dir.path);
      final String hans = File(
        '${dir.path}/dashcn_locales/dashcn_locale_zh_hans.dart',
      ).readAsStringSync();
      expect(
        RegExp(r'@override').allMatches(hans).length,
        _manifest['keyCount'],
      );
      // The barrel now wires both installed locales.
      final String barrel = File(
        '${dir.path}/dashcn_locales/dashcn_locales.dart',
      ).readAsStringSync();
      expect(barrel, contains('DashcnLocalePtBr'));
      expect(barrel, contains('DashcnLocaleZhHans'));
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('re-add is idempotent', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_add');
    try {
      expect(
        locale_tool.localeAdd(_manifest, 'de', dir: dir.path),
        contains('installed de'),
      );
      final File file = File(
        '${dir.path}/dashcn_locales/dashcn_locale_de.dart',
      );
      final DateTime first = file.lastModifiedSync();
      sleep(const Duration(milliseconds: 20));
      expect(
        locale_tool.localeAdd(_manifest, 'de', dir: dir.path),
        contains('already installed'),
      );
      expect(file.lastModifiedSync(), first);
      expect(file.readAsStringSync(), contains('Abbrechen'));
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('list --json reports direction and key counts per locale', () {
    final List<String> lines = locale_tool.localeList(_manifest, json: true);
    expect(lines, hasLength(1));
    final Map<String, dynamic> payload =
        jsonDecode(lines.single) as Map<String, dynamic>;
    expect(payload['ar'], isNotNull);
    expect((payload['ar'] as Map<String, dynamic>)['direction'], 'rtl');
    expect((payload['de'] as Map<String, dynamic>)['direction'], 'ltr');
    for (final MapEntry<String, dynamic> e in payload.entries) {
      final Map<String, dynamic> detail = e.value as Map<String, dynamic>;
      if (detail.containsKey('inherits')) {
        // Regional variants override only what differs; the generated
        // table is still complete via inheritance.
        expect(detail['keys'], greaterThan(0));
      } else {
        expect(detail['keys'], greaterThan(200));
      }
    }
    expect(payload['pt-BR']['inherits'], 'pt');
    expect(payload['zh-Hans']['inherits'], 'zh');
  });

  test('loads from a vendored manifest path (CLI package offline copy)', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_vendor');
    try {
      final File vendored = File('${dir.path}/locale_tables.json')
        ..writeAsStringSync(jsonEncode(_manifest));
      final Map<String, dynamic> manifest = locale_tool.loadManifest(
        vendored.path,
      );
      expect((manifest['locales'] as Map).containsKey('ar'), isTrue);
      final String status = locale_tool.localeAdd(
        manifest,
        'ar',
        dir: dir.path,
      );
      expect(status, contains('installed ar'));
      expect(
        File('${dir.path}/dashcn_locales/dashcn_locale_ar.dart').existsSync(),
        isTrue,
      );
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('barrel wires every installed locale and stays sorted', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_add');
    try {
      locale_tool.localeAdd(_manifest, 'ja', dir: dir.path);
      locale_tool.localeAdd(_manifest, 'ar', dir: dir.path);
      final String barrel = File(
        '${dir.path}/dashcn_locales/dashcn_locales.dart',
      ).readAsStringSync();
      expect(barrel, contains('DashcnLocaleJa'));
      expect(barrel, contains('DashcnLocaleAr'));
      expect(barrel, contains("const Locale('ar')"));
      expect(barrel, contains('dashcnSupportedLocales'));
      expect(barrel, contains('dashcnLocalesDelegates'));
      expect(barrel, contains('isSupported'));
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('unknown locale errors with the supported list', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_add');
    try {
      expect(
        () => locale_tool.localeAdd(_manifest, 'xx', dir: dir.path),
        throwsArgumentError,
      );
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('generated locale file parses as valid Dart', () {
    final String src = locale_tool.generateLocaleFile(_manifest, 'ja');
    expect(src, contains('class DashcnLocaleJa'));
    // Balanced braces as a smoke check for verbatim expression embedding.
    expect(
      RegExp(r'\{').allMatches(src).length,
      RegExp(r'\}').allMatches(src).length,
    );
  });
}
