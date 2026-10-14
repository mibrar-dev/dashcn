// Inventory of every `shadcn` (case-insensitive) occurrence in the kit and
// the docs app: declarations (public + private) in Dart files via
// `package:analyzer` `parseString` (never regex for Dart code; see
// `rename_inventory_ast.dart`), plus string literals, comments, file/folder
// names, and non-Dart text (markdown, JSON, YAML, HTML, platform shells, …).
//
// Usage (from `dashcn/`):
//   dart run tool/rename_inventory.dart [--out <path>]
//
// Writes `$KIT/rearch/plans/api_inventory.json` by default and prints a
// per-area summary. Deterministic: lists are sorted, maps use sorted keys.
import 'dart:convert';
import 'dart:io';

import 'rename_inventory_ast.dart';

/// Scan roots as (area label, kit-relative directory).
const List<(String, String)> _scanRoots = <(String, String)>[
  ('kit_lib', 'dashcn/lib'),
  ('kit_test', 'dashcn/test'),
  ('kit_example', 'dashcn/example'),
  ('kit_tool', 'dashcn/tool'),
  ('kit_gen', 'dashcn/gen'),
  ('kit_guides', 'dashcn/.guides'),
  ('kit_assets', 'dashcn/assets'),
  ('kit_skills', 'dashcn/skills'),
  ('kit_scripts', 'dashcn/scripts'),
  ('kit_cli_fixture', 'dashcn/flutter_cli_verification_example'),
  ('docs_lib', 'docs/lib'),
  ('docs_test', 'docs/test'),
  ('docs_tool', 'docs/tool'),
  ('docs_web', 'docs/web'),
];

/// Package root files scanned as the `kit_root` area (not a directory walk,
/// so the roots above are not double-counted).
const List<String> _rootFiles = <String>[
  'dashcn/pubspec.yaml',
  'dashcn/README.md',
  'dashcn/CHANGELOG.md',
  'dashcn/LICENSE',
  'dashcn/analysis_options.yaml',
  'dashcn/.pubignore',
  'dashcn/.gitignore',
];

/// This tool's own files are not rename subjects: their helpers and needle
/// literals are the search machinery.
const Set<String> _selfFiles = <String>{
  'dashcn/tool/rename_inventory.dart',
  'dashcn/tool/rename_inventory_ast.dart',
};

/// Directories never descended into (build outputs, caches, VCS).
const Set<String> _skippedDirs = <String>{
  'build',
  '.dart_tool',
  'ephemeral',
  '.git',
  '.idea',
  'node_modules',
};

/// Non-Dart text extensions scanned for `shadcn`.
const Set<String> _textExtensions = <String>{
  '.json',
  '.md',
  '.markdown',
  '.yaml',
  '.yml',
  '.txt',
  '.html',
  '.css',
  '.js',
  '.xml',
  '.gradle',
  '.pbxproj',
  '.xcconfig',
  '.plist',
  '.entitlements',
  '.sh',
  '.arb',
  '.lock',
  '.gitignore',
  '.pubignore',
};

/// `Today` names from `DASHCN_PACKAGE_PLAN.md` §2 (exact entries).
const Set<String> _tableExact = <String>{
  'ShadcnApp',
  'ShadcnTheme',
  'ShadcnThemeData',
  'ShadcnThemeDataTween',
  'ShadcnColors',
  'ShadcnFonts',
  'ShadcnTokens',
  'ShadcnForm',
  'ShadcnFormField',
  'ShadcnImage',
  'ShadcnPage',
  'ShadcnPageRoute',
  'ShadcnPageTransition',
  'ShadcnDialogRoute',
  'ShadcnDrawerRoute',
  'ShadcnLayer',
  'ShadcnLocalizations',
  'ShadcnSelectionControls',
  'ShadcnTextSelectionToolbar',
  'ShadcnUI',
  'showShadcnDialog',
  'showShadcnPopup',
  'showShadcnMenu',
  'showShadcnDropdown',
  'showShadcnContextMenu',
};

/// Prefix families covered by the §2 table (`ShadcnTable*`, `ShadcnPage*`,
/// `ShadcnLocalizations*`, `showShadcn*` → `show*`).
const List<String> _tablePrefixes = <String>[
  'ShadcnTable',
  'ShadcnRadioGroup',
  'ShadcnPage',
  'ShadcnLocalizations',
  'showShadcn',
];

/// True when the §2 table already maps [name] (leading `_` ignored).
bool coveredByTable(String name) {
  final String bare = name.startsWith('_') ? name.substring(1) : name;
  if (_tableExact.contains(bare)) {
    return true;
  }
  return _tablePrefixes.any(bare.startsWith);
}

