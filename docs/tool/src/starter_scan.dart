// Registry input scan for the starters layer (P9-6/P9-Z2): reads the
// manifest `starters` map and validates every starter the same way the kit's
// manifest builder does, so the docs Starters pages are generated from
// registry facts instead of hand-typed rows.
//
// Sources: `dashcn/lib/src/starters/<id>/starter.json` + `README.md` (both
// must exist); the template list is the rendered-template file list (targets
// only — the docs never embed raw `.tmpl` text).

import 'dart:io';

import 'registry_scan.dart';

/// One starter route: an app path backed by a flow, a block or a
/// starter-owned page.
class StarterRouteFacts {
  /// Creates the route facts.
  const StarterRouteFacts({
    required this.path,
    required this.title,
    required this.kind,
    required this.ref,
  });

  /// App path (`/signin`).
  final String path;

  /// Display title (`Sign in`).
  final String title;

  /// `flow`, `block` or `page`.
  final String kind;

  /// Flow/block id or starter-owned page ref (`auth-01`).
  final String ref;
}

/// One starter template file: its registry template and app target.
class StarterFileFacts {
  /// Creates the file facts.
  const StarterFileFacts({required this.template, required this.target});

  /// Registry-relative template (`starters/saas/templates/lib/app.dart.tmpl`).
  final String template;

  /// App-relative target (`lib/app.dart`).
  final String target;
}

/// One installable starter: a runnable app scaffold from flows + blocks.
class StarterFacts {
  /// Creates the facts.
  const StarterFacts({
    required this.id,
    required this.name,
    required this.description,
    required this.themePreset,
    required this.platforms,
    required this.flows,
    required this.blocks,
    required this.components,
    required this.routes,
    required this.files,
    required this.tags,
    required this.install,
  });

  /// Registry id == directory name (`saas`).
  final String id;

  /// Manifest display name (`SaaS starter`).
  final String name;

  /// One-line description.
  final String description;

  /// Default theme preset id (`neutral`).
  final String themePreset;

  /// Supported platforms, in manifest order.
  final List<String> platforms;

  /// Flow ids the starter composes.
  final List<String> flows;

  /// Block ids the starter composes.
  final List<String> blocks;

  /// Component ids the starter composes.
  final List<String> components;

  /// App routes, in manifest order.
  final List<StarterRouteFacts> routes;

  /// Template files, in manifest order.
  final List<StarterFileFacts> files;

  /// Manifest tags, sorted.
  final List<String> tags;

  /// `dashcn create <id> my_app`.
  final String install;
}

/// Allowed `--platforms` values (mirrors the CLI `create` command).
const Set<String> kStarterPlatforms = <String>{
  'ios',
  'android',
  'web',
  'macos',
  'windows',
  'linux',
};

/// Reads and validates every starter in the manifest `starters` map, ordered
/// by id.
///
/// Throws [RegistryScanException] on the first violated rule so a broken
/// starter fails `gen_docs_data.dart --check` instead of shipping a
/// half-rendered Starters page. The rules mirror the kit's manifest builder.
List<StarterFacts> scanStarters(
  Directory root,
  Map<String, Object?> startersJson,
) {
  final List<StarterFacts> starters = <StarterFacts>[
    for (final MapEntry<String, Object?> entry in startersJson.entries)
      _starterFacts(root, entry.key, _object(entry.value, entry.key)),
  ];
  starters.sort((StarterFacts a, StarterFacts b) => a.id.compareTo(b.id));
  if (starters.map((StarterFacts s) => s.id).toSet().length !=
      starters.length) {
    throw RegistryScanException('starters: duplicate starter id');
  }
  return starters;
}

