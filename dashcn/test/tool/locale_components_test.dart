// Component locale flow in a temporary project: `component <id>` installs the
// English base and the strings the component needs; `add <code>` installs a
// language for every component already there; both are idempotent and add no
// duplicate keys, in any order.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/locale.dart' as locale_tool;

late Map<String, dynamic> _manifest;
late Map<String, dynamic> _registry;

/// Every relative path under [root] mapped to its content.
Map<String, String> _snapshot(Directory root) {
  final Map<String, String> out = <String, String>{};
  for (final FileSystemEntity e in root.listSync(recursive: true)) {
    if (e is File) {
      out[e.path.substring(root.path.length)] = e.readAsStringSync();
    }
  }
  return out;
}

/// Keys a generated locale file overrides (its `String get x` / `String x(`
/// members, not the private `_number` helper).
List<String> _declaredKeys(String src) => RegExp(
  r'^  String (?:get )?([a-zA-Z]\w*)',
  multiLine: true,
).allMatches(src).map((RegExpMatch m) => m.group(1)!).toList();

Set<String> _keysOf(String src) => _declaredKeys(src).toSet();

void _expectNoDuplicates(String src, String reason) {
  final List<String> keys = _declaredKeys(src);
  expect(keys.toSet(), hasLength(keys.length), reason: reason);
}

