// Generates `lib/src/manifests/locale_tables.json` from the locale sources.
//
// Usage (from `dashcn/`):
//   dart run tool/gen_locale_manifest.dart [--check]
//
// `--check` regenerates in memory and exits 1 when the checked-in JSON is
// stale. The manifest is the single offline source the locale installer
// (`dart run tool/locale.dart`, and the `dashcn_cli` `locale add` command)
// reads: English defaults and signatures per key, plus every translated
// override per locale. Inherited tables (`pt_BR` from `pt`, `zh_Hans` from
// `zh`) list only their own overrides plus an `inherits` pointer; the
// installer resolves the full table at install time.
import 'dart:convert';
import 'dart:io';

const String _localizationsDir = 'lib/src/primitives/localizations';
const String _manifestPath = 'lib/src/manifests/locale_tables.json';

/// languageCode -> (scriptCode, countryCode, file suffix, direction)
const Map<String, List<String>> _locales = <String, List<String>>{
  'ar': <String>['', '', 'ar', 'rtl'],
  'he': <String>['', '', 'he', 'rtl'],
  'fa': <String>['', '', 'fa', 'rtl'],
  'ur': <String>['', '', 'ur', 'rtl'],
  'de': <String>['', '', 'de', 'ltr'],
  'fr': <String>['', '', 'fr', 'ltr'],
  'es': <String>['', '', 'es', 'ltr'],
  'it': <String>['', '', 'it', 'ltr'],
  'pt': <String>['', '', 'pt', 'ltr'],
  'pt-BR': <String>['', 'BR', 'pt_br', 'ltr'],
  'nl': <String>['', '', 'nl', 'ltr'],
  'ru': <String>['', '', 'ru', 'ltr'],
  'tr': <String>['', '', 'tr', 'ltr'],
  'ja': <String>['', '', 'ja', 'ltr'],
  'ko': <String>['', '', 'ko', 'ltr'],
  'zh': <String>['', '', 'zh', 'ltr'],
  'zh-Hans': <String>['Hans', '', 'zh_hans', 'ltr'],
  'hi': <String>['', '', 'hi', 'ltr'],
};

const Map<String, String> _inherits = <String, String>{
  'pt-BR': 'pt',
  'zh-Hans': 'zh',
};

const List<String> _mixinFiles = <String>[
  'localizations_form.dart',
  'localizations_overlay.dart',
  'localizations_date_time.dart',
  'localizations_files.dart',
  'localizations_misc.dart',
  'localizations_media.dart',
  'localizations_chrome.dart',
  'localizations_error.dart',
];

/// Parses `String get name => body;` / `String name(sig) => body;` members.
/// Returns name -> (signature, expression). Bodies may span lines; they never
/// contain a top-level `;`.
Map<String, List<String>> parseMembers(String src) {
  final Map<String, List<String>> out = <String, List<String>>{};
  final List<String> lines = src.split('\n');
  int i = 0;
  while (i < lines.length) {
    final String line = lines[i];
    final RegExpMatch? m = RegExp(
      r'^\s*String (get )?([a-zA-Z0-9_]+)(\([^)]*\))?\s*=>\s?(.*)$',
    ).firstMatch(line);
    if (m == null) {
      i++;
      continue;
    }
    final String name = m.group(2)!;
    final String sig = m.group(3) ?? '';
    // Skip private helpers (`_number`) and non-locale members.
    if (name.startsWith('_') || name == 'localeName' || name == 'locale') {
      i++;
      continue;
    }
    String expr = m.group(4)!;
    while (!expr.contains(';') && i + 1 < lines.length) {
      i++;
      expr += '\n${lines[i]}';
    }
    expr = expr.substring(0, expr.indexOf(';')).trim();
    out[name] = <String>[sig, expr];
    i++;
  }
  return out;
}

Map<String, dynamic> buildManifest() {
  final Map<String, Map<String, String>> keys = <String, Map<String, String>>{};
  for (final String file in _mixinFiles) {
    final String src = File('$_localizationsDir/$file').readAsStringSync();
    for (final MapEntry<String, List<String>> e in parseMembers(src).entries) {
      keys[e.key] = <String, String>{'signature': e.value[0], 'en': e.value[1]};
    }
  }
  final Map<String, dynamic> locales = <String, dynamic>{};
  for (final MapEntry<String, List<String>> e in _locales.entries) {
    final String code = e.key;
    final List<String> meta = e.value;
    final String src = File(
      '$_localizationsDir/localizations_${meta[2]}.dart',
    ).readAsStringSync();
    final Map<String, List<String>> members = parseMembers(src);
    final Map<String, String> overrides = <String, String>{};
    for (final MapEntry<String, List<String>> m in members.entries) {
      overrides[m.key] = m.value[1];
    }
    locales[code] = <String, dynamic>{
      'direction': meta[3],
      if (_inherits.containsKey(code)) 'inherits': _inherits[code],
      'overrides': overrides,
    };
  }
  return <String, dynamic>{
    'keyCount': keys.length,
    'keys': keys,
    'locales': locales,
  };
}

void main(List<String> args) {
  final Map<String, dynamic> manifest = buildManifest();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final String json = '${encoder.convert(manifest)}\n';
  final File out = File(_manifestPath);
  if (args.contains('--check')) {
    if (!out.existsSync() || out.readAsStringSync() != json) {
      stderr.writeln(
        'locale_tables.json is stale; run tool/gen_locale_manifest.dart',
      );
      exit(1);
    }
    return;
  }
  out.writeAsStringSync(json);
  stdout.writeln('wrote $_manifestPath (${manifest['keyCount']} keys)');
}
