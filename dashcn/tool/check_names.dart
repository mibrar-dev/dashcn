// Plain-names guardrail (P8-2): fails when
// (a) any `shadcn` (case-insensitive) remains in tracked text files under
//     `dashcn/`, `docs/lib`, `docs/test`, `docs/tool` or `docs/web`, except
//     lines holding a `tool/check_names_allow.txt` substring; or
// (b) any name exported by the package's public libraries is also exported
//     by `package:flutter/widgets.dart` (resolved via the analyzer, so
//     `show`/`hide` combinators and re-exports are honoured).
//
// Usage (from `dashcn/`): `dart run tool/check_names.dart` (exit 0 = clean).
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';

/// Scanned roots, kit-relative.
const List<String> _scanRoots = <String>[
  'dashcn/',
  'docs/lib/',
  'docs/test/',
  'docs/tool/',
  'docs/web/',
];

/// Tracked paths never scanned (build outputs, caches, generated shells).
bool _skippedPath(String path) =>
    path.contains('/build/') ||
    path.contains('/.dart_tool/') ||
    path.contains('/ephemeral/') ||
    path.endsWith('/build');

/// Rename tooling holds the historical map + needle; skipped by file name.
bool _selfSkipped(String path) =>
    path == 'dashcn/tool/check_names.dart' ||
    path == 'dashcn/tool/check_names_allow.txt' ||
    path == 'dashcn/tool/rename_api.dart' ||
    path == 'dashcn/tool/rename_api_files.dart' ||
    path == 'dashcn/tool/rename_api_map.dart' ||
    path == 'dashcn/tool/rename_api_names.dart' ||
    path == 'dashcn/tool/rename_api_passes.dart' ||
    path == 'dashcn/tool/rename_api_scopes.dart' ||
    path == 'dashcn/tool/rename_inventory.dart' ||
    path == 'dashcn/tool/rename_inventory_ast.dart' ||
    path == 'dashcn/tool/rename_map.yaml' ||
    path == 'dashcn/test/tool/rename_api_test.dart' ||
    path == 'dashcn/test/tool/rename_api_passes_test.dart';

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

void main() async {
  final Directory dir = Directory.current;
  final String? kit = _findKitRoot(dir);
  if (kit == null) {
    stderr.writeln('check_names: cannot locate the kit root.');
    exitCode = 1;
    return;
  }
  final List<String> allow = _loadAllow('$kit/dashcn/tool');
  bool failed = false;
  failed |= _checkNeedle(kit, allow);
  failed |= await _checkWidgetsClashes(kit);
  if (!failed) {
    stdout.writeln('check_names: 0 hits.');
  } else {
    exitCode = 1;
  }
}

/// Walks up until `dashcn/lib/src/manifests/registry.json` resolves.
String? _findKitRoot(Directory start) {
  Directory current = start.absolute;
  while (true) {
    if (File(
      '${current.path}/dashcn/lib/src/manifests/registry.json',
    ).existsSync()) {
      return current.path;
    }
    final Directory parent = current.parent;
    if (parent.path == current.path) {
      return null;
    }
    current = parent;
  }
}

/// `substring # why: ...` entries (blank lines and `#` comments ignored).
List<String> _loadAllow(String toolDir) {
  final File file = File('$toolDir/check_names_allow.txt');
  if (!file.existsSync()) {
    stderr.writeln('check_names: allow file missing; failing closed.');
    exitCode = 1;
    return <String>[];
  }
  final List<String> entries = <String>[];
  for (final String line in file.readAsStringSync().split('\n')) {
    final String trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.startsWith('#')) {
      continue;
    }
    entries.add(trimmed.split('# why:').first.trim().toLowerCase());
  }
  return entries;
}

