// Builds lib/src/manifests/registry.json (schemaVersion 2) from the
// post-cutover flat registry tree.
//
// Data sources:
//   * components/<id>/meta.json — identity, deps, api, theme, files;
//   * foundation/, theme/, primitives/ — unit file sets and primitive deps
//     (derived from real relative imports; layers have no meta.json);
//   * themes/*.json — presets;
//   * pubspec.yaml — registry version and package constraints.
//
// The output is deterministic: no timestamps, keys sorted recursively. The
// contract is rearch/reports/registry_manifest.v2.schema.json (P5-A) and
// rearch/reports/P5_CLI_PLAN.md section 9.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:yaml/yaml.dart';

import '../../rearch/src/json_utils.dart';
import 'categories.dart';
import 'dart_imports.dart';
import 'layer_scan.dart';
import 'locale_keys.dart';
import 'manifest_error.dart';

/// Builds the manifest JSON for the registry at [appRoot] (the
/// dashcn package root). Throws [ManifestBuildException] on any
/// tree inconsistency; the caller writes or diffs the result.
String buildRegistryManifest(String appRoot) {
  return stableJsonEncode(_Builder(appRoot).build());
}

/// Device-frame preview placements (F1): where a component's default
/// preview sits on a real device screen. `meta.json` carries this as
/// `preview.placement`; absent means [center].
const Set<String> previewPlacements = <String>{
  'center',
  'top',
  'bottom',
  'fill',
  'leading',
};

/// Reads `meta['preview']['placement']` for [id], defaulting to `center`.
///
/// Throws [ManifestBuildException] when `preview` is not an object, carries
/// unknown keys, or names a placement outside [previewPlacements].
String previewPlacementOf(String id, Map<String, dynamic> meta) {
  final preview = meta['preview'];
  if (preview == null) {
    return 'center';
  }
  if (preview is! Map) {
    throw ManifestBuildException("component '$id' preview must be an object");
  }
  for (final key in preview.keys) {
    if (key != 'placement') {
      throw ManifestBuildException(
        "component '$id' preview has unknown key '$key'",
      );
    }
  }
  final placement = preview['placement'];
  if (placement == null) {
    return 'center';
  }
  if (placement is! String || !previewPlacements.contains(placement)) {
    throw ManifestBuildException(
      "component '$id' preview.placement '$placement' is not one of "
      '${previewPlacements.join(', ')}',
    );
  }
  return placement;
}

/// Dart file name of the block [id]: Dart files must satisfy the `file_names`
/// lint, so the hyphenated id maps to an underscored stem.
String blockStem(String id) => id.replaceAll('-', '_');

/// A component directory as read from its meta.json.
class _Component implements _Buildable {
  _Component({
    required this.id,
    required this.meta,
    required this.metaFiles,
    required this.userTheme,
    required this.preview,
  });

  @override
  final String id;
  final Map<String, dynamic> meta;
  final List<String> metaFiles;

  /// `<id>_theme.dart` when the file exists in the directory.
  final String? userTheme;

  /// `preview.dart` when listed in meta files.
  final String? preview;

  @override
  Map<String, dynamic> get deps => meta['deps'] as Map<String, dynamic>;

  @override
  String get kindLabel => 'component';
}

/// The shared shape of a `meta.json` unit that declares layer dependencies.
abstract class _Buildable {
  Map<String, dynamic> get deps;

  String get id;

  String get kindLabel;
}

/// A block directory as read from its meta.json.
class _Block implements _Buildable {
  _Block({required this.id, required this.meta, required this.metaFiles});

  @override
  final String id;
  final Map<String, dynamic> meta;
  final List<String> metaFiles;

  @override
  Map<String, dynamic> get deps => meta['deps'] as Map<String, dynamic>;

  @override
  String get kindLabel => 'block';
}

/// A flow directory as read from its meta.json.
class _Flow implements _Buildable {
  _Flow({required this.id, required this.meta, required this.metaFiles});

  @override
  final String id;
  final Map<String, dynamic> meta;
  final List<String> metaFiles;

  @override
  Map<String, dynamic> get deps => meta['deps'] as Map<String, dynamic>;

  @override
  String get kindLabel => 'flow';
}

/// A starter directory as read from its starter.json.
class _Starter {
  _Starter({required this.id, required this.meta});

  final String id;
  final Map<String, dynamic> meta;
}

class _Builder {
  _Builder(this.appRoot) : root = '$appRoot/lib/src';

  final String appRoot;
  final String root;

  late final YamlMap _pubspec =
      loadYaml(File('$appRoot/pubspec.yaml').readAsStringSync()) as YamlMap;

  /// pubspec dependency name -> version constraint (sdk deps excluded).
  Map<String, String> get constraints {
    final result = <String, String>{};
    final deps = _pubspec['dependencies'];
    if (deps is YamlMap) {
      for (final entry in deps.entries) {
        final value = entry.value;
        if (value is String) {
          result[entry.key as String] = value;
        }
      }
    }
    return result;
  }

