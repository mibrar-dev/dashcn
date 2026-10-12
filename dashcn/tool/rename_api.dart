// Plain-name codemod (P8-2 step 3): renames every `shadcn` identifier,
// string, comment and prose occurrence in the kit + docs app from the map in
// `tool/rename_map.yaml`.
//
// Dart code uses the unresolved AST (`parseString`): every map name holds
// `shadcn`/`Shadcn` and is declared only in this kit, so exact-token renames
// of declarations, references, named constructors and show/hide combinators
// are precise; comments come from the token stream; string contents and all
// other text go through the explicit ordered passes in `rename_api_passes.dart`
// (rule 1a→b→c/d/e). No regular expressions. `flutter analyze` + the test
// suites verify correctness afterwards.
//
// Generated mirrors are excluded here: the docs mirror
// (`docs/lib/ui/shadcn/` → `docs/lib/ui/dashcn/`) is regenerated from the
// renamed sources via `docs/tool/sync_registry.sh` after the `git mv`, and
// the CLI fixture old location
// (`flutter_cli_verification_example/lib/ui/shadcn/`) is skipped until its
// move, then codemodded on the second apply at its new location.
//
// File/directory renames from the map run via `git mv` (allowed for renamed
// files only). Idempotent: `--check` is a dry run that exits 1 when any
// rename is still pending.
//
// Usage (from `dashcn/`):
//   dart run tool/rename_api.dart [--check]
import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

import 'rename_api_files.dart';
import 'rename_api_map.dart';
import 'rename_api_passes.dart';

/// Dart roots, kit-relative (unresolved AST, exact identifier tokens).
const List<String> _dartRoots = <String>[
  'dashcn/lib',
  'dashcn/test',
  'dashcn/example',
  'dashcn/tool',
  'dashcn/gen',
  'dashcn/scripts',
  'dashcn/flutter_cli_verification_example',
  'docs/lib',
  'docs/test',
  'docs/tool',
];

/// Text roots, kit-relative (recursive walk; `.dart` goes to the Dart pass).
const List<String> _textRoots = <String>[
  'dashcn',
  'docs/lib',
  'docs/test',
  'docs/tool',
  'docs/web',
];

/// The codemod's own machinery is never rewritten (historical map + needle).
const Set<String> _selfSkipped = <String>{
  'dashcn/tool/rename_api.dart',
  'dashcn/tool/rename_api_files.dart',
  'dashcn/tool/rename_api_map.dart',
  'dashcn/tool/rename_api_names.dart',
  'dashcn/tool/rename_api_passes.dart',
  'dashcn/tool/rename_api_scopes.dart',
  'dashcn/tool/check_names.dart',
  'dashcn/tool/check_names_allow.txt',
  'dashcn/tool/rename_inventory.dart',
  'dashcn/tool/rename_inventory_ast.dart',
  'dashcn/tool/rename_map.yaml',
  'dashcn/test/tool/rename_api_test.dart',
  'dashcn/test/tool/rename_api_passes_test.dart',
};

/// Binary extensions never read as text.
const Set<String> _binaryExtensions = <String>{
  '.png',
  '.jpg',
  '.jpeg',
  '.gif',
  '.webp',
  '.ico',
  '.pdf',
  '.ttf',
  '.otf',
  '.woff',
  '.woff2',
};

/// Generated mirrors excluded from the content passes (see header).
/// The docs mirror (`docs/lib/ui/`) is regenerated from the renamed sources
/// via `docs/tool/sync_registry.sh`, so both the old (`ui/shadcn`) and the
/// moved (`ui/dashcn`) locations are skipped. The CLI fixture copy is
/// codemodded after its move, so only its old location is skipped here.
bool _isExcludedMirror(String relPath) =>
    relPath.startsWith('docs/lib/ui/shadcn/') ||
    relPath.startsWith('docs/lib/ui/dashcn/') ||
    relPath.startsWith(
      'dashcn/flutter_cli_verification_example/lib/ui/shadcn/',
    );

/// Generated outputs skipped here and regenerated in step 6 (map `generated`).
bool _isGenerated(RenameMap map, String relPath) => map.generated.any(
  (String entry) =>
      relPath == entry || (entry.endsWith('/') && relPath.startsWith(entry)),
);

/// Markdown rule 1(d): `*.md`, anything under `skills/`, README files.
bool _isMarkdown(String relPath) {
  if (relPath.endsWith('.md')) {
    return true;
  }
  if (relPath.contains('/skills/') || relPath.startsWith('dashcn/skills/')) {
    return true;
  }
  final String base = relPath.split('/').last;
  return base == 'README' || base.startsWith('README.');
}

