// Restricted Tailwind v3 config parser (pure Dart, no Flutter import).
// Reads `theme.extend.colors` without evaluating JavaScript (object literals,
// string leaves, nested shade maps). Leaves may be colours or `var()`
// references resolved against caller-supplied CSS variables. Dotted names map
// to kit tokens (`primary.DEFAULT` → `primary`); the rest is ignored.

import 'internal/css_mapping.dart';
import 'internal/css_syntax.dart';
import 'theme_model.dart';
import 'web_color_parser.dart';

/// A parsed v3 colour table plus its report.
final class TailwindV3Result {
  /// Creates the result.
  const TailwindV3Result({required this.theme, required this.report});

  /// Imported theme with fallbacks filled.
  final WebTheme theme;

  /// Mapped/defaulted/ignored entries.
  final ImportReport report;
}

/// Parses `theme.extend.colors` out of [source], resolving references
/// against [lightVars]/[darkVars] (variable names without `--`). Never throws.
TailwindV3Result parseTailwindV3Theme(
  String source, {
  Map<String, String> lightVars = const <String, String>{},
  Map<String, String> darkVars = const <String, String>{},
}) {
  final ImportReport report = ImportReport();
  try {
    final Object? root = _JsLiteralParser(source).parseTopLevel();
    return _resolveColors(_extendColors(root), lightVars, darkVars, report);
  } catch (error) {
    report.ignored.add(IgnoredEntry('(source)', 'recovered: $error'));
    return TailwindV3Result(
      theme: const WebTheme().completed(report),
      report: report,
    );
  }
}

/// `theme.extend.colors`, or a bare `{ colors }` / `{ extend.colors }`.
Map<String, Object?> _extendColors(Object? root) {
  if (root is! Map<String, Object?>) {
    return <String, Object?>{};
  }
  final Object? theme = root['theme'];
  final Object? extend = theme is Map<String, Object?>
      ? theme['extend']
      : root['extend'];
  final Object? colors = extend is Map<String, Object?>
      ? extend['colors']
      : root['colors'];
  return colors is Map<String, Object?> ? colors : <String, Object?>{};
}

TailwindV3Result _resolveColors(
  Map<String, Object?> colors,
  Map<String, String> lightVars,
  Map<String, String> darkVars,
  ImportReport report,
) {
  final Map<String, int> light = <String, int>{};
  final Map<String, int> dark = <String, int>{};
  void walk(Map<String, Object?> node, List<String> path) {
    for (final MapEntry<String, Object?> entry in node.entries) {
      final List<String> next = <String>[...path, entry.key];
      final Object? value = entry.value;
      if (value is Map<String, Object?>) {
        walk(value, next);
      } else if (value is String) {
        _absorbLeaf(next, value, lightVars, darkVars, light, dark, report);
      } else {
        report.ignored.add(
          IgnoredEntry(next.join('.'), 'not a colour string; no JS evaluation'),
        );
      }
    }
  }

  walk(colors, <String>[]);
  return TailwindV3Result(
    theme: WebTheme(
      light: Map<String, int>.unmodifiable(light),
      dark: Map<String, int>.unmodifiable(dark),
    ).completed(report),
    report: report,
  );
}

void _absorbLeaf(
  List<String> path,
  String raw,
  Map<String, String> lightVars,
  Map<String, String> darkVars,
  Map<String, int> light,
  Map<String, int> dark,
  ImportReport report,
) {
  final String dotted = path.join('.');
  final String? kitToken = v3PathToKitToken(path);
  if (kitToken == null) {
    report.ignored.add(IgnoredEntry(dotted, 'not a kit colour token'));
    return;
  }
  int? resolve(Map<String, String> vars) {
    final String? resolved = resolveCssRefs(raw, vars);
    return resolved == null ? null : tryParseWebColor(resolved);
  }

  final int? lightArgb = resolve(lightVars);
  final int? darkArgb = resolve(darkVars);
  if (lightArgb != null) {
    light[kitToken] = lightArgb;
  }
  if (darkArgb != null) {
    dark[kitToken] = darkArgb;
  }
  if (lightArgb != null || darkArgb != null) {
    report.mapped.add(
      MappedEntry(
        dotted,
        kitToken,
        raw.contains('var(') ? 'resolved $raw' : '',
      ),
    );
  } else {
    report.ignored.add(IgnoredEntry(dotted, 'unparsable colour: $raw'));
  }
}

/// Non-literal value (call, array, number, …): parses, then ignored.
final class _NonLiteral {
  /// Creates the sentinel.
  const _NonLiteral();
}

/// Restricted JS object-literal parser: objects, strings, numbers, booleans,
/// null, bare identifiers (kept as their name) and arrays. Skips comments
/// and trailing commas. Calls, templates and member access become
/// [_NonLiteral] instead of throwing.
class _JsLiteralParser {
  /// Creates the parser over [source].
  _JsLiteralParser(this.source);

  /// Source text.
  final String source;

  int pos = 0;

  /// Parses the first top-level `{…}` object in [source].
  Object? parseTopLevel() {
    while (pos < source.length) {
      _skipTrivia();
      if (pos < source.length && source[pos] == '{') {
        return _parseObject();
      }
      pos++;
    }
    throw const FormatException('no object literal found');
  }

