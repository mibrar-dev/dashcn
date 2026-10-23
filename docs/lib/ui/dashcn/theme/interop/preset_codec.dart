// Shareable preset-string codec (pure Dart, no Flutter import).
//
// Format (`dcn1_`): canonical JSON (deep-sorted keys, UTF-8) → raw DEFLATE
// → base64url without padding, prefixed with the version tag `dcn1_`.
//
// This is *encoding, not encryption*: a theme is not a secret. The same
// bytes always produce the same string, so the docs Theme Studio can print
// it live and the CLI can accept it with `--preset`. Decoding is local and
// performs no network access. Short preset ids (`--preset bciwvKBk`) are
// not supported: pass the full string.

import 'dart:convert';

import 'package:archive/archive.dart';

/// Version tag prefix of every preset string this codec reads and writes.
const String kPresetStringPrefix = 'dcn1_';

/// Preset-string format version carried by the prefix (`1` in `dcn1_`).
const int kPresetStringVersion = 1;

const int _kMaxPayloadLength = 16 * 1024;

/// A preset string that cannot be decoded.
final class PresetStringException implements Exception {
  /// Creates the exception with a human readable [message].
  const PresetStringException(this.message);

  /// Human readable reason; safe to print to stderr.
  final String message;

  @override
  String toString() => 'PresetStringException: $message';
}

/// Encodes [preset] (a schema-v2 preset document) as a `dcn1_` string.
///
/// The document is canonicalised first (see [canonicalPresetJson]), so key
/// order and insignificant whitespace never change the output.
String encodePresetString(Map<String, Object?> preset) {
  final List<int> jsonBytes = utf8.encode(
    jsonEncode(canonicalPresetJson(preset)),
  );
  final List<int> deflated = Deflate(jsonBytes).getBytes();
  return '$kPresetStringPrefix${base64Url.encode(deflated).replaceAll('=', '')}';
}

/// Decodes a `dcn1_` [input] back to its preset document.
///
/// Throws [PresetStringException] with a clear message for unknown versions
/// (`dcn2_…`), truncated prefixes and malformed input. Never touches the
/// network: short ids are *not* resolved.
Map<String, Object?> decodePresetString(String input) {
  final String text = input.trim();
  final RegExpMatch? versioned = RegExp(r'^dcn(\d+)_').firstMatch(text);
  if (versioned == null) {
    throw const PresetStringException(
      'Not a preset string: expected a dcn1_… string '
      '(canonical JSON, deflated, base64url).',
    );
  }
  if (versioned.group(1) != '$kPresetStringVersion') {
    throw PresetStringException(
      'Unsupported preset string version "dcn${versioned.group(1)}_": '
      'this build reads dcn1_ only.',
    );
  }
  final String payload = text.substring(versioned.group(0)!.length);
  // A real preset is ~2 KB; the cap bounds what DEFLATE can expand to.
  if (payload.length > _kMaxPayloadLength) {
    throw const PresetStringException(
      'Malformed preset string: longer than any real preset.',
    );
  }
  late final List<int> deflated;
  try {
    deflated = base64Url.decode(_repad(payload));
  } on FormatException {
    throw const PresetStringException(
      'Malformed preset string: the part after dcn1_ is not base64url.',
    );
  }
  late final List<int> jsonBytes;
  try {
    jsonBytes = Inflate(deflated).getBytes();
  } on Object {
    throw const PresetStringException(
      'Malformed preset string: DEFLATE decompression failed.',
    );
  }
  late final Object? decoded;
  try {
    decoded = jsonDecode(utf8.decode(jsonBytes));
  } on FormatException {
    throw const PresetStringException(
      'Malformed preset string: the payload is not JSON.',
    );
  }
  if (decoded is! Map<String, Object?>) {
    throw const PresetStringException(
      'Malformed preset string: the payload is not a preset object.',
    );
  }
  return decoded;
}

/// Returns [preset] with every map's keys sorted recursively.
///
/// Sorting makes the encoding deterministic (and therefore diffable) no
/// matter which key order the caller built. Leaf values pass through
/// untouched; only key order is normalised.
Map<String, Object?> canonicalPresetJson(Map<String, Object?> preset) {
  final List<String> keys = preset.keys.toList()..sort();
  return <String, Object?>{
    for (final String key in keys) key: _canonicalValue(preset[key]),
  };
}

Object? _canonicalValue(Object? value) {
  if (value is Map<String, Object?>) {
    return canonicalPresetJson(value);
  }
  if (value is Map) {
    return canonicalPresetJson(
      value.map((Object? key, Object? item) => MapEntry(key.toString(), item)),
    );
  }
  if (value is List) {
    return <Object?>[for (final Object? item in value) _canonicalValue(item)];
  }
  return value;
}

String _repad(String payload) {
  final int remainder = payload.length % 4;
  if (remainder == 0) {
    return payload;
  }
  return payload + '=' * (4 - remainder);
}

/// A token-level diff between two preset documents: dotted paths
/// (`light.primary`, `fonts.sans`, `tracking.normal`, `shadow.light.blur`).
final class PresetDiff {
  /// Creates a diff from its three path lists (already sorted).
  const PresetDiff({
    required this.added,
    required this.changed,
    required this.removed,
  });

  /// Paths present only in the new document.
  final List<String> added;

  /// Paths present in both with different leaf values.
  final List<String> changed;

  /// Paths present only in the old document.
  final List<String> removed;

  /// Whether the documents hold identical tokens.
  bool get isEmpty => added.isEmpty && changed.isEmpty && removed.isEmpty;

  /// Printable `added` / `changed` / `removed` lines (`+`, `~`, `-`).
  List<String> reportLines() => <String>[
    for (final String path in added) '+ $path',
    for (final String path in changed) '~ $path',
    for (final String path in removed) '- $path',
  ];
}

/// Diffs two preset documents token-wise (canonical form, dotted paths).
PresetDiff diffPresetDocuments(
  Map<String, Object?> oldPreset,
  Map<String, Object?> newPreset,
) {
  final Map<String, String> oldFlat = _flatten(canonicalPresetJson(oldPreset));
  final Map<String, String> newFlat = _flatten(canonicalPresetJson(newPreset));
  final List<String> added = <String>[];
  final List<String> changed = <String>[];
  final List<String> removed = <String>[];
  for (final String path in newFlat.keys) {
    if (!oldFlat.containsKey(path)) {
      added.add(path);
    } else if (oldFlat[path] != newFlat[path]) {
      changed.add(path);
    }
  }
  for (final String path in oldFlat.keys) {
    if (!newFlat.containsKey(path)) {
      removed.add(path);
    }
  }
  return PresetDiff(added: added, changed: changed, removed: removed);
}

Map<String, String> _flatten(Map<String, Object?> node, [String prefix = '']) {
  final Map<String, String> out = <String, String>{};
  node.forEach((String key, Object? value) {
    final String path = prefix.isEmpty ? key : '$prefix.$key';
    if (value is Map<String, Object?>) {
      out.addAll(_flatten(value, path));
    } else if (value is Map) {
      out.addAll(
        _flatten(
          value.map((Object? k, Object? v) => MapEntry(k.toString(), v)),
          path,
        ),
      );
    } else {
      out[path] = jsonEncode(value);
    }
  });
  return out;
}