/// Gate (a): the needle in tracked text files.
bool _checkNeedle(String kit, List<String> allow) {
  final ProcessResult tracked = Process.runSync('git', <String>[
    'ls-files',
  ], workingDirectory: kit);
  if (tracked.exitCode != 0) {
    stderr.writeln('check_names: `git ls-files` failed; failing closed.');
    return true;
  }
  int hits = 0;
  final List<String> files =
      (tracked.stdout as String)
          .split('\n')
          .where(
            (String path) =>
                path.isNotEmpty &&
                _scanRoots.any(path.startsWith) &&
                !_skippedPath(path) &&
                !_selfSkipped(path) &&
                !_binaryExtensions.any(path.endsWith),
          )
          .toList()
        ..sort();
  for (final String path in files) {
    late final List<String> lines;
    try {
      final String content = File('$kit/$path').readAsStringSync();
      if (content.contains('\u0000')) {
        continue; // Binary blob with a text extension.
      }
      lines = content.split('\n');
    } on FileSystemException {
      continue;
    }
    for (int i = 0; i < lines.length; i++) {
      final String line = lines[i];
      if (!line.toLowerCase().contains('shadcn')) {
        continue;
      }
      final String lower = line.toLowerCase();
      if (allow.any(
        (String entry) => entry.isNotEmpty && lower.contains(entry),
      )) {
        continue;
      }
      stdout.writeln('$path:${i + 1}: ${line.trim()}');
      hits++;
    }
  }
  if (hits > 0) {
    stderr.writeln('check_names: $hits forbidden `shadcn` hit(s).');
    return true;
  }
  return false;
}

/// Gate (b): exported public names that widgets.dart also exports. Resolves
/// only the package barrel (its export namespace already covers every public
/// library) plus widgets.dart, so the gate stays fast.
Future<bool> _checkWidgetsClashes(String kit) async {
  final AnalysisContextCollection collection = AnalysisContextCollection(
    includedPaths: <String>['$kit/dashcn/lib'],
  );
  final Set<String> owned = await _exportedNames(
    collection,
    '$kit/dashcn/lib/dashcn.dart',
  );
  if (owned.isEmpty) {
    stderr.writeln(
      'check_names: cannot resolve lib/dashcn.dart; failing closed.',
    );
    return true;
  }
  final Set<String> widgets = await _libraryExportNames(
    collection,
    'package:flutter/widgets.dart',
  );
  if (widgets.isEmpty) {
    stderr.writeln(
      'check_names: cannot resolve package:flutter/widgets.dart; '
      'failing closed.',
    );
    return true;
  }
  final List<String> clashes = owned.where(widgets.contains).toList()..sort();
  for (final String name in clashes) {
    stdout.writeln('clash `$name` also exported by widgets.dart');
  }
  if (clashes.isNotEmpty) {
    stderr.writeln('check_names: ${clashes.length} widgets clash(es).');
    return true;
  }
  return false;
}

/// Public names a barrel library re-exports (resolved export namespace).
Future<Set<String>> _exportedNames(
  AnalysisContextCollection collection,
  String path,
) async {
  try {
    final session = collection.contextFor(path).currentSession;
    final SomeResolvedLibraryResult result = await session.getResolvedLibrary(
      path,
    );
    final LibraryElement? element = result is ResolvedLibraryResult
        ? result.element
        : null;
    if (element == null) {
      return const <String>{};
    }
    return element.exportNamespace.definedNames2.keys
        .where((String name) => !name.startsWith('_'))
        .toSet();
  } on StateError {
    return const <String>{};
  }
}

/// Export-namespace names of a library URI (empty when unresolvable).
Future<Set<String>> _libraryExportNames(
  AnalysisContextCollection collection,
  String uri,
) async {
  try {
    final session = collection.contexts.first.currentSession;
    final SomeLibraryElementResult result = await session.getLibraryByUri(uri);
    final LibraryElement? element = result is LibraryElementResult
        ? result.element
        : null;
    if (element == null) {
      return const <String>{};
    }
    return element.exportNamespace.definedNames2.keys.toSet();
  } on StateError {
    return const <String>{};
  }
}
