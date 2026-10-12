// The parsed `tool/rename_map.yaml` for the P8-2 codemod (`rename_api.dart`).
//
// Tool-internal API (public names only because `tool/` scripts compile as
// separate libraries; nothing here is exported by the package).
import 'package:yaml/yaml.dart';

/// A parsed `rename_map.yaml`.
class RenameMap {
  RenameMap({
    required this.identifiers,
    required this.removals,
    required this.prefixes,
    required this.strings,
    required this.commentRules,
    required this.markdownRules,
    required this.fallbackRules,
    required this.allow,
    required this.paths,
    required this.generated,
  });

  /// Exact identifier renames (`from` → `to`).
  final Map<String, String> identifiers;

  /// Identifiers with `action: remove` (handled by hand, never rewritten).
  final Set<String> removals;

  /// Prefix families, longest prefix first.
  final List<MapEntry<String, String>> prefixes;

  /// Ordered substring rules for the explicit string pass.
  final List<MapEntry<String, String>> strings;

  /// Rule 1(c): Dart comments.
  final List<MapEntry<String, String>> commentRules;

  /// Rule 1(d): Markdown.
  final List<MapEntry<String, String>> markdownRules;

  /// Rule 1(e): every other text.
  final List<MapEntry<String, String>> fallbackRules;

  /// Allow-list substrings (lowercase); spans holding one are masked.
  final List<String> allow;

  /// File/directory renames (`from` → `to`, kit-relative).
  final List<MapEntry<String, String>> paths;

  /// Generated outputs the codemod skips (regenerated in step 6).
  final List<String> generated;
}

/// Parses `rename_map.yaml` text into a [RenameMap].
RenameMap loadRenameMap(String text) {
  final YamlMap root = loadYaml(text) as YamlMap;
  Map<String, String> ident() {
    final Map<String, String> out = <String, String>{};
    for (final dynamic entry in root['identifiers'] as YamlList) {
      final YamlMap map = entry as YamlMap;
      if (map['action'] == 'remove') {
        continue;
      }
      out[map['from'] as String] = map['to'] as String;
    }
    return out;
  }

  Set<String> removed() {
    final Set<String> out = <String>{};
    for (final dynamic entry in root['identifiers'] as YamlList) {
      final YamlMap map = entry as YamlMap;
      if (map['action'] == 'remove') {
        out.add(map['from'] as String);
      }
    }
    return out;
  }

  List<MapEntry<String, String>> pairs(Object? key) {
    final List<MapEntry<String, String>> out = <MapEntry<String, String>>[];
    final Object? section = root[key];
    if (section is YamlList) {
      for (final dynamic entry in section) {
        final YamlMap map = entry as YamlMap;
        out.add(
          MapEntry<String, String>(map['from'] as String, map['to'] as String),
        );
      }
    } else if (section is YamlMap) {
      for (final dynamic entry in section['rules'] as YamlList) {
        final YamlMap map = entry as YamlMap;
        out.add(
          MapEntry<String, String>(map['from'] as String, map['to'] as String),
        );
      }
    }
    return out;
  }

  List<MapEntry<String, String>> byLength(List<MapEntry<String, String>> in_) {
    final List<MapEntry<String, String>> sorted = in_.toList()
      ..sort((a, b) => b.key.length.compareTo(a.key.length));
    return sorted;
  }

  final List<MapEntry<String, String>> prefixes = <MapEntry<String, String>>[];
  for (final dynamic entry in root['prefixes'] as YamlList) {
    final YamlMap map = entry as YamlMap;
    prefixes.add(
      MapEntry<String, String>(
        map['prefix'] as String,
        map['replacement'] as String,
      ),
    );
  }

  final List<String> allow = <String>[];
  for (final dynamic entry in root['allow_list'] as YamlList) {
    allow.add(((entry as YamlMap)['entry'] as String).toLowerCase());
  }
  final List<MapEntry<String, String>> paths = <MapEntry<String, String>>[];
  for (final dynamic entry in root['paths'] as YamlList) {
    final YamlMap map = entry as YamlMap;
    paths.add(
      MapEntry<String, String>(map['from'] as String, map['to'] as String),
    );
  }
  final List<String> generated = <String>[];
  for (final dynamic entry in root['generated'] as YamlList) {
    generated.add(((entry as YamlMap)['path'] as String));
  }
  return RenameMap(
    identifiers: ident(),
    removals: removed(),
    prefixes: byLength(prefixes),
    strings: byLength(pairs('strings')),
    commentRules: pairs('comment_rules'),
    markdownRules: pairs('markdown_rules'),
    fallbackRules: pairs('fallback'),
    allow: allow,
    paths: paths,
    generated: generated,
  );
}
