// Generates the scorecard harness and `lib/src/manifests/scorecards.json`.
//
// Usage (from `dashcn/`):
//   dart run tool/gen_scorecards.dart [--check] [--harness-only]
//
// `--check` regenerates in memory and exits 1 when the harness or the stored
// JSON (excluding `generatedAt`/`commit`/frame numbers) is stale.
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

import '../test/scorecards/scorecard_model.dart';

const _componentsDir = 'lib/src/components';
const _examplesDir = 'test/scorecards/examples';
const _harnessPath = 'test/scorecards/scorecard_harness_test.dart';
const _jsonPath = 'lib/src/manifests/scorecards.json';
const _framesLabel = 'test environment (relative)';

void main(List<String> args) async {
  if (args.contains('--help')) {
    stdout.writeln(
      'Usage: dart run tool/gen_scorecards.dart [--check] [--harness-only]',
    );
    return;
  }
  final check = args.contains('--check');
  final harnessOnly = args.contains('--harness-only');
  final appRoot = findAppRoot(Directory.current);
  final ids = listedIds(appRoot);
  final idToVar = <String, String>{};
  for (final id in ids) {
    final variable = previewVariable(
      File('$appRoot/$_componentsDir/$id/preview.dart'),
    );
    if (variable == null) {
      stderr.writeln('listed component "$id" has no preview list.');
      exitCode = 66;
      return;
    }
    idToVar[id] = variable;
  }
  final harnessSource = formatDart(renderHarness(idToVar));
  final harnessFile = File('$appRoot/$_harnessPath');
  if (check) {
    final current = harnessFile.existsSync()
        ? harnessFile.readAsStringSync()
        : '';
    if (current != harnessSource) {
      stderr.writeln('$_harnessPath is not up to date. Run gen_scorecards.');
      exitCode = 1;
      return;
    }
  } else {
    writeExamples(appRoot, idToVar);
    harnessFile.parent.createSync(recursive: true);
    harnessFile.writeAsStringSync(harnessSource);
    stdout.writeln('Wrote $_harnessPath (${idToVar.length} components).');
  }
  if (harnessOnly) {
    return;
  }
  final output = await runScorecardTests(appRoot);
  final markers = parseScorecardOutput(output);
  final counts = countComponentTests(appRoot, ids);
  final commit = readCommit(appRoot);
  final flutter = readFlutterVersion();
  final fresh = buildScorecards(
    ids: ids,
    markers: markers,
    counts: counts,
    commit: commit,
    flutter: flutter,
    generatedAt: DateTime.now().toUtc().toIso8601String(),
  );
  final jsonFile = File('$appRoot/$_jsonPath');
  if (check) {
    if (!jsonFile.existsSync()) {
      stderr.writeln('$_jsonPath is missing. Run gen_scorecards.');
      exitCode = 1;
      return;
    }
    final stored =
        jsonDecode(jsonFile.readAsStringSync()) as Map<String, Object?>;
    if (!scorecardsEqual(stored, fresh)) {
      stderr.writeln('$_jsonPath is stale. Run gen_scorecards.');
      exitCode = 1;
      return;
    }
    stdout.writeln('$_jsonPath is up to date (${ids.length} components).');
    return;
  }
  jsonFile.parent.createSync(recursive: true);
  jsonFile.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(fresh)}\n',
  );
  stdout.writeln('Wrote $_jsonPath (${ids.length} components).');
}

/// Locates the `dashcn` package root by walking up from [start].
String findAppRoot(Directory start) {
  var current = start.absolute;
  while (true) {
    if (File('${current.path}/pubspec.yaml').existsSync() &&
        Directory('${current.path}/lib/src').existsSync()) {
      return current.path;
    }
    final parent = current.parent;
    if (parent.path == current.path) {
      throw StateError('cannot locate the dashcn package root');
    }
    current = parent;
  }
}

/// Sorted ids of listed components (meta `listed` != false).
List<String> listedIds(String appRoot) {
  final result = <String>[];
  for (final entity in Directory('$appRoot/$_componentsDir').listSync()) {
    if (entity is! Directory) {
      continue;
    }
    final id = entity.path.split('/').last;
    final metaFile = File('${entity.path}/meta.json');
    if (!metaFile.existsSync()) {
      continue;
    }
    final meta = jsonDecode(metaFile.readAsStringSync());
    if (meta is Map<String, Object?> && meta['listed'] == false) {
      continue;
    }
    result.add(id);
  }
  result.sort();
  return result;
}