void main() {
  setUpAll(() {
    _manifest = locale_tool.loadManifest(
      'lib/src/manifests/locale_tables.json',
    );
    _registry = locale_tool.loadRegistry('lib/src/manifests/registry.json');
  });

  late Directory project;
  late String locales;

  setUp(() {
    project = Directory.systemTemp.createTempSync('dashcn_project');
    locales = '${project.path}/dashcn_locales';
  });

  tearDown(() {
    project.deleteSync(recursive: true);
  });

  String read(String name) => File('$locales/$name').readAsStringSync();

  Set<String> keysFor(List<String> components) => <String>{
    for (final String c in components)
      ...locale_tool.componentKeys(_registry, c),
  };

  test('a component needs its own keys and the keys of what it depends on', () {
    final Set<String> pagination = keysFor(<String>['pagination']);
    expect(pagination, contains('paginationPage'));
    expect(pagination, containsAll(keysFor(<String>['button'])));
  });

  test('en only: component add writes the English base and wiring', () {
    final String status = locale_tool.componentAdd(
      _manifest,
      _registry,
      'pagination',
      dir: project.path,
    );
    expect(status, contains('added pagination'));

    expect(File('$locales/dashcn_locale_en.dart').existsSync(), isTrue);
    expect(File('$locales/dashcn_locale_ar.dart').existsSync(), isFalse);

    final String en = read('dashcn_locale_en.dart');
    expect(en, contains('class DashcnLocaleEn extends ComponentLocalizations'));
    expect(_keysOf(en), keysFor(<String>['pagination']));
    _expectNoDuplicates(en, 'en has duplicate keys');
    expect(
      en,
      contains(locale_tool.resolveTable(_manifest, 'en')['paginationPage']!),
    );

    final String barrel = read('dashcn_locales.dart');
    expect(barrel, contains('DashcnLocaleEn'));
    expect(barrel, isNot(contains('DashcnLocaleAr')));
    expect(barrel, contains('dashcnLocalesDelegates'));

    final Map<String, dynamic> state =
        jsonDecode(read('state.json')) as Map<String, dynamic>;
    expect(state['components'], <String>['pagination']);
    expect(state['locales'], <String>['en']);
  });

  test('en and ar: ar follows components added before and after it', () {
    locale_tool.componentAdd(
      _manifest,
      _registry,
      'pagination',
      dir: project.path,
    );
    locale_tool.localeAdd(_manifest, _registry, 'ar', dir: project.path);

    final String ar = read('dashcn_locale_ar.dart');
    expect(ar, contains('class DashcnLocaleAr extends ComponentLocalizations'));
    expect(_keysOf(ar), keysFor(<String>['pagination']));
    expect(
      ar,
      contains(locale_tool.resolveTable(_manifest, 'ar')['paginationPage']!),
    );

    // A component added after ar lands in both locale files.
    expect(
      locale_tool.componentAdd(
        _manifest,
        _registry,
        'dropzone',
        dir: project.path,
      ),
      contains('added dropzone'),
    );
    final Set<String> union = keysFor(<String>['pagination', 'dropzone']);
    for (final String file in <String>[
      'dashcn_locale_en.dart',
      'dashcn_locale_ar.dart',
    ]) {
      final String src = read(file);
      expect(_keysOf(src), union, reason: file);
      _expectNoDuplicates(src, file);
    }
    expect(
      read('dashcn_locale_ar.dart'),
      contains(locale_tool.resolveTable(_manifest, 'ar')['dropzoneBrowse']!),
    );

    final String barrel = read('dashcn_locales.dart');
    expect(barrel, contains('DashcnLocaleEn'));
    expect(barrel, contains('DashcnLocaleAr'));
    expect(barrel, contains("const Locale('ar')"));
  });

  test('re-running component add or locale add changes nothing', () {
    locale_tool.componentAdd(
      _manifest,
      _registry,
      'pagination',
      dir: project.path,
    );
    locale_tool.localeAdd(_manifest, _registry, 'ar', dir: project.path);
    locale_tool.componentAdd(
      _manifest,
      _registry,
      'dropzone',
      dir: project.path,
    );
    final Map<String, String> before = _snapshot(Directory(locales));

    expect(
      locale_tool.componentAdd(
        _manifest,
        _registry,
        'dropzone',
        dir: project.path,
      ),
      contains('already installed dropzone'),
    );
    expect(
      locale_tool.componentAdd(
        _manifest,
        _registry,
        'pagination',
        dir: project.path,
      ),
      contains('already installed pagination'),
    );
    expect(
      locale_tool.localeAdd(_manifest, _registry, 'ar', dir: project.path),
      contains('already installed ar'),
    );
    expect(_snapshot(Directory(locales)), before);
  });

  test('locale added after components covers every installed component', () {
    locale_tool.componentAdd(
      _manifest,
      _registry,
      'pagination',
      dir: project.path,
    );
    locale_tool.componentAdd(
      _manifest,
      _registry,
      'dropzone',
      dir: project.path,
    );
    expect(
      locale_tool.localeAdd(_manifest, _registry, 'de', dir: project.path),
      contains('installed de'),
    );

    final String de = read('dashcn_locale_de.dart');
    expect(_keysOf(de), keysFor(<String>['pagination', 'dropzone']));
    _expectNoDuplicates(de, 'de');
    expect(
      de,
      contains(locale_tool.resolveTable(_manifest, 'de')['dropzoneBrowse']!),
    );
    final Map<String, dynamic> state =
        jsonDecode(read('state.json')) as Map<String, dynamic>;
    expect(state['locales'], <String>['de', 'en']);
    expect(read('dashcn_locales.dart'), contains('DashcnLocaleDe'));
  });

  test('components recorded in dashcn.lock count when adding a locale', () {
    // Installed by `dashcn add` (the CLI package), not by this tool.
    File('${project.path}/dashcn.lock').writeAsStringSync(
      '${jsonEncode(<String, Object>{
        'lockfileVersion': 2,
        'components': <Map<String, String>>[
          <String, String>{'id': 'pagination'},
        ],
      })}\n',
    );
    locale_tool.localeAdd(_manifest, _registry, 'ar', dir: project.path);
    expect(
      _keysOf(read('dashcn_locale_ar.dart')),
      keysFor(<String>['pagination']),
    );
  });

  test('a component the lock lists but the registry lacks is skipped', () {
    File('${project.path}/dashcn.lock').writeAsStringSync(
      '${jsonEncode(<String, Object>{
        'lockfileVersion': 2,
        'components': <Map<String, String>>[
          <String, String>{'id': 'not_in_this_kit'},
        ],
      })}\n',
    );
    expect(
      () =>
          locale_tool.localeAdd(_manifest, _registry, 'ar', dir: project.path),
      returnsNormally,
    );
    expect(_declaredKeys(read('dashcn_locale_ar.dart')), isEmpty);
  });
}
