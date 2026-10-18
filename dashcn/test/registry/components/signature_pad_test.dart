// Widget and controller tests for the `signature_pad` component.
//
// Covers stroke capture from a drag, undo/redo/clear, SVG and PNG export,
// read-only/disabled input gating, semantics labels and the four theme legs.

import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/signature_pad/signature_pad.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _green = Color(0xFF00FF00);
const Color _blue = Color(0xFF0000FF);

Widget _frame({
  required Widget child,
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  SignaturePadTheme? scopedTheme,
}) {
  Widget body = SizedBox(width: 320, height: 200, child: child);
  if (scopedTheme != null) {
    body = ComponentTheme<SignaturePadTheme>(data: scopedTheme, child: body);
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

/// A deterministic two-segment stroke for export and controller tests.
SignatureStroke _demoStroke({Color color = const Color(0xFF000000)}) {
  final DateTime base = DateTime(2026, 1, 1);
  return SignatureStroke(
    points: <SignaturePoint>[
      SignaturePoint(const Offset(24, 100), base),
      SignaturePoint(
        const Offset(72, 76),
        base.add(const Duration(milliseconds: 16)),
      ),
      SignaturePoint(
        const Offset(120, 124),
        base.add(const Duration(milliseconds: 32)),
      ),
      SignaturePoint(
        const Offset(168, 76),
        base.add(const Duration(milliseconds: 48)),
      ),
    ],
    color: color,
    width: 3,
    minWidth: 1,
  );
}

void main() {
  group('capture', () {
    testWidgets('a drag records one stroke and reports its count', (
      tester,
    ) async {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      final List<int> counts = <int>[];
      await tester.pumpWidget(
        _frame(
          child: SignaturePad(controller: controller, onChanged: counts.add),
        ),
      );
      expect(controller.isEmpty, isTrue);
      await tester.drag(find.byType(SignaturePad), const Offset(60, 10));
      await tester.pump();
      expect(controller.strokeCount, 1);
      expect(controller.strokes.first.points.length, greaterThan(1));
      expect(counts, <int>[1]);
    });

    testWidgets('a disabled pad ignores input', (tester) async {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      final List<int> counts = <int>[];
      await tester.pumpWidget(
        _frame(
          child: SignaturePad(
            controller: controller,
            enabled: false,
            onChanged: counts.add,
          ),
        ),
      );
      await tester.drag(find.byType(SignaturePad), const Offset(60, 10));
      await tester.pump();
      expect(controller.isEmpty, isTrue);
      expect(counts, isEmpty);
    });

    testWidgets('a read-only pad ignores input without dimming', (
      tester,
    ) async {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(child: SignaturePad(controller: controller, readOnly: true)),
      );
      await tester.drag(find.byType(SignaturePad), const Offset(60, 10));
      await tester.pump();
      expect(controller.isEmpty, isTrue);
      final Opacity opacity = tester.widget<Opacity>(
        find.descendant(
          of: find.byType(SignaturePad),
          matching: find.byType(Opacity),
        ),
      );
      expect(opacity.opacity, 1);
    });

    testWidgets('a disabled pad dims', (tester) async {
      await tester.pumpWidget(
        _frame(child: const SignaturePad(enabled: false)),
      );
      final Opacity opacity = tester.widget<Opacity>(
        find.descendant(
          of: find.byType(SignaturePad),
          matching: find.byType(Opacity),
        ),
      );
      expect(opacity.opacity, 0.5);
    });
  });

  group('controller', () {
    test('undo/redo/clear move strokes and report emptiness', () {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      expect(controller.undo(), isFalse);
      expect(controller.redo(), isFalse);
      controller.addStroke(_demoStroke());
      controller.addStroke(_demoStroke());
      expect(controller.strokeCount, 2);
      expect(controller.undo(), isTrue);
      expect(controller.strokeCount, 1);
      expect(controller.canRedo, isTrue);
      expect(controller.redo(), isTrue);
      expect(controller.strokeCount, 2);
      // A fresh stroke clears the redo stack.
      expect(controller.undo(), isTrue);
      controller.addStroke(_demoStroke());
      expect(controller.canRedo, isFalse);
      expect(controller.redo(), isFalse);
      controller.clear();
      expect(controller.isEmpty, isTrue);
      expect(controller.strokeCount, 0);
    });

    test('onChanged-style listeners fire on undo/redo/clear', () {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      final List<int> counts = <int>[];
      controller.addListener(() => counts.add(controller.strokeCount));
      controller.addStroke(_demoStroke());
      controller.undo();
      controller.redo();
      controller.clear();
      expect(counts, <int>[1, 0, 1, 0]);
    });

    test('slow movement keeps the base width, speed narrows it', () {
      final DateTime base = DateTime(2026, 1, 1);
      final SignatureStroke slow = SignatureStroke(
        points: <SignaturePoint>[
          SignaturePoint(const Offset(0, 0), base),
          // 10px in 100ms: well under the full-speed threshold.
          SignaturePoint(
            const Offset(10, 0),
            base.add(const Duration(milliseconds: 100)),
          ),
        ],
        color: const Color(0xFF000000),
        width: 4,
        minWidth: 1,
      );
      expect(signatureStrokeWidths(slow).last, 4);
      final SignatureStroke fast = SignatureStroke(
        points: <SignaturePoint>[
          SignaturePoint(const Offset(0, 0), base),
          // 300px in 16ms: far past the full-speed threshold.
          SignaturePoint(
            const Offset(300, 0),
            base.add(const Duration(milliseconds: 16)),
          ),
        ],
        color: const Color(0xFF000000),
        width: 4,
        minWidth: 1,
      );
      expect(signatureStrokeWidths(fast).last, 1);
    });

    test('a fixed-width stroke never narrows', () {
      final DateTime base = DateTime(2026, 1, 1);
      final SignatureStroke stroke = SignatureStroke(
        points: <SignaturePoint>[
          SignaturePoint(const Offset(0, 0), base),
          SignaturePoint(
            const Offset(300, 0),
            base.add(const Duration(milliseconds: 16)),
          ),
        ],
        color: const Color(0xFF000000),
        width: 4,
        minWidth: 1,
        variableWidth: false,
      );
      expect(signatureStrokeWidths(stroke), <double>[4, 4]);
    });
  });

  group('export', () {
    test('an empty pad exports an empty SVG path', () {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      expect(controller.toSvgPath(), isEmpty);
    });

    test('a stroke exports a non-empty smoothed SVG path', () {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      controller.addStroke(_demoStroke());
      final String path = controller.toSvgPath();
      expect(path, isNotEmpty);
      expect(path, startsWith('M '));
      // Midpoint smoothing emits at least one quadratic segment.
      expect(path, contains(' Q '));
    });

    testWidgets('a stroke exports non-empty PNG bytes', (tester) async {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      controller.addStroke(_demoStroke());
      final Size size = const Size(320, 200);
      final Uint8List? bytes = await tester.runAsync<Uint8List>(
        () => controller.toPngBytes(
          size: size,
          background: const Color(0xFFFFFFFF),
        ),
      );
      expect(bytes, isNotNull);
      expect(bytes!, isNotEmpty);
      // PNG magic header.
      expect(bytes.sublist(0, 8), <int>[137, 80, 78, 71, 13, 10, 26, 10]);
    });
  });

  group('semantics', () {
    testWidgets('the default label is announced', (tester) async {
      await tester.pumpWidget(_frame(child: const SignaturePad()));
      expect(find.bySemanticsLabel('Signature pad'), findsOneWidget);
    });

    testWidgets('a custom label is announced', (tester) async {
      await tester.pumpWidget(
        _frame(child: const SignaturePad(semanticsLabel: 'Sign here')),
      );
      expect(find.bySemanticsLabel('Sign here'), findsOneWidget);
    });
  });

  group('theme precedence', () {
    testWidgets('a scoped stroke colour reaches committed strokes', (
      tester,
    ) async {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          scopedTheme: const SignaturePadTheme(
            strokeColor: ThemedColor.value(_green),
          ),
          child: SignaturePad(controller: controller),
        ),
      );
      await tester.drag(find.byType(SignaturePad), const Offset(60, 10));
      await tester.pump();
      expect(controller.strokes.first.color, _green);
    });

    testWidgets('the widget leg overrides the scoped leg', (tester) async {
      final SignaturePadController controller = SignaturePadController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          scopedTheme: const SignaturePadTheme(
            strokeColor: ThemedColor.value(_green),
          ),
          child: SignaturePad(controller: controller, strokeColor: _blue),
        ),
      );
      await tester.drag(find.byType(SignaturePad), const Offset(60, 10));
      await tester.pump();
      expect(controller.strokes.first.color, _blue);
    });

    testWidgets('a scoped background paints the pad surface', (tester) async {
      await tester.pumpWidget(
        _frame(
          scopedTheme: const SignaturePadTheme(
            background: ThemedColor.value(_green),
          ),
          child: const SignaturePad(),
        ),
      );
      final DecoratedBox box = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(SignaturePad),
          matching: find.byType(DecoratedBox),
        ),
      );
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.color, _green);
    });
  });
}