void main(List<String> args) {
  String? out;
  for (int i = 0; i < args.length; i++) {
    if (args[i] == '--out' && i + 1 < args.length) {
      out = args[++i];
    } else if (args[i] == '--help' || args[i] == '-h') {
      stdout.writeln(
        'Usage: dart run tool/rename_inventory.dart [--out <path>]',
      );
      return;
    } else {
      stderr.writeln('rename_inventory: unknown argument `${args[i]}`.');
      exitCode = 64;
      return;
    }
  }
  // Kit root = directory holding `dashcn/` and `docs/`, found by walking up
  // from here until `lib/src/manifests/registry.json` resolves under `dashcn/`.
  Directory dir = Directory.current;
  while (true) {
    if (File(
      '${dir.path}/dashcn/lib/src/manifests/registry.json',
    ).existsSync()) {
      break;
    }
    final Directory parent = dir.parent;
    if (parent.path == dir.path) {
      stderr.writeln('rename_inventory: cannot locate the kit root.');
      exitCode = 1;
      return;
    }
    dir = parent;
  }
  final String kit = dir.path;
  out ??= '$kit/rearch/plans/api_inventory.json';

  final List<Map<String, Object>> declarations = <Map<String, Object>>[];
  final Map<String, Map<String, int>> referencesByArea =
      <String, Map<String, int>>{};
  final Map<String, int> stringHitsByArea = <String, int>{};
  final Map<String, int> commentHitsByArea = <String, int>{};
  final Map<String, int> dartFilesByArea = <String, int>{};
  final Map<String, int> textFilesByArea = <String, int>{};
  final Map<String, int> textMatchesByArea = <String, int>{};
  final List<String> pathsWithShadcn = <String>[];

  for (final (String area, String rel) in _scanRoots) {
    final Directory root = Directory('$kit/$rel');
    if (!root.existsSync()) {
      continue;
    }
    referencesByArea[area] = <String, int>{};
    stringHitsByArea[area] = 0;
    commentHitsByArea[area] = 0;
    dartFilesByArea[area] = 0;
    textFilesByArea[area] = 0;
    textMatchesByArea[area] = 0;
    final List<File> files = _listFiles(root);
    for (final File file in files) {
      final String relPath = file.path.substring(kit.length + 1);
      if (_selfFiles.contains(relPath)) {
        continue;
      }
      if (containsShadcn(relPath)) {
        pathsWithShadcn.add(relPath);
      }
      if (file.path.endsWith('.dart')) {
        dartFilesByArea[area] = dartFilesByArea[area]! + 1;
        _scanDart(
          file,
          relPath,
          declarations,
          referencesByArea[area]!,
          stringHitsByArea,
          commentHitsByArea,
          area,
        );
      } else if (_textExtensions.any(file.path.endsWith)) {
        String content;
        try {
          content = file.readAsStringSync();
        } on FileSystemException {
          continue; // Unreadable/binary: not a text occurrence.
        }
        if (content.contains('\u0000')) {
          continue; // Binary blob with a text extension.
        }
        final int matches = countShadcn(content);
        if (matches > 0) {
          textFilesByArea[area] = textFilesByArea[area]! + 1;
          textMatchesByArea[area] = textMatchesByArea[area]! + matches;
        }
      }
    }
  }
  const String rootArea = 'kit_root';
  referencesByArea[rootArea] = <String, int>{};
  stringHitsByArea[rootArea] = 0;
  commentHitsByArea[rootArea] = 0;
  dartFilesByArea[rootArea] = 0;
  textFilesByArea[rootArea] = 0;
  textMatchesByArea[rootArea] = 0;
  for (final String relPath in _rootFiles) {
    final File file = File('$kit/$relPath');
    if (!file.existsSync()) {
      continue;
    }
    if (containsShadcn(relPath)) {
      pathsWithShadcn.add(relPath);
    }
    final String content = file.readAsStringSync();
    final int matches = countShadcn(content);
    if (matches > 0) {
      textFilesByArea[rootArea] = textFilesByArea[rootArea]! + 1;
      textMatchesByArea[rootArea] = textMatchesByArea[rootArea]! + matches;
    }
  }
  pathsWithShadcn.sort();
  declarations.sort(_compareDeclarations);

  final Set<String> declaredNames = <String>{
    for (final Map<String, Object> d in declarations) d['name'] as String,
  };
  final List<String> notCovered =
      declaredNames.where((String name) => !coveredByTable(name)).toList()
        ..sort();

  final Map<String, Object> areas = <String, Object>{};
  final Map<String, String> dirs = <String, String>{
    for (final (String area, String rel) in _scanRoots) area: rel,
    rootArea: 'dashcn/*',
  };
  for (final MapEntry<String, Map<String, int>> areaEntry
      in referencesByArea.entries) {
    final String area = areaEntry.key;
    final String rel = dirs[area] ?? area;
    final Map<String, int> refs = referencesByArea[area]!;
    final List<String> names = refs.keys.toList()..sort();
    areas[area] = <String, Object>{
      'dir': rel,
      'dart_files': dartFilesByArea[area]!,
      'declarations': declarations
          .where((Map<String, Object> d) => d['area'] == area)
          .length,
      'identifier_references': <String, Object>{
        for (final String name in names) name: refs[name]!,
      },
      'string_literal_hits': stringHitsByArea[area]!,
      'comment_hits': commentHitsByArea[area]!,
      'text_files_with_match': textFilesByArea[area]!,
      'text_total_matches': textMatchesByArea[area]!,
    };
  }

  final Map<String, Object> inventory = <String, Object>{
    'generated_at': DateTime.now().toUtc().toIso8601String(),
    'tool': 'dashcn/tool/rename_inventory.dart',
    'areas': areas,
    'declaration_count': declarations.length,
    'declarations': declarations,
    'paths_with_shadcn': pathsWithShadcn,
    'path_count': pathsWithShadcn.length,
    'not_covered_by_table': notCovered,
  };
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  File(out).writeAsStringSync('${encoder.convert(inventory)}\n');

  stdout.writeln('wrote $out');
  stdout.writeln(
    'declarations: ${declarations.length} '
    '(${declaredNames.length} distinct names)',
  );
  stdout.writeln('paths with shadcn: ${pathsWithShadcn.length}');
  stdout.writeln('not covered by the §2 table: ${notCovered.length}');
  for (final String name in notCovered) {
    stdout.writeln('  table-miss: $name');
  }
  for (final MapEntry<String, Object> entry in areas.entries) {
    final Map<String, Object> summary = entry.value as Map<String, Object>;
    stdout.writeln(
      '${entry.key}: dart=${summary['dart_files']} '
      'decls=${summary['declarations']} '
      'strings=${summary['string_literal_hits']} '
      'comments=${summary['comment_hits']} '
      'text_files=${summary['text_files_with_match']} '
      'text_hits=${summary['text_total_matches']}',
    );
  }
}

