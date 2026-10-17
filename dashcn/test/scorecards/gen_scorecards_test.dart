// Unit tests for the scorecard generator parsing and aggregation.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/gen_scorecards.dart' as tool;
import 'scorecard_model.dart' as model;

void main() {
  group('parseScorecardOutput', () {
    test('extracts JSON print events', () {
      final record = {
        'id': 'button',
        'a11y': {
          'textContrast': {'passed': true, 'message': null},
        },
        'rtl': {'passed': true},
        'frames': {'p50Ms': 0.1},
      };
      final outer = jsonEncode({
        'type': 'print',
        'message': 'SCORECARD ${jsonEncode(record)}',
      });
      final output = '$outer\n{"type":"done"}\n';
      final parsed = model.parseScorecardOutput(output);
      expect(parsed['button']!['id'], 'button');
    });

    test('extracts raw shell lines and skips garbage', () {
      final record = {'id': 'badge', 'a11y': {}};
      final output = [
        'noise line',
        'Shell: SCORECARD ${jsonEncode(record)}',
        'SCORECARD not-json',
        'SCORECARD {"id": 123}',
      ].join('\n');
      final parsed = model.parseScorecardOutput(output);
      expect(parsed.keys, ['badge']);
    });

    test('last marker wins for duplicate ids', () {
      final first = jsonEncode({'id': 'card', 'v': 1});
      final second = jsonEncode({'id': 'card', 'v': 2});
      final output = 'SCORECARD $first\nSCORECARD $second\n';
      final parsed = model.parseScorecardOutput(output);
      expect((parsed['card'] as Map)['v'], 2);
    });
  });

  group('buildScorecards', () {
    test('missing markers become null (not measured)', () {
      final doc = model.buildScorecards(
        ids: const ['button', 'badge'],
        markers: const {},
        counts: const {'button': 11, 'badge': 0},
        commit: 'abc',
        flutter: '3.47.7',
        generatedAt: '2026-10-12T00:00:00Z',
      );
      final components = doc['components'] as Map<String, Object?>;
      final button = components['button'] as Map<String, Object?>;
      final frames = button['frames'] as Map<String, Object?>;
      expect(frames['p50Ms'], isNull);
      expect(frames['label'], model.scorecardFramesLabel);
      final tests = button['tests'] as Map<String, Object?>;
      expect(tests['count'], 11);
      expect(tests['passed'], isFalse);
    });

    test('markers flow through with relative label', () {
      final marker = {
        'id': 'button',
        'a11y': {
          'textContrast': {'passed': true, 'message': null},
        },
        'rtl': {'passed': true},
        'frames': {'p50Ms': 0.5, 'p90Ms': 0.9},
      };
      final doc = model.buildScorecards(
        ids: const ['button'],
        markers: {'button': marker},
        counts: const {'button': 3},
        commit: 'abc',
        flutter: 'x',
        generatedAt: 't',
      );
      final comp = (doc['components'] as Map)['button'] as Map<String, Object?>;
      expect((comp['tests'] as Map)['passed'], isTrue);
      expect((comp['frames'] as Map)['label'], 'test environment (relative)');
    });

    test('no exemptions are recorded on any check', () {
      Map<String, Object?> marker(String id) => <String, Object?>{
        'id': id,
        'a11y': <String, Object?>{
          'textContrast': <String, Object?>{'passed': true, 'message': null},
          'semantics': <String, Object?>{'present': true, 'message': null},
        },
        'rtl': <String, Object?>{'passed': true},
        'frames': <String, Object?>{'p50Ms': 0.1, 'p90Ms': 0.2},
      };
      // The exemption map is empty: decorative examples pass the semantics
      // check vacuously (see the harness `isDecorative`), so no check ever
      // carries an `exempt` entry.
      expect(model.scorecardExemptions, isEmpty);
      final doc = model.buildScorecards(
        ids: const ['divider', 'button'],
        markers: <String, Map<String, Object?>>{
          'divider': marker('divider'),
          'button': marker('button'),
        },
        counts: const {'divider': 1, 'button': 1},
        commit: 'abc',
        flutter: 'x',
        generatedAt: 't',
      );
      Map<String, Object?> a11y(String id) =>
          (((doc['components'] as Map)[id] as Map)['a11y']
              as Map<String, Object?>);
      expect(
        (a11y('divider')['semantics'] as Map).containsKey('exempt'),
        isFalse,
      );
      expect(
        (a11y('button')['textContrast'] as Map).containsKey('exempt'),
        isFalse,
      );
    });
  });

  group('scorecardsEqual', () {
    test('ignores timestamp, commit and frame numbers', () {
      Map<String, Object?> doc(String stamp, String commit, double p50) {
        return {
          'generatedAt': stamp,
          'commit': commit,
          'flutter': '3.47.7',
          'components': {
            'button': {
              'a11y': {
                'textContrast': {'passed': true, 'message': null},
              },
              'rtl': {'passed': true},
              'frames': {
                'p50Ms': p50,
                'p90Ms': 0.2,
                'frames': 120,
                'label': model.scorecardFramesLabel,
              },
              'tests': {'count': 5, 'passed': true},
            },
          },
        };
      }

      expect(
        model.scorecardsEqual(doc('a', 'c1', 0.1), doc('b', 'c2', 9.9)),
        isTrue,
      );
    });

    test('detects a11y, rtl and test changes', () {
      Map<String, Object?> base() {
        return {
          'generatedAt': 't',
          'commit': 'c',
          'flutter': 'f',
          'components': {
            'button': {
              'a11y': {
                'textContrast': {'passed': true, 'message': null},
              },
              'rtl': {'passed': true},
              'frames': {'p50Ms': 1.0, 'frames': 120, 'label': 'x'},
              'tests': {'count': 5, 'passed': true},
            },
          },
        };
      }

      final a = base();
      final b = base();
      ((b['components'] as Map)['button'] as Map)['a11y'] = {
        'textContrast': {'passed': false, 'message': 'low contrast'},
      };
      expect(model.scorecardsEqual(a, b), isFalse);
      final c = base();
      ((c['components'] as Map)['button'] as Map)['tests'] = {
        'count': 6,
        'passed': true,
      };
      expect(model.scorecardsEqual(a, c), isFalse);
    });
  });

  group('counting (analyzer, no regex)', () {
    test('counts test cases in a file', () {
      final dir = Directory.systemTemp.createTempSync('scorecard_count');
      try {
        final file = File('${dir.path}/sample_test.dart')
          ..writeAsStringSync('''
import 'package:flutter_test/flutter_test.dart';
void main() {
  test('one', () {});
  testWidgets('two', (t) async {});
  group('g', () {
    test('three', () {});
  });
}
''');
        expect(model.countTestsInFile(file), 3);
      } finally {
        dir.deleteSync(recursive: true);
      }
    });

    test('matches by prefix and tags', () {
      final root = Directory.systemTemp.createTempSync('scorecard_root');
      try {
        final compDir = Directory('${root.path}/test/registry/components')
          ..createSync(recursive: true);
        File('${compDir.path}/button_test.dart').writeAsStringSync(
          "import 'package:flutter_test/flutter_test.dart';\n"
          'void main() { testWidgets(\'a\', (t) async {}); test(\'b\', () {}); }\n',
        );
        File('${compDir.path}/other_test.dart').writeAsStringSync(
          "import 'package:flutter_test/flutter_test.dart';\n"
          "void main() { test('tagged', () {}, tags: ['component:button']); }\n",
        );
        final counts = model.countComponentTests(root.path, const ['button']);
        // 2 from the path match plus 1 from the tag in another file.
        expect(counts['button'], 3);
      } finally {
        root.deleteSync(recursive: true);
      }
    });
  });

  group('harness generation', () {
    test('example source uses the preview list', () {
      final src = tool.exampleSource('button', 'buttonPreviews');
      expect(src, contains('buttonPreviews[0].builder'));
      expect(
        src,
        contains('package:dashcn/src/components/button/preview.dart'),
      );
    });

    test('harness avoids settling and labels frames relatively', () {
      final src = tool.renderHarness(const {
        'button': 'buttonPreviews',
        'badge': 'badgePreviews',
      });
      expect(src, contains('button'));
      expect(src, contains('badge'));
      expect(src, contains('Timeout(Duration(seconds: 60))'));
      expect(src, contains('test environment (relative)'));
      expect(src, contains('SCORECARD'));
      expect(src.contains('pumpAndSettle'), isFalse);
    });
  });
}
