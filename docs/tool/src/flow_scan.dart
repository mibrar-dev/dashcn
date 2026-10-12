// Registry input scan for the flows layer (P9-3b): reads the manifest
// `flows` map and validates every flow the same way the kit's
// `flow-installable` layer rule does, so the docs Flows pages are generated
// from registry facts instead of hand-typed rows.

import 'dart:io';

import 'registry_scan.dart';

/// One installable flow: a navigable mini-app (auth, checkout, ...) shipped
/// as registry source with its screens.
class FlowFacts {
  /// Creates the facts.
  const FlowFacts({
    required this.id,
    required this.name,
    required this.description,
    required this.viewport,
    required this.screens,
    required this.install,
    required this.import,
    required this.entry,
    required this.files,
    required this.docs,
    required this.deps,
    required this.tags,
  });

  /// Registry id == directory name (`auth-01`).
  final String id;

  /// Manifest display name (`Auth 01`).
  final String name;

  /// One-line description.
  final String description;

  /// Viewport hint: `desktop` or `mobile`.
  final String viewport;

  /// Display screen names from `meta.json` (`Sign in`, `Cart`, ...).
  final List<String> screens;

  /// `dashcn add flow:<id>`.
  final String install;

  /// Corrected user import line for the installed layout.
  final String import;

  /// Registry-relative entry file (`flows/auth-01/flow.dart`).
  final String entry;

  /// Registry-relative Dart files, entry first, no README.
  final List<String> files;

  /// Registry-relative docs files (`flows/<id>/README.md`).
  final List<String> docs;

  /// Manifest deps per layer, each sorted (`components`, `blocks`,
  /// `primitives`, `foundation`, `theme`).
  final Map<String, List<String>> deps;

  /// Manifest tags, sorted.
  final List<String> tags;

  /// Whether the flow targets a phone viewport.
  bool get isMobile => viewport == 'mobile';
}

/// One flow file plus its verbatim source (the docs code view).
class FlowFileFacts {
  /// Creates the file facts.
  const FlowFileFacts({required this.path, required this.code});

  /// Registry-relative path (`flows/auth-01/flow.dart`).
  final String path;

  /// File source, verbatim.
  final String code;
}

/// Reads and validates every flow in the manifest `flows` map, ordered by id.
///
/// Throws [RegistryScanException] on the first violated rule so a broken flow
/// fails `gen_docs_data.dart --check` instead of shipping a half-rendered
/// Flows page. The rules mirror the kit's `flow-installable` layer check.
List<FlowFacts> scanFlows(Directory root, Map<String, Object?> flowsJson) {
  final List<FlowFacts> flows = <FlowFacts>[
    for (final MapEntry<String, Object?> entry in flowsJson.entries)
      _flowFacts(root, entry.key, _object(entry.value, entry.key)),
  ];
  flows.sort((FlowFacts a, FlowFacts b) => a.id.compareTo(b.id));
  if (flows.map((FlowFacts f) => f.id).toSet().length != flows.length) {
    throw RegistryScanException('flows: duplicate flow id');
  }
  return flows;
}

FlowFacts _flowFacts(Directory root, String id, Map<String, Object?> manifest) {
  final String type = _string(manifest['type'], '');
  if (type != 'flow') {
    throw RegistryScanException('flow $id: type must be "flow"');
  }
  final String name = _string(manifest['name'], '');
  final String description = _string(manifest['description'], '');
  final String viewport = _string(manifest['viewport'], '');
  final String entry = _string(manifest['entry'], '');
  final List<String> files = _strings(manifest['files'], 'files');
  final List<String> docs = _strings(manifest['docs'], 'docs');
  final List<String> screens = _strings(manifest['screens'], 'screens');
  if (name.isEmpty || description.isEmpty) {
    throw RegistryScanException('flow $id: name/description missing');
  }
  if (viewport != 'desktop' && viewport != 'mobile') {
    throw RegistryScanException(
      'flow $id: viewport must be desktop or mobile (got "$viewport")',
    );
  }
  if (screens.isEmpty) {
    throw RegistryScanException('flow $id: no screens list');
  }
  if (entry != 'flows/$id/flow.dart') {
    throw RegistryScanException(
      'flow $id: entry "$entry" is not flows/$id/flow.dart',
    );
  }
  if (files.isEmpty || files.first != entry) {
    throw RegistryScanException('flow $id: files must start with $entry');
  }
  final Map<String, List<String>> deps = <String, List<String>>{
    for (final String layer in const <String>[
      'components',
      'blocks',
      'primitives',
      'foundation',
      'theme',
    ])
      layer: _strings(_objectOrEmpty(manifest['deps'])[layer], 'deps.$layer')
        ..sort(),
  };
  final FlowFacts facts = FlowFacts(
    id: id,
    name: name,
    description: description,
    viewport: viewport,
    screens: screens,
    install: _string(manifest['install'], 'dashcn add flow:$id'),
    import: _string(manifest['import'], ''),
    entry: entry,
    files: files,
    docs: docs,
    deps: deps,
    tags: _strings(manifest['tags'], 'tags')..sort(),
  );
  for (final String file in facts.files) {
    final File dart = File('${root.path}/$file');
    if (!dart.existsSync()) {
      throw RegistryScanException('flow $id: missing file $file');
    }
  }
  for (final String doc in facts.docs) {
    if (!File('${root.path}/$doc').existsSync()) {
      throw RegistryScanException('flow $id: missing doc $doc');
    }
  }
  return facts;
}

Map<String, Object?> _object(Object? value, String what) {
  if (value is! Map) {
    throw RegistryScanException('$what is not a JSON object');
  }
  return <String, Object?>{
    for (final MapEntry<Object?, Object?> entry in value.entries)
      entry.key.toString(): entry.value,
  };
}

Map<String, Object?> _objectOrEmpty(Object? value) =>
    value is Map ? _object(value, 'object') : const <String, Object?>{};

String _string(Object? value, String fallback) =>
    value is String ? value : fallback;

List<String> _strings(Object? value, String what) {
  if (value == null) {
    return <String>[];
  }
  if (value is! List) {
    throw RegistryScanException('$what is not a JSON list');
  }
  return <String>[for (final Object? item in value) '$item'];
}