  Object? _parseValue() {
    _skipTrivia();
    if (pos >= source.length) {
      throw const FormatException('unexpected end of input');
    }
    final String char = source[pos];
    if (char == '{') {
      return _parseObject();
    }
    if (char == '[') {
      return _parseArray();
    }
    if (char == "'" || char == '"' || char == '`') {
      return _parseString();
    }
    if (char == '-' || _isDigit(char)) {
      return _parseNumber();
    }
    if (_isIdentStart(char)) {
      final String word = _parseIdentifier();
      switch (word) {
        case 'true':
          return true;
        case 'false':
          return false;
        case 'null':
        case 'undefined':
          return null;
      }
      _skipTrivia();
      // Calls, templates and member access are not literals.
      if (pos < source.length &&
          (source[pos] == '(' || source[pos] == '.' || source[pos] == '`')) {
        _skipNonLiteral();
        return const _NonLiteral();
      }
      return word;
    }
    throw FormatException('unexpected character: $char');
  }

  Map<String, Object?> _parseObject() {
    pos++; // `{`
    final Map<String, Object?> out = <String, Object?>{};
    while (true) {
      _skipTrivia();
      if (pos >= source.length) {
        throw const FormatException('unterminated object');
      }
      if (source[pos] == '}') {
        pos++;
        return out;
      }
      final String key = _parseKey();
      _skipTrivia();
      if (pos >= source.length || source[pos] != ':') {
        throw FormatException('expected ":" after key "$key"');
      }
      pos++;
      out[key] = _parseValue();
      _skipTrivia();
      if (pos < source.length && source[pos] == ',') {
        pos++;
      }
    }
  }

  String _parseKey() {
    _skipTrivia();
    if (pos >= source.length) {
      throw const FormatException('expected an object key');
    }
    final String char = source[pos];
    if (char == "'" || char == '"' || char == '`') {
      return _parseString();
    }
    if (_isIdentStart(char)) {
      return _parseIdentifier();
    }
    if (char == '-' || _isDigit(char)) {
      return _parseNumber().toString();
    }
    throw const FormatException('expected an object key');
  }

  List<Object?> _parseArray() {
    pos++; // `[`
    final List<Object?> out = <Object?>[];
    while (true) {
      _skipTrivia();
      if (pos >= source.length) {
        throw const FormatException('unterminated array');
      }
      if (source[pos] == ']') {
        pos++;
        return out;
      }
      if (source[pos] == ',') {
        pos++;
        continue;
      }
      out.add(_parseValue());
      _skipTrivia();
      if (pos < source.length && source[pos] == ',') {
        pos++;
      }
    }
  }

  String _parseString() {
    final String quote = source[pos];
    pos++;
    final StringBuffer out = StringBuffer();
    while (pos < source.length && source[pos] != quote) {
      if (source[pos] == '\\' && pos + 1 < source.length) {
        pos++;
        out.write(source[pos]);
      } else {
        out.write(source[pos]);
      }
      pos++;
    }
    if (pos >= source.length) {
      throw const FormatException('unterminated string');
    }
    pos++;
    return out.toString();
  }

  num _parseNumber() {
    final int start = pos;
    while (pos < source.length && _isNumChar(source[pos])) {
      pos++;
    }
    return num.parse(source.substring(start, pos));
  }

  String _parseIdentifier() {
    final int start = pos;
    while (pos < source.length && _isIdentPart(source[pos])) {
      pos++;
    }
    return source.substring(start, pos);
  }

  bool _isDigit(String char) {
    final int code = char.codeUnitAt(0);
    return code >= 0x30 && code <= 0x39;
  }

  bool _isIdentStart(String char) {
    if (char == r'$' || char == '_') {
      return true;
    }
    final int code = char.codeUnitAt(0);
    return (code >= 0x41 && code <= 0x5A) || (code >= 0x61 && code <= 0x7A);
  }

  bool _isIdentPart(String char) => _isIdentStart(char) || _isDigit(char);

  bool _isNumChar(String char) =>
      _isDigit(char) || char == '.' || '+-eE'.contains(char);

  void _skipTrivia() {
    while (pos < source.length) {
      final String char = source[pos];
      if (char.trim().isEmpty) {
        pos++;
      } else if (_startsWith('//')) {
        while (pos < source.length && source[pos] != '\n') {
          pos++;
        }
      } else if (_startsWith('/*')) {
        pos += 2;
        while (!_startsWith('*/') && pos < source.length) {
          pos++;
        }
        pos += 2;
      } else {
        break;
      }
    }
  }

  bool _startsWith(String token) => source.startsWith(token, pos);

  /// Skips member chains, calls and templates, stopping at the enclosing
  /// value terminator.
  void _skipNonLiteral() {
    int depth = 0;
    while (pos < source.length) {
      final String char = source[pos];
      if (char == "'" || char == '"' || char == '`') {
        _parseString();
      } else if (char == '(' || char == '[' || char == '{') {
        depth++;
        pos++;
      } else if (char == ')' || char == ']' || char == '}') {
        if (depth == 0) {
          return;
        }
        depth--;
        pos++;
      } else if (depth == 0 && (char == ',' || char == ';')) {
        return;
      } else {
        pos++;
      }
    }
  }
}