  Map<String, Object?> build() {
    final components = _readComponents();
    final blocks = _readBlocks();
    final flows = _readFlows();
    final starters = _readStarters();
    final declared = _declaredLayerIds(components, blocks, flows);
    final foundation = scanLayer(root, 'foundation', declared['foundation']!);
    final theme = scanLayer(root, 'theme', declared['theme']!);
    final primitives = scanLayer(root, 'primitives', declared['primitives']!);
    _validateComponentDeps(components, foundation, theme, primitives);
    _validateBlocks(blocks, components, foundation, theme, primitives);
    _validateFlows(flows, blocks, components, foundation, theme, primitives);
    final themesJson = _themesJson();
    _validateStarters(starters, flows, blocks, components, themesJson);

    final deps = primitiveDeps(primitives);
    final hashes = <String, String>{};

    final componentJson = <String, Object?>{};
    for (final id in components.keys.toList()..sort()) {
      componentJson[id] = _componentJson(components[id]!, hashes);
    }
    final blockJson = <String, Object?>{};
    for (final id in blocks.keys.toList()..sort()) {
      blockJson[id] = _blockJson(blocks[id]!, hashes);
    }
    final flowJson = <String, Object?>{};
    for (final id in flows.keys.toList()..sort()) {
      flowJson[id] = _flowJson(flows[id]!, hashes);
    }
    final starterJson = <String, Object?>{};
    for (final id in starters.keys.toList()..sort()) {
      starterJson[id] = _starterJson(starters[id]!, hashes);
    }
    // Theme presets are hashed too: `themes/<id>.json` is the input the CLI
    // renders into `<installRoot>/theme/app_theme.dart`, so a consumer that
    // caches or diffs the generated file needs the preset digest to tell "the
    // preset changed" from "only the theme selection changed".
    for (final preset in themesJson.values) {
      hashes[(preset as Map<String, Object?>)['file']! as String] = _sha256(
        (preset['file']! as String),
      );
    }
    for (final file in <String>[
      ...foundation.allFiles,
      ...theme.allFiles,
      ...primitives.allFiles,
    ]) {
      hashes[file] = _sha256(file);
    }
    final fontsJson = _fontsJson();
    for (final path in _fontPaths(fontsJson)) {
      hashes[path] = _sha256KitFile(path);
    }

    final foundationJson = _unitsJson(foundation);
    final themeJson = _unitsJson(theme);
    final primitivesJson = _primitivesJson(primitives, deps);
    _addLocalizationKeys(
      componentJson,
      foundation: foundationJson,
      theme: themeJson,
      primitives: primitivesJson,
    );

    return <String, Object?>{
      'schemaVersion': 2,
      'registry': <String, Object?>{
        'name': 'dashcn',
        'version': _pubspec['version'] as String,
      },
      'fonts': fontsJson,
      'install': <String, Object?>{
        'root': 'lib/ui/dashcn',
        'componentsDir': 'components',
        'blocksDir': 'blocks',
        'layerDirs': <String, Object?>{
          'foundation': 'foundation',
          'theme': 'theme',
          'primitives': 'primitives',
        },
        'userOwnedSuffix': '_theme.dart',
      },
      'foundation': foundationJson,
      'theme': themeJson,
      'primitives': primitivesJson,
      'components': componentJson,
      'blocks': blockJson,
      'flows': flowJson,
      'starters': starterJson,
      'themes': themesJson,
      'fileHashes': hashes,
    };
  }

  /// The opt-in font packs the CLI installs (`dashcn fonts add <id>`).
  ///
  /// The kit itself bundles no text faces: apps get the platform font by
  /// default and add these through the CLI. The table is transcribed from the
  /// `flutter: fonts:` block the kit used to declare (binaries stay in
  /// `dashcn/assets/fonts` for the CLI to copy but are excluded from the
  /// published package by `.pubignore`); paths stay relative to the kit root
  /// so the CLI resolves them against the registry source. Icon fonts are
  /// not listed: their glyphs are public API and stay bundled.
  Map<String, Object?> _fontsJson() {
    Map<String, Object?> family(String name, List<List<Object>> files) {
      return <String, Object?>{
        'families': <Object?>[
          <String, Object?>{
            'family': name,
            'files': <Object?>[
              for (final file in files)
                <String, Object?>{
                  'path': 'assets/fonts/${file[0]}',
                  'weight': file[1],
                  if (file.length > 2) 'style': file[2],
                },
            ],
          },
        ],
      };
    }

    return <String, Object?>{
      'geist-sans': family('GeistSans', const <List<Object>>[
        ['Geist-Black.otf', 800],
        ['Geist-BlackItalic.otf', 800, 'italic'],
        ['Geist-Bold.otf', 700],
        ['Geist-BoldItalic.otf', 700, 'italic'],
        ['Geist-ExtraLightItalic.otf', 200, 'italic'],
        ['Geist-Light.otf', 300],
        ['Geist-LightItalic.otf', 300, 'italic'],
        ['Geist-Medium.otf', 500],
        ['Geist-MediumItalic.otf', 500, 'italic'],
        ['Geist-Regular.otf', 400],
        ['Geist-RegularItalic.otf', 400, 'italic'],
        ['Geist-SemiBold.otf', 600],
        ['Geist-SemiBoldItalic.otf', 600, 'italic'],
        ['Geist-Thin.otf', 100],
        ['Geist-ThinItalic.otf', 100, 'italic'],
        ['Geist-UltraLight.otf', 200],
        ['Geist-UltraBlack.otf', 900],
      ]),
      'geist-mono': family('GeistMono', const <List<Object>>[
        ['GeistMono-Black.otf', 800],
        ['GeistMono-BlackItalic.otf', 800, 'italic'],
        ['GeistMono-Bold.otf', 700],
        ['GeistMono-BoldItalic.otf', 700, 'italic'],
        ['GeistMono-ExtraLightItalic.otf', 200, 'italic'],
        ['GeistMono-Light.otf', 300],
        ['GeistMono-LightItalic.otf', 300, 'italic'],
        ['GeistMono-Medium.otf', 500],
        ['GeistMono-MediumItalic.otf', 500, 'italic'],
        ['GeistMono-Regular.otf', 400],
        ['GeistMono-Italic.otf', 400, 'italic'],
        ['GeistMono-SemiBold.otf', 600],
        ['GeistMono-SemiBoldItalic.otf', 600, 'italic'],
        ['GeistMono-Thin.otf', 100],
        ['GeistMono-ThinItalic.otf', 100, 'italic'],
        ['GeistMono-UltraLight.otf', 200],
        ['GeistMono-UltraBlack.otf', 900],
      ]),
      'noto-symbols': family('NotoSansSymbols2', const <List<Object>>[
        ['NotoSansSymbols2-Regular.ttf', 400],
      ]),
    };
  }

