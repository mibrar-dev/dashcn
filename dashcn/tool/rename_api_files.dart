// File walking and kit-root discovery for the P8-2 codemod tooling.
//
// Tool-internal API (public names only because `tool/` scripts compile as
// separate libraries; nothing here is exported by the package).
import 'dart:io';

/// Directories never descended into (build outputs, caches, VCS).
const Set<String> skippedDirs = <String>{
  'build',
  '.dart_tool',
  'ephemeral',
  '.git',
  '.idea',
  'node_modules',
};

/// Walks [root] returning kit-relative paths ending with [suffix]
/// (empty suffix = every file), skipping caches and VCS metadata.
List<String> listFiles(Directory root, String kit, String suffix) {
  final List<String> out = <String>[];
  if (!root.existsSync()) {
    return out;
  }
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
        if (!skippedDirs.contains(name)) {
          queue.add(entry);
        }
      } else if (entry is File) {
        if (suffix.isEmpty || entry.path.endsWith(suffix)) {
          out.add(entry.path.substring(kit.length + 1));
        }
      }
    }
  }
  return out;
}

/// Walks up until `dashcn/lib/src/manifests/registry.json` resolves.
String? findKitRoot(Directory start) {
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
