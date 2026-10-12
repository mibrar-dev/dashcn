// Identifier, comment, string and text passes for `tool/rename_api.dart`.
// Map-driven (see `rename_api_map.dart`), no regex: Dart structure comes from
// the analyzer, words use a hand-rolled boundary scan, substrings use literal
// `String.replaceAll`. Declaration names → `rename_api_names.dart`, theme
// scopes → `rename_api_scopes.dart`.
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rename_api_map.dart';
import 'rename_api_names.dart';
import 'rename_api_scopes.dart';

/// True when [text] holds `shadcn` (case-insensitive). Every map rule key
/// contains it, so files without it are provably no-ops and skip all passes.
bool hasShadcn(String text) {
  final String lower = text.toLowerCase();
  return lower.contains('shadcn');
}

/// True for `[A-Za-z0-9_]` code units.
bool _isWord(int code) =>
    code == 95 ||
    (code >= 48 && code <= 57) ||
    (code >= 65 && code <= 90) ||
    (code >= 97 && code <= 122);

/// Replaces whole-word occurrences of [from] with [to] (no regex).
String replaceWord(String text, String from, String to) {
  if (from.isEmpty || !text.contains(from)) {
    return text;
  }
  final StringBuffer out = StringBuffer();
  int i = 0;
  while (true) {
    final int hit = text.indexOf(from, i);
    if (hit < 0) {
      out.write(text.substring(i));
      break;
    }
    final int end = hit + from.length;
    final bool leftOk = hit == 0 || !_isWord(text.codeUnitAt(hit - 1));
    final bool rightOk = end >= text.length || !_isWord(text.codeUnitAt(end));
    out.write(text.substring(i, leftOk && rightOk ? hit : end));
    if (leftOk && rightOk) {
      out.write(to);
    }
    i = end;
  }
  return out.toString();
}

/// Replaces the [prefix] of whole words starting with it (keeps `_`s).
String replaceWordPrefix(String text, String prefix, String replacement) {
  if (prefix.isEmpty || !text.contains(prefix)) {
    return text;
  }
  final StringBuffer out = StringBuffer();
  int i = 0;
  while (i < text.length) {
    if (!_isWord(text.codeUnitAt(i))) {
      out.writeCharCode(text.codeUnitAt(i));
      i++;
      continue;
    }
    int end = i;
    while (end < text.length && _isWord(text.codeUnitAt(end))) {
      end++;
    }
    final String word = text.substring(i, end);
    String head = word;
    String underscores = '';
    while (head.startsWith('_')) {
      underscores += '_';
      head = head.substring(1);
    }
    if (head.startsWith(prefix)) {
      out.write(underscores + replacement + head.substring(prefix.length));
    } else {
      out.write(word);
    }
    i = end;
  }
  return out.toString();
}

/// Masks allow-list spans with inert placeholders; returns the masked text
/// plus the table needed by [unmaskAllow] to restore them.
(Map<String, String>, String) maskAllow(String text, List<String> allow) {
  final Map<String, String> table = <String, String>{};
  String masked = text;
  int index = 0;
  for (final String entry in allow) {
    if (entry.isEmpty) {
      continue;
    }
    final String needle = entry.toLowerCase();
    int from = 0;
    while (true) {
      final int hit = masked.toLowerCase().indexOf(needle, from);
      if (hit < 0) {
        break;
      }
      final String placeholder =
          '${String.fromCharCode(0xE000)}$index${String.fromCharCode(0xE001)}';
      table[placeholder] = masked.substring(hit, hit + entry.length);
      masked =
          masked.substring(0, hit) +
          placeholder +
          masked.substring(hit + entry.length);
      // Rescan after the placeholder; the matched text is consumed.
      from = hit + placeholder.length;
      index++;
    }
  }
  return (table, masked);
}

/// Restores placeholders created by [maskAllow].
String unmaskAllow(String text, Map<String, String> table) {
  String out = text;
  table.forEach((String placeholder, String original) {
    out = out.replaceAll(placeholder, original);
  });
  return out;
}

/// Applies the exact identifier renames + prefix families to whole words.
String applyIdentifierRules(
  String text,
  Map<String, String> identifiers,
  List<MapEntry<String, String>> prefixes,
) {
  final List<String> names = identifiers.keys.toList()
    ..sort((String a, String b) => b.length.compareTo(a.length));
  String out = text;
  for (final String from in names) {
    out = replaceWord(out, from, identifiers[from]!);
  }
  for (final MapEntry<String, String> prefix in prefixes) {
    out = replaceWordPrefix(out, prefix.key, prefix.value);
  }
  return out;
}

/// Applies ordered substring rules (`String.replaceAll`, literals only).
String applySubstringRules(String text, List<MapEntry<String, String>> rules) {
  String out = text;
  for (final MapEntry<String, String> rule in rules) {
    if (rule.key.isNotEmpty) {
      out = out.replaceAll(rule.key, rule.value);
    }
  }
  return out;
}

