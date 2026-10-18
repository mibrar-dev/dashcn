// Pure-Dart QR matrix wrapper for the `qr_code` component.
//
// The `qr` package (https://pub.dev/packages/qr) is a pure-Dart encoder with
// no Flutter/material import (its only dependency is `meta`), so it
// qualifies for kit use. This file isolates that dependency: the widget and
// its tests talk to [QrMatrix] only, and the public error-correction enum
// [QrErrorCorrectionLevel] never leaks the package's types.

import 'package:qr/qr.dart' as qr;

/// Error-correction level of a QR code: higher levels survive more damage
/// but need more modules for the same payload.
enum QrErrorCorrectionLevel {
  /// ~7% recovery.
  low,

  /// ~15% recovery (the default).
  medium,

  /// ~25% recovery.
  quartile,

  /// ~30% recovery.
  high,
}

/// Maps the public level to the encoder's level.
qr.QrErrorCorrectLevel _toEncoderLevel(QrErrorCorrectionLevel level) {
  return switch (level) {
    QrErrorCorrectionLevel.low => qr.QrErrorCorrectLevel.low,
    QrErrorCorrectionLevel.medium => qr.QrErrorCorrectLevel.medium,
    QrErrorCorrectionLevel.quartile => qr.QrErrorCorrectLevel.quartile,
    QrErrorCorrectionLevel.high => qr.QrErrorCorrectLevel.high,
  };
}

/// A decoded QR module grid: `moduleCount` by `moduleCount` dark/light
/// cells. Row-major storage; the encoder picks the smallest version that
/// fits the payload and level.
class QrMatrix {
  /// Creates a matrix from raw row-major cells.
  const QrMatrix._({required this.moduleCount, required this._dark});

  /// Encodes [data] at [level], auto-selecting the smallest QR version that
  /// fits. Empty data yields a version-1 all-light grid (a blank
  /// placeholder, never an exception).
  factory QrMatrix.encode(
    String data, {
    QrErrorCorrectionLevel level = QrErrorCorrectionLevel.medium,
  }) {
    if (data.isEmpty) {
      return const QrMatrix._(moduleCount: 21, dark: <bool>[]);
    }
    final qr.QrCode code = qr.QrCode(
      payload: qr.QrPayload.fromString(data),
      errorCorrectLevel: _toEncoderLevel(level),
    );
    final qr.QrImage image = qr.QrImage(code);
    final int count = image.moduleCount;
    final List<bool> dark = List<bool>.filled(count * count, false);
    for (var row = 0; row < count; row++) {
      for (var col = 0; col < count; col++) {
        dark[row * count + col] = image.isDark(row, col);
      }
    }
    final int version = (count - 21) ~/ 4 + 1;
    assert(version >= 1 && version <= 40);
    return QrMatrix._(moduleCount: count, dark: dark);
  }

  /// Modules per side (21 for version 1, +4 per version).
  final int moduleCount;

  /// Row-major dark cells; empty for the blank placeholder.
  final List<bool> _dark;

  /// QR version (1-40) derived from the module count.
  int get typeNumber => (moduleCount - 21) ~/ 4 + 1;

  /// Whether the cell is dark; out-of-range reads light.
  bool isDark(int row, int col) {
    if (row < 0 || col < 0 || row >= moduleCount || col >= moduleCount) {
      return false;
    }
    if (_dark.isEmpty) {
      return false;
    }
    return _dark[row * moduleCount + col];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QrMatrix || other.moduleCount != moduleCount) {
      return false;
    }
    if (_dark.length != other._dark.length) {
      return false;
    }
    for (var i = 0; i < _dark.length; i++) {
      if (_dark[i] != other._dark[i]) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(moduleCount, Object.hashAll(_dark));
}
