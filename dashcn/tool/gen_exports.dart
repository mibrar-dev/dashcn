// Generates the public libraries from `lib/src/manifests/registry.json`:
//
//   lib/dashcn.dart            barrel: foundation + theme + primitives +
//                              every component (blocks are NOT included)
//   lib/foundation.dart        one library per layer (tree-shakeable)
//   lib/theme.dart
//   lib/primitives.dart
//   lib/components/<id>.dart  one library per component
//   lib/blocks/<id>.dart       one library per block
//
// Usage:
//   dart run tool/gen_exports.dart [--check] [--help]
//
// `--check` regenerates in memory and exits 1 listing stale files.
//
// Ambiguous exports are resolved deterministically: when one top-level name
// is declared by several exported files (detected with `package:analyzer`),
// it stays visible from the alphabetically-first file and is hidden from the
// rest. Every resolution is printed; a real collision needs a human rename.
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

const String _header =
    '// GENERATED FILE - DO NOT EDIT.\n'
    '// Run: dart run tool/gen_exports.dart\n';

/// Locates the `dashcn` package root by walking up from [start].
Directory? findPackageRoot(Directory start) {
  Directory current = start.absolute;
  while (true) {
    if (File('${current.path}/lib/src/manifests/registry.json').existsSync()) {
      return current;
    }
    final Directory parent = current.parent;
    if (parent.path == current.path) {
      return null;
    }
    current = parent;
  }
}

/// Public top-level names declared by one source file.
Set<String> declaredNames(String path) {
  final ParseStringResult result = parseString(
    content: File(path).readAsStringSync(),
    throwIfDiagnostics: false,
  );
  final Set<String> names = <String>{};
  for (final CompilationUnitMember member in result.unit.declarations) {
    if (member is TopLevelVariableDeclaration) {
      for (final VariableDeclaration variable in member.variables.variables) {
        if (!variable.name.lexeme.startsWith('_')) {
          names.add(variable.name.lexeme);
        }
      }
      continue;
    }
    final String? name = _declarationName(member);
    if (name != null) {
      names.add(name);
    }
  }
  return names;
}

/// Best-effort public name of one top-level declaration, or null for
/// private/anonymous members (analyzer 14 fragments AST).
String? _declarationName(CompilationUnitMember member) {
  final dynamic any = member;
  try {
    final dynamic namePart = any.namePart;
    if (namePart != null) {
      final String lexeme = namePart.typeName.lexeme as String;
      return lexeme.startsWith('_') ? null : lexeme;
    }
  } on NoSuchMethodError {
    // No fragments namePart; fall through to the Token name.
  }
  try {
    final dynamic name = any.name;
    if (name == null) {
      return null;
    }
    final String lexeme = name.lexeme as String;
    return lexeme.startsWith('_') ? null : lexeme;
  } on NoSuchMethodError {
    return null;
  }
}

/// One export line, with `hide` for names owned by another export.
String _exportLine(String uri, List<String> hidden) {
  if (hidden.isEmpty) {
    return "export '$uri';";
  }
  final List<String> sorted = hidden.toList()..sort();
  return "export '$uri' hide ${sorted.join(', ')};";
}

/// Renders one library: [relPaths] are manifest-relative (`components/…`)
/// paths; the emitted URIs are relative from the library file to `lib/src/`.
String renderLibrary(
  String libraryPath,
  List<String> relPaths,
  Map<String, Set<String>> namesByFile,
  void Function(String message) onCollision,
) {
  final List<String> dirSegments = libraryPath.split('/')
    ..removeLast()
    ..removeAt(0); // Drop the leading `lib`.
  final String prefix = '${'../' * dirSegments.length}src/';
  final List<String> sorted = relPaths.toSet().toList()..sort();
  final Map<String, List<String>> owners = <String, List<String>>{};
  for (final String path in sorted) {
    for (final String name in namesByFile[path] ?? const <String>{}) {
      owners.putIfAbsent(name, () => <String>[]).add(path);
    }
  }
  final Map<String, List<String>> hiddenByFile = <String, List<String>>{};
  for (final MapEntry<String, List<String>> entry in owners.entries) {
    if (entry.value.length < 2) {
      continue;
    }
    // Deterministic: the alphabetically-first file keeps the name.
    final List<String> files = entry.value.toList()..sort();
    onCollision(
      'collision `${entry.key}` kept in ${files.first}, '
      'hidden from ${files.skip(1).join(', ')}',
    );
    for (final String loser in files.skip(1)) {
      hiddenByFile.putIfAbsent(loser, () => <String>[]).add(entry.key);
    }
  }
  final StringBuffer out = StringBuffer(_header);
  for (final String path in sorted) {
    out.writeln(
      _exportLine('$prefix$path', hiddenByFile[path] ?? const <String>[]),
    );
  }
  return out.toString();
}

