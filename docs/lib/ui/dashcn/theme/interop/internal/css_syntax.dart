// Unexported CSS syntax helpers for web-theme interop (pure Dart).
//
// Canonical home of the rule-block scanning, declaration splitting, `var()`
// reference resolution and web length parsing shared by the CSS theme parser
// and the Tailwind v3 parser. Not exported by `interop.dart` (or any barrel):
// import it directly from `src/` when working inside the interop layer.

/// Resolves `var(--name)` / `var(--name, fallback)` against [vars] (keys
/// without `--`), iteratively up to 10 levels with cycle protection.
///
/// Returns the fully substituted value, or null when a reference cannot be
/// resolved (missing variable without a fallback, or a cycle).
String? resolveCssRefs(String raw, Map<String, String> vars) {
  String current = raw;
  final Set<String> seen = <String>{};
  for (int i = 0; i < 10; i++) {
    final int start = current.indexOf('var(');
    if (start < 0) {
      return current;
    }
    int depth = 0;
    int end = start;
    for (; end < current.length; end++) {
      if (current[end] == '(') {
        depth++;
      } else if (current[end] == ')') {
        depth--;
        if (depth == 0) {
          break;
        }
      }
    }
    if (end >= current.length) {
      return null;
    }
    final String inner = current.substring(start + 4, end);
    final int comma = _topLevelComma(inner);
    final String name = (comma < 0 ? inner : inner.substring(0, comma))
        .trim()
        .toLowerCase();
    final String? fallback = comma < 0
        ? null
        : inner.substring(comma + 1).trim();
    final String key = name.startsWith('--') ? name.substring(2) : name;
    final String? replacement =
        vars[key] ?? (fallback == null || fallback.isEmpty ? null : fallback);
    if (replacement == null) {
      return null;
    }
    if (!seen.add('$key=$replacement')) {
      return null;
    }
    current =
        '${current.substring(0, start)}$replacement${current.substring(end + 1)}';
  }
  return null;
}

int _topLevelComma(String text) {
  int depth = 0;
  for (int i = 0; i < text.length; i++) {
    if (text[i] == '(') {
      depth++;
    } else if (text[i] == ')') {
      depth--;
    } else if (text[i] == ',' && depth == 0) {
      return i;
    }
  }
  return -1;
}

double? _parseNumber(String text) {
  final double? value = double.tryParse(text.trim());
  return value != null && value.isFinite ? value : null;
}

/// Parses a radius/spacing length into rem: `0.625rem` as-is, `10px` / 16,
/// bare numbers assumed rem.
double? parseRemLength(String raw) {
  final String text = raw.trim().toLowerCase();
  if (text.endsWith('rem')) {
    return _parseNumber(text.substring(0, text.length - 3));
  }
  if (text.endsWith('px')) {
    final double? px = _parseNumber(text.substring(0, text.length - 2));
    return px == null ? null : px / 16;
  }
  if (text.endsWith('em')) {
    return _parseNumber(text.substring(0, text.length - 2));
  }
  return _parseNumber(text);
}

/// Parses a tracking length into em: `0.025em` as-is, bare numbers as em.
double? parseEmLength(String raw) {
  final String text = raw.trim().toLowerCase();
  if (text.endsWith('em')) {
    return _parseNumber(text.substring(0, text.length - 2));
  }
  if (text.endsWith('px')) {
    final double? px = _parseNumber(text.substring(0, text.length - 2));
    return px == null ? null : px / 16;
  }
  if (text.endsWith('rem')) {
    return _parseNumber(text.substring(0, text.length - 3));
  }
  return _parseNumber(text);
}

/// Parses a shadow-atom length into px: `4px` as-is, bare numbers as px, or
/// a plain number/percent for opacity.
double? parsePxLength(String raw) {
  final String text = raw.trim().toLowerCase();
  if (text.endsWith('px')) {
    return _parseNumber(text.substring(0, text.length - 2));
  }
  if (text.endsWith('%')) {
    final double? percent = _parseNumber(text.substring(0, text.length - 1));
    return percent == null ? null : percent / 100;
  }
  return _parseNumber(text);
}

/// Whether [resolved] is a bare v3 `H S% L%` triplet (era signal only).
bool looksLikeTriplet(String resolved) {
  final List<String> channels = resolved
      .split(RegExp(r'\s+'))
      .where((String c) => c.isNotEmpty)
      .toList();
  return channels.length == 3 &&
      RegExp(r'^[-+0-9.]+(deg|rad|turn)?$').hasMatch(channels[0]) &&
      channels[1].endsWith('%') &&
      channels[2].endsWith('%');
}

/// Formats a number shortest-round-trip (`0.625`, `3`, `-30`, `0.070588`).
String formatCssNumber(double value) {
  if (!value.isFinite) {
    return '0';
  }
  if (value == value.roundToDouble() && value.abs() < 1e15) {
    return value.round().toString();
  }
  return value.toString();
}

// ---------------------------------------------------------------------------
// Rule-block scanning
// ---------------------------------------------------------------------------

/// Strips `/* … */` comments.
String stripCssComments(String source) =>
    source.replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), ' ');

/// Whether [selector] targets the dark mode.
bool isDarkSelector(String selector) =>
    selector.contains('.dark') ||
    RegExp(r'''data-theme\s*=\s*['"]?dark''').hasMatch(selector);

/// Splits a block body into `--name: value` entries (quote/paren aware so
/// `url(data:…;…)` values survive); later entries win.
///
/// Statements that are not declarations (`@apply …;`) and plain CSS
/// properties (`letter-spacing: …`) are not variables, so they never enter
/// the map; when [skippedAtRules] is given, `@…` statements are appended to
/// it in source order so the caller can report them instead of dropping
/// them silently.
Map<String, String> splitCssDeclarations(
  String body, [
  List<String>? skippedAtRules,
]) {
  final Map<String, String> out = <String, String>{};
  int depth = 0;
  bool quote = false;
  String quoteChar = '';
  final StringBuffer current = StringBuffer();
  void flush() {
    final String text = current.toString().trim();
    current.clear();
    if (text.isEmpty) {
      return;
    }
    final int colon = text.indexOf(':');
    if (colon < 0) {
      if (text.startsWith('@')) {
        skippedAtRules?.add(text);
      }
      return;
    }
    final String name = text.substring(0, colon).trim();
    final String value = text
        .substring(colon + 1)
        .trim()
        .replaceAll(RegExp(r'\s*!important\s*$'), '');
    if (name.startsWith('--') && value.isNotEmpty) {
      out[name.substring(2).toLowerCase()] = value;
    }
  }

  for (int i = 0; i < body.length; i++) {
    final String char = body[i];
    if (quote) {
      current.write(char);
      if (char == quoteChar) {
        quote = false;
      }
    } else if (char == '"' || char == "'") {
      quote = true;
      quoteChar = char;
      current.write(char);
    } else if (char == '(') {
      depth++;
      current.write(char);
    } else if (char == ')') {
      if (depth > 0) {
        depth--;
      }
      current.write(char);
    } else if (char == ';' && depth == 0) {
      flush();
    } else {
      current.write(char);
    }
  }
  flush();
  return out;
}
