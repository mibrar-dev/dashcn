// Offline locale installer for user projects: the single implementation of
// `dashcn locale add <code>` and of the locale step of `dashcn add <component>`.
//
// Usage (from `dashcn/`):
//   dart run tool/locale.dart list [--json] [--manifest <path>]
//   dart run tool/locale.dart add <code> [--dir <project-dir>]
//       [--manifest <path>] [--registry <path>]
//   dart run tool/locale.dart component <id> [--dir <project-dir>]
//       [--manifest <path>] [--registry <path>]
//
// Project state lives in `<dir>/dashcn_locales/`:
//   dashcn_locale_<suffix>.dart  one ComponentLocalizations subclass per
//                                installed locale, overriding exactly the keys
//                                the project's components need (English is the
//                                base table, `dashcn_locale_en.dart`);
//   dashcn_locales.dart          barrel exposing `dashcnLocalesDelegates` and
//                                `dashcnSupportedLocales`;
//   state.json                   the components and locales this tool installed.
// Components installed by `dashcn add` are also read from `<dir>/dashcn.lock`.
//
// `component <id>` installs the English base and the strings that component
// needs (`localizationKeys` in the registry manifest, transitively). `add <code>`
// installs a language for every component already in the project. Both write
// only files whose content changed, so repeating a command is a no-op.
//
// `--manifest` points at a vendored copy of `locale_tables.json`, and
// `--registry` at `registry.json`. Both keep the tool offline: no network, no
// third-party packages.
import 'dart:convert';
import 'dart:io';

const String _defaultManifestPath = 'lib/src/manifests/locale_tables.json';
const String _defaultRegistryPath = 'lib/src/manifests/registry.json';
const String _baseLocale = 'en';
const String _localesDirName = 'dashcn_locales';
const String _stateFileName = 'state.json';
const String _lockFileName = 'dashcn.lock';

const Map<String, String> _classNames = <String, String>{
  'en': 'DashcnLocaleEn',
  'ar': 'DashcnLocaleAr',
  'he': 'DashcnLocaleHe',
  'fa': 'DashcnLocaleFa',
  'ur': 'DashcnLocaleUr',
  'de': 'DashcnLocaleDe',
  'fr': 'DashcnLocaleFr',
  'es': 'DashcnLocaleEs',
  'it': 'DashcnLocaleIt',
  'pt': 'DashcnLocalePt',
  'pt-BR': 'DashcnLocalePtBr',
  'nl': 'DashcnLocaleNl',
  'ru': 'DashcnLocaleRu',
  'tr': 'DashcnLocaleTr',
  'ja': 'DashcnLocaleJa',
  'ko': 'DashcnLocaleKo',
  'zh': 'DashcnLocaleZh',
  'zh-Hans': 'DashcnLocaleZhHans',
  'hi': 'DashcnLocaleHi',
};

String _fileSuffix(String code) => code.replaceAll('-', '_').toLowerCase();

/// `Locale(...)` constructor expression for [code].
String _localeExpr(String code) {
  final List<String> parts = code.split('-');
  if (parts.length == 2 &&
      parts[1].length == 2 &&
      parts[1] == parts[1].toUpperCase()) {
    return "const Locale('${parts[0]}', '${parts[1]}')";
  }
  if (code == 'zh-Hans') {
    return "const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans')";
  }
  return "const Locale('$code')";
}