  /// Sets `localizationKeys` on every component: the locale keys its own
  /// sources read, plus the keys of every unit it depends on, transitively.
  /// Installing a component therefore installs every string it can show.
  ///
  /// The key universe is `lib/src/manifests/locale_tables.json`, so run
  /// `tool/gen_locale_manifest.dart` before this generator.
  void _addLocalizationKeys(
    Map<String, Object?> componentJson, {
    required Map<String, Object?> foundation,
    required Map<String, Object?> theme,
    required Map<String, Object?> primitives,
  }) {
    final universe = _localeKeyUniverse();
    final nodes = <String, _LocaleNode>{};
    void addUnits(String layer, Map<String, Object?> units) {
      for (final entry in units.entries) {
        nodes['$layer:${entry.key}'] = _LocaleNode.of(
          entry.value as Map<String, Object?>,
        );
      }
    }

    addUnits('foundation', foundation);
    addUnits('theme', theme);
    addUnits('primitives', primitives);
    for (final entry in componentJson.entries) {
      nodes['components:${entry.key}'] = _LocaleNode.of(
        entry.value as Map<String, Object?>,
      );
    }

    final memo = <String, Set<String>>{};
    Set<String> closure(String token) {
      final cached = memo[token];
      if (cached != null) {
        return cached;
      }
      final node = nodes[token];
      final keys = <String>{};
      memo[token] = keys;
      if (node == null) {
        return keys;
      }
      for (final file in node.files) {
        if (file.startsWith('primitives/localizations/')) {
          continue;
        }
        keys.addAll(localeKeysUsedIn('$root/$file', universe));
      }
      for (final dep in node.deps) {
        keys.addAll(closure(dep));
      }
      return keys;
    }

    for (final id in componentJson.keys) {
      final keys = closure('components:$id').toList()..sort();
      (componentJson[id] as Map<String, Object?>)['localizationKeys'] = keys;
    }
  }

  /// Every key in `locale_tables.json`.
  Set<String> _localeKeyUniverse() {
    final file = File('$root/manifests/locale_tables.json');
    if (!file.existsSync()) {
      throw ManifestBuildException(
        'locale_tables.json is missing; run tool/gen_locale_manifest.dart',
      );
    }
    final tables = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    return (tables['keys'] as Map<String, dynamic>).keys.toSet();
  }

  String _sha256(String relPath) =>
      sha256.convert(File('$root/$relPath').readAsBytesSync()).toString();

  /// Every `path` listed in the `fonts` map, in manifest order.
  List<String> _fontPaths(Map<String, Object?> fontsJson) {
    final paths = <String>[];
    for (final pack in fontsJson.values) {
      for (final family in (pack as Map<String, Object?>)['families'] as List) {
        for (final file in (family as Map<String, Object?>)['files'] as List) {
          paths.add((file as Map<String, Object?>)['path']! as String);
        }
      }
    }
    return paths;
  }

  /// sha256 of a kit-root-relative file (the `fonts` paths live under
  /// `assets/`, outside `lib/src`, so [_sha256] cannot read them).
  String _sha256KitFile(String kitRelPath) {
    final file = File('$appRoot/$kitRelPath');
    if (!file.existsSync()) {
      throw ManifestBuildException("font file '$kitRelPath' does not exist");
    }
    return sha256.convert(file.readAsBytesSync()).toString();
  }

