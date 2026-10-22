// Guard: no hardcoded user-facing English in converted kit UI.
//
// Scans `lib/src` (excluding docs-sample `preview.dart` files and the locale
// tables themselves) for English literals in UI label positions and fails on
// any hit that is not covered by [_allowList]. Add a new entry — with a
// reason — instead of weakening the patterns when a legitimate exception
// appears.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A single allowed exception: [pattern] matches the offending line, [reason]
/// justifies why it is not converted to the locale table.
class _Allowed {
  const _Allowed(this.pattern, this.reason);
  final Pattern pattern;
  final String reason;
}

/// Folder-level allowance: every remaining literal under these roots is demo
/// sample content (the preview.dart doctrine). Blocks, flows and starters
/// carry no blanket exemption: their control chrome reads the locale table
/// and only demo data (names, messages, amounts, timestamps) stays English,
/// covered by the per-file entries below.
const List<String> _sampleContentRoots = <String>[];

/// Explicit per-exception allow-list. Each entry needs a reason.
const Map<String, List<_Allowed>> _allowList = <String, List<_Allowed>>{
  // Documented English fallbacks for context-free public API. Widget builds
  // pass the ambient locale; the literal only shows without a BuildContext.
  'components/button/button_status.dart': <_Allowed>[
    _Allowed(
      "'Loading'",
      'buttonStatusAnnouncement: context-free English fallback; builds use buttonStatusAnnouncementOf.',
    ),
    _Allowed(
      "'Success'",
      'buttonStatusAnnouncement: context-free English fallback; builds use buttonStatusAnnouncementOf.',
    ),
    _Allowed(
      "'Failure'",
      'buttonStatusAnnouncement: context-free English fallback; builds use buttonStatusAnnouncementOf.',
    ),
  ],
  'components/video_player/video_player_menu.dart': <_Allowed>[
    _Allowed(
      "'More options, playback speed",
      'videoMoreButton: optional-strings fallback; internal call sites pass locale.',
    ),
    _Allowed(
      "'Captions on'",
      'videoMenuSection: optional-strings fallback; internal call sites pass locale.',
    ),
    _Allowed(
      "'Captions off'",
      'videoMenuSection: optional-strings fallback; internal call sites pass locale.',
    ),
    _Allowed(
      "'Quality Auto'",
      'videoMenuSection: optional-strings fallback; internal call sites pass locale.',
    ),
  ],
  'components/audio_player/audio_player_playlist.dart': <_Allowed>[
    _Allowed(
      "'Untitled'",
      'resolveAudioTitle: optional-strings fallback; widget call sites pass locale.',
    ),
    _Allowed(
      'Southern Roots',
      'demoAudioTracks entries are explicitly demo content; docs-sample doctrine.',
    ),
  ],
  // Diff porcelain: unified-diff markers and git status words stay English by
  // convention (same as `---`/`+++`), like code.
  'components/file_diff_viewer/file_diff_viewer_style.dart': <_Allowed>[
    _Allowed(
      "'modified'",
      'git status porcelain vocabulary; caller data, not kit UI chrome.',
    ),
    _Allowed(
      'rename from',
      'unified-diff header syntax; locale-invariant like +++/---.',
    ),
    _Allowed(
      'rename to',
      'unified-diff header syntax; locale-invariant like +++/---.',
    ),
  ],
  // Config objects with English const defaults + per-instance override; the
  // components resolve locale values when the caller leaves them null.
  'primitives/file_value/file_format.dart': <_Allowed>[
    _Allowed(
      "'Queued'",
      'FileStatusLabels const default; file_upload_row passes locale values.',
    ),
    _Allowed(
      "'Uploading'",
      'FileStatusLabels const default; file_upload_row passes locale values.',
    ),
    _Allowed(
      "'Completed'",
      'FileStatusLabels const default; file_upload_row passes locale values.',
    ),
    _Allowed(
      "'Failed'",
      'FileStatusLabels const default; file_upload_row passes locale values.',
    ),
  ],
  'primitives/file_value/file_upload_controller.dart': <_Allowed>[
    _Allowed(
      '_englishMessage',
      'documented fallback for programmatic controller use; file_picker passes a locale message fn.',
    ),
  ],
  // Locale-invariant data: proper nouns, unit symbols, key caps, charsets,
  // syntax tables, markup tokens, mime/extension lists, demo media entries.
  'primitives/countries.dart': <_Allowed>[
    _Allowed(
      '',
      'whole file: CLDR-style country/currency data; proper nouns stay English, picker chrome is localized.',
    ),
  ],
  'components/locale_utils/locale_utils.dart': <_Allowed>[
    _Allowed('', 'whole file: SI/IEC byte-unit symbols; locale-invariant.'),
  ],
  'components/keyboard_shortcut/keyboard_shortcut.dart': <_Allowed>[
    _Allowed("'Ctrl'", 'platform key-cap labels; locale-invariant key names.'),
    _Allowed("'Shift'", 'platform key-cap labels; locale-invariant key names.'),
    _Allowed("'Alt'", 'platform key-cap labels; locale-invariant key names.'),
    _Allowed("'Esc'", 'platform key-cap labels; locale-invariant key names.'),
  ],
  'primitives/number_ticker': <_Allowed>[
    _Allowed('', 'charset data for the ticker alphabet; not words.'),
  ],
  'primitives/syntax_highlight': <_Allowed>[
    _Allowed('', 'language ids and lexer regexes; code data.'),
  ],
  'primitives/markdown_parser': <_Allowed>[
    _Allowed('', 'HTML tag names, entities and parser regexes; markup syntax.'),
  ],
  'primitives/file_value/file_upload_row.dart': <_Allowed>[
    _Allowed("'png'", 'file-extension allow-list data; not words.'),
  ],
  'primitives/file_value/file_value.dart': <_Allowed>[
    _Allowed('', 'mime/extension data tables; not words.'),
  ],
  'components/video_player/video_player_sources.dart': <_Allowed>[
    _Allowed(
      "'Online MP4'",
      'demoVideoSources entries are explicitly demo content; docs-sample doctrine.',
    ),
    _Allowed(
      "'Live stream'",
      'demoVideoSources entries are explicitly demo content; docs-sample doctrine.',
    ),
    _Allowed(
      "'Live feed'",
      'demoVideoSources entries are explicitly demo content; docs-sample doctrine.',
    ),
  ],
  'theme/interop/css_theme_parser.dart': <_Allowed>[
    _Allowed(
      'IgnoredEntry(',
      'CSS theme parser diagnostics (variable names); developer-facing, never rendered.',
    ),
  ],
  'components/chart/chart_pie_painter.dart': <_Allowed>[
    _Allowed(
      "'Slice \$i'",
      'unreachable defensive fallback; names are pre-resolved with locale strings in chart.dart sliceNames.',
    ),
  ],
  // User data / locale-invariant numbers composed with caller content.
  'components/pagination/pagination.dart': <_Allowed>[
    _Allowed(
      "'\$pageNumber'",
      'page digits; wrapped in DashcnLtr so RTL never reorders them.',
    ),
  ],
  'components/search_bar/search_bar.dart': <_Allowed>[
    _Allowed("'\$item'", 'caller-provided item data echoed verbatim.'),
  ],
  'components/chip_input/chip_input.dart': <_Allowed>[
    _Allowed("'\$chip'", 'caller-provided chip data echoed verbatim.'),
  ],
  'components/stepper/stepper_style.dart': <_Allowed>[
    _Allowed("'\${index + 1}'", 'ring digits; locale-invariant numbers.'),
  ],
  'components/filter_bar/filter_bar_menu.dart': <_Allowed>[
    _Allowed(
      "'\$title (\$activeCount)'",
      'caller title plus count composite; title is caller data.',
    ),
  ],
  'components/filter_bar/filter_bar_triggers.dart': <_Allowed>[
    _Allowed(
      "'\$label (\$activeCount)'",
      'caller label plus count composite; label is caller data.',
    ),
  ],
  'components/input_otp/input_otp.dart': <_Allowed>[
    _Allowed('', 'separator glyphs (-, •) and slot counts; not words.'),
  ],
  'components/object_input': <_Allowed>[
    _Allowed('', 'path separator glyphs; locale-invariant syntax.'),
  ],
  'components/text_animate': <_Allowed>[
    _Allowed('', 'split-unit separators; locale-invariant.'),
  ],
  'components/formatted_input/formatted_input.dart': <_Allowed>[
    _Allowed('', 'group separator glyphs; locale-invariant.'),
  ],
  'primitives/form_core/validation.dart': <_Allowed>[
    _Allowed('', 'decimal/grouping punctuation; locale-invariant syntax.'),
  ],
  'primitives/text_editing': <_Allowed>[
    _Allowed('', 'token fragment debug/empty separators; not UI words.'),
  ],
  // Blocks, flows and starters: control chrome reads ComponentLocalizations;
  // the entries below are demo sample content (names, example emails,
  // addresses, dates, version rows, legal link labels) adopters replace.
  'blocks/login-01/login_01.dart': <_Allowed>[
    _Allowed("'name@example.com'", 'example-email demo hint; sample content.'),
  ],
  'blocks/account-01/account_01_profile.dart': <_Allowed>[
    _Allowed("'Ada Lovelace'", 'demo name hint; sample content.'),
    _Allowed("hintText: 'ada'", 'demo username hint; sample content.'),
  ],
  'blocks/sidebar-02/sidebar_02_panel.dart': <_Allowed>[
    _Allowed("'Platform'", 'demo search facet; sample content.'),
  ],
  'blocks/sidebar-02/sidebar_02_content.dart': <_Allowed>[
    _Allowed("'Stable'", 'demo version rows; sample content.'),
    _Allowed("'Beta channel'", 'demo version rows; sample content.'),
    _Allowed("'New: batches'", 'demo version rows; sample content.'),
  ],
  'blocks/signup-02/signup_02_form.dart': <_Allowed>[
    _Allowed("'Ada'", 'demo name hints; sample content.'),
    _Allowed("'Lovelace'", 'demo name hints; sample content.'),
    _Allowed("'ada@example.com'", 'demo email hint; sample content.'),
    _Allowed(
      "'terms'",
      'English legal link label; legal copy stays source-language.',
    ),
    _Allowed(
      "'privacy policy'",
      'English legal link label; legal copy stays source-language.',
    ),
  ],
  'blocks/signup-02/signup_02_aside.dart': <_Allowed>[
    _Allowed("'Acme Inc'", 'demo brand; sample content.'),
  ],
  'components/sidebar/sidebar.dart': <_Allowed>[
    _Allowed("'Acme Inc'", 'demo brand default; callers pass their own title.'),
  ],
  'blocks/login-02/login_02.dart': <_Allowed>[
    _Allowed("'name@example.com'", 'example-email demo hint; sample content.'),
  ],
  'blocks/login-02/login_02_panel.dart': <_Allowed>[
    _Allowed("'Acme Inc'", 'demo brand; sample content.'),
  ],
  'blocks/login-03/login_03.dart': <_Allowed>[
    _Allowed("'name@example.com'", 'example-email demo hint; sample content.'),
  ],
  'blocks/calendar-02/calendar_02.dart': <_Allowed>[
    _Allowed("'Saturday, 10 October'", 'demo date heading; sample content.'),
    _Allowed("'Calendar link'", 'demo link label; sample content.'),
  ],
  'blocks/signup-01/signup_01.dart': <_Allowed>[
    _Allowed("'Ada Lovelace'", 'demo name hint; sample content.'),
    _Allowed("'name@example.com'", 'example-email demo hint; sample content.'),
    _Allowed(
      "'terms'",
      'English legal link label; legal copy stays source-language.',
    ),
    _Allowed(
      "'privacy policy'",
      'English legal link label; legal copy stays source-language.',
    ),
  ],
  'flows/checkout-01/screens/address_sheet.dart': <_Allowed>[
    _Allowed("'Ada Lovelace'", 'demo name hint; sample content.'),
    _Allowed("'Springfield'", 'demo city hint; sample content.'),
  ],
  'flows/auth-01/screens/sign_up_screen.dart': <_Allowed>[
    _Allowed("'Ada Lovelace'", 'demo name hint; sample content.'),
    _Allowed("'name@example.com'", 'example-email demo hint; sample content.'),
  ],
  'flows/auth-01/screens/forgot_password_screen.dart': <_Allowed>[
    _Allowed("'name@example.com'", 'example-email demo hint; sample content.'),
  ],
  'flows/auth-01/screens/sign_in_screen.dart': <_Allowed>[
    _Allowed("'name@example.com'", 'example-email demo hint; sample content.'),
  ],
  'flows/settings-01/flow.dart': <_Allowed>[
    _Allowed(
      "this.userName = 'Ada Lovelace'",
      'demo user default; sample content.',
    ),
  ],
};