/// Rule 1(a+b) for prose spans: the specific string rules first (so
/// `ui/shadcn` beats the `shadcn` word rule), then identifier renames for
/// code names. Bare `shadcn` is NOT a code rename in prose (rule c/e own
/// that word in comments and other text); `shadcnTheme` and the `ShadcnX`
/// names keep their map renames so references stay live.
String applyProseBase(String text, RenameMap map) {
  final String step1 = applySubstringRules(text, map.strings);
  final Map<String, String> codeNames = <String, String>{
    for (final MapEntry<String, String> entry in map.identifiers.entries)
      if (entry.key != 'shadcn') entry.key: entry.value,
  };
  return applyIdentifierRules(step1, codeNames, map.prefixes);
}

/// One source edit.
class SourceEdit {
  SourceEdit(this.offset, this.length, this.replacement);

  final int offset;
  final int length;
  final String replacement;
}

/// Result of the Dart passes over one file.
class DartPass {
  DartPass({
    required this.edits,
    required this.identifiers,
    required this.strings,
    required this.comments,
    required this.unhandled,
    required this.conflicts,
  });

  final List<SourceEdit> edits;
  final int identifiers;
  final int strings;
  final int comments;
  final List<String> unhandled;
  final List<String> conflicts;
}

/// Runs the rule-1(a+b+c) passes over one parsed compilation unit:
/// identifiers in code, comment spans, static string spans.
DartPass computeDartEdits(CompilationUnit unit, String content, RenameMap map) {
  final found = findIdentifierEdits(unit, map);
  final prose = computeProseEdits(unit, content, map);
  final List<SourceEdit> edits = <SourceEdit>[...found.edits, ...prose.edits]
    ..sort((SourceEdit a, SourceEdit b) => a.offset.compareTo(b.offset));
  return DartPass(
    edits: edits,
    identifiers: found.count,
    strings: prose.strings,
    comments: prose.comments,
    unhandled: found.unhandled,
    conflicts: found.conflicts,
  );
}

/// Identifier renames found in [unit] (unresolved AST tokens, token-exact).
/// Every identifier token whose lexeme exactly equals a map key becomes its
/// `to` (plus prefix families), including type names (`NamedType` tokens),
/// `show`/`hide` combinators and constructor names. Theme-target renames
/// (`shadcn`/`shadcnTheme` → `themeData`) are skipped inside scopes with a
/// `themeData` collision and reported in `conflicts` instead. Import prefixes
/// (`as shadcn`) become `dashcn` to satisfy the `library_prefixes` lint.
({
  List<SourceEdit> edits,
  int count,
  List<String> unhandled,
  List<String> conflicts,
})
findIdentifierEdits(CompilationUnit unit, RenameMap map) {
  final Set<String> themeTargets = <String>{
    for (final MapEntry<String, String> entry in map.identifiers.entries)
      if (entry.value == 'themeData') entry.key,
  };
  final Set<AstNode> blocked = themeTargets.isEmpty
      ? <AstNode>{}
      : themeBlockedScopes(unit, themeTargets);
  final declared = collectDeclarationNames(unit, map, blocked, themeTargets);
  final Set<int> importPrefixes = _importPrefixOffsets(unit);
  final List<SourceEdit> tokenEdits = <SourceEdit>[];
  final List<String> tokenUnhandled = <String>[];
  final List<String> tokenConflicts = <String>[];
  Token? token = unit.beginToken;
  while (token != null && !token.isEof) {
    final int offset = token.offset;
    final String lexeme = token.lexeme;
    if (offset >= 0 && !declared.offsets.contains(offset)) {
      final String head = stripHead(lexeme);
      if (map.removals.contains(head)) {
        tokenUnhandled.add('$lexeme @$offset');
      } else if (themeTargets.contains(head) &&
          (importPrefixes.contains(offset) || _isImportUse(token))) {
        // Import prefixes must stay snake_case (`library_prefixes` lint):
        // `as shadcn` and its `shadcn.Card` uses become `dashcn`, never
        // `themeData`. A `shadcn.` use with an uppercase member is an import
        // prefix; lowercase members (`shadcn.colors`) are locals.
        tokenEdits.add(SourceEdit(offset, token.length, 'dashcn'));
      } else {
        final String? to = replacementFor(map, lexeme);
        if (to != null) {
          if (themeTargets.contains(head) &&
              _inBlockedOffset(offset, blocked)) {
            tokenConflicts.add(
              '`$lexeme` kept: `themeData` collision @$offset',
            );
          } else {
            tokenEdits.add(SourceEdit(offset, token.length, to));
          }
        }
      }
    }
    token = token.next;
  }
  final List<SourceEdit> edits = <SourceEdit>[
    for (final (int, int, String) edit in declared.edits)
      SourceEdit(edit.$1, edit.$2, edit.$3),
    ...tokenEdits,
  ];
  return (
    edits: edits,
    count: declared.edits.length + tokenEdits.length,
    unhandled: {...declared.unhandled, ...tokenUnhandled}.toList()..sort(),
    conflicts: {...declared.conflicts, ...tokenConflicts}.toList()..sort(),
  );
}