void main(List<String> args) async {
  final bool check = args.contains('--check');
  if (args.any((String arg) => arg != '--check') ||
      args.contains('--help') ||
      args.contains('-h')) {
    stdout.writeln('Usage: dart run tool/rename_api.dart [--check]');
    if (!args.contains('--help') && !args.contains('-h')) {
      exitCode = 64;
    }
    return;
  }
  final String? kit = findKitRoot(Directory.current);
  if (kit == null) {
    stderr.writeln('rename_api: cannot locate the kit root.');
    exitCode = 1;
    return;
  }
  final File mapFile = File('$kit/dashcn/tool/rename_map.yaml');
  final RenameMap map = loadRenameMap(mapFile.readAsStringSync());
  final DateTime started = DateTime.now();

  // Every Dart file under the Dart roots.
  final List<String> dartFiles = <String>[];
  for (final String root in _dartRoots) {
    dartFiles.addAll(listFiles(Directory('$kit/$root'), kit, '.dart'));
  }
  dartFiles.sort();
  final Set<String> dartCovered = dartFiles.toSet();

  int dartChanged = 0;
  int identifiers = 0;
  int strings = 0;
  int comments = 0;
  int dartMicros = 0;
  final List<String> slowFiles = <String>[];
  final List<String> unhandled = <String>[];
  final List<String> conflicts = <String>[];
  final Map<String, String> pendingWrites = <String, String>{};
  // Unresolved AST throughout (`parseString`): every map name holds
  // `shadcn`/`Shadcn` and is declared only in this kit, so exact-token
  // renames are precise; `flutter analyze` + tests verify afterwards.
  int scanned = 0;
  for (final String relPath in dartFiles) {
    if (_selfSkipped.contains(relPath) ||
        _isExcludedMirror(relPath) ||
        _isGenerated(map, relPath)) {
      continue;
    }
    stdout.writeln('rename_api: dart $relPath');
    await stdout.flush();
    final String absolute = '$kit/$relPath';
    late final String content;
    try {
      content = File(absolute).readAsStringSync();
    } on FileSystemException {
      continue;
    }
    scanned++;
    if (!hasShadcn(content)) {
      continue;
    }
    final ParseStringResult parsed = parseString(
      content: content,
      throwIfDiagnostics: false,
    );
    final DateTime fileStart = DateTime.now();
    final DartPass pass = computeDartEdits(parsed.unit, content, map);
    final int fileMicros = DateTime.now().difference(fileStart).inMicroseconds;
    dartMicros += fileMicros;
    if (fileMicros > 200000) {
      slowFiles.add('$relPath ${fileMicros ~/ 1000}ms');
      stdout.writeln('rename_api: slow $relPath ${fileMicros ~/ 1000}ms');
      await stdout.flush();
    }
    unhandled.addAll(pass.unhandled.map((String spot) => '$relPath $spot'));
    conflicts.addAll(pass.conflicts.map((String spot) => '$relPath $spot'));
    if (scanned % 400 == 0) {
      stdout.writeln(
        'rename_api: scanned $scanned/${dartFiles.length} '
        '(${DateTime.now().difference(started).inSeconds}s)',
      );
      await stdout.flush();
    }
    if (pass.edits.isEmpty) {
      continue;
    }
    _assertDisjoint(relPath, pass.edits);
    pendingWrites[relPath] = _applyEdits(content, pass.edits);
    dartChanged++;
    identifiers += pass.identifiers;
    strings += pass.strings;
    comments += pass.comments;
  }
  stdout.writeln(
    'rename_api: dart pass done (${dartMicros ~/ 1000}ms compute); '
    'slow files: ${slowFiles.take(10).join(', ')}',
  );
  await stdout.flush();
  // Every non-Dart text file under the text roots.
  int textChanged = 0;
  final List<String> strayDart = <String>[];
  for (final String root in _textRoots) {
    for (final String relPath in listFiles(Directory('$kit/$root'), kit, '')) {
      if (_selfSkipped.contains(relPath) ||
          _isExcludedMirror(relPath) ||
          _isGenerated(map, relPath)) {
        continue;
      }
      // Pre-print: if the run stalls, the last path is the culprit.
      stdout.writeln('rename_api: text $relPath');
      await stdout.flush();
      if (relPath.endsWith('.dart')) {
        if (!dartCovered.contains(relPath)) {
          strayDart.add(relPath);
        }
        continue;
      }
      if (_binaryExtensions.any(relPath.endsWith)) {
        continue;
      }
      late final String content;
      try {
        content = File('$kit/$relPath').readAsStringSync();
      } on FileSystemException {
        continue;
      }
      if (content.contains('\u0000')) {
        continue; // Binary blob with a text extension.
      }
      if (!hasShadcn(content)) {
        continue;
      }
      final String? next = rewriteText(content, _isMarkdown(relPath), map);
      if (next != null) {
        pendingWrites[relPath] = next;
        textChanged++;
      }
    }
  }

  // File/directory renames pending from the map.
  final List<String> pendingMoves = <String>[];
  for (final MapEntry<String, String> move in map.paths) {
    final bool fromExists =
        File('$kit/${move.key}').existsSync() ||
        Directory('$kit/${move.key}').existsSync();
    final bool toExists =
        File('$kit/${move.value}').existsSync() ||
        Directory('$kit/${move.value}').existsSync();
    if (fromExists && move.key != move.value && !toExists) {
      pendingMoves.add('${move.key} -> ${move.value}');
    }
  }

  final bool pending =
      pendingWrites.isNotEmpty ||
      pendingMoves.isNotEmpty ||
      unhandled.isNotEmpty ||
      conflicts.isNotEmpty ||
      strayDart.isNotEmpty;
  if (check) {
    _report(
      pendingWrites.keys.toList()..sort(),
      pendingMoves,
      unhandled,
      conflicts,
      strayDart,
      dartChanged,
      textChanged,
      identifiers,
      strings,
      comments,
    );
    if (pending) {
      stderr.writeln(
        'rename_api: ${pendingWrites.length} file(s), '
        '${pendingMoves.length} move(s) pending.',
      );
      exitCode = 1;
    } else {
      stdout.writeln('rename_api: no renames pending.');
    }
    return;
  }
  if (conflicts.isNotEmpty || unhandled.isNotEmpty || strayDart.isNotEmpty) {
    _report(
      pendingWrites.keys.toList()..sort(),
      pendingMoves,
      unhandled,
      conflicts,
      strayDart,
      dartChanged,
      textChanged,
      identifiers,
      strings,
      comments,
    );
    stderr.writeln(
      'rename_api: refusing to write with unhandled leftovers; fix by hand.',
    );
    exitCode = 1;
    return;
  }
  for (final MapEntry<String, String> entry in pendingWrites.entries) {
    File('$kit/${entry.key}').writeAsStringSync(entry.value);
  }
  for (final MapEntry<String, String> move in map.paths) {
    final ProcessResult moved = Process.runSync('git', <String>[
      'mv',
      move.key,
      move.value,
    ], workingDirectory: kit);
    if (moved.exitCode != 0 && File('$kit/${move.key}').existsSync()) {
      stderr.writeln('rename_api: `git mv ${move.key}` failed.');
      exitCode = 1;
      return;
    }
  }
  stdout.writeln(
    'rename_api: rewrote $dartChanged Dart + $textChanged text file(s) '
    '($identifiers identifiers, $strings strings, $comments comments), '
    '${pendingMoves.length} move(s).',
  );
}

