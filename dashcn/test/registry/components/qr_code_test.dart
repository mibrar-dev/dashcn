// Widget and matrix tests for the `qr_code` component.
//
// Covers the module matrix for known inputs, the quiet zone (by pixel),
// box fitting at 320 px, semantics labels, the centre-logo clear area and
// the four theme legs.

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/qr_code/qr_code.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _black = Color(0xFF000000);
const Color _white = Color(0xFFFFFFFF);
const Color _green = Color(0xFF00FF00);
const Color _blue = Color(0xFF0000FF);

Widget _frame({
  required Widget child,
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  QrCodeTheme? scopedTheme,
}) {
  Widget body = child;
  if (scopedTheme != null) {
    body = ComponentTheme<QrCodeTheme>(data: scopedTheme, child: body);
  }
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: body),
      ),
    ),
  );
}

/// Paints [painter] headless at [size] and returns raw RGBA bytes.
Future<List<int>> _paintBytes(QrCodePainter painter, Size size) async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder, Offset.zero & size);
  painter.paint(canvas, size);
  final ui.Picture picture = recorder.endRecording();
  final ui.Image image = await picture.toImage(
    size.width.toInt(),
    size.height.toInt(),
  );
  picture.dispose();
  final ByteData? data = await image.toByteData(
    format: ui.ImageByteFormat.rawRgba,
  );
  image.dispose();
  return data!.buffer.asUint8List().toList();
}

/// Red channel of the pixel at ([x], [y]) in a raw-RGBA image.
int _red(List<int> bytes, int side, int x, int y) {
  return bytes[(y * side + x) * 4];
}

/// The 7x7 finder pattern in the top-left corner of [matrix].
void _expectFinder(QrMatrix matrix) {
  // Outer ring dark, inner ring light, 3x3 centre dark.
  for (var i = 0; i < 7; i++) {
    expect(matrix.isDark(0, i), isTrue, reason: 'top row $i');
    expect(matrix.isDark(6, i), isTrue, reason: 'bottom row $i');
    expect(matrix.isDark(i, 0), isTrue, reason: 'left col $i');
    expect(matrix.isDark(i, 6), isTrue, reason: 'right col $i');
  }
  expect(matrix.isDark(1, 1), isFalse);
  expect(matrix.isDark(1, 5), isFalse);
  expect(matrix.isDark(5, 1), isFalse);
  expect(matrix.isDark(2, 2), isTrue);
  expect(matrix.isDark(3, 3), isTrue);
}

