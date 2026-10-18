// State for the `signature_pad` component: the [SignaturePoint] /
// [SignatureStroke] models, the [SignaturePadController] (strokes, undo/redo
// stacks, SVG and PNG export) and the shared stroke rasterizer
// [paintSignatureStrokes] used by both the widget painter and PNG export, so
// on-screen ink and exported bytes always match.
//
// Widgets-only: `dart:ui` for the recorder/image encode, `widgets.dart` for
// [ChangeNotifier]. No material/cupertino.

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

/// Speed (logical pixels per millisecond) that narrows the stroke from its
/// base width all the way to [SignatureStroke.minWidth].
const double _fullSpeed = 3;

/// Speed at or below which the stroke keeps its full base width; hand jitter
/// at rest must not thin the ink.
const double _restSpeed = 0.5;

/// One sampled pointer position of a stroke.
class SignaturePoint {
  /// Creates a point.
  const SignaturePoint(this.position, this.time);

  /// Pointer position in the pad's local coordinates.
  final Offset position;

  /// When the sample was taken; drives the speed-based width.
  final DateTime time;
}

/// One pen-down to pen-up stroke.
///
/// The ink appearance is frozen at capture time ([color], [width],
/// [minWidth], [variableWidth]), so undo/redo and export keep the exact look
/// even when the ambient theme changes afterwards.
class SignatureStroke {
  /// Creates a stroke.
  const SignatureStroke({
    required this.points,
    required this.color,
    required this.width,
    required this.minWidth,
    this.variableWidth = true,
  });

  /// Sampled positions, in order.
  final List<SignaturePoint> points;

  /// Ink colour.
  final Color color;

  /// Width at rest (slow movement) in logical pixels.
  final double width;

  /// Width at speed (fast movement) in logical pixels.
  final double minWidth;

  /// Whether pointer speed narrows the stroke.
  final bool variableWidth;
}

/// Per-point widths for [stroke]: slow samples keep [SignatureStroke.width],
/// fast samples narrow towards [SignatureStroke.minWidth]. One entry per
/// point in [SignatureStroke.points].
List<double> signatureStrokeWidths(SignatureStroke stroke) {
  final List<SignaturePoint> points = stroke.points;
  final List<double> widths = List<double>.filled(points.length, stroke.width);
  if (!stroke.variableWidth || points.length < 2) {
    return widths;
  }
  for (var i = 1; i < points.length; i++) {
    final SignaturePoint previous = points[i - 1];
    final SignaturePoint current = points[i];
    final double dt =
        current.time.difference(previous.time).inMicroseconds / 1000.0;
    final double distance = (current.position - previous.position).distance;
    final double speed = dt <= 0 ? 0.0 : distance / dt;
    final double t = ((speed - _restSpeed) / (_fullSpeed - _restSpeed)).clamp(
      0.0,
      1.0,
    );
    widths[i] = stroke.width + (stroke.minWidth - stroke.width) * t;
  }
  return widths;
}

/// Paints [strokes] with midpoint quadratic smoothing and round caps, one
/// path segment per sample so the speed-based width can change along the
/// stroke. Shared by the on-screen painter and [SignaturePadController].
void paintSignatureStrokes(Canvas canvas, List<SignatureStroke> strokes) {
  for (final SignatureStroke stroke in strokes) {
    final List<Offset> positions = <Offset>[
      for (final SignaturePoint point in stroke.points) point.position,
    ];
    if (positions.isEmpty) {
      continue;
    }
    final List<double> widths = signatureStrokeWidths(stroke);
    if (positions.length == 1) {
      canvas.drawCircle(
        positions.first,
        widths.first / 2,
        Paint()..color = stroke.color,
      );
      continue;
    }
    Offset start = positions.first;
    for (var i = 1; i < positions.length; i++) {
      final bool last = i == positions.length - 1;
      final Offset control = positions[i];
      final Offset end = last
          ? positions[i]
          : Offset(
              (positions[i].dx + positions[i + 1].dx) / 2,
              (positions[i].dy + positions[i + 1].dy) / 2,
            );
      canvas.drawPath(
        Path()
          ..moveTo(start.dx, start.dy)
          ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy),
        Paint()
          ..color = stroke.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = widths[i]
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
      start = end;
    }
  }
}

/// Formats one offset with a single decimal, the SVG path precision.
String _formatOffset(Offset position) {
  return '${position.dx.toStringAsFixed(1)},${position.dy.toStringAsFixed(1)}';
}