  Map<String, _Component> _readComponents() {
    final components = <String, _Component>{};
    for (final entity in Directory('$root/components').listSync()) {
      if (entity is! Directory) continue;
      final id = _baseName(entity.path);
      final metaFile = File('${entity.path}/meta.json');
      if (!metaFile.existsSync()) {
        throw ManifestBuildException("component '$id' has no meta.json");
      }
      final meta =
          jsonDecode(metaFile.readAsStringSync()) as Map<String, dynamic>;
      if (meta['id'] != id) {
        throw ManifestBuildException(
          "component '$id' meta.id is '${meta['id']}'",
        );
      }
      final files = meta['files'];
      if (files is! List) {
        throw ManifestBuildException("component '$id' has no files list");
      }
      final metaFiles = files.whereType<String>().toList();
      components[id] = _Component(
        id: id,
        meta: meta,
        metaFiles: metaFiles,
        userTheme: File('${entity.path}/${id}_theme.dart').existsSync()
            ? '${id}_theme.dart'
            : null,
        preview: metaFiles.contains('preview.dart') ? 'preview.dart' : null,
      );
    }
    return components;
  }

  Map<String, _Block> _readBlocks() {
    final dir = Directory('$root/blocks');
    if (!dir.existsSync()) {
      return const <String, _Block>{};
    }
    final blocks = <String, _Block>{};
    for (final entity in dir.listSync()) {
      if (entity is! Directory) continue;
      final id = _baseName(entity.path);
      final metaFile = File('${entity.path}/meta.json');
      if (!metaFile.existsSync()) {
        throw ManifestBuildException("block '$id' has no meta.json");
      }
      final meta =
          jsonDecode(metaFile.readAsStringSync()) as Map<String, dynamic>;
      if (meta['id'] != id) {
        throw ManifestBuildException("block '$id' meta.id is '${meta['id']}'");
      }
      final files = meta['files'];
      if (files is! List) {
        throw ManifestBuildException("block '$id' has no files list");
      }
      blocks[id] = _Block(
        id: id,
        meta: meta,
        metaFiles: files.whereType<String>().toList(),
      );
    }
    return blocks;
  }

  Map<String, _Flow> _readFlows() {
    final dir = Directory('$root/flows');
    if (!dir.existsSync()) {
      return const <String, _Flow>{};
    }
    final flows = <String, _Flow>{};
    for (final entity in dir.listSync()) {
      if (entity is! Directory) continue;
      final id = _baseName(entity.path);
      final metaFile = File('${entity.path}/meta.json');
      if (!metaFile.existsSync()) {
        throw ManifestBuildException("flow '$id' has no meta.json");
      }
      final meta =
          jsonDecode(metaFile.readAsStringSync()) as Map<String, dynamic>;
      if (meta['id'] != id) {
        throw ManifestBuildException("flow '$id' meta.id is '${meta['id']}'");
      }
      final files = meta['files'];
      if (files is! List) {
        throw ManifestBuildException("flow '$id' has no files list");
      }
      flows[id] = _Flow(
        id: id,
        meta: meta,
        metaFiles: files.whereType<String>().toList(),
      );
    }
    return flows;
  }

  Map<String, _Starter> _readStarters() {
    final dir = Directory('$root/starters');
    if (!dir.existsSync()) {
      return const <String, _Starter>{};
    }
    final starters = <String, _Starter>{};
    for (final entity in dir.listSync()) {
      if (entity is! Directory) continue;
      final id = _baseName(entity.path);
      final metaFile = File('${entity.path}/starter.json');
      if (!metaFile.existsSync()) {
        throw ManifestBuildException("starter '$id' has no starter.json");
      }
      final meta =
          jsonDecode(metaFile.readAsStringSync()) as Map<String, dynamic>;
      if (meta['id'] != id) {
        throw ManifestBuildException(
          "starter '$id' starter.id is '${meta['id']}'",
        );
      }
      starters[id] = _Starter(id: id, meta: meta);
    }
    return starters;
  }