void _report(
  List<String> files,
  List<String> moves,
  List<String> unhandled,
  List<String> conflicts,
  List<String> strayDart,
  int dartChanged,
  int textChanged,
  int identifiers,
  int strings,
  int comments,
) {
  stdout.writeln(
    'pending: ${files.length} file(s) '
    '($dartChanged Dart, $textChanged text; '
    '$identifiers identifiers, $strings strings, $comments comments)',
  );
  for (final String file in files.take(10)) {
    stdout.writeln('  edit: $file');
  }
  if (files.length > 10) {
    stdout.writeln('  ... and ${files.length - 10} more');
  }
  void section(String label, List<String> rows) {
    for (final String row in rows.take(20)) {
      stdout.writeln('  $label: $row');
    }
    if (rows.length > 20) {
      stdout.writeln('  ... and ${rows.length - 20} more $label');
    }
  }

  section('move', moves);
  section('unhandled removal', unhandled);
  section('themeData conflict (kept, fix by hand)', conflicts);
  section('dart outside roots', strayDart);
}

/// Applies non-overlapping [edits] to [content] (offsets in original text).
String _applyEdits(String content, List<SourceEdit> edits) {
  final StringBuffer out = StringBuffer();
  int cursor = 0;
  for (final SourceEdit edit in edits) {
    out.write(content.substring(cursor, edit.offset));
    out.write(edit.replacement);
    cursor = edit.offset + edit.length;
  }
  out.write(content.substring(cursor));
  return out.toString();
}

void _assertDisjoint(String relPath, List<SourceEdit> edits) {
  for (int i = 1; i < edits.length; i++) {
    if (edits[i].offset < edits[i - 1].offset + edits[i - 1].length) {
      throw StateError('overlapping edits in $relPath');
    }
  }
}