/// Lines that are never user-facing: diagnostics, debug labels, storage keys,
/// JSON keys, regexes, URLs, imports/exports and doc comments are skipped
/// before matching.
bool _isTechnical(String line) {
  final String s = line.trim();
  if (s.startsWith('///') ||
      s.startsWith('//') ||
      s.startsWith('*') ||
      s.startsWith('import ') ||
      s.startsWith('export ')) {
    return true;
  }
  if (RegExp(
    r'debugLabel|ValueKey|debugPrint|debugDescription|debugFillProperties',
  ).hasMatch(line)) {
    return true;
  }
  if (RegExp(
    r'\bassert\(|\bthrow\b|StateError|ArgumentError|UnimplementedError|FlutterError|RangeError|AssertionError|TypeError|UnsupportedError|FormatException|StateError\(',
  ).hasMatch(line)) {
    return true;
  }
  if (RegExp(
    r'RegExp\(|fontFamily|IconData\(|codePoint|^\s*///',
  ).hasMatch(line)) {
    return true;
  }
  if (RegExp(
    r"'(?:https?|mailto:|asset:|image/|text/plain|#[0-9a-fA-F]|[a-z]+/[a-z0-9+.-]+)'",
  ).hasMatch(line)) {
    return true;
  }
  // JSON map keys and `dashcn.`-style storage/debug ids.
  if (RegExp(r"'[a-z][a-zA-Z0-9_]*':").hasMatch(line)) {
    return true;
  }
  if (line.contains('dashcn.') || line.contains('__matcher:')) {
    return true;
  }
  return false;
}

