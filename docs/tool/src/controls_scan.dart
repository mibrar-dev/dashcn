// Enum + playground-override scan for the docs playground codegen.
//
// Two inputs feed the per-component `ControlSpec` derivation in
// `controls_build.dart`:
//  1. enum values: every `enum X { a, b }` declared under the registry
//     `lib/src/**` tree, read with `package:analyzer` (unresolved AST).
//     Names are unique across the kit, so the first declaration wins and a
//     duplicate is ignored deterministically (sorted file order).
//  2. per-component `playground` blocks from `components/<id>/meta.json`:
//     `{exclude: [...], ranges: {...}, defaults: {...}, labels: {...}}`.
//  3. constructor constness: whether the primary widget constructor is
//     `const` (drives the `const` prefix of the emitted playground code).
//
// Only reads files; the manifest never carries the `playground` block, so
// meta.json edits here cannot drift `registry.json`.

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

/// Enum value names keyed by enum type name (`ButtonVariant` -> the seven
/// variant names, declaration order).
Map<String, List<String>> scanEnumValues(String registryRoot) {
  final Map<String, List<String>> values = <String, List<String>>{};
  final List<File> files =
      Directory(registryRoot)
          .listSync(recursive: true)
          .whereType<File>()
          .where((File file) => file.path.endsWith('.dart'))
          .toList(growable: false)
        ..sort((File a, File b) => a.path.compareTo(b.path));
  for (final File file in files) {
    late final ParseStringResult result;
    try {
      result = parseString(
        content: file.readAsStringSync(),
        throwIfDiagnostics: false,
      );
    } on FileSystemException {
      continue;
    }
    for (final CompilationUnitMember member in result.unit.declarations) {
      if (member is! EnumDeclaration) {
        continue;
      }
      final String name = member.namePart.typeName.lexeme;
      if (values.containsKey(name)) {
        continue;
      }
      values[name] = <String>[
        for (final EnumConstantDeclaration constant in member.body.constants)
          constant.name.lexeme,
      ];
    }
  }
  return values;
}

/// The optional `playground` block of one component's `meta.json`.
class PlaygroundOverrides {
  /// Creates the overrides (all empty when the block is absent).
  const PlaygroundOverrides({
    this.exclude = const <String>[],
    this.ranges = const <String, PlaygroundRange>{},
    this.defaults = const <String, String>{},
    this.labels = const <String, String>{},
  });

  /// Parameter names with no control at all (not even read-only).
  final List<String> exclude;

  /// Slider bounds keyed by parameter name.
  final Map<String, PlaygroundRange> ranges;

  /// Default values keyed by parameter name, already in Dart-source shape
  /// (`true`, `3`, `'Label'`, `ButtonVariant.primary`).
  final Map<String, String> defaults;

  /// Control labels keyed by parameter name.
  final Map<String, String> labels;
}

/// Slider bounds from a `playground.ranges` entry.
class PlaygroundRange {
  /// Creates the range.
  const PlaygroundRange({required this.min, required this.max, this.step});

  /// Lower bound.
  final double min;

  /// Upper bound.
  final double max;

  /// Step, or null for the kind default.
  final double? step;
}

/// Reads the `playground` block of `components/<id>/meta.json`.
///
/// Unknown keys are ignored; malformed entries fall back to empty so one bad
/// block can never fail the whole codegen run.
PlaygroundOverrides readPlaygroundOverrides(
  String registryRoot,
  String componentId,
) {
  final File meta = File('$registryRoot/components/$componentId/meta.json');
  if (!meta.existsSync()) {
    return const PlaygroundOverrides();
  }
  late final Object? decoded;
  try {
    decoded = jsonDecode(meta.readAsStringSync());
  } on FormatException {
    return const PlaygroundOverrides();
  }
  if (decoded is! Map) {
    return const PlaygroundOverrides();
  }
  final Object? block = decoded['playground'];
  if (block is! Map) {
    return const PlaygroundOverrides();
  }
  List<String> strings(Object? value) => value is List
      ? <String>[for (final Object? item in value) '$item']
      : const <String>[];
  final Map<String, PlaygroundRange> ranges = <String, PlaygroundRange>{};
  final Object? rangesJson = block['ranges'];
  if (rangesJson is Map) {
    final List<String> keys = <String>[
      for (final Object? key in rangesJson.keys) '$key',
    ]..sort();
    for (final String key in keys) {
      final Object? entry = rangesJson[key];
      if (entry is! Map) {
        continue;
      }
      final double? min = _number(entry['min']);
      final double? max = _number(entry['max']);
      if (min == null || max == null) {
        continue;
      }
      ranges[key] = PlaygroundRange(
        min: min,
        max: max,
        step: _number(entry['step']),
      );
    }
  }
  Map<String, String> sources(Object? value) {
    if (value is! Map) {
      return const <String, String>{};
    }
    final Map<String, String> out = <String, String>{};
    final List<String> keys = <String>[
      for (final Object? key in value.keys) '$key',
    ]..sort();
    for (final String key in keys) {
      out[key] = _jsonToSource(value[key]);
    }
    return out;
  }

  return PlaygroundOverrides(
    exclude: strings(block['exclude']),
    ranges: ranges,
    defaults: sources(block['defaults']),
    labels: sources(block['labels']),
  );
}

/// Whether the primary constructor of [className] in [entrySource] is const.
///
/// Returns false when the class or its unnamed constructor is missing (the
/// function-first and factory-first components never emit `const`).
bool isPrimaryConstructorConst(String entrySource, String className) {
  final ParseStringResult result = parseString(
    content: entrySource,
    throwIfDiagnostics: false,
  );
  for (final CompilationUnitMember member in result.unit.declarations) {
    if (member is! ClassDeclaration ||
        member.namePart.typeName.lexeme != className) {
      continue;
    }
    for (final ClassMember node in member.body.members) {
      if (node is ConstructorDeclaration && node.name == null) {
        return node.constKeyword != null;
      }
    }
    return false;
  }
  return false;
}

double? _number(Object? value) =>
    value is num ? value.toDouble() : double.tryParse('$value');

/// A JSON default/label value in Dart-source shape for `defaultValue`.
String _jsonToSource(Object? value) {
  if (value == null) {
    return 'null';
  }
  if (value is bool) {
    return value ? 'true' : 'false';
  }
  if (value is num) {
    return '$value';
  }
  if (value is String) {
    final String trimmed = value.trim();
    // Already source-shaped (`ButtonVariant.primary`, `'Label'`, `3`).
    if (trimmed.startsWith("'") ||
        trimmed == 'null' ||
        trimmed == 'true' ||
        trimmed == 'false' ||
        double.tryParse(trimmed) != null ||
        RegExp(r'^[A-Za-z_][\w]*\.[\w.]+$').hasMatch(trimmed)) {
      return trimmed;
    }
    return "'${trimmed.replaceAll(r'\', r'\\').replaceAll("'", r"\'")}'";
  }
  return 'null';
}
