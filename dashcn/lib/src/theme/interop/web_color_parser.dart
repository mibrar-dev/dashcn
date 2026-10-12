// Notation parsing for web-theme interop (split out of `color_space.dart`
// for the ~400-line rule): oklch/oklab/hsl/bare v3 triplets/rgb/hex/keywords
// into 32-bit ARGB. Pure Dart, no Flutter import.

import 'dart:math' as math;

import 'color_space.dart';

/// Parses any supported web colour into 32-bit ARGB (`0xAARRGGBB`).
///
/// Throws [WebColorException] on failure; see [tryParseWebColor].
int parseWebColor(String source) {
  final String text = source.trim();
  if (text.isEmpty) {
    throw const WebColorException('empty colour');
  }
  if (text.startsWith('#')) {
    return _parseHex(text);
  }
  final String lower = text.toLowerCase();
  if (lower.startsWith('oklch(') && text.endsWith(')')) {
    return _parseOklch(text.substring(6, text.length - 1), source);
  }
  if (lower.startsWith('oklab(') && text.endsWith(')')) {
    return _parseOklab(text.substring(6, text.length - 1), source);
  }
  if ((lower.startsWith('hsl(') || lower.startsWith('hsla(')) &&
      text.endsWith(')')) {
    return _parseHsl(text.substring(text.indexOf('(') + 1, text.length - 1));
  }
  if ((lower.startsWith('rgb(') || lower.startsWith('rgba(')) &&
      text.endsWith(')')) {
    return _parseRgb(text.substring(text.indexOf('(') + 1, text.length - 1));
  }
  final int? named = _namedColors[lower];
  if (named != null) {
    return named;
  }
  final int? triplet = _tryParseBareTriplet(text);
  if (triplet != null) {
    return triplet;
  }
  throw WebColorException('unrecognised colour: $source');
}

/// Nullable variant of [parseWebColor].
int? tryParseWebColor(String source) {
  try {
    return parseWebColor(source);
  } on WebColorException {
    return null;
  } on FormatException {
    return null;
  }
}

/// The 16 CSS keyword colours plus transparent.
const Map<String, int> _namedColors = <String, int>{
  'transparent': 0x00000000,
  'black': 0xFF000000,
  'silver': 0xFFC0C0C0,
  'gray': 0xFF808080,
  'grey': 0xFF808080,
  'white': 0xFFFFFFFF,
  'maroon': 0xFF800000,
  'red': 0xFFFF0000,
  'purple': 0xFF800080,
  'fuchsia': 0xFFFF00FF,
  'magenta': 0xFFFF00FF,
  'green': 0xFF008000,
  'lime': 0xFF00FF00,
  'olive': 0xFF808000,
  'yellow': 0xFFFFFF00,
  'navy': 0xFF000080,
  'blue': 0xFF0000FF,
  'teal': 0xFF008080,
  'aqua': 0xFF00FFFF,
  'cyan': 0xFF00FFFF,
};

int _parseHex(String text) {
  String digits = text.substring(1);
  if (digits.length == 3 || digits.length == 4) {
    digits = digits.split('').map((String c) => '$c$c').join();
  }
  if (digits.length != 6 && digits.length != 8) {
    throw WebColorException('bad hex colour: $text');
  }
  final int? rgb = int.tryParse(digits.substring(0, 6), radix: 16);
  final int? alpha = digits.length == 8
      ? int.tryParse(digits.substring(6, 8), radix: 16)
      : 0xFF;
  if (rgb == null || alpha == null) {
    throw WebColorException('bad hex colour: $text');
  }
  return (alpha << 24) | rgb;
}

/// Splits a function body on commas or slashes, honouring nested parens.
List<String> _splitBody(String body) {
  final List<String> parts = <String>[];
  int depth = 0;
  final StringBuffer current = StringBuffer();
  for (int i = 0; i < body.length; i++) {
    final String char = body[i];
    if (char == '(') {
      depth++;
    } else if (char == ')') {
      depth--;
    }
    if (depth == 0 && (char == ',' || char == '/')) {
      parts.add(current.toString());
      current.clear();
    } else {
      current.write(char);
    }
  }
  parts.add(current.toString());
  return parts.map((String part) => part.trim()).toList();
}

List<String> _spaceOrComma(String text) => text
    .split(',')
    .expand((String c) => c.split(RegExp(r'\s+')))
    .map((String c) => c.trim())
    .where((String c) => c.isNotEmpty)
    .toList();

void _rejectRefs(List<String> parts, String source) {
  for (final String part in parts) {
    if (part.contains('var(') ||
        part.contains('light-dark(') ||
        part.contains('color-mix(')) {
      throw WebColorException('unresolvable reference in: $source');
    }
  }
}

double _number(String text, String source) {
  final double? value = double.tryParse(text);
  if (value == null || !value.isFinite) {
    throw WebColorException('bad number "$text" in: $source');
  }
  return value;
}

/// A bare number or `n%` (percent of [scale]).
double _percentOrNumber(String text, double scale, String source) {
  final String clean = text.trim();
  if (clean.endsWith('%')) {
    return _number(clean.substring(0, clean.length - 1), source) / 100 * scale;
  }
  return _number(clean, source);
}

/// Alpha as a number 0..1 or a percentage.
double _alphaValue(String text, String source) =>
    _percentOrNumber(text, 1, source).clamp(0.0, 1.0);

/// Hue as a number or `deg`/`rad`/`turn` angle, normalised to 0..360.
double _hueValue(String text, String source) {
  final String clean = text.trim().toLowerCase();
  double value;
  if (clean.endsWith('deg')) {
    value = _number(clean.substring(0, clean.length - 3), source);
  } else if (clean.endsWith('rad')) {
    value =
        _number(clean.substring(0, clean.length - 3), source) * 180 / math.pi;
  } else if (clean.endsWith('turn')) {
    value = _number(clean.substring(0, clean.length - 4), source) * 360;
  } else {
    value = _number(clean, source);
  }
  return value % 360;
}