void main(List<String> args) {
  if (args.contains('--help') || args.contains('-h')) {
    stdout.writeln(
      'Usage: dart run tool/gen_exports.dart [--check]\n'
      '  --check   exit 1 when a generated library is stale',
    );
    return;
  }
  final bool check = args.contains('--check');
  if (args.any((String arg) => arg != '--check')) {
    stderr.writeln('gen_exports: unknown argument `${args.join(' ')}`');
    exitCode = 64;
    return;
  }
  final Directory? root = findPackageRoot(Directory.current);
  if (root == null) {
    stderr.writeln('gen_exports: cannot locate the dashcn package root.');
    exitCode = 1;
    return;
  }
  final Map<String, dynamic> manifest =
      jsonDecode(
            File(
              '${root.path}/lib/src/manifests/registry.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;

  List<String> sectionFiles(String section) {
    final Map<String, dynamic> group = (manifest[section] as Map)
        .cast<String, dynamic>();
    final List<String> files = <String>[];
    for (final MapEntry<String, dynamic> entry in group.entries) {
      files.addAll(((entry.value as Map)['files'] as List).cast<String>());
    }
    return files.toSet().toList()..sort();
  }

  final Map<String, dynamic> components = (manifest['components'] as Map)
      .cast<String, dynamic>();
  final Map<String, dynamic> blocks = (manifest['blocks'] as Map)
      .cast<String, dynamic>();
  final List<String> componentIds = components.keys.toList()..sort();
  final List<String> blockIds = blocks.keys.toList()..sort();

  List<String> entryFiles(String id, Map<String, dynamic> group) {
    final List<String> files = ((group[id] as Map)['files'] as List)
        .cast<String>();
    return files.toSet().toList()..sort();
  }

  final List<String> foundation = sectionFiles('foundation');
  final List<String> theme = sectionFiles('theme');
  final List<String> primitives = sectionFiles('primitives');
  final List<String> barrel = <String>[...foundation, ...theme, ...primitives];
  for (final String id in componentIds) {
    barrel.addAll(entryFiles(id, components));
  }

  // Parse every exported file once.
  final Set<String> allPaths = <String>{
    ...foundation,
    ...theme,
    ...primitives,
    ...barrel,
  };
  for (final String id in blockIds) {
    allPaths.addAll(entryFiles(id, blocks));
  }
  final Map<String, Set<String>> namesByFile = <String, Set<String>>{};
  for (final String rel in allPaths) {
    namesByFile[rel] = declaredNames('${root.path}/lib/src/$rel');
  }

  final List<String> collisions = <String>[];
  String render(String libraryPath, List<String> paths) =>
      renderLibrary(libraryPath, paths, namesByFile, collisions.add);

  final Map<String, String> bundle = <String, String>{
    'lib/dashcn.dart': render('lib/dashcn.dart', barrel),
    'lib/foundation.dart': render('lib/foundation.dart', foundation),
    'lib/theme.dart': render('lib/theme.dart', theme),
    'lib/primitives.dart': render('lib/primitives.dart', primitives),
  };
  for (final String id in componentIds) {
    bundle['lib/components/$id.dart'] = render(
      'lib/components/$id.dart',
      entryFiles(id, components),
    );
  }
  for (final String id in blockIds) {
    // Block ids contain hyphens (`account-01`), which violate the
    // `file_names` lint; the library stem uses underscores, matching the
    // source stem convention (`account_01.dart`).
    final String stem = id.replaceAll('-', '_');
    bundle['lib/blocks/$stem.dart'] = render(
      'lib/blocks/$stem.dart',
      entryFiles(id, blocks),
    );
  }

  for (final String message in collisions.toList()..sort()) {
    stdout.writeln(message);
  }
  if (check) {
    final List<String> stale = <String>[];
    for (final MapEntry<String, String> entry in bundle.entries) {
      final File file = File('${root.path}/${entry.key}');
      if (!file.existsSync() || file.readAsStringSync() != entry.value) {
        stale.add(entry.key);
      }
    }
    if (stale.isEmpty) {
      stdout.writeln(
        'exports are up to date (${bundle.length} libraries checked).',
      );
      return;
    }
    for (final String path in stale) {
      stdout.writeln('out of date: $path');
    }
    stderr.writeln(
      'gen_exports: ${stale.length} generated librar(ies) out of date; '
      'run `dart run tool/gen_exports.dart`.',
    );
    exitCode = 1;
    return;
  }
  for (final MapEntry<String, String> entry in bundle.entries) {
    final File file = File('${root.path}/${entry.key}');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(entry.value);
  }
  stdout.writeln('wrote ${bundle.length} libraries.');
}