  void _validateStarters(
    Map<String, _Starter> starters,
    Map<String, _Flow> flows,
    Map<String, _Block> blocks,
    Map<String, _Component> components,
    Map<String, Object?> themes,
  ) {
    const allowedPlatforms = <String>{
      'ios',
      'android',
      'web',
      'macos',
      'windows',
      'linux',
    };
    for (final starter in starters.values) {
      final meta = starter.meta;
      final id = starter.id;
      if (meta['type'] != 'starter') {
        throw ManifestBuildException(
          "starter '$id' type '${meta['type']}' is not 'starter'",
        );
      }
      if (meta['name'] is! String || (meta['name'] as String).isEmpty) {
        throw ManifestBuildException("starter '$id' has no name");
      }
      final description = meta['description'];
      if (description is! String || description.isEmpty) {
        throw ManifestBuildException("starter '$id' has no description");
      }
      final preset = meta['themePreset'];
      if (preset is! String || !themes.containsKey(preset)) {
        throw ManifestBuildException(
          "starter '$id' themePreset '$preset' is not a theme",
        );
      }
      final platforms = meta['platforms'];
      if (platforms is! List ||
          platforms.isEmpty ||
          !platforms.whereType<String>().every(allowedPlatforms.contains)) {
        throw ManifestBuildException(
          "starter '$id' platforms must be a non-empty subset of "
          'ios, android, web, macos, windows, linux',
        );
      }
      for (final key in <String>['flows', 'blocks', 'components']) {
        final list = meta[key];
        if (list is! List) {
          throw ManifestBuildException("starter '$id' has no $key list");
        }
      }
      for (final flowId in (meta['flows'] as List).whereType<String>()) {
        if (!flows.containsKey(flowId)) {
          throw ManifestBuildException(
            "starter '$id' flow '$flowId' does not exist",
          );
        }
      }
      for (final blockId in (meta['blocks'] as List).whereType<String>()) {
        if (!blocks.containsKey(blockId)) {
          throw ManifestBuildException(
            "starter '$id' block '$blockId' does not exist",
          );
        }
      }
      for (final componentId
          in (meta['components'] as List).whereType<String>()) {
        if (!components.containsKey(componentId)) {
          throw ManifestBuildException(
            "starter '$id' component '$componentId' does not exist",
          );
        }
      }
      final routes = meta['routes'];
      if (routes is! List || routes.isEmpty) {
        throw ManifestBuildException("starter '$id' has no routes list");
      }
      for (final route in routes) {
        if (route is! Map) {
          throw ManifestBuildException("starter '$id' has a bad route");
        }
        final map = route.map(
          (Object? k, Object? v) => MapEntry(k.toString(), v),
        );
        for (final key in <String>['path', 'title', 'kind', 'ref']) {
          if (map[key] is! String || (map[key] as String).isEmpty) {
            throw ManifestBuildException("starter '$id' route misses $key");
          }
        }
        final kind = map['kind'] as String;
        final ref = map['ref'] as String;
        if (kind == 'flow' && !flows.containsKey(ref)) {
          throw ManifestBuildException(
            "starter '$id' route ref flow '$ref' does not exist",
          );
        }
        if (kind == 'block' && !blocks.containsKey(ref)) {
          throw ManifestBuildException(
            "starter '$id' route ref block '$ref' does not exist",
          );
        }
        if (kind != 'flow' && kind != 'block' && kind != 'page') {
          throw ManifestBuildException(
            "starter '$id' route kind '$kind' is not flow, block or page",
          );
        }
      }
      final files = meta['files'];
      if (files is! List || files.isEmpty) {
        throw ManifestBuildException("starter '$id' has no files list");
      }
      for (final entry in files) {
        if (entry is! Map) {
          throw ManifestBuildException("starter '$id' has a bad file entry");
        }
        final map = entry.map(
          (Object? k, Object? v) => MapEntry(k.toString(), v),
        );
        final template = map['template'];
        final target = map['target'];
        if (template is! String || template.isEmpty) {
          throw ManifestBuildException("starter '$id' file misses template");
        }
        if (target is! String || target.isEmpty) {
          throw ManifestBuildException("starter '$id' file misses target");
        }
        if (!File('$root/$template').existsSync()) {
          throw ManifestBuildException(
            "starter '$id' template '$template' does not exist",
          );
        }
        if (!target.startsWith('lib/') && !target.startsWith('test/')) {
          throw ManifestBuildException(
            "starter '$id' target '$target' must start with lib/ or test/",
          );
        }
      }
      if (!File('$root/starters/$id/README.md').existsSync()) {
        throw ManifestBuildException("starter '$id' has no README.md");
      }
    }
  }

  void _validateFlows(
    Map<String, _Flow> flows,
    Map<String, _Block> blocks,
    Map<String, _Component> components,
    LayerScan foundation,
    LayerScan theme,
    LayerScan primitives,
  ) {
    for (final flow in flows.values) {
      final meta = flow.meta;
      final id = flow.id;
      if (meta['type'] != 'flow') {
        throw ManifestBuildException(
          "flow '$id' type '${meta['type']}' is not 'flow'",
        );
      }
      if (meta['name'] is! String || (meta['name'] as String).isEmpty) {
        throw ManifestBuildException("flow '$id' has no name");
      }
      final description = meta['description'];
      if (description is! String || description.isEmpty) {
        throw ManifestBuildException("flow '$id' has no description");
      }
      final screens = meta['screens'];
      if (screens is! List || screens.isEmpty) {
        throw ManifestBuildException("flow '$id' has no screens list");
      }
      final viewport = meta['viewport'];
      if (viewport is! String || !blockViewports.contains(viewport)) {
        throw ManifestBuildException(
          "flow '$id' viewport '$viewport' is not one of "
          '${blockViewports.join(', ')}',
        );
      }
      if (!File('$root/flows/$id/README.md').existsSync()) {
        throw ManifestBuildException("flow '$id' has no README.md");
      }
      if (!File('$root/flows/$id/flow.dart').existsSync()) {
        throw ManifestBuildException("flow '$id' has no entry file flow.dart");
      }
      final deps = flow.deps;
      const expectedKeys = <String>{
        'foundation',
        'theme',
        'primitives',
        'components',
        'blocks',
      };
      if (deps.length != expectedKeys.length ||
          !expectedKeys.every(deps.containsKey)) {
        throw ManifestBuildException(
          "flow '$id' deps must have exactly "
          'foundation, theme, primitives, components, blocks',
        );
      }
      _checkLayerDeps(flow, 'foundation', foundation.units.keys.toSet());
      _checkLayerDeps(flow, 'theme', theme.units.keys.toSet());
      _checkLayerDeps(flow, 'primitives', primitives.units.keys.toSet());
      _checkLayerDeps(flow, 'components', components.keys.toSet());
      _checkLayerDeps(flow, 'blocks', blocks.keys.toSet());
      for (final file in flow.metaFiles) {
        if (!File('$root/flows/$id/$file').existsSync()) {
          throw ManifestBuildException(
            "flow '$id' files entry '$file' does not exist",
          );
        }
      }
    }
  }

