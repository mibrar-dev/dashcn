// Tests for the offline locale installer (`tool/locale.dart`) and its
// manifest generator (`tool/gen_locale_manifest.dart`). The component
// scenario (en, then ar, then components and locales in any order) lives in
// `locale_components_test.dart`.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/locale.dart' as locale_tool;

late Map<String, dynamic> _manifest;
late Map<String, dynamic> _registry;

String get _manifestPath => 'lib/src/manifests/locale_tables.json';
String get _registryPath => 'lib/src/manifests/registry.json';

void main() {
  setUpAll(() {
    _manifest = locale_tool.loadManifest(_manifestPath);
    _registry = locale_tool.loadRegistry(_registryPath);
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

  test('add with no components writes an override-free locale file', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_add');
    try {
      final String status = locale_tool.localeAdd(
        _manifest,
        _registry,
        'ar',
        dir: dir.path,
      );
      expect(status, contains('installed ar'));
      final String src = File(
        '${dir.path}/dashcn_locales/dashcn_locale_ar.dart',
      ).readAsStringSync();
      expect(
        src,
        contains('class DashcnLocaleAr extends ComponentLocalizations'),
      );
      expect(src, contains("const Locale('ar')"));
      // No component is installed, so there is nothing to override yet.
      expect(RegExp('@override').allMatches(src), isEmpty);
      final String barrel = File(
        '${dir.path}/dashcn_locales/dashcn_locales.dart',
      ).readAsStringSync();
      expect(barrel, contains('dashcnLocalesDelegates'));
      expect(barrel, contains('DashcnLocaleAr'));
      expect(barrel, contains('dashcnSupportedLocales'));
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('locale file imports intl only when a key formats numbers', () {
    final String plain = locale_tool.generateLocaleFile(
      _manifest,
      'de',
      <String>{'dialogDismiss'},
    );
    expect(plain, isNot(contains('package:intl')));
    expect(plain, isNot(contains('_number(')));
    final String numeric = locale_tool.generateLocaleFile(
      _manifest,
      'ar',
      <String>{'paginationPage'},
    );
    expect(numeric, contains("import 'package:intl/intl.dart' as intl;"));
    expect(numeric, contains('String _number(Object? value)'));
  });

  test('locale file overrides exactly the keys it is given', () {
    final String src = locale_tool.generateLocaleFile(_manifest, 'ja', <String>{
      'dialogDismiss',
      'buttonNext',
    });
    expect(RegExp('@override').allMatches(src), hasLength(2));
    expect(src, contains('String get dialogDismiss'));
    expect(src, contains('String get buttonNext'));
  });

  test('add resolves inherited tables (pt-BR, zh-Hans)', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_add');
    try {
      locale_tool.componentAdd(
        _manifest,
        _registry,
        'pagination',
        dir: dir.path,
      );
      locale_tool.localeAdd(_manifest, _registry, 'pt-BR', dir: dir.path);
      final String src = File(
        '${dir.path}/dashcn_locales/dashcn_locale_pt_br.dart',
      ).readAsStringSync();
      expect(src, contains('class DashcnLocalePtBr'));
      // Inherited from pt: the pagination string resolves through the pt table.
      final String expected = locale_tool.resolveTable(
        _manifest,
        'pt-BR',
      )['paginationPage']!;
      expect(src, contains(expected));
      locale_tool.localeAdd(_manifest, _registry, 'zh-Hans', dir: dir.path);
      final String hans = File(
        '${dir.path}/dashcn_locales/dashcn_locale_zh_hans.dart',
      ).readAsStringSync();
      expect(hans, contains('class DashcnLocaleZhHans'));
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
      locale_tool.componentAdd(_manifest, _registry, 'dropzone', dir: dir.path);
      expect(
        locale_tool.localeAdd(_manifest, _registry, 'de', dir: dir.path),
        contains('installed de'),
      );
      final File file = File(
        '${dir.path}/dashcn_locales/dashcn_locale_de.dart',
      );
      final DateTime first = file.lastModifiedSync();
      final String before = file.readAsStringSync();
      sleep(const Duration(milliseconds: 20));
      expect(
        locale_tool.localeAdd(_manifest, _registry, 'de', dir: dir.path),
        contains('already installed'),
      );
      expect(file.lastModifiedSync(), first);
      expect(file.readAsStringSync(), before);
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('unknown locale errors with the supported list', () {
    final Directory dir = Directory.systemTemp.createTempSync('locale_add');
    try {
      expect(
        () => locale_tool.localeAdd(_manifest, _registry, 'xx', dir: dir.path),
        throwsArgumentError,
      );
      expect(
        () => locale_tool.componentAdd(
          _manifest,
          _registry,
          'no_such_component',
          dir: dir.path,
        ),
        throwsArgumentError,
      );
    } finally {
      dir.deleteSync(recursive: true);
    }
  });

  test('generated locale file has balanced braces', () {
    final String src = locale_tool.generateLocaleFile(
      _manifest,
      'ja',
      locale_tool.componentKeys(_registry, 'pagination').toSet(),
    );
    expect(src, contains('class DashcnLocaleJa'));
    // Balanced braces as a smoke check for verbatim expression embedding.
    expect(
      RegExp(r'\{').allMatches(src).length,
      RegExp(r'\}').allMatches(src).length,
    );
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
        _registry,
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
      locale_tool.localeAdd(_manifest, _registry, 'ja', dir: dir.path);
      locale_tool.localeAdd(_manifest, _registry, 'ar', dir: dir.path);
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
}
