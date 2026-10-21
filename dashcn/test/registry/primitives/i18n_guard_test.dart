// Analyzer-free i18n guard: every user-facing string in the kit comes from
// a locale table.
//
// Part 1 (key coverage) parses the eight `localizations_<domain>.dart`
// mixins for their `String get` / `String method(` members and requires each
// of the sixteen shipped locale tables to override every one of them, with a
// non-empty body that interpolates its parameters. Parsing the mixins at
// test time (instead of a checked-in key list) means the coverage can never
// drift when a domain mixin gains a key: the next run fails until the
// sixteen tables catch up.
//
// Part 2 (hardcoded literals) greps `components/` and `primitives/`
// (excluding the locale tables themselves and the `preview*.dart` demo
// surfaces, whose narrative sample copy stays English by doctrine) for
// suspicious English literals in known widgets and reports `file:line`.
// Legitimate English fallbacks — context-free helpers and nullable
// per-instance `strings` overrides — are allow-listed per file with the
// reason inline. No `package:analyzer` is used anywhere here: plain
// `dart:io` reads plus regular expressions.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Domain mixins holding the English defaults (the string table's source).
const List<String> _mixinFiles = <String>[
  'localizations_form.dart',
  'localizations_overlay.dart',
  'localizations_date_time.dart',
  'localizations_misc.dart',
  'localizations_files.dart',
  'localizations_error.dart',
  'localizations_chrome.dart',
  'localizations_media.dart',
];

// Dispatch helpers that read the translated getters above; they need no
// per-locale override of their own.
const Set<String> _derivedMembers = <String>{
  'getMonth',
  'getAbbreviatedMonth',
  'getAbbreviatedWeekday',
};

// The sixteen locales that must be complete for every key. `pt` also serves
// `pt-BR` (see `ComponentLocalizations.resolveLocale`) and `zh` is
// Simplified (`zh-Hans`); both resolve without their own table.
const List<String> _requiredLocales = <String>[
  'ar',
  'he',
  'fa',
  'ur',
  'de',
  'fr',
  'es',
  'it',
  'pt',
  'nl',
  'ru',
  'tr',
  'ja',
  'ko',
  'zh',
  'hi',
];

// Whole-word user strings that must come from a locale table.
const List<String> _bannedWords = <String>[
  'Cancel',
  'Save',
  'Previous',
  'Next',
  'Search',
  'Dismiss',
  'Delete',
  'Retry',
  'Loading',
  'Success',
  'Failure',
  'More',
  'Close',
  'Play',
  'Pause',
  'Mute',
  'Unmute',
  'Volume',
  'Seek',
  'Download',
  'Collapse',
  'Expand',
  'Details',
  'Clear',
  'Apply',
  'Verify',
  'Resend',
  'Code',
  'Email',
  'Password',
  'Name',
  'Undo',
  'Redo',
  'Cut',
  'Copy',
  'Paste',
  'Share',
];

// Full-phrase user strings that must come from a locale table.
const List<String> _bannedPhrases = <String>[
  'More actions',
  'Sign in',
  'No results found',
  'Pick a date',
  'Select a time',
  'Select a duration',
  'Nothing here yet',
  'Something went wrong',
  'Show captions',
  'Hide captions',
  'Captions on',
  'Captions off',
  'Fullscreen',
  'Feature carousel',
  'Add to chat',
  'Signature pad',
  'QR code',
  'Resize column',
  'Resize row',
  'Resize handle',
  'No suggestions',
  'Browse files',
  'Choose file',
  'No file chosen',
  'Remove file',
  'Retry upload',
  'Preview file',
  'Download file',
  'Clear all',
  'Date range',
  'Pull to refresh',
  'Release to refresh',
  'Refreshing',
  'Refresh complete',
  'Type a command',
  'Select all',
  'Search web',
  'Live text input',
  'Move up',
  'Move down',
  'Activate',
  'Pick a color',
  'Create your first item',
  'Try adjusting',
];