int _bytesToArgb(int alpha, int r, int g, int b) =>
    (alpha.clamp(0, 255) << 24) |
    (r.clamp(0, 255) << 16) |
    (g.clamp(0, 255) << 8) |
    b.clamp(0, 255);
int _parseOklch(String body, String source) {
  final List<String> parts = _splitBody(body);
  _rejectRefs(parts, source);
  final List<String> flat = _spaceOrComma(parts.join(','));
  if (flat.length != 3 && flat.length != 4) {
    throw WebColorException('bad oklch() in: $source');
  }
  return argbFromOklch(
    Oklch(
      _percentOrNumber(flat[0], 1, source).clamp(0.0, 1.0),
      _percentOrNumber(flat[1], 0.4, source),
      _hueValue(flat[2], source),
      flat.length == 4 ? _alphaValue(flat[3], source) : 1,
    ),
  );
}

int _parseOklab(String body, String source) {
  final List<String> parts = _splitBody(body);
  _rejectRefs(parts, source);
  final List<String> flat = _spaceOrComma(parts.join(','));
  if (flat.length != 3 && flat.length != 4) {
    throw WebColorException('bad oklab() in: $source');
  }
  final double a = _percentOrNumber(flat[1], 0.4, source);
  final double b = _percentOrNumber(flat[2], 0.4, source);
  double hue = math.atan2(b, a) * 180 / math.pi;
  if (hue < 0) {
    hue += 360;
  }
  return argbFromOklch(
    Oklch(
      _percentOrNumber(flat[0], 1, source).clamp(0.0, 1.0),
      math.sqrt(a * a + b * b),
      hue,
      flat.length == 4 ? _alphaValue(flat[3], source) : 1,
    ),
  );
}

int _parseHsl(String body) {
  final List<String> parts = _splitBody(body);
  final String source = 'hsl($body)';
  _rejectRefs(parts, source);
  // Joined first so the `/ alpha` tail of space syntax becomes element 4.
  final List<String> channels = _spaceOrComma(parts.join(','));
  if (channels.length != 3 && channels.length != 4) {
    throw WebColorException('bad hsl() in: $source');
  }
  final double hue = _hueValue(channels[0], source);
  // Lenient: bare numbers count as percentages (v3 triplets put `%` on S/L
  // only, but accepting them everywhere never misparses valid input).
  final double saturation =
      _percentOrNumber(channels[1], 100, source).clamp(0.0, 100.0) / 100;
  final double lightness =
      _percentOrNumber(channels[2], 100, source).clamp(0.0, 100.0) / 100;
  final List<int> rgb = _hslToRgbBytes(hue, saturation, lightness);
  final int byteA = channels.length == 4
      ? (_alphaValue(channels[3], source) * 255).round().clamp(0, 255)
      : 0xFF;
  return _bytesToArgb(byteA, rgb[0], rgb[1], rgb[2]);
}

/// Bare v3 triplet: `222.2 47.4% 11.2%` with an optional `/ alpha` tail.
int? _tryParseBareTriplet(String text) {
  final List<String> parts = _splitBody(text);
  if (parts.length > 2) {
    return null;
  }
  final List<String> channels = _spaceOrComma(parts[0]);
  if (channels.length != 3) {
    return null;
  }
  if (!RegExp(r'^[-+0-9.]+(deg|rad|turn)?$').hasMatch(channels[0])) {
    return null;
  }
  if (!channels[1].endsWith('%') || !channels[2].endsWith('%')) {
    return null;
  }
  try {
    String body = channels.join(' ');
    if (parts.length == 2) {
      body = '$body / ${parts[1]}';
    }
    return _parseHsl(body);
  } on WebColorException {
    return null;
  }
}

int _parseRgb(String body) {
  final List<String> parts = _splitBody(body);
  final String source = 'rgb($body)';
  _rejectRefs(parts, source);
  // Joined first so the `/ alpha` tail of space syntax becomes element 4.
  final List<String> channels = _spaceOrComma(parts.join(','));
  if (channels.length != 3 && channels.length != 4) {
    throw WebColorException('bad rgb() in: $source');
  }
  int channel(String text) {
    final String clean = text.trim();
    if (clean.endsWith('%')) {
      return (_percentOrNumber(clean, 100, source) / 100 * 255).round();
    }
    return _number(clean, source).round();
  }

  final int byteA = channels.length == 4
      ? (_alphaValue(channels[3], source) * 255).round().clamp(0, 255)
      : 0xFF;
  return _bytesToArgb(
    byteA,
    channel(channels[0]),
    channel(channels[1]),
    channel(channels[2]),
  );
}

List<int> _hslToRgbBytes(double hue, double saturation, double lightness) {
  final double c = (1 - (2 * lightness - 1).abs()) * saturation;
  final double x = c * (1 - ((hue / 60) % 2 - 1).abs());
  final double m = lightness - c / 2;
  double r = 0;
  double g = 0;
  double b = 0;
  if (hue < 60) {
    r = c;
    g = x;
  } else if (hue < 120) {
    r = x;
    g = c;
  } else if (hue < 180) {
    g = c;
    b = x;
  } else if (hue < 240) {
    g = x;
    b = c;
  } else if (hue < 300) {
    r = x;
    b = c;
  } else {
    r = c;
    b = x;
  }
  return <int>[
    ((r + m) * 255).round().clamp(0, 255),
    ((g + m) * 255).round().clamp(0, 255),
    ((b + m) * 255).round().clamp(0, 255),
  ];
}