/// UI label positions: a hardcoded English word here reaches the screen.
final List<RegExp> _forbidden = <RegExp>[
  // Text('Words'), Text("Words"), label: Text('Words')
  RegExp(r'''Text\(\s*['"][A-Za-z]'''),
  // label:/hintText:/tooltip:/placeholder:/semanticLabel: 'Words'
  RegExp(
    r'''(label|hintText|tooltip|placeholder|semanticLabel|semanticsLabel)\s*:\s*['"][A-Za-z]''',
  ),
  // const Text('Words') assigned to label-like params
  RegExp(r'''label:\s*(const\s+)?Text\(\s*['"][A-Za-z]'''),
  // 'Words' fallbacks and config defaults with real English words
  RegExp(r'''\?\?\s*['"][A-Za-z][a-z]+ [a-z]'''),
  RegExp(r'''this\.\w+\s*=\s*['"][A-Z][a-z]+'''),
];

/// English-word check on the literal itself (filters digits/symbols-only).
bool _hasEnglishWords(String line) {
  final Iterable<RegExpMatch> lits = RegExp(
    r"""'((?:[^'\\]|\\.){2,120})'""",
  ).allMatches(line);
  for (final RegExpMatch m in lits) {
    final String v = m.group(1)!;
    if (RegExp(r'[a-z]{2,}').hasMatch(v) &&
        RegExp(r'[A-Za-z]').hasMatch(v) &&
        !v.contains(r'$') &&
        !v.contains('http') &&
        !v.contains('dashcn.')) {
      return true;
    }
  }
  return false;
}