/// Midpoint-smoothed SVG sub-path for one stroke's positions.
String _strokeSubPath(List<Offset> positions) {
  if (positions.isEmpty) {
    return '';
  }
  if (positions.length == 1) {
    // A zero-length line renders as a dot under a round line cap.
    final String point = _formatOffset(positions.first);
    return 'M $point L $point';
  }
  final StringBuffer buffer = StringBuffer('M ${_formatOffset(positions[0])}');
  for (var i = 1; i < positions.length - 1; i++) {
    final Offset mid = Offset(
      (positions[i].dx + positions[i + 1].dx) / 2,
      (positions[i].dy + positions[i + 1].dy) / 2,
    );
    buffer.write(' Q ${_formatOffset(positions[i])} ${_formatOffset(mid)}');
  }
  buffer.write(' L ${_formatOffset(positions.last)}');
  return buffer.toString();
}

/// Owns the strokes of a [SignaturePad]: capture, undo/redo, clear, SVG path
/// and PNG export. The widget forwards every mutation through [onChanged]
/// listeners as the stroke count; listen directly for finer updates.
class SignaturePadController extends ChangeNotifier {
  /// Creates an empty controller.
  SignaturePadController();

  final List<SignatureStroke> _strokes = <SignatureStroke>[];
  final List<SignatureStroke> _redoStack = <SignatureStroke>[];

  /// Committed strokes, oldest first; unmodifiable.
  List<SignatureStroke> get strokes =>
      List<SignatureStroke>.unmodifiable(_strokes);

  /// Number of committed strokes.
  int get strokeCount => _strokes.length;

  /// Whether no stroke is committed.
  bool get isEmpty => _strokes.isEmpty;

  /// Whether [undo] would remove a stroke.
  bool get canUndo => _strokes.isNotEmpty;

  /// Whether [redo] would restore a stroke.
  bool get canRedo => _redoStack.isNotEmpty;

  /// Commits [stroke] (a fresh pen-up pass or a restored save); clears redo.
  void addStroke(SignatureStroke stroke) {
    _strokes.add(stroke);
    _redoStack.clear();
    notifyListeners();
  }

  /// Removes the latest stroke to the redo stack; false when empty.
  bool undo() {
    if (_strokes.isEmpty) {
      return false;
    }
    _redoStack.add(_strokes.removeLast());
    notifyListeners();
    return true;
  }

  /// Restores the latest undone stroke; false when the redo stack is empty.
  bool redo() {
    if (_redoStack.isEmpty) {
      return false;
    }
    _strokes.add(_redoStack.removeLast());
    notifyListeners();
    return true;
  }

  /// Drops every stroke and the redo stack.
  void clear() {
    if (_strokes.isEmpty && _redoStack.isEmpty) {
      return;
    }
    _strokes.clear();
    _redoStack.clear();
    notifyListeners();
  }

  /// SVG path data (`d` attribute) for every stroke, midpoint-smoothed;
  /// empty when the pad is empty. Pair with `stroke-linecap="round"`.
  String toSvgPath() {
    final List<String> parts = <String>[];
    for (final SignatureStroke stroke in _strokes) {
      final String subPath = _strokeSubPath(<Offset>[
        for (final SignaturePoint point in stroke.points) point.position,
      ]);
      if (subPath.isNotEmpty) {
        parts.add(subPath);
      }
    }
    return parts.join(' ');
  }

  /// Renders the strokes over [background] at [size] and encodes PNG bytes.
  ///
  /// Pass the pad's own size (`tester.getSize` / `context.size`) so the bytes
  /// match the on-screen ink; [pixelRatio] scales the output resolution.
  Future<Uint8List> toPngBytes({
    required Size size,
    Color background = const Color(0x00000000),
    double pixelRatio = 3,
  }) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    // Scale once so logical-size drawing fills the scaled image below.
    canvas.save();
    canvas.scale(pixelRatio);
    if (background.a > 0) {
      canvas.drawRect(Offset.zero & size, Paint()..color = background);
    }
    paintSignatureStrokes(canvas, _strokes);
    canvas.restore();
    final ui.Picture picture = recorder.endRecording();
    // The drawing was scaled by [pixelRatio], so the image needs the scaled
    // dimensions.
    final ui.Image image = await picture.toImage(
      (size.width * pixelRatio).ceil(),
      (size.height * pixelRatio).ceil(),
    );
    picture.dispose();
    final ByteData? data = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    image.dispose();
    if (data == null) {
      return Uint8List(0);
    }
    return data.buffer.asUint8List();
  }
}
