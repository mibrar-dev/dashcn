// Unexported colour formatting and distance helpers (pure Dart).
//
// Canonical home of the hex/oklch formatters and the CIE Lab / CIEDE2000
// distance used by the writers and the round-trip gates. Not exported by
// `interop.dart` (or any barrel): import it directly from `src/` when working
// inside the interop layer.

import 'dart:math' as math;

import '../color_space.dart';

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

List<double> _argbToLinear(int argb) => <double>[
  _toLinear(((argb >> 16) & 0xFF) / 255),
  _toLinear(((argb >> 8) & 0xFF) / 255),
  _toLinear((argb & 0xFF) / 255),
];

double _toLinear(double channel) => channel <= 0.04045
    ? channel / 12.92
    : math.pow((channel + 0.055) / 1.055, 2.4).toDouble();

/// Fixed-decimal formatting without trailing zeros.
String _fixed(double value, int digits) {
  final String text = value.toStringAsFixed(digits);
  if (!text.contains('.')) {
    return text;
  }
  return text.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
}
