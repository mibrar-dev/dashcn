// Pure helpers for the scorecard generator (shared by the tool and its tests).
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Label for frame times, required verbatim by the spec.
const scorecardFramesLabel = 'test environment (relative)';

/// Documented exemptions: component id -> check name -> reason.
///
/// Exempt checks keep their measured values but render as "Exempt" and do
/// not count as failures. There are currently no exemptions: every check
/// passes as measured (purely decorative examples with nothing to announce
/// pass the semantics check vacuously — see the harness `isDecorative`).
const Map<String, Map<String, String>> scorecardExemptions =
    <String, Map<String, String>>{};

/// Applies [scorecardExemptions] to one component's `a11y` map in place.
void applyScorecardExemptions(String id, Map<String, Object?> a11y) {
  final Map<String, String>? exempt = scorecardExemptions[id];
  if (exempt == null) {
    return;
  }
  for (final MapEntry<String, String> entry in exempt.entries) {
    final Object? check = a11y[entry.key];
    if (check is Map<String, Object?>) {
      check['exempt'] = entry.value;
    }
  }
}

/// Counts `test`/`testWidgets` calls in one file via the analyzer.
class TestVisitor extends RecursiveAstVisitor<void> {
  int total = 0;
  final List<String> testSources = <String>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final name = node.methodName.name;
    if (name == 'test' ||
        name == 'testWidgets' ||
        name == 'testGoldens' ||
        name == 'testOnPlatform') {
      total++;
      testSources.add(node.argumentList.toSource());
    }
    super.visitMethodInvocation(node);
  }
}

/// Number of test cases declared in [file] (0 when unparseable).
int countTestsInFile(File file) {
  try {
    final result = parseString(
      content: file.readAsStringSync(),
      path: file.path,
    );
    final visitor = TestVisitor();
    result.unit.visitChildren(visitor);
    return visitor.total;
  } catch (_) {
    return 0;
  }
}

/// Files under `test/registry/components` matching [id] by prefix or folder.
List<File> filesForComponent(String appRoot, String id) {
  final dir = Directory('$appRoot/test/registry/components');
  if (!dir.existsSync()) {
    return const <File>[];
  }
  final folder = Directory('${dir.path}/$id');
  if (folder.existsSync()) {
    return folder
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('_test.dart'))
        .toList();
  }
  return dir.listSync().whereType<File>().where((f) {
    final base = f.path.split('/').last;
    return base == '${id}_test.dart' || base.startsWith('${id}_');
  }).toList();
}

/// Counts test cases per component: path matches plus `tags: component:<id>`.
Map<String, int> countComponentTests(String appRoot, List<String> ids) {
  final counts = <String, int>{for (final id in ids) id: 0};
  final matched = <String, Set<String>>{for (final id in ids) id: <String>{}};
  for (final id in ids) {
    var total = 0;
    for (final file in filesForComponent(appRoot, id)) {
      total += countTestsInFile(file);
      matched[id]!.add(file.path);
    }
    counts[id] = total;
  }
  final allFiles = Directory('$appRoot/test/registry')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('_test.dart'))
      .toList();
  for (final file in allFiles) {
    TestVisitor visitor;
    try {
      final result = parseString(
        content: file.readAsStringSync(),
        path: file.path,
      );
      visitor = TestVisitor();
      result.unit.visitChildren(visitor);
    } catch (_) {
      continue;
    }
    if (visitor.testSources.isEmpty) {
      continue;
    }
    for (final id in ids) {
      if (matched[id]!.contains(file.path)) {
        continue;
      }
      var tagged = 0;
      for (final src in visitor.testSources) {
        if (src.contains('component:$id')) {
          tagged++;
        }
      }
      if (tagged > 0) {
        counts[id] = (counts[id] ?? 0) + tagged;
      }
    }
  }
  return counts;
}

/// Extracts SCORECARD records from `flutter test --reporter json` output.
///
/// Handles both JSON `print` events and raw `SCORECARD {...}` shell lines.
Map<String, Map<String, Object?>> parseScorecardOutput(String output) {
  final records = <String, Map<String, Object?>>{};
  for (final line in output.split('\n')) {
    final trimmed = line.trim();
    if (trimmed.isEmpty || !trimmed.contains('SCORECARD')) {
      continue;
    }
    String? payload;
    try {
      final outer = jsonDecode(trimmed) as Map<String, Object?>;
      if (outer['type'] == 'print' && outer['message'] is String) {
        final message = outer['message'] as String;
        final index = message.indexOf('SCORECARD');
        if (index >= 0) {
          payload = message.substring(index + 'SCORECARD'.length).trim();
        }
      }
    } catch (_) {
      final index = trimmed.indexOf('SCORECARD');
      if (index >= 0) {
        var rest = trimmed.substring(index + 'SCORECARD'.length).trim();
        if (rest.startsWith('Shell:')) {
          rest = rest.substring('Shell:'.length).trim();
        }
        // Shell lines look like `Shell: SCORECARD {...}`.
        if (rest.startsWith('SCORECARD')) {
          rest = rest.substring('SCORECARD'.length).trim();
        }
        payload = rest;
      }
    }
    // Raw shell line (not JSON): `Shell: SCORECARD {...}` or `SCORECARD {...}`.
    if (payload == null) {
      final index = trimmed.indexOf('SCORECARD');
      if (index < 0) {
        continue;
      }
      var rest = trimmed.substring(index + 'SCORECARD'.length).trim();
      if (rest.startsWith('Shell:')) {
        rest = rest.substring('Shell:'.length).trim();
        if (rest.startsWith('SCORECARD')) {
          rest = rest.substring('SCORECARD'.length).trim();
        }
      }
      payload = rest;
    }
    if (!payload.startsWith('{')) {
      continue;
    }
    try {
      final record = jsonDecode(payload) as Map<String, Object?>;
      final id = record['id'] as String?;
      if (id != null) {
        records[id] = record;
      }
    } catch (_) {
      continue;
    }
  }
  return records;
}

