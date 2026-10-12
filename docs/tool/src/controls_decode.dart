// Default decoding, slider ranges and labels for the playground codegen.
//
// Helpers for `controls_build.dart`: kept separate so the derivation file
// stays focused on the kind mapping.

/// The declared type without nullability (`VoidCallback?` -> `VoidCallback`).
String stripNullability(String type) =>
    type.endsWith('?') ? type.substring(0, type.length - 1) : type;

/// Slider bounds.
class SliderRange {
  /// Creates the range.
  const SliderRange({required this.min, required this.max, this.step});

  /// Lower bound.
  final double min;

  /// Upper bound.
  final double max;

  /// Step, or null for the kind default.
  final double? step;
}

/// Slider bounds heuristic by parameter name.
///
/// `value`/`progress` are unit fractions; page counters count pages; line
/// counts and lengths count lines/chars; the `px` set measures logical
/// pixels; hairlines measure thin strokes. Anything else falls back to
/// int 0..100 step 1 / double 0..10 step 0.1.
SliderRange rangeFor(String name, bool isInt) {
  const Set<String> percent = <String>{'value', 'progress'};
  const Set<String> px = <String>{
    'size',
    'height',
    'width',
    'maxWidth',
    'maxHeight',
    'gap',
    'spacing',
    'extent',
    'indent',
    'endIndent',
    'badgeGap',
    'leadingGap',
    'trailingGap',
    'cursorHeight',
    'labelGap',
  };
  const Set<String> hairline = <String>{
    'thickness',
    'strokeWidth',
    'cursorWidth',
    'borderWidth',
  };
  if (percent.contains(name)) {
    return const SliderRange(min: 0, max: 1, step: 0.01);
  }
  if (name == 'page' || name == 'totalPages') {
    return const SliderRange(min: 1, max: 10, step: 1);
  }
  if (name == 'maxPages') {
    return const SliderRange(min: 1, max: 7, step: 1);
  }
  if (name == 'index') {
    return const SliderRange(min: 0, max: 2, step: 1);
  }
  if (name == 'firstDayOfWeek') {
    return const SliderRange(min: 1, max: 7, step: 1);
  }
  if (name == 'maxLength') {
    return const SliderRange(min: 1, max: 200, step: 1);
  }
  if (name == 'maxLines' || name == 'minLines') {
    return const SliderRange(min: 1, max: 10, step: 1);
  }
  if (px.contains(name)) {
    return const SliderRange(min: 0, max: 64, step: 1);
  }
  if (hairline.contains(name)) {
    return SliderRange(min: 0, max: 8, step: isInt ? 1 : 0.5);
  }
  return SliderRange(min: 0, max: isInt ? 100 : 10, step: isInt ? 1 : 0.1);
}

/// Decodes a default expression into source shape, or null when the default
/// is a non-literal expression (the playground then omits the argument).
String? decodeDefault(String type, String? source) {
  if (source == null || source == 'null') {
    return null;
  }
  final String base = stripNullability(type);
  if (base == 'bool') {
    return source == 'true' || source == 'false' ? source : null;
  }
  if (base == 'int') {
    return int.tryParse(source) != null ? source : null;
  }
  if (base == 'double') {
    return double.tryParse(source) != null ? source : null;
  }
  if (base == 'String') {
    return _unquote(source);
  }
  // Enum: `ButtonVariant.primary` -> `primary`; bare names pass through.
  if (source.startsWith('$base.')) {
    return source.substring(base.length + 1);
  }
  if (RegExp(r'^[a-z][A-Za-z0-9]*$').hasMatch(source)) {
    return source;
  }
  return null;
}

/// Unquotes a single-quoted default (`'•'` -> `•`), or null.
String? _unquote(String source) {
  if (source.length >= 2 && source.startsWith("'") && source.endsWith("'")) {
    return source
        .substring(1, source.length - 1)
        .replaceAll(r"\'", "'")
        .replaceAll(r'\\', r'\')
        .replaceAll(r'\n', '\n');
  }
  return null;
}

/// `showAsDot` -> `Show as dot`; `child` -> `Child`.
String humanizeLabel(String name) {
  final StringBuffer out = StringBuffer();
  final String flat = name.startsWith('_') ? name.substring(1) : name;
  for (int i = 0; i < flat.length; i++) {
    final String ch = flat[i];
    if (ch == '_') {
      out.write(' ');
      continue;
    }
    if (i > 0 &&
        ch.toUpperCase() == ch &&
        ch.toLowerCase() != ch &&
        flat[i - 1] != ' ' &&
        flat[i - 1].toLowerCase() == flat[i - 1]) {
      out.write(' ');
    }
    out.write(i == 0 ? ch.toUpperCase() : ch);
  }
  return out.toString();
}