/// Name of the exported `const List<ComponentPreview>` variable, or null.
String? previewVariable(File preview) {
  final result = parseString(
    content: preview.readAsStringSync(),
    path: preview.path,
  );
  for (final member in result.unit.declarations) {
    if (member is FunctionDeclaration && member.isGetter) {
      final getterType = member.returnType?.toSource() ?? '';
      if (getterType.replaceAll(' ', '') == 'List<ComponentPreview>') {
        return member.name.lexeme;
      }
      continue;
    }
    if (member is! TopLevelVariableDeclaration) {
      continue;
    }
    final type = member.variables.type?.toSource() ?? '';
    if (type.replaceAll(' ', '') != 'List<ComponentPreview>') {
      continue;
    }
    if (member.variables.variables.length != 1) {
      continue;
    }
    return member.variables.variables.first.name.lexeme;
  }
  return null;
}

/// Source for `test/scorecards/examples/<id>.dart`.
String exampleSource(String id, String variable) {
  return '// Canonical scorecard example for `$id`: first docs preview.\n'
      "import 'package:flutter/widgets.dart';\n"
      '\n'
      "import 'package:dashcn/src/components/$id/preview.dart';\n"
      '\n'
      '/// Minimal example pumped by the scorecard harness.\n'
      'Widget scorecardExample(BuildContext context) =>\n'
      '    $variable[0].builder(context);\n';
}

/// Writes one example file per component (overwrites for determinism).
void writeExamples(String appRoot, Map<String, String> idToVar) {
  final dir = Directory('$appRoot/$_examplesDir');
  dir.createSync(recursive: true);
  for (final entry in idToVar.entries) {
    final file = File('${dir.path}/${entry.key}.dart');
    file.writeAsStringSync(exampleSource(entry.key, entry.value));
  }
  final formatted = Process.runSync('dart', ['format', dir.path]);
  if (formatted.exitCode != 0) {
    throw StateError('dart format failed on examples: ${formatted.stderr}');
  }
}

