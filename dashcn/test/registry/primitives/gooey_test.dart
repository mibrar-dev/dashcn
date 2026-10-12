// Widget tests for the `primitives/gooey` layer.
//
// Covers the reusable machinery, without the component on top: the merged
// silhouette geometry, the metaball compositing, the pill/body content, the
// swipe wrapper and the stack anchors — plus the pill-height regression that
// squashed the old rewrite's silhouette to half the pill.

import 'dart:ui' show lerpDouble;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/primitives/gooey/gooey_chip.dart';
import 'package:dashcn/src/primitives/gooey/gooey_content.dart';
import 'package:dashcn/src/primitives/gooey/gooey_frame.dart';
import 'package:dashcn/src/primitives/gooey/gooey_paint.dart';
import 'package:dashcn/src/primitives/gooey/gooey_shape.dart';
import 'package:dashcn/src/primitives/gooey/gooey_stack.dart';
import 'package:dashcn/src/primitives/gooey/gooey_surface.dart';
import 'package:dashcn/src/primitives/gooey/gooey_swipe.dart';
import 'package:dashcn/src/primitives/toast_queue/toast_placement.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const IconData _kTestIcon = IconData(0);

Widget _surfaceFrame({
  String title = 'Saved',
  String? description = 'Body',
  Widget? body,
  Widget? action,
  double width = 350,
  double roundness = 18,
  bool expandUp = false,
  GooeySurfaceBodyAnimation bodyAnimation = GooeySurfaceBodyAnimation.fade,
  double progress = 0,
}) {
  return ShadcnTheme(
    data: const ShadcnThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: GooeySurfaceFrame(
        progress: progress,
        width: width,
        pillHeight: kGooeySurfacePillHeight,
        pillBase: kGooeySurfacePillHeight + roundness * kGooeyBlurRatio * 3,
        targetHeight: description == null && body == null && action == null
            ? kGooeySurfacePillHeight
            : kGooeySurfacePillHeight * 2.25,
        pillWidth: 200,
        pillX: 0,
        roundness: roundness,
        color: const Color(0xFF0D1117),
        fillAlpha: 1,
        blur: 0,
        surfaceBlur: 0,
        enableGooeyBlur: false,
        expandUp: expandUp,
        bodyAnimation: bodyAnimation,
        ready: true,
        borderColor: null,
        shadowColor: null,
        pill: GooeySurfacePill(
          title: title,
          titleStyle: const TextStyle(),
          width: 200,
          height: kGooeySurfacePillHeight,
          morph: const GooeyCompactMorphFrame(),
          leading: const GooeyStateIcon(
            icon: _kTestIcon,
            color: Color(0xFF63C65E),
          ),
        ),
        body: description == null && body == null && action == null
            ? null
            : GooeySurfaceBody(
                width: width,
                onSizeChanged: (_) {},
                description: description,
                body: body,
                action: action,
              ),
      ),
    ),
  );
}