void main() {
  test('no hardcoded user-facing English outside the allow-list', () {
    final Directory root = Directory('lib/src');
    final List<String> violations = <String>[];
    for (final FileSystemEntity entity in root.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      final String rel = entity.path
          .replaceFirst(RegExp(r'^lib/src/'), '')
          .replaceAll('\\', '/');
      if (rel.split('/').last.contains('preview')) {
        continue;
      }
      if (rel.startsWith('primitives/localizations/')) {
        continue;
      }
      if (_sampleContentRoots.any(rel.startsWith)) {
        continue;
      }
      final List<String> lines = entity.readAsLinesSync();
      for (int i = 0; i < lines.length; i++) {
        final String line = lines[i];
        if (_isTechnical(line)) {
          continue;
        }
        final bool hit = _forbidden.any((RegExp r) => r.hasMatch(line));
        if (!hit || !_hasEnglishWords(line)) {
          continue;
        }
        List<_Allowed>? effective = _allowList[rel];
        if (effective == null) {
          for (final MapEntry<String, List<_Allowed>> e in _allowList.entries) {
            if (!e.key.endsWith('.dart') && rel.startsWith(e.key)) {
              effective = e.value;
              break;
            }
          }
        }
        final bool excused =
            effective != null &&
            effective.any(
              (_Allowed a) =>
                  a.pattern == '' ||
                  (a.pattern is String
                      ? line.contains(a.pattern as String)
                      : (a.pattern as RegExp).hasMatch(line)),
            );
        if (!excused) {
          violations.add('$rel:${i + 1}: ${line.trim()}');
        }
      }
    }
    expect(
      violations,
      isEmpty,
      reason: 'hardcoded UI English:\n${violations.join('\n')}',
    );
  });

  test('allow-list entries still match (no stale excuses)', () {
    final List<String> stale = <String>[];
    for (final MapEntry<String, List<_Allowed>> entry in _allowList.entries) {
      if (entry.value.any((_Allowed a) => a.pattern == '')) {
        continue;
      }
      final File file = File('lib/src/${entry.key}');
      if (!file.existsSync()) {
        // Prefix entries (directories) are checked per-file at scan time.
        continue;
      }
      final String src = file.readAsStringSync();
      for (final _Allowed a in entry.value) {
        final bool found = a.pattern is String
            ? src.contains(a.pattern as String)
            : (a.pattern as RegExp).hasMatch(src);
        if (!found) {
          stale.add('${entry.key} :: ${a.pattern}');
        }
      }
    }
    expect(stale, isEmpty, reason: 'stale allow-list:\n${stale.join('\n')}');
  });
}
