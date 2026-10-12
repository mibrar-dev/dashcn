// Pure-Dart colour spaces for web-theme interop (no Flutter import, so the
// CLI can vendor this directory as-is): Oklch/Lab conversion through linear
// sRGB, chroma-reduction gamut mapping, CIEDE2000 distance, and hex/oklch
// formatting. Notation parsing lives in `web_color_parser.dart` (split out
// for the ~400-line rule); both are re-exported by `interop.dart`.

import 'dart:math' as math;

/// Rejected web colour literal.
class WebColorException implements Exception {
  /// Creates the exception with a human readable [message].
  const WebColorException(this.message);

  /// Human readable reason.
  final String message;

  @override
  String toString() => 'WebColorException: $message';
}

/// Oklch colour: [lightness] 0..1, [chroma] >= 0, [hue] degrees, [alpha] 0..1.
final class Oklch {
  /// Creates an Oklch colour.
  const Oklch(this.lightness, this.chroma, this.hue, [this.alpha = 1]);

  /// Lightness 0..1.
  final double lightness;

  /// Chroma >= 0.
  final double chroma;

  /// Hue angle in degrees.
  final double hue;

  /// Alpha 0..1.
  final double alpha;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Oklch &&
          other.lightness == lightness &&
          other.chroma == chroma &&
          other.hue == hue &&
          other.alpha == alpha;

  @override
  int get hashCode => Object.hash(lightness, chroma, hue, alpha);
}

/// CIE Lab colour (D65) with alpha 0..1.
final class CieLab {
  /// Creates a Lab colour.
  const CieLab(this.l, this.a, this.b, [this.alpha = 1]);

  /// Lightness 0..100.
  final double l;

  /// Green-red axis.
  final double a;

  /// Blue-yellow axis.
  final double b;

  /// Alpha 0..1.
  final double alpha;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CieLab &&
          other.l == l &&
          other.a == a &&
          other.b == b &&
          other.alpha == alpha;

  @override
  int get hashCode => Object.hash(l, a, b, alpha);
}