  void _validateBlocks(
    Map<String, _Block> blocks,
    Map<String, _Component> components,
    LayerScan foundation,
    LayerScan theme,
    LayerScan primitives,
  ) {
    for (final block in blocks.values) {
      final meta = block.meta;
      final id = block.id;
      if (meta['name'] is! String || (meta['name'] as String).isEmpty) {
        throw ManifestBuildException("block '$id' has no name");
      }
      final description = meta['description'];
      if (description is! String || description.isEmpty) {
        throw ManifestBuildException("block '$id' has no description");
      }
      final category = meta['category'];
      if (category is! String || !isBlockCategory(category)) {
        throw ManifestBuildException(
          "block '$id' category '$category' is not one of the block "
          'categories (${blockCategories.join(', ')})',
        );
      }
      final viewport = meta['viewport'];
      if (viewport is! String || !blockViewports.contains(viewport)) {
        throw ManifestBuildException(
          "block '$id' viewport '$viewport' is not one of "
          '${blockViewports.join(', ')}',
        );
      }
      if (!File('$root/blocks/$id/README.md').existsSync()) {
        throw ManifestBuildException("block '$id' has no README.md");
      }
      final deps = block.deps;
      const expectedKeys = <String>{
        'foundation',
        'theme',
        'primitives',
        'components',
      };
      if (deps.length != expectedKeys.length ||
          !expectedKeys.every(deps.containsKey)) {
        throw ManifestBuildException(
          "block '$id' deps must have exactly "
          'foundation, theme, primitives, components',
        );
      }
      _checkLayerDeps(block, 'foundation', foundation.units.keys.toSet());
      _checkLayerDeps(block, 'theme', theme.units.keys.toSet());
      _checkLayerDeps(block, 'primitives', primitives.units.keys.toSet());
      for (final entry in (deps['components'] as List).whereType<String>()) {
        if (entry == id) {
          throw ManifestBuildException("block '$id' depends on itself");
        }
      }
      _checkLayerDeps(block, 'components', components.keys.toSet());
      for (final file in block.metaFiles) {
        if (!File('$root/blocks/$id/$file').existsSync()) {
          throw ManifestBuildException(
            "block '$id' files entry '$file' does not exist",
          );
        }
      }
    }
  }

  Map<String, Set<String>> _declaredLayerIds(
    Map<String, _Component> components,
    Map<String, _Block> blocks,
    Map<String, _Flow> flows,
  ) {
    final declared = <String, Set<String>>{
      'foundation': <String>{},
      'theme': <String>{},
      'primitives': <String>{},
    };
    for (final owner in <Map<String, _Buildable>>[components, blocks, flows]) {
      for (final unit in owner.values) {
        for (final layer in declared.keys) {
          final list = unit.deps[layer];
          if (list is! List) {
            throw ManifestBuildException(
              "${unit.kindLabel} '${unit.id}' deps.$layer is missing",
            );
          }
          declared[layer]!.addAll(list.whereType<String>());
        }
      }
    }
    return declared;
  }

  void _validateComponentDeps(
    Map<String, _Component> components,
    LayerScan foundation,
    LayerScan theme,
    LayerScan primitives,
  ) {
    const expectedKeys = <String>{
      'foundation',
      'theme',
      'primitives',
      'components',
    };
    for (final component in components.values) {
      final deps = component.deps;
      if (deps.length != expectedKeys.length ||
          !expectedKeys.every(deps.containsKey)) {
        throw ManifestBuildException(
          "component '${component.id}' deps must have exactly "
          'foundation, theme, primitives, components',
        );
      }
      final category = component.meta['category'];
      if (category is! String || !isComponentCategory(category)) {
        throw ManifestBuildException(
          "component '${component.id}' category '$category' is not one of "
          'the component categories (${componentCategories.join(', ')})',
        );
      }
      _checkLayerDeps(component, 'foundation', foundation.units.keys.toSet());
      _checkLayerDeps(component, 'theme', theme.units.keys.toSet());
      _checkLayerDeps(component, 'primitives', primitives.units.keys.toSet());
      for (final entry in (deps['components'] as List).whereType<String>()) {
        if (!components.containsKey(entry)) {
          throw ManifestBuildException(
            "component '${component.id}' deps.components '$entry' does not exist",
          );
        }
        if (entry == component.id) {
          throw ManifestBuildException(
            "component '${component.id}' depends on itself",
          );
        }
      }
      final entryFile = '$root/components/${component.id}/${component.id}.dart';
      if (!File(entryFile).existsSync()) {
        throw ManifestBuildException(
          "component '${component.id}' has no entry file",
        );
      }
      if (!component.metaFiles.contains('${component.id}.dart')) {
        throw ManifestBuildException(
          "component '${component.id}' files list misses '${component.id}.dart'",
        );
      }
      for (final file in component.metaFiles) {
        if (!File('$root/components/${component.id}/$file').existsSync()) {
          throw ManifestBuildException(
            "component '${component.id}' files entry '$file' does not exist",
          );
        }
      }
      final import = component.meta['import'];
      if (import is! String ||
          !import.contains('/ui/dashcn/components/${component.id}/')) {
        throw ManifestBuildException(
          "component '${component.id}' meta import must use "
          'ui/dashcn/components/<id>/',
        );
      }
    }
  }