/// True when [offset] sits inside any blocked scope.
bool _inBlockedOffset(int offset, Set<AstNode> blocked) {
  for (final AstNode node in blocked) {
    if (offset >= node.offset && offset < node.end) {
      return true;
    }
  }
  return false;
}

/// True when [token] is an import-prefix use (`shadcn.Card`): a dot follows
/// with an uppercase member. Locals use lowercase members (`shadcn.colors`).
bool _isImportUse(Token token) {
  final Token? dot = token.next;
  if (dot == null || dot.isEof || dot.lexeme != '.') {
    return false;
  }
  final Token? member = dot.next;
  if (member == null || member.isEof || member.lexeme.isEmpty) {
    return false;
  }
  final int first = member.lexeme.codeUnitAt(0);
  return first >= 65 && first <= 90;
}

/// Offsets of import-prefix names (`as shadcn`) in [unit].
Set<int> _importPrefixOffsets(CompilationUnit unit) {
  final _ImportPrefixVisitor visitor = _ImportPrefixVisitor();
  unit.accept(visitor);
  return visitor.offsets;
}

/// Collects `as prefix` offsets from import directives.
class _ImportPrefixVisitor extends RecursiveAstVisitor<void> {
  final Set<int> offsets = <int>{};

  @override
  void visitImportDirective(ImportDirective node) {
    final SimpleIdentifier? prefix = node.prefix;
    if (prefix != null && prefix.offset >= 0) {
      offsets.add(prefix.offset);
    }
    super.visitImportDirective(node);
  }
}

/// Comment-span (rule a+b+c) and static-string (rule a+b+e) edits in [unit].
({List<SourceEdit> edits, int strings, int comments}) computeProseEdits(
  CompilationUnit unit,
  String content,
  RenameMap map,
) {
  final List<SourceEdit> edits = <SourceEdit>[];
  int stringCount = 0;
  int commentCount = 0;

  // Comment spans (rule a+b+c), walked from the token stream so every
  // comment — including doc comments and trailing EOF comments — is covered.
  Token? token = unit.beginToken;
  while (token != null) {
    final bool isEof = token.isEof;
    Token? comment = token.precedingComments;
    while (comment != null) {
      if (comment is CommentToken) {
        final String rewritten = _rewriteComment(comment.lexeme, map);
        if (rewritten != comment.lexeme) {
          edits.add(SourceEdit(comment.offset, comment.length, rewritten));
          commentCount++;
        }
      }
      comment = comment.next;
    }
    if (isEof) {
      break;
    }
    token = token.next;
  }

  // Static string spans (rule a+b+e): literal contents only, never the
  // `${…}` code (renamed by the identifier pass, so spans must not overlap).
  final _StringVisitor strings = _StringVisitor();
  unit.accept(strings);
  for (final _Span span in strings.spans) {
    final String original = content.substring(span.offset, span.end);
    final masked = maskAllow(original, map.allow);
    String next = applyProseBase(masked.$2, map);
    next = applySubstringRules(next, map.fallbackRules);
    next = unmaskAllow(next, masked.$1);
    if (next != original) {
      edits.add(SourceEdit(span.offset, span.end - span.offset, next));
      stringCount++;
    }
  }
  edits.sort((SourceEdit a, SourceEdit b) => a.offset.compareTo(b.offset));
  return (edits: edits, strings: stringCount, comments: commentCount);
}

/// Rule 1(a+b+c) over one comment's text.
String _rewriteComment(String text, RenameMap map) {
  final masked = maskAllow(text, map.allow);
  String next = applyProseBase(masked.$2, map);
  next = applySubstringRules(next, map.commentRules);
  return unmaskAllow(next, masked.$1);
}

/// Rule 1(a+b+d/e) over a whole non-Dart file; null when unchanged.
String? rewriteText(String content, bool isMarkdown, RenameMap map) {
  final masked = maskAllow(content, map.allow);
  String next = applyProseBase(masked.$2, map);
  next = applySubstringRules(
    next,
    isMarkdown ? map.markdownRules : map.fallbackRules,
  );
  next = unmaskAllow(next, masked.$1);
  return next == content ? null : next;
}

class _Span {
  _Span(this.offset, this.end);

  final int offset;
  final int end;
}

/// Collects static string spans (literal contents, interpolation chunks).
class _StringVisitor extends RecursiveAstVisitor<void> {
  final List<_Span> spans = <_Span>[];

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    if (node.contentsOffset >= 0 && node.contentsEnd >= node.contentsOffset) {
      spans.add(_Span(node.contentsOffset, node.contentsEnd));
    }
    super.visitSimpleStringLiteral(node);
  }

  @override
  void visitInterpolationString(InterpolationString node) {
    if (node.offset >= 0) {
      spans.add(_Span(node.offset, node.offset + node.length));
    }
    super.visitInterpolationString(node);
  }
}