/// `#RRGGBB`, or `#RRGGBBAA` when translucent (upper case, preset schema).
String webHexOf(int argb) {
  final int alpha = (argb >> 24) & 0xFF;
  final String rgb = (argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0');
  if (alpha == 0xFF) {
    return '#${rgb.toUpperCase()}';
  }
  return '#${rgb.toUpperCase()}${alpha.toRadixString(16).padLeft(2, '0').toUpperCase()}';
}

/// `oklch(L C H)`, with `/ alpha` appended when translucent.
String oklchOf(int argb) {
  final Oklch color = oklchFromArgb(argb);
  final String body =
      'oklch(${_fixed(color.lightness, 4)} ${_fixed(color.chroma, 4)} '
      '${_fixed(color.hue, 2)}';
  return color.alpha >= 0.9995
      ? '$body)'
      : '$body / ${_fixed(color.alpha, 4)})';
}

/// Converts [argb] to Oklch (alpha carried through, never premultiplied).
Oklch oklchFromArgb(int argb) {
  final List<double> linear = _argbToLinear(argb);
  final List<double> lab = _linearToOklab(linear[0], linear[1], linear[2]);
  final double chroma = math.sqrt(lab[1] * lab[1] + lab[2] * lab[2]);
  double hue = math.atan2(lab[2], lab[1]) * 180 / math.pi;
  if (hue < 0) {
    hue += 360;
  }
  return Oklch(
    lab[0],
    chroma,
    // Matrix residuals give near-greys a noisy hue; snap it (invisible).
    chroma < 1e-3 ? 0 : hue,
    ((argb >> 24) & 0xFF) / 255,
  );
}

/// Converts [color] to ARGB, pulling out-of-gamut chroma back into sRGB.
int argbFromOklch(Oklch color, {bool gamutMap = true}) {
  final double light = color.lightness.clamp(0.0, 1.0);
  final double radians = color.hue * math.pi / 180;
  double chroma = math.max(0.0, color.chroma);
  if (gamutMap) {
    chroma = _fitChroma(light, chroma, radians);
  }
  final List<double> linear = _oklabToLinear(
    light,
    chroma * math.cos(radians),
    chroma * math.sin(radians),
  );
  final int byteA = (color.alpha.clamp(0.0, 1.0) * 255).round().clamp(0, 255);
  return (byteA << 24) |
      (_toSrgbByte(linear[0]) << 16) |
      (_toSrgbByte(linear[1]) << 8) |
      _toSrgbByte(linear[2]);
}

/// Converts [argb] to CIE Lab (D65), for perceptual distance.
CieLab labFromArgb(int argb) {
  final List<double> l = _argbToLinear(argb);
  double f(double t) =>
      t > 0.008856 ? math.pow(t, 1 / 3).toDouble() : 7.787 * t + 16 / 116;
  final double fx = f(
    (0.4123907993 * l[0] + 0.3575843394 * l[1] + 0.1804807884 * l[2]) / 0.95047,
  );
  final double fy = f(
    0.2126390059 * l[0] + 0.7151686788 * l[1] + 0.0721923154 * l[2],
  );
  final double fz = f(
    (0.0193308187 * l[0] + 0.1191947798 * l[1] + 0.9505321522 * l[2]) / 1.08883,
  );
  return CieLab(
    116 * fy - 16,
    500 * (fx - fy),
    200 * (fy - fz),
    ((argb >> 24) & 0xFF) / 255,
  );
}

/// CIEDE2000 distance between two ARGB colours (alpha ignored).
double deltaE2000(int first, int second) =>
    deltaE2000Lab(labFromArgb(first), labFromArgb(second));

/// CIEDE2000 between two Lab colours (Sharma et al., kL=kC=kH=1).
double deltaE2000Lab(CieLab first, CieLab second) {
  final double c1 = math.sqrt(first.a * first.a + first.b * first.b);
  final double c2 = math.sqrt(second.a * second.a + second.b * second.b);
  final double meanC = (c1 + c2) / 2;
  final double powC = math.pow(meanC, 7).toDouble();
  final double g = 0.5 * (1 - math.sqrt(powC / (powC + math.pow(25, 7))));
  final double a1p = first.a * (1 + g);
  final double a2p = second.a * (1 + g);
  final double c1p = math.sqrt(a1p * a1p + first.b * first.b);
  final double c2p = math.sqrt(a2p * a2p + second.b * second.b);
  double h1p = _hueDeg(a1p, first.b);
  double h2p = _hueDeg(a2p, second.b);
  final double deltaLp = second.l - first.l;
  final double deltaCp = c2p - c1p;
  double dhp = 0;
  if (c1p * c2p >= 1e-9) {
    double raw = h2p - h1p;
    if (raw > 180) {
      raw -= 360;
    } else if (raw < -180) {
      raw += 360;
    }
    dhp = 2 * math.sqrt(c1p * c2p) * math.sin(raw * math.pi / 360);
  }
  final double meanLp = (first.l + second.l) / 2;
  final double meanCp = (c1p + c2p) / 2;
  double meanHp = h1p + h2p;
  if (c1p * c2p >= 1e-9) {
    meanHp = (h1p - h2p).abs() <= 180
        ? (h1p + h2p) / 2
        : (h1p + h2p + (h1p + h2p < 360 ? 360 : -360)) / 2;
  }
  final double t =
      1 -
      0.17 * math.cos((meanHp - 30) * math.pi / 180) +
      0.24 * math.cos(2 * meanHp * math.pi / 180) +
      0.32 * math.cos((3 * meanHp + 6) * math.pi / 180) -
      0.20 * math.cos((4 * meanHp - 63) * math.pi / 180);
  final double deltaRo =
      30 * math.exp(-math.pow((meanHp - 275) / 25, 2).toDouble());
  final double powCp = math.pow(meanCp, 7).toDouble();
  final double rc = 2 * math.sqrt(powCp / (powCp + math.pow(25, 7)));
  final double dl = meanLp - 50;
  final double sL = 1 + 0.015 * dl * dl / math.sqrt(20 + dl * dl);
  final double sC = 1 + 0.045 * meanCp;
  final double sH = 1 + 0.015 * meanCp * t;
  final double rt = -math.sin(2 * deltaRo * math.pi / 180) * rc;
  final double dc = deltaCp / sC;
  final double dh = dhp / sH;
  return math.sqrt(
    (deltaLp / sL) * (deltaLp / sL) + dc * dc + dh * dh + rt * dc * dh,
  );
}

double _hueDeg(double a, double b) {
  double h = math.atan2(b, a) * 180 / math.pi;
  if (h < 0) {
    h += 360;
  }
  return h;
}

// ---------------------------------------------------------------------------
// Linear-sRGB conversion internals
// ---------------------------------------------------------------------------

double _cbrt(double x) => x.sign * math.pow(x.abs(), 1 / 3).toDouble();

/// ARGB channels as linear-sRGB 0..1.
List<double> _argbToLinear(int argb) => <double>[
  _toLinear(((argb >> 16) & 0xFF) / 255),
  _toLinear(((argb >> 8) & 0xFF) / 255),
  _toLinear((argb & 0xFF) / 255),
];

double _toLinear(double channel) => channel <= 0.04045
    ? channel / 12.92
    : math.pow((channel + 0.055) / 1.055, 2.4).toDouble();

int _toSrgbByte(double channel) {
  final double c = channel <= 0.0031308
      ? 12.92 * channel
      : 1.055 * math.pow(channel, 1 / 2.4).toDouble() - 0.055;
  return (c * 255).round().clamp(0, 255);
}

/// Linear sRGB to Oklab (Björn Ottosson's matrices).
List<double> _linearToOklab(double r, double g, double b) {
  final double l = _cbrt(
    0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b,
  );
  final double m = _cbrt(
    0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b,
  );
  final double s = _cbrt(
    0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b,
  );
  return <double>[
    0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
    1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
    0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s,
  ];
}

/// Oklab to linear sRGB (inverse matrices).
List<double> _oklabToLinear(double l, double a, double b) {
  final double l_ = l + 0.3963377774 * a + 0.2158037573 * b;
  final double m_ = l - 0.1055613458 * a - 0.0638541728 * b;
  final double s_ = l - 0.0894841775 * a - 1.2914855480 * b;
  final double l2 = l_ * l_ * l_;
  final double m2 = m_ * m_ * m_;
  final double s2 = s_ * s_ * s_;
  return <double>[
    4.0767416621 * l2 - 3.3077115913 * m2 + 0.2309699292 * s2,
    -1.2684380046 * l2 + 2.6097574011 * m2 - 0.3413193965 * s2,
    -0.0041960863 * l2 - 0.7034186147 * m2 + 1.7076147010 * s2,
  ];
}

bool _inGamut(List<double> linear) =>
    linear.every((double c) => c >= -0.0001 && c <= 1.0001);

/// Binary-searches the largest chroma at ([light], [radians]) that fits in
/// sRGB, so written Oklch always round-trips through real CSS colours.
double _fitChroma(double light, double chroma, double radians) {
  if (chroma <= 0) {
    return 0;
  }
  final double cosH = math.cos(radians);
  final double sinH = math.sin(radians);
  bool fits(double c) => _inGamut(_oklabToLinear(light, c * cosH, c * sinH));
  if (fits(chroma)) {
    return chroma;
  }
  double low = 0;
  double high = chroma;
  for (int i = 0; i < 24; i++) {
    final double mid = (low + high) / 2;
    if (fits(mid)) {
      low = mid;
    } else {
      high = mid;
    }
  }
  return low;
}

/// Fixed-decimal formatting without trailing zeros.
String _fixed(double value, int digits) {
  final String text = value.toStringAsFixed(digits);
  if (!text.contains('.')) {
    return text;
  }
  return text.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
}