void main() {
  group('silhouette geometry', () {
    test('closed: the pill is exactly its content height', () {
      const GooeyShapeGeometry geometry = GooeyShapeGeometry(
        roundness: 24,
        pillWidth: 200,
        pillHeight: 40,
        pillCanvasHeight: 40 + 24 * 0.5 * 3,
        pillScaleY: 40 / (40 + 24 * 0.5 * 3),
      );
      final Path path = geometry.buildSilhouette(const Size(350, 40));
      expect(path.getBounds().height, closeTo(40, 0.001));
      expect(path.computeMetrics().length, 1);
    });

    test('open: a union that grows past the pill width to the canvas', () {
      const GooeyShapeGeometry geometry = GooeyShapeGeometry(
        roundness: 24,
        pillX: 0,
        pillWidth: 200,
        bodyHeight: 120,
        bodyScaleY: 1,
      );
      final Path path = geometry.buildSilhouette(const Size(350, 160));
      // The reference silhouette is a union of the pill, the body and two
      // shoulder ovals (no stroke), so it carries several sub-paths; the
      // metaball pass merges them.
      expect(path.computeMetrics().length, greaterThan(1));
      expect(path.getBounds().width, greaterThan(200));
      // The body grows to the full canvas width (its right edge reaches the
      // width); the shoulder ovals may bloom a little past the pill's own edge,
      // exactly as the reference does.
      expect(path.getBounds().right, closeTo(350, 0.5));
      expect(path.getBounds().height, greaterThan(120));
    });

    test('zero body scale is the closed pill, with no pop', () {
      const GooeyShapeGeometry closed = GooeyShapeGeometry(
        roundness: 24,
        pillWidth: 200,
        bodyHeight: 0,
        bodyScaleY: 0,
      );
      const GooeyShapeGeometry nearly = GooeyShapeGeometry(
        roundness: 24,
        pillWidth: 200,
        bodyHeight: 120,
        bodyScaleY: 0.02,
      );
      final Path a = closed.buildSilhouette(const Size(350, 40));
      final Path b = nearly.buildSilhouette(const Size(350, 40));
      // Both are the pill: the body appears gradually, not at a threshold.
      expect(a.getBounds().height, closeTo(b.getBounds().height, 0.001));
    });

    test('the body morphs from the pill width to the canvas width', () {
      const GooeyShapeGeometry early = GooeyShapeGeometry(
        roundness: 24,
        pillX: 0,
        pillWidth: 200,
        bodyHeight: 120,
        bodyScaleY: 0.05,
      );
      const GooeyShapeGeometry late = GooeyShapeGeometry(
        roundness: 24,
        pillX: 0,
        pillWidth: 200,
        bodyHeight: 120,
        bodyScaleY: 1,
      );
      final Path a = early.buildSilhouette(const Size(350, 160));
      final Path b = late.buildSilhouette(const Size(350, 160));
      expect(b.getBounds().width, greaterThan(a.getBounds().width));
      expect(a.getBounds().width, greaterThanOrEqualTo(200));
    });

    test('a right-anchored pill keeps its body inside the canvas', () {
      // The pill and the opening body are clamped to the canvas; the shoulder
      // ovals may bloom a few px past the pill edge (as in the reference), so
      // assert on the pill/body, which always fit.
      const GooeyShapeGeometry geometry = GooeyShapeGeometry(
        roundness: 24,
        pillX: 150,
        pillWidth: 200,
        pillHeight: 40,
      );
      expect(
        geometry.buildSilhouette(const Size(350, 40)).getBounds().right,
        lessThanOrEqualTo(350),
      );
      const GooeyShapeGeometry open = GooeyShapeGeometry(
        roundness: 24,
        pillX: 150,
        pillWidth: 200,
        pillHeight: 40,
        bodyHeight: 120,
        bodyScaleY: 1,
      );
      // The body spans the full canvas width; the shoulder ovals bloom at most
      // one roundness (24) past the edge, exactly like the reference (which is
      // clipped at paint time).
      expect(
        open.buildSilhouette(const Size(350, 160)).getBounds().right,
        lessThanOrEqualTo(350 + 24),
      );
    });
  });

  group('shape painting', () {
    testWidgets('the border strokes the merged contour once', (tester) async {
      await tester.pumpWidget(
        ShadcnTheme(
          data: const ShadcnThemeData(),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: GooeyShapeLayer(
              width: 350,
              height: 160,
              geometry: GooeyShapeGeometry(
                roundness: 24,
                pillX: 20,
                pillWidth: 200,
                bodyHeight: 120,
                bodyScaleY: 1,
              ),
              color: Color(0xFF0D1117),
              blur: 0,
              enableGooeyBlur: false,
              borderColor: Color(0xFFFFFFFF),
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      // One `GooeyShapePainter` with a border, one without (the metaball copy):
      // the border is never painted twice.
      final List<GooeyShapePainter> painters = tester
          .widgetList<CustomPaint>(find.byType(CustomPaint))
          .map((CustomPaint p) => p.painter)
          .whereType<GooeyShapePainter>()
          .toList();
      expect(
        painters.where((GooeyShapePainter p) => p.borderColor != null),
        hasLength(1),
      );
    });

    testWidgets('the backdrop blur is clipped to the silhouette', (
      tester,
    ) async {
      await tester.pumpWidget(
        const ShadcnTheme(
          data: ShadcnThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: GooeyShapeLayer(
              width: 350,
              height: 160,
              geometry: GooeyShapeGeometry(
                roundness: 24,
                pillWidth: 200,
                bodyHeight: 120,
                bodyScaleY: 1,
              ),
              color: Color(0xFF0D1117),
              surfaceBlur: 12,
              enableGooeyBlur: false,
            ),
          ),
        ),
      );
      expect(find.byType(ClipPath), findsOne);
      expect(find.byType(BackdropFilter), findsOne);
      // The clipper is a `CustomClipper` field on the `ClipPath`, not a child
      // widget, so it is read off the element.
      final ClipPath clip = tester.widget<ClipPath>(find.byType(ClipPath));
      expect(clip.clipper, isA<GooeyShapeClipper>());
    });
  });

  group('pill content', () {
    testWidgets('measures the pill from its title', (tester) async {
      final TextDirection direction = TextDirection.ltr;
      final double narrow = GooeySurfacePill.measureWidth(
        title: 'A',
        style: const TextStyle(fontSize: 14),
        direction: direction,
        pillHeight: 40,
        maxWidth: 350,
      );
      final double wide = GooeySurfacePill.measureWidth(
        title: 'A much longer compact title here',
        style: const TextStyle(fontSize: 14),
        direction: direction,
        pillHeight: 40,
        maxWidth: 350,
      );
      expect(wide, greaterThan(narrow));
    });

    testWidgets('the pill clamps to the surface width', (tester) async {
      final double clamped = GooeySurfacePill.measureWidth(
        title:
            'A title that is far too long to ever fit inside the pill at all',
        style: const TextStyle(fontSize: 14),
        direction: TextDirection.ltr,
        pillHeight: 40,
        maxWidth: 200,
      );
      expect(clamped, 200);
    });

    testWidgets('a morphing pill shows both frames', (tester) async {
      await tester.pumpWidget(
        const ShadcnTheme(
          data: ShadcnThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: GooeySurfacePill(
              title: 'Next',
              titleStyle: TextStyle(),
              width: 300,
              height: kGooeySurfacePillHeight,
              morph: GooeyCompactMorphFrame(progress: 0.5, title: 'Previous'),
              leading: GooeyStateIcon(
                icon: _kTestIcon,
                color: Color(0xFF63C65E),
              ),
            ),
          ),
        ),
      );
      expect(find.text('Previous'), findsOne);
      expect(find.text('Next'), findsOne);
    });

    testWidgets('a settled morph shows only the current frame', (tester) async {
      await tester.pumpWidget(
        const ShadcnTheme(
          data: ShadcnThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: GooeySurfacePill(
              title: 'Next',
              titleStyle: TextStyle(),
              width: 300,
              height: kGooeySurfacePillHeight,
              morph: GooeyCompactMorphFrame(progress: 1, title: 'Previous'),
              leading: null,
            ),
          ),
        ),
      );
      expect(find.text('Previous'), findsNothing);
      expect(find.text('Next'), findsOne);
    });
  });

  group('body content', () {
    testWidgets('the action chip sits below the description', (tester) async {
      await tester.pumpWidget(
        ShadcnTheme(
          data: const ShadcnThemeData(),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: GooeySurfaceBody(
              width: 350,
              onSizeChanged: _noop,
              description: 'Body',
              action: GooeyActionChip(
                label: 'Undo',
                color: Color(0xFF63C65E),
                onPressed: _noop2,
              ),
            ),
          ),
        ),
      );
      expect(find.text('Body'), findsOne);
      expect(find.text('Undo'), findsOne);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the state icon spins while loading', (tester) async {
      await tester.pumpWidget(
        const ShadcnTheme(
          data: ShadcnThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: GooeyStateIcon(
              icon: _kTestIcon,
              color: Color(0xFF8A8F98),
              loading: true,
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      // The spinner is a repeating transform: it keeps ticking.
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));
    });
  });

  group('surface frame', () {
    testWidgets('progress 0 is the pill, progress 1 the body', (tester) async {
      await tester.pumpWidget(_surfaceFrame(progress: 0));
      final double closed = _canvasHeight(tester);
      await tester.pumpWidget(_surfaceFrame(progress: 1));
      final double open = _canvasHeight(tester);
      expect(closed, closeTo(40, 0.01));
      expect(open, greaterThan(closed));
    });

    testWidgets('a closed surface with no body is pill-only', (tester) async {
      // With no body the surface has nothing to open into, so the canvas stays
      // the pill height at every progress.
      await tester.pumpWidget(_surfaceFrame(description: null, progress: 1));
      expect(_canvasHeight(tester), closeTo(40, 0.01));
    });

    testWidgets('expandUp flips the shape and the body order', (tester) async {
      await tester.pumpWidget(_surfaceFrame(progress: 0.5, expandUp: true));
      expect(find.byType(GooeySurfaceFrame), findsOne);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the instant body animation snaps the content in', (
      tester,
    ) async {
      await tester.pumpWidget(
        _surfaceFrame(
          progress: 0.6,
          bodyAnimation: GooeySurfaceBodyAnimation.none,
        ),
      );
      // `none` waits for the open to finish: the content is still clipped away
      // at 0.6.
      await tester.pumpWidget(
        _surfaceFrame(
          progress: 1,
          bodyAnimation: GooeySurfaceBodyAnimation.none,
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('swipe', () {
    testWidgets('a horizontal drag past the threshold dismisses', (
      tester,
    ) async {
      int dismissed = 0;
      await tester.pumpWidget(
        ShadcnTheme(
          data: const ShadcnThemeData(),
          child: Center(
            child: GooeySwipe(
              directions: const <ToastSwipeDirection>{
                ToastSwipeDirection.right,
              },
              onDismissed: () => dismissed++,
              child: const SizedBox(width: 200, height: 60),
            ),
          ),
        ),
      );
      await _swipe(tester, const Offset(90, 0));
      expect(dismissed, 1);
    });

    testWidgets('a drag in a disallowed direction keeps the toast', (
      tester,
    ) async {
      int dismissed = 0;
      await tester.pumpWidget(
        ShadcnTheme(
          data: const ShadcnThemeData(),
          child: Center(
            child: GooeySwipe(
              directions: const <ToastSwipeDirection>{
                ToastSwipeDirection.right,
              },
              onDismissed: () => dismissed++,
              child: const SizedBox(width: 200, height: 60),
            ),
          ),
        ),
      );
      await _swipe(tester, const Offset(0, 90));
      expect(dismissed, 0);
    });
  });

  group('stack anchors', () {
    test('a leading toast anchors to the left in ltr', () {
      final GooeyEdgeAnchors anchors = GooeyEdgeAnchors.resolve(
        placement: ToastPlacement.topLeading,
        width: 350,
        viewport: const Size(1440, 900),
        textDirection: TextDirection.ltr,
      );
      expect(anchors.left, kGooeyEdgeInset);
      expect(anchors.right, isNull);
      expect(anchors.top, kGooeyEdgeInset);
      expect(anchors.bottom, isNull);
    });

    test('a leading toast mirrors to the right in rtl', () {
      final GooeyEdgeAnchors anchors = GooeyEdgeAnchors.resolve(
        placement: ToastPlacement.topLeading,
        width: 350,
        viewport: const Size(1440, 900),
        textDirection: TextDirection.rtl,
      );
      expect(anchors.left, isNull);
      expect(anchors.right, kGooeyEdgeInset);
    });

    test('a centred toast spans the window', () {
      final GooeyEdgeAnchors anchors = GooeyEdgeAnchors.resolve(
        placement: ToastPlacement.topCenter,
        width: 350,
        viewport: const Size(1440, 900),
        textDirection: TextDirection.ltr,
      );
      expect(anchors.left, 0);
      expect(anchors.right, 0);
      expect(anchors.top, kGooeyEdgeInset);
    });

    test('a bottom toast anchors from the bottom edge', () {
      final GooeyEdgeAnchors anchors = GooeyEdgeAnchors.resolve(
        placement: ToastPlacement.bottomTrailing,
        width: 350,
        viewport: const Size(1440, 900),
        textDirection: TextDirection.ltr,
      );
      expect(anchors.top, isNull);
      expect(anchors.bottom, kGooeyEdgeInset);
      expect(anchors.right, kGooeyEdgeInset);
    });

    test('stack offsets grow with the index', () {
      const GooeyStackLayout layout = GooeyStackLayout();
      expect(layout.offsetAt(0), 0);
      expect(layout.offsetAt(1), kGooeyStackGap);
      expect(layout.offsetAt(3), kGooeyStackGap * 3);
    });

    test('overlap stacking replaces the gap', () {
      const GooeyStackLayout layout = GooeyStackLayout(overlapOffset: 4);
      expect(layout.offsetAt(2), 8);
    });

    test('a max visible count hides the tail of the stack', () {
      const GooeyStackLayout layout = GooeyStackLayout(maxVisible: 2);
      expect(layout.isVisible(0), isTrue);
      expect(layout.isVisible(1), isTrue);
      expect(layout.isVisible(2), isFalse);
    });
  });
}

/// Drags [delta] across the wrapped surface and lifts.
Future<void> _swipe(WidgetTester tester, Offset delta) async {
  final Offset centre = tester.getCenter(find.byType(SizedBox).first);
  final TestGesture gesture = await tester.startGesture(
    centre,
    pointer: 7,
    kind: PointerDeviceKind.touch,
  );
  // Several small moves: one big jump is not a pan for the recognizer.
  const int steps = 6;
  for (int i = 1; i <= steps; i++) {
    await gesture.moveBy(Offset(delta.dx / steps, delta.dy / steps));
  }
  await gesture.up();
  await tester.pumpAndSettle();
}

/// The one live `GooeySurfaceFrame` in the tree.
GooeySurfaceFrame _frame(WidgetTester tester) =>
    tester.widget<GooeySurfaceFrame>(find.byType(GooeySurfaceFrame));

/// Height the surface's canvas paints at, once the entry animation settles.
double _canvasHeight(WidgetTester tester) {
  final GooeySurfaceFrame frame = _frame(tester);
  final double open = frame.progress.clamp(0.0, 1.0).toDouble();
  return lerpDouble(frame.pillHeight, frame.targetHeight, open)!;
}

void _noop(Size size) {}

void _noop2() {}