  void _checkLayerDeps(_Buildable unit, String layer, Set<String> unitIds) {
    for (final entry in (unit.deps[layer] as List).whereType<String>()) {
      if (!unitIds.contains(entry)) {
        throw ManifestBuildException(
          "${unit.kindLabel} '${unit.id}' deps.$layer entry '$entry' does "
          'not exist',
        );
      }
    }
  }

  Map<String, Object?> _unitsJson(LayerScan scan) {
    final json = <String, Object?>{};
    for (final id in scan.units.keys.toList()..sort()) {
      final files = scan.units[id]!;
      final entry = <String, Object?>{'files': files};
      final packages = _packagesFor(files);
      if (packages.isNotEmpty) {
        entry['packages'] = packages;
      }
      json[id] = entry;
    }
    return json;
  }

  Map<String, Object?> _primitivesJson(
    LayerScan scan,
    Map<String, List<String>> deps,
  ) {
    final json = <String, Object?>{};
    for (final id in scan.units.keys.toList()..sort()) {
      final files = scan.units[id]!;
      final entry = <String, Object?>{
        'files': files,
        'deps': <String, Object?>{'primitives': deps[id]},
      };
      final packages = _packagesFor(files);
      if (packages.isNotEmpty) {
        entry['packages'] = packages;
      }
      json[id] = entry;
    }
    return json;
  }

  Map<String, Object?> _componentJson(
    _Component component,
    Map<String, String> hashes,
  ) {
    final id = component.id;
    final userOwned = component.userTheme == null
        ? <String>[]
        : <String>['components/$id/${component.userTheme}'];
    final files = <String>[
      for (final file in component.metaFiles)
        if (file != 'preview.dart' && file != component.userTheme)
          'components/$id/$file',
    ]..sort();
    final json = <String, Object?>{
      'name': component.meta['name'],
      'category': component.meta['category'],
      'description': component.meta['description'] ?? '',
      'entry': 'components/$id/$id.dart',
      'files': files,
      'userOwned': userOwned,
      'deps': component.meta['deps'],
      'tags': component.meta['tags'] ?? const <String>[],
      'listed': component.meta['listed'] != false,
      'api': component.meta['api'] ?? const <String, Object?>{},
      'preview': <String, Object?>{
        'placement': previewPlacementOf(id, component.meta),
      },
      'install': component.meta['install'],
      'import': component.meta['import'],
    };
    if (component.meta['theme'] != null) {
      json['theme'] = component.meta['theme'];
    }
    final packages = _packagesFor(<String>[
      for (final file in component.metaFiles) 'components/$id/$file',
    ]);
    if (packages.isNotEmpty) {
      json['packages'] = packages;
    }
    for (final file in files) {
      hashes[file] = _sha256(file);
    }
    for (final file in userOwned) {
      hashes[file] = _sha256(file);
    }
    if (component.preview != null) {
      final preview = 'components/$id/${component.preview}';
      hashes[preview] = _sha256(preview);
    }
    return json;
  }

  Map<String, Object?> _blockJson(_Block block, Map<String, String> hashes) {
    final id = block.id;
    // The entry file is the install target; the README is documentation, so
    // it is hashed but never copied into the app.
    final files = <String>[
      for (final file in block.metaFiles)
        if (file.endsWith('.dart')) 'blocks/$id/$file',
    ]..sort();
    final docs = <String>[
      if (File('$root/blocks/$id/README.md').existsSync())
        'blocks/$id/README.md',
    ];
    final json = <String, Object?>{
      'name': block.meta['name'],
      'category': block.meta['category'],
      'description': block.meta['description'],
      'viewport': block.meta['viewport'],
      'entry': 'blocks/$id/${blockStem(id)}.dart',
      'files': files,
      'docs': docs,
      'deps': block.meta['deps'],
      'tags': block.meta['tags'] ?? const <String>[],
      'install': block.meta['install'],
      'import': block.meta['import'],
    };
    final packages = _packagesFor(<String>[
      for (final file in block.metaFiles)
        if (file.endsWith('.dart')) 'blocks/$id/$file',
    ]);
    if (packages.isNotEmpty) {
      json['packages'] = packages;
    }
    for (final file in files) {
      hashes[file] = _sha256(file);
    }
    for (final file in docs) {
      hashes[file] = _sha256(file);
    }
    return json;
  }