void main() {
  group('matrix', () {
    test('a known input yields the finder pattern', () {
      final QrMatrix matrix = QrMatrix.encode('HELLO');
      expect(matrix.moduleCount, greaterThanOrEqualTo(21));
      _expectFinder(matrix);
    });

    test('every error-correction level encodes a valid matrix', () {
      for (final QrErrorCorrectionLevel level
          in QrErrorCorrectionLevel.values) {
        final QrMatrix matrix = QrMatrix.encode(
          'https://example.com',
          level: level,
        );
        expect(matrix.moduleCount, greaterThanOrEqualTo(21), reason: '$level');
        _expectFinder(matrix);
      }
    });

    test('empty data yields a blank version-1 grid', () {
      final QrMatrix matrix = QrMatrix.encode('');
      expect(matrix.moduleCount, 21);
      expect(matrix.typeNumber, 1);
      for (var row = 0; row < 21; row++) {
        for (var col = 0; col < 21; col++) {
          expect(matrix.isDark(row, col), isFalse);
        }
      }
    });

    test('out-of-range cells read light', () {
      final QrMatrix matrix = QrMatrix.encode('HELLO');
      expect(matrix.isDark(-1, 0), isFalse);
      expect(matrix.isDark(0, matrix.moduleCount), isFalse);
    });
  });

  group('layout', () {
    testWidgets('a fixed size paints a square of that side', (tester) async {
      await tester.pumpWidget(
        _frame(child: const QrCode(data: 'https://example.com', size: 200)),
      );
      expect(tester.getSize(find.byType(QrCode)), const Size(200, 200));
    });

    testWidgets('a long payload still fits a 320 px box', (tester) async {
      final String long = 'https://example.com/${'a' * 200}';
      await tester.pumpWidget(
        _frame(
          child: SizedBox.square(
            dimension: 320,
            child: QrCode(data: long, center: const Text('D')),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      final Size size = tester.getSize(find.byType(QrCode));
      expect(size.width, lessThanOrEqualTo(320));
      expect(size.height, lessThanOrEqualTo(320));
    });

    testWidgets('an unbounded height sizes from the width', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const SizedBox(
            width: 320,
            child: QrCode(data: 'https://example.com'),
          ),
        ),
      );
      expect(tester.getSize(find.byType(QrCode)), const Size(320, 320));
    });

    testWidgets('every module shape paints without error', (tester) async {
      for (final QrModuleShape shape in QrModuleShape.values) {
        await tester.pumpWidget(
          _frame(
            child: QrCode(data: 'dashcn', size: 120, moduleShape: shape),
          ),
        );
        expect(tester.takeException(), isNull, reason: '$shape');
      }
    });
  });

  group('quiet zone', () {
    test('total modules include the margin on every side', () {
      final QrMatrix matrix = QrMatrix.encode('HELLO');
      final QrCodePainter painter = QrCodePainter(
        matrix: matrix,
        quietZone: 4,
        shape: QrModuleShape.square,
        foreground: _black,
        background: _white,
      );
      expect(painter.totalModules, matrix.moduleCount + 8);
    });

    testWidgets('the margin paints in the background ink', (tester) async {
      final QrMatrix matrix = QrMatrix.encode('HELLO');
      final QrCodePainter painter = QrCodePainter(
        matrix: matrix,
        quietZone: 4,
        shape: QrModuleShape.square,
        foreground: _black,
        background: _white,
      );
      final int total = matrix.moduleCount + 8;
      const int side = 290;
      final double cell = side / total;
      // Centre of finder module (3, 3), offset by the quiet zone.
      final int finderPx = ((4 + 3) * cell + cell / 2).round();
      final List<int>? bytes = await tester.runAsync<List<int>>(
        () => _paintBytes(painter, Size.square(side.toDouble())),
      );
      expect(bytes, isNotNull);
      // Corner of the quiet zone: background.
      expect(_red(bytes!, side, 2, 2), 255);
      // Finder module: foreground black.
      expect(_red(bytes, side, finderPx, finderPx), 0);
    });
  });

  group('centre logo', () {
    testWidgets('the logo widget paints over a cleared area', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const QrCode(
            data: 'https://example.com',
            size: 200,
            center: Text('D'),
          ),
        ),
      );
      expect(find.text('D'), findsOneWidget);
      final QrCodePainter painter =
          tester
                  .widget<CustomPaint>(
                    find.descendant(
                      of: find.byType(QrCode),
                      matching: find.byType(CustomPaint),
                    ),
                  )
                  .painter!
              as QrCodePainter;
      expect(painter.clearFraction, greaterThan(0));
    });

    testWidgets('cleared modules stay in the background ink', (tester) async {
      final QrMatrix matrix = QrMatrix.encode('HELLO');
      final QrCodePainter painter = QrCodePainter(
        matrix: matrix,
        quietZone: 4,
        shape: QrModuleShape.square,
        foreground: _black,
        background: _white,
        clearFraction: 0.24,
      );
      const int side = 290;
      final List<int>? bytes = await tester.runAsync<List<int>>(
        () => _paintBytes(painter, Size.square(side.toDouble())),
      );
      expect(bytes, isNotNull);
      // Grid centre: cleared to background even though the timing area
      // around it carries dark modules elsewhere.
      expect(_red(bytes!, side, side ~/ 2, side ~/ 2), 255);
    });
  });

  group('semantics', () {
    testWidgets('the default label is announced', (tester) async {
      await tester.pumpWidget(
        _frame(child: const QrCode(data: 'x', size: 120)),
      );
      expect(find.bySemanticsLabel('QR code'), findsOneWidget);
    });

    testWidgets('a custom label is announced', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const QrCode(
            data: 'x',
            size: 120,
            semanticsLabel: 'QR code for example',
          ),
        ),
      );
      expect(find.bySemanticsLabel('QR code for example'), findsOneWidget);
    });
  });

  group('theme precedence', () {
    QrCodePainter painterOf(WidgetTester tester) {
      return tester
              .widget<CustomPaint>(
                find.descendant(
                  of: find.byType(QrCode),
                  matching: find.byType(CustomPaint),
                ),
              )
              .painter!
          as QrCodePainter;
    }

    testWidgets('a scoped theme recolours the modules', (tester) async {
      await tester.pumpWidget(
        _frame(
          scopedTheme: const QrCodeTheme(foreground: ThemedColor.value(_green)),
          child: const QrCode(data: 'x', size: 120),
        ),
      );
      expect(painterOf(tester).foreground, _green);
    });

    testWidgets('the widget leg overrides the scoped leg', (tester) async {
      await tester.pumpWidget(
        _frame(
          scopedTheme: const QrCodeTheme(foreground: ThemedColor.value(_green)),
          child: const QrCode(data: 'x', size: 120, foreground: _blue),
        ),
      );
      expect(painterOf(tester).foreground, _blue);
    });

    testWidgets('dark tokens drive the same slots', (tester) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(colors: ThemeColors.darkFallback),
          child: const QrCode(data: 'x', size: 120),
        ),
      );
      final QrCodePainter painter = painterOf(tester);
      expect(painter.foreground, ThemeColors.darkFallback.foreground);
      expect(painter.background, ThemeColors.darkFallback.background);
    });
  });
}
