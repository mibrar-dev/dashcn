// Codemod tests for the P8-2 plain-name rename (`tool/rename_api.dart`).
//
// Fixtures use the analyzer unresolved AST (`parseString`); expectations pin
// the P8-2b rulings: locals become `themeData` (never `theme`), no `this.`
// qualifiers are emitted, combinators and doc refs rename, and collisions
// are reported instead of renamed.
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tool/rename_api_map.dart';
import '../../tool/rename_api_passes.dart';

RenameMap _testMap() {
  return RenameMap(
    identifiers: <String, String>{
      'ShadcnApp': 'DashcnApp',
      'ShadcnTheme': 'Theme',
      'ShadcnThemeData': 'ThemeData',
      'ShadcnColors': 'ThemeColors',
      '_ShadcnImageState': '_PictureState',
      'shadcn': 'themeData',
      'shadcnTheme': 'themeData',
    },
    removals: <String>{'ShadcnUI'},
    prefixes: const <MapEntry<String, String>>[],
    strings: const <MapEntry<String, String>>[],
    commentRules: <MapEntry<String, String>>[
      const MapEntry<String, String>('Shadcn', 'Upstream'),
      const MapEntry<String, String>('shadcn', 'upstream'),
    ],
    markdownRules: const <MapEntry<String, String>>[],
    fallbackRules: <MapEntry<String, String>>[
      const MapEntry<String, String>('Shadcn', 'Dashcn'),
      const MapEntry<String, String>('shadcn', 'dashcn'),
    ],
    allow: const <String>[],
    paths: const <MapEntry<String, String>>[],
    generated: const <String>[],
  );
}

String _rewrite(String source, RenameMap map, List<String> conflictsOut) {
  final parsed = parseString(content: source, throwIfDiagnostics: false);
  final DartPass pass = computeDartEdits(parsed.unit, source, map);
  conflictsOut.addAll(pass.conflicts);
  final List<SourceEdit> edits = pass.edits.toList()
    ..sort((SourceEdit a, SourceEdit b) => a.offset.compareTo(b.offset));
  final StringBuffer out = StringBuffer();
  int cursor = 0;
  for (final SourceEdit edit in edits) {
    out.write(source.substring(cursor, edit.offset));
    out.write(edit.replacement);
    cursor = edit.offset + edit.length;
  }
  out.write(source.substring(cursor));
  return out.toString();
}

void main() {
  test('chat bubble local becomes themeData without this qualifiers', () {
    const String source = '''
import 'package:flutter/widgets.dart';
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, this.theme});
  final Object? theme;
  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData shadcn = ShadcnTheme.of(context);
    final Object? style = resolve(widgetTheme: theme, c: shadcn.colors);
    return const SizedBox();
  }
}
''';
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(conflicts, isEmpty);
    expect(out, contains('final ThemeData themeData = Theme.of(context);'));
    expect(out, contains('widgetTheme: theme'));
    expect(out, contains('themeData.colors'));
    expect(out, isNot(contains('widgetTheme: this.theme')));
    expect('this.'.allMatches(out).length, 'this.'.allMatches(source).length);
    expect(out, isNot(contains('Shadcn')));
  });

  test('show combinator renames', () {
    const String source = "import 'a.dart' show ShadcnTheme;\n";
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(conflicts, isEmpty);
    expect(out, contains('show Theme'));
  });

  test('doc comment ref renames', () {
    const String source = '/// See [ShadcnTheme].\nclass Foo {}\n';
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(out, contains('See [Theme]'));
  });

  test('trailing EOF comment renames', () {
    const String source = 'class Foo {}\n/// The theme data for shadcn.\n';
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(out, isNot(contains('shadcn')));
  });

  test('named argument label renames', () {
    const String source = 'void f() { g(shadcn: 1); }\n';
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(out, contains('themeData: 1'));
  });

  test('private names with underscores rename', () {
    const String source = '''
class Picture extends StatelessWidget {
  State<Picture> createState() => _ShadcnImageState();
}
class _ShadcnImageState extends State<Picture> {}
''';
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(out, contains('_PictureState'));
    expect(out, isNot(contains('Shadcn')));
  });

  test('import prefix becomes dashcn for lint', () {
    const String source = "import 'a.dart' as shadcn;\nvoid f() {}\n";
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(conflicts, isEmpty);
    expect(out, contains("as dashcn;"));
  });

  test('import prefix use becomes dashcn', () {
    const String source = '''
import 'a.dart' as shadcn;
void f() {
  final x = shadcn.Card();
}
''';
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(out, contains('dashcn.Card'));
  });

  test('shadcnTheme param becomes themeData', () {
    const String source = '''
void f() {
  final ShadcnThemeData shadcnTheme = ShadcnTheme.of(context);
  print(shadcnTheme.colors);
}
''';
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(conflicts, isEmpty);
    expect(out, contains('themeData'));
    expect(out, isNot(contains('this.')));
  });

  test('themeData collision is reported and kept', () {
    const String source = '''
void f() {
  final int themeData = 1;
  final ShadcnThemeData shadcn = ShadcnTheme.of(context);
  print(shadcn);
  print(themeData);
}
''';
    final List<String> conflicts = <String>[];
    final String out = _rewrite(source, _testMap(), conflicts);
    expect(conflicts, isNotEmpty);
    expect(out, contains('shadcn'));
  });

  test('maskAllow round trip with two occurrences', () {
    const List<String> allow = <String>[
      'design inspired by shadcn/ui.',
      'github.com/mibrar-dev/shadcn_flutter_kit',
    ];
    const String text =
        'See https://github.com/mibrar-dev/shadcn_flutter_kit. '
        'Design inspired by shadcn/ui. Again '
        'github.com/mibrar-dev/shadcn_flutter_kit end.';
    final masked = maskAllow(text, allow);
    expect(unmaskAllow(masked.$2, masked.$1), text);
  });

  test('real map routes locals to themeData', () {
    final File file = File('tool/rename_map.yaml');
    final RenameMap map = loadRenameMap(file.readAsStringSync());
    expect(map.identifiers['shadcn'], 'themeData');
    expect(map.identifiers['shadcnTheme'], 'themeData');
  });
}
