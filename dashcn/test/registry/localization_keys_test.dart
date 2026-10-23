// Guard for the per-component locale keys in the registry manifest.
//
// Every component's sources are scanned again here, independently of the
// generator, and every key they read as a member must appear in that
// component's `localizationKeys`. A hand edit or a stale manifest fails here,
// and so does a new locale key used without a regenerated manifest.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/registry/src/locale_keys.dart';

Set<String> _universe() {
  final Map<String, dynamic> tables =
      jsonDecode(
            File('lib/src/manifests/locale_tables.json').readAsStringSync(),
          )
          as Map<String, dynamic>;
  return (tables['keys'] as Map<String, dynamic>).keys.toSet();
}

void main() {
  late Map<String, dynamic> registry;
  late Set<String> universe;

  setUpAll(() {
    registry =
        jsonDecode(File('lib/src/manifests/registry.json').readAsStringSync())
            as Map<String, dynamic>;
    universe = _universe();
  });

  group('scanner', () {
    late Directory dir;

    setUp(() {
      dir = Directory.systemTemp.createTempSync('locale_keys_scan');
    });

    tearDown(() {
      dir.deleteSync(recursive: true);
    });

    test('counts member reads only, never strings, comments or locals', () {
      final File file = File('${dir.path}/sample.dart')
        ..writeAsStringSync('''
// A comment naming paginationPage must not count.
String label(strings) {
  const text = 'buttonNext is only a string';
  final buttonCancel = 1;
  return [
    strings.dialogDismiss,
    ComponentLocalizations.of(context).buttonSave,
    strings.formBetweenExclusively(1, 2),
    text,
    buttonCancel.toString(),
  ].join();
}
''');
      final List<String> used = localeKeysUsedIn(file.path, <String>{
        'paginationPage',
        'buttonNext',
        'buttonCancel',
        'dialogDismiss',
        'buttonSave',
        'formBetweenExclusively',
      });
      expect(used, <String>[
        'buttonSave',
        'dialogDismiss',
        'formBetweenExclusively',
      ]);
    });
  });

  test('every component lists every locale key its sources read', () {
    final Map<String, dynamic> components = (registry['components'] as Map)
        .cast<String, dynamic>();
    expect(components, isNotEmpty);
    for (final MapEntry<String, dynamic> e in components.entries) {
      final Map<String, dynamic> entry = e.value as Map<String, dynamic>;
      final List<String> listed = (entry['localizationKeys'] as List)
          .cast<String>();
      expect(
        listed,
        equals(<String>[...listed]..sort()),
        reason: '${e.key} localizationKeys must be sorted',
      );
      expect(
        listed.toSet(),
        hasLength(listed.length),
        reason: '${e.key} localizationKeys must not repeat a key',
      );
      for (final String key in listed) {
        expect(
          universe,
          contains(key),
          reason: '${e.key} lists unknown locale key $key',
        );
      }

      final List<String> files = <String>[
        ...(entry['files'] as List).cast<String>(),
        ...(entry['userOwned'] as List).cast<String>(),
      ];
      for (final String file in files) {
        if (file.startsWith('primitives/localizations/')) {
          continue;
        }
        final List<String> used = localeKeysUsedIn('lib/src/$file', universe);
        for (final String key in used) {
          expect(
            listed,
            contains(key),
            reason:
                '${e.key} reads locale key $key in $file, but its manifest entry omits it',
          );
        }
      }
    }
  });

  test('a component lists the keys of every component it depends on', () {
    final Map<String, dynamic> components = (registry['components'] as Map)
        .cast<String, dynamic>();
    for (final MapEntry<String, dynamic> e in components.entries) {
      final Map<String, dynamic> deps =
          (e.value as Map<String, dynamic>)['deps'] as Map<String, dynamic>;
      final Set<String> own = ((e.value as Map)['localizationKeys'] as List)
          .cast<String>()
          .toSet();
      for (final String dep in (deps['components'] as List).cast<String>()) {
        final Set<String> depKeys =
            ((components[dep] as Map)['localizationKeys'] as List)
                .cast<String>()
                .toSet();
        expect(
          own,
          containsAll(depKeys),
          reason: '${e.key} must carry the keys of its dependency $dep',
        );
      }
    }
  });
}