// Prefix patterns: screen-reader labels carrying an interpolated value.
final List<RegExp> _bannedPrefixes = <RegExp>[
  RegExp(r'^Page(\s|$)'),
  RegExp(r'^Step\s'),
  RegExp(r'^Series\s'),
  RegExp(r'^Slice\s'),
  RegExp(r'^Category\s'),
];

// Documented English fallbacks, per file basename: context-free helpers and
// nullable per-instance `strings` overrides that fall back to English when no
// delegate was installed. Every entry names the reason in [_fallbackReasons].
const Map<String, Set<String>> _fallbackAllowlist = <String, Set<String>>{
  // `buttonStatusAnnouncement` is context-free by design; widget builds use
  // the locale-aware `buttonStatusAnnouncementOf`.
  'button_status.dart': <String>{'Loading', 'Success', 'Failure'},
  // `_formatSpokenDuration` is context-free by design; widget builds use
  // `formatVideoSpokenDuration`, which pluralizes in the ambient locale.
  'video_player_buttons.dart': <String>{
    'hour',
    'hours',
    'minute',
    'minutes',
    'second',
    'seconds',
  },
  // Nullable per-instance `strings` override; falls back to English without a
  // delegate, exactly like `ComponentLocalizations.of`.
  'video_player_menu.dart': <String>{
    'Captions on',
    'Captions off',
    r'Speed ${s}x',
    r'More options, playback speed ${c.playbackSpeed}x',
  },
  // Nullable per-instance `strings` override with an English default.
  'audio_player_playlist.dart': <String>{'Untitled'},
  // `CustomPainter.paint` has no `BuildContext`; the widget path localizes
  // every name through `sliceNames`/`chartSliceDefault`, so this only serves
  // direct painter users.
  'chart_pie_painter.dart': <String>{r'Slice $i'},
};

String _locDir() =>
    '${Directory.current.path}/lib/src/primitives/localizations';

/// `name` plus its parameter names for a `String name(params)` member.
({String name, List<String> params})? _parseMember(String line) {
  final RegExpMatch? getter = RegExp(r'String get (\w+)').firstMatch(line);
  if (getter != null) {
    return (name: getter.group(1)!, params: const <String>[]);
  }
  final RegExpMatch? method = RegExp(
    r'String (\w+)\(([^)]*)\)',
  ).firstMatch(line);
  if (method != null) {
    final String name = method.group(1)!;
    if (name.startsWith('_')) {
      return null;
    }
    final List<String> params = method
        .group(2)!
        .split(',')
        .map((String p) => p.trim().split(' ').last.replaceAll('?', ''))
        .where((String p) => p.isNotEmpty)
        .toList(growable: false);
    return (name: name, params: params);
  }
  return null;
}

/// Reads every `String` member declared by the domain mixins.
Map<String, List<String>> _requiredKeys() {
  final Map<String, List<String>> keys = <String, List<String>>{};
  for (final String file in _mixinFiles) {
    for (final String line in File('${_locDir()}/$file').readAsLinesSync()) {
      final parsed = _parseMember(line);
      if (parsed != null && !_derivedMembers.contains(parsed.name)) {
        keys[parsed.name] = parsed.params;
      }
    }
  }
  return keys;
}

/// The override body for [key] in [source], from `=>` to the closing `;`.
String? _overrideBody(String source, String key) {
  final RegExpMatch? match = RegExp(
    'String (?:get $key\\b|$key\\()',
  ).firstMatch(source);
  if (match == null) {
    return null;
  }
  final int arrow = source.indexOf('=>', match.start);
  if (arrow < 0) {
    return null;
  }
  final int end = source.indexOf(';', arrow);
  if (end < 0) {
    return null;
  }
  return source.substring(arrow + 2, end);
}

/// Strips `//` comments outside string literals; `///` doc lines are dropped
/// by the caller. Keeps `https://` inside literals intact.
String _stripLineComment(String line) {
  bool inSingle = false;
  bool inDouble = false;
  for (int i = 0; i + 1 < line.length; i++) {
    final String c = line[i];
    if (c == r'\') {
      i++;
      continue;
    }
    if (c == "'" && !inDouble) {
      inSingle = !inSingle;
    } else if (c == '"' && !inSingle) {
      inDouble = !inDouble;
    } else if (c == '/' && line[i + 1] == '/' && !inSingle && !inDouble) {
      return line.substring(0, i);
    }
  }
  return line;
}