StarterFacts _starterFacts(
  Directory root,
  String id,
  Map<String, Object?> manifest,
) {
  final String type = _string(manifest['type'], '');
  if (type != 'starter') {
    throw RegistryScanException('starter $id: type must be "starter"');
  }
  final String name = _string(manifest['name'], '');
  final String description = _string(manifest['description'], '');
  if (name.isEmpty || description.isEmpty) {
    throw RegistryScanException('starter $id: name/description missing');
  }
  final String themePreset = _string(manifest['themePreset'], '');
  if (themePreset.isEmpty) {
    throw RegistryScanException('starter $id: no themePreset');
  }
  final List<String> platforms = _strings(manifest['platforms'], 'platforms');
  if (platforms.isEmpty || !platforms.every(kStarterPlatforms.contains)) {
    throw RegistryScanException(
      'starter $id: platforms must be a non-empty subset of '
      'ios, android, web, macos, windows, linux',
    );
  }
  final List<String> flows = _strings(manifest['flows'], 'flows');
  final List<String> blocks = _strings(manifest['blocks'], 'blocks');
  final List<String> components = _strings(
    manifest['components'],
    'components',
  );
  final List<StarterRouteFacts> routes = _routes(manifest['routes'], id);
  if (routes.isEmpty) {
    throw RegistryScanException('starter $id: no routes list');
  }
  final List<StarterFileFacts> files = _files(manifest['files'], id);
  if (files.isEmpty) {
    throw RegistryScanException('starter $id: no files list');
  }
  final StarterFacts facts = StarterFacts(
    id: id,
    name: name,
    description: description,
    themePreset: themePreset,
    platforms: platforms,
    flows: flows,
    blocks: blocks,
    components: components,
    routes: routes,
    files: files,
    tags: _strings(manifest['tags'], 'tags')..sort(),
    install: _string(manifest['install'], 'dashcn create $id my_app'),
  );
  // The kit guarantees the README + starter.json + templates exist; the docs
  // scan re-checks so a stale manifest fails `--check` here too.
  if (!File('${root.path}/starters/$id/starter.json').existsSync()) {
    throw RegistryScanException('starter $id: missing starter.json');
  }
  final File readme = File('${root.path}/starters/$id/README.md');
  if (!readme.existsSync() || readme.readAsStringSync().trim().isEmpty) {
    throw RegistryScanException('starter $id: missing README.md');
  }
  for (final StarterFileFacts file in facts.files) {
    if (!File('${root.path}/${file.template}').existsSync()) {
      throw RegistryScanException(
        'starter $id: missing template ${file.template}',
      );
    }
    if (!file.target.startsWith('lib/') && !file.target.startsWith('test/')) {
      throw RegistryScanException(
        'starter $id: target "${file.target}" must start with lib/ or test/',
      );
    }
  }
  return facts;
}

List<StarterRouteFacts> _routes(Object? value, String id) {
  if (value == null) {
    return const <StarterRouteFacts>[];
  }
  if (value is! List) {
    throw RegistryScanException('starter $id: routes is not a JSON list');
  }
  return <StarterRouteFacts>[
    for (final Object? entry in value) _route(_object(entry, 'route'), id),
  ];
}

StarterRouteFacts _route(Map<String, Object?> map, String id) {
  final String path = _string(map['path'], '');
  final String title = _string(map['title'], '');
  final String kind = _string(map['kind'], '');
  final String ref = _string(map['ref'], '');
  if (path.isEmpty || title.isEmpty || kind.isEmpty || ref.isEmpty) {
    throw RegistryScanException(
      'starter $id: route misses path/title/kind/ref',
    );
  }
  if (kind != 'flow' && kind != 'block' && kind != 'page') {
    throw RegistryScanException(
      "starter $id: route kind '$kind' is not flow, block or page",
    );
  }
  return StarterRouteFacts(path: path, title: title, kind: kind, ref: ref);
}

List<StarterFileFacts> _files(Object? value, String id) {
  if (value == null) {
    return const <StarterFileFacts>[];
  }
  if (value is! List) {
    throw RegistryScanException('starter $id: files is not a JSON list');
  }
  return <StarterFileFacts>[
    for (final Object? entry in value) _file(_object(entry, 'file'), id),
  ];
}

StarterFileFacts _file(Map<String, Object?> map, String id) {
  final String template = _string(map['template'], '');
  final String target = _string(map['target'], '');
  if (template.isEmpty || target.isEmpty) {
    throw RegistryScanException('starter $id: file misses template/target');
  }
  return StarterFileFacts(template: template, target: target);
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
