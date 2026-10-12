// Playground generator tests: `docs_controls.dart` regenerates
// deterministically and `--check` passes on a fresh tree.

import 'dart:io';

import 'package:docs/generated/docs_controls.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tool/gen_docs_data.dart';

void main() {
  final String? discovered = findDefaultRegistry();
  if (discovered == null) {
    test('registry discovery', () {
      fail(
        'registry not found; run `flutter test` from docs/ (expected '
        'dashcn/lib/src in the checkout)',
      );
    });
    return;
  }
  final String registry = discovered;

  group('docs_controls.dart', () {
    test('covers every component with API-order controls', () {
      expect(kControlSpecs, isNotEmpty);
      final ComponentControls button = kControlSpecs['button']!;
      expect(button.symbol, 'Button');
      expect(button.import, 'package:dashcn/components/button.dart');
      expect(button.isConst, isTrue);
      expect(
        button.controls.map((ControlSpec c) => c.name),
        containsAll(<String>['enabled', 'child', 'variant', 'size']),
      );
      final ControlSpec variant = button.controls.firstWhere(
        (ControlSpec c) => c.name == 'variant',
      );
      expect(variant.kind, ControlKind.select);
      expect(variant.options, containsAll(<String>['primary', 'outline']));
      expect(variant.defaultValue, 'primary');
      // Function-first components never emit const.
      expect(kControlSpecs['dialog']!.isConst, isFalse);
      expect(kControlSpecs['dialog']!.symbol, 'showDialog');
    });

    test('regeneration is deterministic', () {
      Directory('.dart_tool').createSync(recursive: true);
      final Directory temp = Directory(
        '.dart_tool',
      ).createTempSync('controls_gen_test');
      addTearDown(() => temp.deleteSync(recursive: true));
      List<String> argsFor(String tag) => <String>[
        '--registry',
        registry,
        '--out',
        '${temp.path}/$tag',
        '--previews',
        '${temp.path}/$tag-previews.dart',
        '--block-sources',
        '${temp.path}/$tag-blocks.dart',
        '--block-previews',
        '${temp.path}/$tag-block-previews.dart',
      ];
      expect(
        runDocsGen(argsFor('first'), out: StringBuffer(), err: StringBuffer()),
        0,
      );
      expect(
        runDocsGen(argsFor('second'), out: StringBuffer(), err: StringBuffer()),
        0,
      );
      expect(
        File('${temp.path}/first/docs_controls.dart').readAsStringSync(),
        File('${temp.path}/second/docs_controls.dart').readAsStringSync(),
      );
      // The checked-in file matches a fresh regeneration.
      expect(
        File('${temp.path}/first/docs_controls.dart').readAsStringSync(),
        File('lib/generated/docs_controls.dart').readAsStringSync(),
      );
    });

    test('--check passes on a fresh tree', () {
      expect(
        runDocsGen(
          <String>['--registry', registry, '--check'],
          out: StringBuffer(),
          err: StringBuffer(),
        ),
        0,
      );
    });
  });
}