/// Builds the `scorecards.json` document from markers and test counts.
Map<String, Object?> buildScorecards({
  required List<String> ids,
  required Map<String, Map<String, Object?>> markers,
  required Map<String, int> counts,
  required String commit,
  required String flutter,
  required String generatedAt,
}) {
  final components = <String, Object?>{};
  for (final id in ids) {
    final marker = markers[id];
    Map<String, Object?> a11y;
    Map<String, Object?> rtl;
    Map<String, Object?> frames;
    if (marker == null) {
      a11y = {
        'textContrast': {'passed': null, 'message': 'not measured'},
        'labeledTapTarget': {'passed': null, 'message': 'not measured'},
        'androidTapTarget': {'passed': null, 'message': 'not measured'},
        'iOSTapTarget': {'passed': null, 'message': 'not measured'},
        'semantics': {'present': null, 'message': 'not measured'},
      };
      rtl = {
        'passed': null,
        'renders': null,
        'mirrored': null,
        'message': 'not measured',
        'ltrX': null,
        'rtlX': null,
      };
      frames = {
        'p50Ms': null,
        'p90Ms': null,
        'frames': 120,
        'label': scorecardFramesLabel,
      };
    } else {
      a11y = Map<String, Object?>.from(marker['a11y'] as Map? ?? {});
      rtl = Map<String, Object?>.from(marker['rtl'] as Map? ?? {});
      frames = Map<String, Object?>.from(marker['frames'] as Map? ?? {});
      frames['label'] = scorecardFramesLabel;
      frames['frames'] = 120;
      applyScorecardExemptions(id, a11y);
    }
    components[id] = {
      'a11y': a11y,
      'rtl': rtl,
      'frames': frames,
      'tests': {'count': counts[id] ?? 0, 'passed': marker != null},
    };
  }
  return {
    'generatedAt': generatedAt,
    'commit': commit,
    'flutter': flutter,
    'components': components,
  };
}

/// Compares stored vs fresh, ignoring `generatedAt`/`commit`/frame numbers.
bool scorecardsEqual(Map<String, Object?> a, Map<String, Object?> b) {
  Map<String, Object?> norm(Map<String, Object?> doc) {
    final copy = jsonDecode(jsonEncode(doc)) as Map<String, Object?>;
    copy.remove('generatedAt');
    copy.remove('commit');
    final components = copy['components'] as Map<String, Object?>?;
    if (components != null) {
      for (final entry in components.entries) {
        final comp = (entry.value as Map).cast<String, Object?>();
        final frames = (comp['frames'] as Map?)?.cast<String, Object?>();
        if (frames != null) {
          frames.remove('p50Ms');
          frames.remove('p90Ms');
        }
        components[entry.key] = comp;
      }
    }
    return copy;
  }

  return jsonEncode(norm(a)) == jsonEncode(norm(b));
}

/// Current commit hash, or `unknown` outside git.
String readCommit(String appRoot) {
  try {
    final kitRoot = Directory(appRoot).parent.path;
    final result = Process.runSync('git', ['-C', kitRoot, 'rev-parse', 'HEAD']);
    if (result.exitCode == 0) {
      return (result.stdout as String).trim();
    }
  } catch (_) {}
  return 'unknown';
}

/// Flutter version string from `--version --machine`, fallback to raw.
String readFlutterVersion() {
  try {
    final result = Process.runSync('flutter', ['--version', '--machine']);
    if (result.exitCode == 0) {
      final info = jsonDecode(result.stdout as String) as Map<String, Object?>;
      final flutter = info['flutterVersion'] as String?;
      final dart = info['dartSdkVersion'] as String?;
      if (flutter != null) {
        return dart == null ? flutter : '$flutter / Dart $dart';
      }
    }
  } catch (_) {}
  return 'unknown';
}

/// Runs the harness suite and returns its combined stdout.
Future<String> runScorecardTests(String appRoot) async {
  final result = await Process.run('flutter', [
    'test',
    'test/scorecards',
    '--reporter',
    'json',
  ], workingDirectory: appRoot);
  final out = StringBuffer()
    ..write(result.stdout)
    ..write(result.stderr);
  if (result.exitCode != 0) {
    // Harness tests always pass; a failure here means the suite broke.
    throw StateError('scorecard tests failed:\n$out');
  }
  return out.toString();
}