Map<String, dynamic> loadManifest([String path = _defaultManifestPath]) {
  final File file = File(path);
  if (!file.existsSync()) {
    throw StateError(
      'locale manifest not found at $path; run tool/gen_locale_manifest.dart first.',
    );
  }
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

/// The registry manifest (`registry.json`), which carries each component's
/// `localizationKeys`.
Map<String, dynamic> loadRegistry([String path = _defaultRegistryPath]) {
  final File file = File(path);
  if (!file.existsSync()) {
    throw StateError(
      'registry manifest not found at $path; run tool/registry/gen_registry_manifest.dart first.',
    );
  }
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

/// Resolves the full key -> expression table for [code], merging inherited
/// tables and falling back to the English defaults. [_baseLocale] is the
/// English table itself.
Map<String, String> resolveTable(Map<String, dynamic> manifest, String code) {
  final Map<String, dynamic> locales = (manifest['locales'] as Map)
      .cast<String, dynamic>();
  final Map<String, dynamic> keys = (manifest['keys'] as Map)
      .cast<String, dynamic>();
  final Map<String, String> table = <String, String>{};
  for (final String key in keys.keys) {
    table[key] = (keys[key] as Map)['en'] as String;
  }
  if (code == _baseLocale) {
    return table;
  }
  if (!locales.containsKey(code)) {
    throw ArgumentError.value(code, 'code', 'unsupported locale');
  }
  void apply(String c) {
    final Map<String, dynamic> locale = (locales[c] as Map)
        .cast<String, dynamic>();
    final String? parent = locale['inherits'] as String?;
    if (parent != null) {
      apply(parent);
    }
    final Map<String, dynamic> overrides = (locale['overrides'] as Map)
        .cast<String, dynamic>();
    for (final MapEntry<String, dynamic> e in overrides.entries) {
      table[e.key] = e.value as String;
    }
  }

  apply(code);
  return table;
}

String _memberDart(String key, String signature, String expression) {
  if (signature.isEmpty) {
    return '  @override\n  String get $key => $expression;';
  }
  return '  @override\n  String $key$signature => $expression;';
}

/// Generates the locale file for [code], overriding exactly [keys]. Keys the
/// project does not need fall back to English through `ComponentLocalizations`.
/// Output depends only on [code] and [keys], so re-running is byte-identical.
String generateLocaleFile(
  Map<String, dynamic> manifest,
  String code,
  Set<String> keys,
) {
  final String className = _classNames[code]!;
  final Map<String, String> table = resolveTable(manifest, code);
  final Map<String, dynamic> manifestKeys = (manifest['keys'] as Map)
      .cast<String, dynamic>();
  final List<String> names = keys.toList()..sort();
  final List<String> members = <String>[];
  for (final String key in names) {
    final String? expression = table[key];
    if (expression == null) {
      throw ArgumentError.value(key, 'keys', 'unknown locale key');
    }
    final String sig = (manifestKeys[key] as Map)['signature'] as String;
    members.add(_memberDart(key, sig, expression));
  }
  // The number helper and its intl import are emitted only when a key uses
  // them, so no file carries an unused import or an unused private member.
  final bool usesNumber = members.any((String m) => m.contains('_number('));
  final StringBuffer out = StringBuffer();
  out.writeln('// GENERATED by `dart run tool/locale.dart` —');
  out.writeln(
    '// do not edit by hand. Re-run `add` or `component` after a kit upgrade.',
  );
  out.writeln();
  out.writeln("import 'package:flutter/widgets.dart';");
  if (usesNumber) {
    out.writeln("import 'package:intl/intl.dart' as intl;");
  }
  out.writeln();
  out.writeln(
    "import 'package:dashcn/src/primitives/localizations/localizations.dart';",
  );
  out.writeln();
  out.writeln('/// $code strings for this project.');
  out.writeln('///');
  out.writeln(
    '/// Overrides only the keys this project\'s components need; every other',
  );
  out.writeln('/// key falls back to English through ComponentLocalizations.');
  out.writeln('class $className extends ComponentLocalizations {');
  out.writeln('  /// Creates the $code strings.');
  out.writeln('  const $className() : super(${_localeExpr(code)});');
  if (usesNumber) {
    out.writeln();
    out.writeln('  /// Formats [value] as a number in this locale.');
    out.writeln('  String _number(Object? value) {');
    out.writeln("    if (value is! num) return '\$value';");
    out.writeln(
      '    return intl.NumberFormat.decimalPattern(localeName).format(value);',
    );
    out.writeln('  }');
  }
  for (final String member in members) {
    out.writeln();
    out.writeln(member);
  }
  out.writeln('}');
  return out.toString();
}

/// Generates the barrel wiring every locale in [codes].
String generateBarrel(Map<String, dynamic> manifest, List<String> codes) {
  final List<String> sorted = codes.toList()..sort();
  final StringBuffer out = StringBuffer();
  out.writeln('// GENERATED by `dart run tool/locale.dart` —');
  out.writeln('// do not edit by hand. Re-run `add` after a kit upgrade.');
  out.writeln('//');
  out.writeln('// Import this barrel and spread its members into your app:');
  out.writeln('// ```dart');
  out.writeln('// MaterialApp(');
  out.writeln('//   localizationsDelegates: [');
  out.writeln('//     ...dashcnLocalesDelegates,');
  out.writeln('//     GlobalMaterialLocalizations.delegate,');
  out.writeln('//     GlobalWidgetsLocalizations.delegate,');
  out.writeln('//   ],');
  out.writeln('//   supportedLocales: dashcnSupportedLocales,');
  out.writeln('//   ...');
  out.writeln('// );');
  out.writeln('// ```');
  out.writeln();
  out.writeln(
    "import 'package:flutter/foundation.dart' show SynchronousFuture;",
  );
  out.writeln("import 'package:flutter/widgets.dart';");
  out.writeln();
  out.writeln(
    "import 'package:dashcn/src/primitives/localizations/localizations.dart';",
  );
  for (final String code in sorted) {
    out.writeln("import 'dashcn_locale_${_fileSuffix(code)}.dart';");
  }
  out.writeln();
  out.writeln('/// Supported locales for every installed locale.');
  out.writeln('final List<Locale> dashcnSupportedLocales = <Locale>[');
  for (final String code in sorted) {
    out.writeln('  ${_localeExpr(code)},');
  }
  out.writeln('];');
  out.writeln();
  out.writeln('/// Delegate serving every installed locale.');
  out.writeln(
    'class DashcnLocalesDelegate extends LocalizationsDelegate<ComponentLocalizations> {',
  );
  out.writeln('  /// Creates the delegate.');
  out.writeln('  const DashcnLocalesDelegate();');
  out.writeln();
  out.writeln('  ComponentLocalizations _load(String code) => switch (code) {');
  for (final String code in sorted) {
    out.writeln("    '$code' => const ${_classNames[code]}(),");
  }
  out.writeln('    _ => ComponentLocalizations.english,');
  out.writeln('  };');
  out.writeln();
  out.writeln('  static String _key(Locale locale) {');
  out.writeln("    if (locale.countryCode == 'BR' &&");
  out.writeln("        locale.languageCode == 'pt') {");
  out.writeln("      return 'pt-BR';");
  out.writeln('    }');
  out.writeln("    if (locale.scriptCode == 'Hans' &&");
  out.writeln("        locale.languageCode == 'zh') {");
  out.writeln("      return 'zh-Hans';");
  out.writeln('    }');
  out.writeln('    return locale.languageCode;');
  out.writeln('  }');
  out.writeln();
  out.writeln('  @override');
  out.writeln('  bool isSupported(Locale locale) => <String>{');
  for (final String code in sorted) {
    out.writeln("    '$code',");
  }
  out.writeln('  }.contains(_key(locale));');
  out.writeln();
  out.writeln('  @override');
  out.writeln(
    '  Future<ComponentLocalizations> load(Locale locale) => SynchronousFuture<ComponentLocalizations>(',
  );
  out.writeln('    _load(_key(locale)),');
  out.writeln('  );');
  out.writeln();
  out.writeln('  @override');
  out.writeln('  bool shouldReload(DashcnLocalesDelegate old) => false;');
  out.writeln('}');
  out.writeln();
  out.writeln('/// Delegates covering every installed locale.');
  out.writeln(
    'const List<LocalizationsDelegate<ComponentLocalizations>> dashcnLocalesDelegates =',
  );
  out.writeln('    <LocalizationsDelegate<ComponentLocalizations>>[');
  out.writeln('  DashcnLocalesDelegate(),');
  out.writeln('];');
  return out.toString();
}

/// Prints the locale list; returns the lines (useful for tests).
List<String> localeList(Map<String, dynamic> manifest, {bool json = false}) {
  final Map<String, dynamic> locales = (manifest['locales'] as Map)
      .cast<String, dynamic>();
  final List<String> codes = locales.keys.toList()..sort();
  if (json) {
    final Map<String, dynamic> payload = <String, dynamic>{};
    for (final String code in codes) {
      final Map<String, dynamic> locale = (locales[code] as Map)
          .cast<String, dynamic>();
      payload[code] = <String, dynamic>{
        'direction': locale['direction'],
        'keys': (locale['overrides'] as Map).length,
        if (locale['inherits'] != null) 'inherits': locale['inherits'],
      };
    }
    final String line = jsonEncode(payload);
    stdout.writeln(line);
    return <String>[line];
  }
  final List<String> lines = <String>['code     direction keys'];
  for (final String code in codes) {
    final Map<String, dynamic> locale = (locales[code] as Map)
        .cast<String, dynamic>();
    lines.add(
      '${code.padRight(9)}${(locale['direction'] as String).padRight(10)}${(locale['overrides'] as Map).length}',
    );
  }
  for (final String line in lines) {
    stdout.writeln(line);
  }
  return lines;
}

/// The locale keys [component] needs, from the registry manifest. Throws
/// [ArgumentError] for an unknown component.
List<String> componentKeys(Map<String, dynamic> registry, String component) {
  final Map<String, dynamic> components = (registry['components'] as Map)
      .cast<String, dynamic>();
  final Object? entry = components[component];
  if (entry == null) {
    final String known = (components.keys.toList()..sort()).join(', ');
    throw ArgumentError.value(
      component,
      'component',
      'unknown component; known: $known',
    );
  }
  final Object? keys = (entry as Map)['localizationKeys'];
  if (keys is! List) {
    throw StateError(
      'registry entry for $component has no localizationKeys; regenerate the registry manifest.',
    );
  }
  return keys.cast<String>();
}

/// The state this tool records in `<dir>/dashcn_locales/state.json`.
class _ProjectState {
  const _ProjectState({required this.components, required this.locales});

  /// Components installed through this tool.
  final Set<String> components;

  /// Locales installed in this project, including the English base.
  final Set<String> locales;
}

Set<String> _stringSet(Object? value) {
  if (value is! List) {
    return <String>{};
  }
  return value.whereType<String>().toSet();
}

_ProjectState _readState(String dir) {
  final File file = File('$dir/$_localesDirName/$_stateFileName');
  if (!file.existsSync()) {
    return const _ProjectState(components: <String>{}, locales: <String>{});
  }
  final Map<String, dynamic> json =
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return _ProjectState(
    components: _stringSet(json['components']),
    locales: _stringSet(json['locales']),
  );
}

/// Component ids `dashcn.lock` records as installed. Empty without a lock.
Set<String> _lockedComponents(String dir) {
  final File file = File('$dir/$_lockFileName');
  if (!file.existsSync()) {
    return <String>{};
  }
  final Map<String, dynamic> json =
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final Object? list = json['components'];
  if (list is! List) {
    return <String>{};
  }
  return <String>{
    for (final Object? entry in list)
      if (entry is Map && entry['id'] is String) entry['id'] as String,
  };
}

/// Writes [content] unless the file already holds exactly that. Returns
/// whether it wrote.
bool _writeIfChanged(File file, String content) {
  if (file.existsSync() && file.readAsStringSync() == content) {
    return false;
  }
  file.writeAsStringSync(content);
  return true;
}

String _stateJson(Set<String> components, Set<String> locales) {
  final List<String> sortedComponents = components.toList()..sort();
  final List<String> sortedLocales = locales.toList()..sort();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final String json = encoder.convert(<String, Object>{
    'components': sortedComponents,
    'locales': sortedLocales,
  });
  return '$json\n';
}

/// The outcome of one sync: the keys every locale now carries and the files
/// that changed.
class _SyncResult {
  const _SyncResult(this.keys, this.written);

  final Set<String> keys;
  final List<String> written;
}

/// Brings `<dir>/dashcn_locales` in line with [recorded] components and
/// [locales]. Each locale overrides the union of the keys of [recorded] and of
/// the components `dashcn.lock` lists. Only changed files are written.
_SyncResult _sync(
  Map<String, dynamic> manifest,
  Map<String, dynamic> registry,
  String dir, {
  required Set<String> recorded,
  required Set<String> locales,
}) {
  final Set<String> keys = <String>{};
  final Map<String, dynamic> components = (registry['components'] as Map)
      .cast<String, dynamic>();
  for (final String component in <String>{
    ...recorded,
    ..._lockedComponents(dir),
  }) {
    if (components.containsKey(component)) {
      keys.addAll(componentKeys(registry, component));
    }
  }
  final Directory target = Directory('$dir/$_localesDirName')
    ..createSync(recursive: true);
  final List<String> written = <String>[];
  final List<String> sorted = locales.toList()..sort();
  for (final String code in sorted) {
    final File file = File(
      '${target.path}/dashcn_locale_${_fileSuffix(code)}.dart',
    );
    if (_writeIfChanged(file, generateLocaleFile(manifest, code, keys))) {
      written.add(file.path);
    }
  }
  final File barrel = File('${target.path}/dashcn_locales.dart');
  if (_writeIfChanged(barrel, generateBarrel(manifest, sorted))) {
    written.add(barrel.path);
  }
  final File state = File('${target.path}/$_stateFileName');
  if (_writeIfChanged(state, _stateJson(recorded, locales))) {
    written.add(state.path);
  }
  return _SyncResult(keys, written);
}

void _checkLocale(Map<String, dynamic> manifest, String code) {
  final Map<String, dynamic> locales = (manifest['locales'] as Map)
      .cast<String, dynamic>();
  if (code == _baseLocale || locales.containsKey(code)) {
    return;
  }
  final String known = (locales.keys.toList()..sort()).join(', ');
  throw ArgumentError.value(code, 'code', 'unknown locale; known: $known');
}

/// Installs [code] for every component in the project. Returns a status line.
/// Idempotent: nothing is written when the project already has it.
String localeAdd(
  Map<String, dynamic> manifest,
  Map<String, dynamic> registry,
  String code, {
  required String dir,
}) {
  _checkLocale(manifest, code);
  final _ProjectState state = _readState(dir);
  final _SyncResult result = _sync(
    manifest,
    registry,
    dir,
    recorded: state.components,
    locales: <String>{...state.locales, code},
  );
  final String target = '$dir/$_localesDirName';
  return result.written.isEmpty
      ? 'already installed $code in $target'
      : 'installed $code in $target';
}

/// Installs the English base and the strings [component] needs, for every
/// locale the project already has. Returns a status line. Idempotent.
String componentAdd(
  Map<String, dynamic> manifest,
  Map<String, dynamic> registry,
  String component, {
  required String dir,
}) {
  componentKeys(registry, component);
  final _ProjectState state = _readState(dir);
  final _SyncResult result = _sync(
    manifest,
    registry,
    dir,
    recorded: <String>{...state.components, component},
    locales: <String>{...state.locales, _baseLocale},
  );
  final String target = '$dir/$_localesDirName';
  if (result.written.isEmpty) {
    return 'already installed $component in $target';
  }
  final List<String> locales = (<String>{...state.locales, _baseLocale}.toList()
    ..sort());
  return 'added $component (${result.keys.length} keys) for ${locales.join(', ')} in $target';
}

void _usage() {
  stdout.writeln('usage:');
  stdout.writeln(
    '  dart run tool/locale.dart list [--json] [--manifest <path>]',
  );
  stdout.writeln(
    '  dart run tool/locale.dart add <code> [--dir <project-dir>] '
    '[--manifest <path>] [--registry <path>]',
  );
  stdout.writeln(
    '  dart run tool/locale.dart component <id> [--dir <project-dir>] '
    '[--manifest <path>] [--registry <path>]',
  );
  stdout.writeln();
  stdout.writeln(
    '  list       every locale the kit ships, with direction and key count',
  );
  stdout.writeln(
    '  add        install <code> for every component already in the project',
  );
  stdout.writeln(
    '  component  install the English base and the strings <id> needs',
  );
  stdout.writeln(
    '             (run it when adding a component; the project receives the',
  );
  stdout.writeln('             strings for every locale it already has)');
}

/// The value after [flag] in [args], or null when the flag is absent.
String? _option(List<String> args, String flag) {
  final int at = args.indexOf(flag);
  if (at != -1 && at + 1 < args.length) {
    return args[at + 1];
  }
  return null;
}

void main(List<String> args) {
  if (args.isEmpty || args.first == '--help' || args.first == '-h') {
    _usage();
    return;
  }
  final Map<String, dynamic> manifest = loadManifest(
    _option(args, '--manifest') ?? _defaultManifestPath,
  );
  switch (args.first) {
    case 'list':
      localeList(manifest, json: args.contains('--json'));
    case 'add':
    case 'component':
      if (args.length < 2) {
        stderr.writeln(
          '${args.first} needs ${args.first == 'add' ? 'a locale code' : 'a component id'}.',
        );
        _usage();
        exit(64);
      }
      final String dir = _option(args, '--dir') ?? '.';
      final Map<String, dynamic> registry = loadRegistry(
        _option(args, '--registry') ?? _defaultRegistryPath,
      );
      try {
        stdout.writeln(
          args.first == 'add'
              ? localeAdd(manifest, registry, args[1], dir: dir)
              : componentAdd(manifest, registry, args[1], dir: dir),
        );
      } on ArgumentError catch (e) {
        stderr.writeln(e.message);
        exit(64);
      }
    default:
      stderr.writeln('unknown command ${args.first}.');
      _usage();
      exit(64);
  }
}