  Map<String, Object?> _flowJson(_Flow flow, Map<String, String> hashes) {
    final id = flow.id;
    // The entry file is the install target; the README is documentation, so
    // it is hashed but never copied into the app.
    final files = <String>[
      for (final file in flow.metaFiles)
        if (file.endsWith('.dart')) 'flows/$id/$file',
    ]..sort();
    final docs = <String>[
      if (File('$root/flows/$id/README.md').existsSync()) 'flows/$id/README.md',
    ];
    final json = <String, Object?>{
      'type': 'flow',
      'name': flow.meta['name'],
      'description': flow.meta['description'],
      'viewport': flow.meta['viewport'],
      'screens': (flow.meta['screens'] as List).whereType<String>().toList(),
      'entry': 'flows/$id/flow.dart',
      'files': files,
      'docs': docs,
      'deps': flow.meta['deps'],
      'tags': flow.meta['tags'] ?? const <String>[],
      'install': flow.meta['install'],
      'import': flow.meta['import'],
    };
    final packages = _packagesFor(<String>[
      for (final file in flow.metaFiles)
        if (file.endsWith('.dart')) 'flows/$id/$file',
    ]);
    if (packages.isNotEmpty) {
      json['packages'] = packages;
    }
    for (final file in files) {
      hashes[file] = _sha256(file);
    }
    for (final file in docs) {
      hashes[file] = _sha256(file);
    }
    return json;
  }

  Map<String, Object?> _starterJson(
    _Starter starter,
    Map<String, String> hashes,
  ) {
    final id = starter.id;
    final meta = starter.meta;
    final files = <String>[
      for (final entry in (meta['files'] as List))
        (entry as Map)['template'] as String,
    ]..sort();
    final docs = <String>[
      if (File('$root/starters/$id/README.md').existsSync())
        'starters/$id/README.md',
      if (File('$root/starters/$id/starter.json').existsSync())
        'starters/$id/starter.json',
    ];
    final json = <String, Object?>{
      'type': 'starter',
      'name': meta['name'],
      'description': meta['description'],
      'themePreset': meta['themePreset'],
      'platforms': (meta['platforms'] as List).whereType<String>().toList(),
      'flows': (meta['flows'] as List).whereType<String>().toList(),
      'blocks': (meta['blocks'] as List).whereType<String>().toList(),
      'components': (meta['components'] as List).whereType<String>().toList(),
      'routes': (meta['routes'] as List).toList(),
      'files': (meta['files'] as List).toList(),
      'docs': docs,
      'tags': meta['tags'] ?? const <String>[],
      'install': meta['install'],
    };
    for (final file in [...files, ...docs]) {
      hashes[file] = _sha256(file);
    }
    return json;
  }

  Map<String, Object?> _themesJson() {
    final dir = Directory('$root/themes');
    if (!dir.existsSync()) {
      throw ManifestBuildException('themes directory is missing');
    }
    final files =
        dir
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('.json'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));
    final json = <String, Object?>{};
    for (final file in files) {
      final name = _baseName(file.path);
      if (name == 'index.json' || name == 'themes.schema.json') {
        continue;
      }
      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final id = data['id'];
      final presetName = data['name'];
      if (id is! String || '$id.json' != name) {
        throw ManifestBuildException("theme '$name' has a mismatched id '$id'");
      }
      if (presetName is! String || presetName.isEmpty) {
        throw ManifestBuildException("theme '$name' has no name");
      }
      if (data['light'] is! Map || data['dark'] is! Map) {
        throw ManifestBuildException(
          "theme '$name' must define light and dark",
        );
      }
      json[id] = <String, Object?>{
        'file': 'themes/$name',
        'name': presetName,
        'modes': <String>['light', 'dark'],
      };
    }
    return json;
  }

  List<Map<String, Object?>> _packagesFor(List<String> relFiles) {
    final names = <String>{};
    for (final file in relFiles) {
      for (final uri in directiveUris('$root/$file')) {
        if (!uri.startsWith('package:')) continue;
        final name = uri.substring('package:'.length).split('/').first;
        if (name == 'flutter' || name == 'dashcn') continue;
        names.add(name);
      }
    }
    final entries = <Map<String, Object?>>[];
    for (final name in names.toList()..sort()) {
      if (name == 'flutter_localizations') {
        entries.add(<String, Object?>{'name': name, 'sdk': true});
        continue;
      }
      final constraint = constraints[name];
      if (constraint == null) {
        throw ManifestBuildException(
          "package '$name' is imported but has no pubspec constraint",
        );
      }
      entries.add(<String, Object?>{'name': name, 'constraint': constraint});
    }
    return entries;
  }
}

String _baseName(String path) => path.split(Platform.pathSeparator).last;

/// One unit's files and dependency tokens (`layer:id`) for the locale-key
/// closure.
class _LocaleNode {
  _LocaleNode(this.files, this.deps);

  factory _LocaleNode.of(Map<String, Object?> entry) {
    final files = (entry['files'] as List).cast<String>();
    final deps = <String>[];
    final rawDeps = entry['deps'];
    if (rawDeps is Map) {
      for (final layer in const <String>[
        'components',
        'foundation',
        'theme',
        'primitives',
      ]) {
        for (final id in (rawDeps[layer] as List?) ?? const <Object?>[]) {
          deps.add('$layer:$id');
        }
      }
    }
    return _LocaleNode(files, deps);
  }

  final List<String> files;
  final List<String> deps;
}