/// Every file under [root], skipping build outputs, caches and VCS metadata.
List<File> _listFiles(Directory root) {
  final List<File> files = <File>[];
  final List<Directory> queue = <Directory>[root];
  while (queue.isNotEmpty) {
    final Directory current = queue.removeLast();
    List<FileSystemEntity> entries;
    try {
      entries = current.listSync(followLinks: false);
    } on FileSystemException {
      continue;
    }
    entries.sort((a, b) => a.path.compareTo(b.path));
    for (final FileSystemEntity entry in entries) {
      final String name = entry.path.split(Platform.pathSeparator).last;
      if (entry is Directory) {
        if (!_skippedDirs.contains(name)) {
          queue.add(entry);
        }
      } else if (entry is File) {
        files.add(entry);
      }
    }
  }
  return files;
}

int _compareDeclarations(Map<String, Object> a, Map<String, Object> b) {
  final int byFile = (a['file'] as String).compareTo(b['file'] as String);
  if (byFile != 0) {
    return byFile;
  }
  return (a['line'] as int).compareTo(b['line'] as int);
}

/// Parses one Dart file and records shadcn declarations, identifier
/// references, string-literal hits and comment hits.
void _scanDart(
  File file,
  String relPath,
  List<Map<String, Object>> declarations,
  Map<String, int> references,
  Map<String, int> stringHitsByArea,
  Map<String, int> commentHitsByArea,
  String area,
) {
  late final String content;
  try {
    content = file.readAsStringSync();
  } on FileSystemException {
    return;
  }
  final InventoryScan? scan = scanDartContent(content);
  if (scan == null) {
    return;
  }
  final LineStarts lines = LineStarts(content);
  for (final InventoryDeclaration declaration in scan.declarations) {
    declarations.add(<String, Object>{
      'name': declaration.name,
      'kind': declaration.kind,
      'file': relPath,
      'line': lines.lineOf(declaration.offset),
      'area': area,
      'public': !declaration.name.startsWith('_'),
    });
  }
  for (final MapEntry<String, int> entry in scan.references.entries) {
    references[entry.key] = (references[entry.key] ?? 0) + entry.value;
  }
  stringHitsByArea[area] = stringHitsByArea[area]! + scan.stringLiteralHits;
  commentHitsByArea[area] = commentHitsByArea[area]! + commentHitsIn(content);
}