/// Renders the harness test that pumps every example and prints SCORECARD.
String renderHarness(Map<String, String> idToVar) {
  final ids = idToVar.keys.toList()..sort();
  final imports = ids
      .map((id) => "import 'examples/$id.dart' as ${id}_example;")
      .join('\n');
  final cases = ids
      .map((id) => "  '$id': ${id}_example.scorecardExample,")
      .join('\n');
  return '''
// Scorecard harness: measures every component and prints SCORECARD JSON.
// Generated by tool/gen_scorecards.dart. Do not edit by hand.
import 'dart:convert';
import 'dart:io' show stdout;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

$imports

/// Pumps [builder] under [direction] with no settling.
///
/// The stage paints the theme background behind the example and installs the
/// same default text scope `DashcnApp` provides (docs and apps always render
/// inside both); without them the pixel sampler compares bare text against
/// transparent black (artefact ratios like 4.43 muted grey or 1.06 dark text)
/// or samples the white fallback style on the now-white stage (1.00).
Future<Object?> pumpExample(
  WidgetTester tester,
  WidgetBuilder builder,
  TextDirection direction,
) async {
  const ThemeData stage = ThemeData();
  await tester.pumpWidget(
    Theme(
      data: stage,
      child: Directionality(
        textDirection: direction,
        child: Overlay.wrap(
          child: Center(
            child: SizedBox(
              width: 800,
              height: 600,
              child: ColoredBox(
                color: stage.colors.background,
                child: DefaultTextStyle(
                  style: stage.typography.sans.copyWith(
                    color: stage.colors.foreground,
                  ),
                  child: Builder(builder: builder),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  return tester.takeException();
}

/// True when any semantics node carries a label, value, hint or tooltip.
bool hasSemantics(WidgetTester tester) {
  try {
    var found = false;
    void visit(SemanticsNode node) {
      if (found) {
        return;
      }
      final data = node.getSemanticsData();
      if (data.label.isNotEmpty ||
          data.value.isNotEmpty ||
          data.hint.isNotEmpty ||
          data.tooltip.isNotEmpty) {
        found = true;
        return;
      }
      node.visitChildren((child) {
        visit(child);
        return true;
      });
    }

    for (final view in tester.binding.renderViews) {
      final root = view.owner?.semanticsOwner?.rootSemanticsNode;
      if (root != null) {
        visit(root);
      }
      if (found) {
        break;
      }
    }
    return found;
  } catch (_) {
    return false;
  }
}

/// True when the example exposes nothing a screen reader needs: no labels,
/// values, hints or tooltips, and no tap/long-press actions. A purely
/// decorative example (the unlabelled divider, excluded from semantics by
/// design) passes the semantics check vacuously instead of failing it.
bool isDecorative(WidgetTester tester) {
  try {
    for (final view in tester.binding.renderViews) {
      var announceable = false;
      void visit(SemanticsNode node) {
        if (announceable) {
          return;
        }
        final data = node.getSemanticsData();
        if (data.label.isNotEmpty ||
            data.value.isNotEmpty ||
            data.hint.isNotEmpty ||
            data.tooltip.isNotEmpty ||
            data.hasAction(SemanticsAction.tap) ||
            data.hasAction(SemanticsAction.longPress)) {
          announceable = true;
          return;
        }
        node.visitChildren((child) {
          visit(child);
          return true;
        });
      }

      final root = view.owner?.semanticsOwner?.rootSemanticsNode;
      if (root != null) {
        visit(root);
      }
      if (announceable) {
        return false;
      }
    }
    return true;
  } catch (_) {
    return false;
  }
}

/// X of the first text, or null when the example has no text.
double? firstTextX(WidgetTester tester) {
  final finder = find.byType(Text);
  if (finder.evaluate().isEmpty) {
    return null;
  }
  try {
    return tester.getTopLeft(finder.first).dx;
  } catch (_) {
    return null;
  }
}

Map<String, Object?> guidelineResult(Evaluation evaluation) {
  return <String, Object?>{
    'passed': evaluation.passed,
    'message': evaluation.reason,
  };
}

final Map<String, WidgetBuilder> scorecardCases = <String, WidgetBuilder>{
$cases
};

void main() {
  for (final entry in scorecardCases.entries) {
    testWidgets('\${entry.key} scorecard', (WidgetTester tester) async {
      final builder = entry.value;
      final ltrError = await pumpExample(
        tester,
        builder,
        TextDirection.ltr,
      );
      final ltrX = firstTextX(tester);
      final rendersLtr = ltrError == null;
      final handle = tester.ensureSemantics();
      await tester.pump();
      final textContrast = await textContrastGuideline.evaluate(tester);
      final labeled = await labeledTapTargetGuideline.evaluate(tester);
      final android = await androidTapTargetGuideline.evaluate(tester);
      final ios = await iOSTapTargetGuideline.evaluate(tester);
      final semanticsPresent =
          hasSemantics(tester) || isDecorative(tester);
      handle.dispose();
      final rtlError = await pumpExample(
        tester,
        builder,
        TextDirection.rtl,
      );
      final rtlX = firstTextX(tester);
      final rendersRtl = rtlError == null;
      bool? mirrored;
      String? rtlMessage = rtlError?.toString();
      if (ltrX != null && rtlX != null) {
        if ((ltrX - rtlX).abs() > 1.0) {
          mirrored = true;
        } else {
          rtlMessage ??= 'symmetric layout (no directional shift)';
        }
      }
      await pumpExample(tester, builder, TextDirection.ltr);
      final times = <double>[];
      for (var i = 0; i < 120; i++) {
        final stopwatch = Stopwatch()..start();
        await tester.pump(const Duration(milliseconds: 16));
        stopwatch.stop();
        times.add(stopwatch.elapsedMicroseconds / 1000.0);
      }
      times.sort();
      final record = <String, Object?>{
        'id': entry.key,
        'a11y': <String, Object?>{
          'textContrast': guidelineResult(textContrast),
          'labeledTapTarget': guidelineResult(labeled),
          'androidTapTarget': guidelineResult(android),
          'iOSTapTarget': guidelineResult(ios),
          'semantics': <String, Object?>{
            'present': semanticsPresent,
            'message': semanticsPresent
                ? null
                : 'no semantic label, value, hint or tooltip found',
          },
        },
        'rtl': <String, Object?>{
          'passed': rendersRtl,
          'renders': rendersRtl,
          'mirrored': mirrored,
          'message': rtlMessage,
          'ltrX': ltrX,
          'rtlX': rtlX,
        },
        'ltr': <String, Object?>{
          'renders': rendersLtr,
          'message': ltrError?.toString(),
        },
        'frames': <String, Object?>{
          'p50Ms': times[60],
          'p90Ms': times[108],
          'frames': 120,
          'label': '$_framesLabel',
        },
      };
      stdout.writeln('SCORECARD \${jsonEncode(record)}');
    }, timeout: const Timeout(Duration(seconds: 60)));
  }
}
''';
}

/// Runs `dart format` over [source] and returns the formatted text.
String formatDart(String source) {
  final scratch = File(
    '${Directory.systemTemp.path}/dashcn_gen_scorecards.dart',
  );
  scratch.writeAsStringSync(source);
  final result = Process.runSync('dart', ['format', scratch.path]);
  if (result.exitCode != 0) {
    throw StateError('dart format failed: ${result.stderr}');
  }
  final formatted = scratch.readAsStringSync();
  scratch.deleteSync();
  return formatted;
}