final RegExp _literalPattern = RegExp(
  "\"((?:[^\"\\\\]|\\\\.)*)\"|'((?:[^'\\\\]|\\\\.)*)'",
);

void main() {
  group('i18n key coverage (static, analyzer-free)', () {
    late Map<String, List<String>> keys;

    setUpAll(() {
      keys = _requiredKeys();
      expect(keys.length, greaterThan(200), reason: 'mixin parse failed');
    });

    for (final String code in _requiredLocales) {
      test('$code overrides every key with a non-empty body', () {
        final String source = File(
          '${_locDir()}/localizations_$code.dart',
        ).readAsStringSync();
        final List<String> missing = <String>[];
        final List<String> empty = <String>[];
        final List<String> uninterpolated = <String>[];
        for (final MapEntry<String, List<String>> entry in keys.entries) {
          final String? body = _overrideBody(source, entry.key);
          if (body == null) {
            missing.add(entry.key);
            continue;
          }
          final RegExpMatch? quoted = _literalPattern.firstMatch(body);
          final String content = quoted == null
              ? ''
              : (quoted.group(1) ?? quoted.group(2) ?? '');
          if (content.isEmpty) {
            empty.add(entry.key);
            continue;
          }
          // Parameterized members must interpolate: the body references a
          // parameter (directly or through `_number(...)`).
          if (entry.value.isNotEmpty && !body.contains(r'$')) {
            uninterpolated.add(entry.key);
          }
        }
        expect(missing, isEmpty, reason: '$code is missing overrides');
        expect(empty, isEmpty, reason: '$code has empty strings');
        expect(
          uninterpolated,
          isEmpty,
          reason: '$code drops placeholders like {count}',
        );
      });
    }
  });

  group('no hardcoded user-facing English in widgets (static grep)', () {
    test('components/ and primitives/ read strings from locale tables', () {
      final RegExp wordPattern = RegExp(
        '^(${_bannedWords.map(RegExp.escape).join('|')})\$',
      );
      final RegExp phrasePattern = RegExp(
        '^(${_bannedPhrases.map(RegExp.escape).join('|')})',
      );
      final List<String> hits = <String>[];
      for (final String scope in <String>['components', 'primitives']) {
        final Directory dir = Directory(
          '${Directory.current.path}/lib/src/$scope',
        );
        if (!dir.existsSync()) {
          continue;
        }
        for (final FileSystemEntity entity in dir.listSync(recursive: true)) {
          if (entity is! File || !entity.path.endsWith('.dart')) {
            continue;
          }
          final String name = entity.path.split('/').last;
          if (name == 'preview.dart' || name.startsWith('preview_')) {
            continue;
          }
          if (entity.path.contains('/localizations/')) {
            continue;
          }
          final List<String> lines = entity.readAsLinesSync();
          for (int i = 0; i < lines.length; i++) {
            final String stripped = lines[i].trimLeft();
            if (stripped.startsWith('///')) {
              continue;
            }
            final String code = _stripLineComment(lines[i]);
            for (final RegExpMatch m in _literalPattern.allMatches(code)) {
              final String literal = m.group(1) ?? m.group(2) ?? '';
              if (literal.isEmpty) {
                continue;
              }
              final bool banned =
                  wordPattern.hasMatch(literal) ||
                  phrasePattern.hasMatch(literal) ||
                  _bannedPrefixes.any((RegExp rx) => rx.hasMatch(literal));
              if (!banned) {
                continue;
              }
              if ((_fallbackAllowlist[name] ?? const <String>{}).contains(
                literal,
              )) {
                continue;
              }
              hits.add(
                '${entity.path.split('lib/src/').last}:${i + 1}: '
                '"$literal"',
              );
            }
          }
        }
      }
      expect(
        hits,
        isEmpty,
        reason:
            'hardcoded English literals (use a locale table):\n'
            '${hits.join('\n')}',
      );
    });
  });
}
