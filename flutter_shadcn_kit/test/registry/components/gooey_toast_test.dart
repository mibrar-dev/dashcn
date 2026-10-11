// Widget tests for the `gooey_toast` component (P7-G2 port from `main`).
//
// The ported controller inserts into the ROOT overlay, so every test pumps a
// `Navigator` (where the root overlay comes from) and asserts on the real
// overlay tree — that is what the window-edge anchoring means.
//
// Covers: lifecycle with the hold, hover pause, dismiss, every variant's tone,
// the action chip callback, the loading → success promise morph, the six
// positions, RTL mirroring, the presets, the single merged silhouette, reduced
// motion, and no toast before the trigger.

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/app/app.dart';
import 'package:flutter_shadcn_kit/registry/components/gooey_toast/gooey_toast.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_chip.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_frame.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_shape.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_surface.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [total] milliseconds in 100ms slices.
///
/// One big jump translates into a single frame, and the ticker measures its
/// elapsed time per frame — so the open animation would never reach 1.0. Real
/// usage ticks ~every frame, so the test does too.
Future<void> _advance(WidgetTester tester, Duration total) async {
  int remaining = total.inMilliseconds;
  while (remaining > 0) {
    final int step = remaining < 100 ? remaining : 100;
    await tester.pump(Duration(milliseconds: step));
    remaining -= step;
  }
}

/// Rect of the one live gooey surface (the pill while it is closed).
Rect _surfaceRect(WidgetTester tester) =>
    tester.getRect(find.byType(GooeySurface).first);

/// Whether the live gooey surface has opened.
///
/// The body content is built (and measured) even while the surface is closed,
/// so presence of the text says nothing; the open progress does.
bool _isOpen(WidgetTester tester) {
  final List<Element> frames = find
      .byType(GooeySurfaceFrame)
      .evaluate()
      .toList();
  if (frames.isEmpty) {
    return false;
  }
  return (frames.first.widget as GooeySurfaceFrame).progress > 0.5;
}

Widget _frame({
  required GooeyToastController controller,
  GooeyToastTheme? theme,
  TextDirection direction = TextDirection.ltr,
}) {
  return ShadcnApp(
    home: Directionality(
      textDirection: direction,
      child: GooeyToastLayer(
        controller: controller,
        theme: theme,
        child: const SizedBox.shrink(),
      ),
    ),
  );
}

/// Forces reduced motion at the platform level and restores it afterwards.
///
/// The toast's overlay entry sits above every widget below `ShadcnApp`, so a
/// `MediaQuery` inside the test tree is invisible to it; the platform dispatcher
/// is what `MediaQuery.fromView` reads instead.
void testReducedMotion(
  String description,
  WidgetTesterCallback body, {
  bool? skip,
}) {
  testWidgets(description, (WidgetTester tester) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(() {
      tester.platformDispatcher.clearAccessibilityFeaturesTestValue();
    });
    await body(tester);
  }, skip: skip);
}

GooeyToastOptions _options({
  String title = 'Saved',
  String? description,
  GooeyToastState state = GooeyToastState.success,
  GooeyToastPosition position = GooeyToastPosition.center,
  GooeyToastExpandDirection direction = GooeyToastExpandDirection.bottom,
  Duration duration = const Duration(seconds: 30),
  GooeyAutopilot? autopilot = const GooeyAutopilot(),
  GooeyToastAnimationStyle? animationStyle,
}) {
  return GooeyToastOptions(
    title: title,
    description: description,
    state: state,
    position: position,
    expandDirection: direction,
    duration: duration,
    autopilot: autopilot,
    animationStyle: animationStyle,
  );
}

void main() {
  group('lifecycle', () {
    testWidgets('nothing renders before a toast is shown', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1440, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      await _advance(tester, const Duration(seconds: 3));
      expect(find.text('Saved'), findsNothing);
      controller.dispose();
    });

    testWidgets('pill → expanding → expanded → collapse', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1440, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(title: 'Saved', description: 'Everything is in sync.'),
      );

      // Enters as a compact pill: the body content is built but clipped to
      // zero height and transparent, exactly like the reference.
      await tester.pump();
      expect(find.text('Saved'), findsOne);
      expect(_isOpen(tester), false);

      // Opens past the expand delay (150ms) + open duration (600ms).
      await _advance(tester, const Duration(milliseconds: 900));
      expect(_isOpen(tester), true);
      expect(find.text('Everything is in sync.'), findsOne);

      // Holds while open (collapse delay 4s; probed at 2s).
      await _advance(tester, const Duration(milliseconds: 2000));
      expect(_isOpen(tester), true);

      // Collapses back into the pill.
      await _advance(tester, const Duration(milliseconds: 2700));
      await _advance(tester, const Duration(milliseconds: 900));
      expect(_isOpen(tester), false);
      expect(find.text('Saved'), findsOne);
      controller.dispose();
    });

    testWidgets('hover keeps the body open and pauses the countdown', (
      tester,
    ) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.binding.setSurfaceSize(const Size(1440, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_frame(controller: controller));
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(title: 'Saved', description: 'Hold me'),
        duration: const Duration(milliseconds: 600),
      );
      await _advance(tester, const Duration(milliseconds: 900));
      expect(_isOpen(tester), true);

      final TestGesture gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await _advance(tester, const Duration(milliseconds: 3000));
      expect(controller.activeToasts, isNotEmpty);
      expect(_isOpen(tester), true);
      controller.dispose();
    });

    testWidgets('dismiss removes the entry', (tester) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      final String id = controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(title: 'Bye'),
      );
      expect(controller.containsToast(id), isTrue);
      controller.dismiss(id);
      await tester.pump();
      expect(controller.containsToast(id), isFalse);
      expect(find.text('Bye'), findsNothing);
      controller.dispose();
    });
  });

  group('variants', () {
    testWidgets('each state paints its own tone', (tester) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      final BuildContext context = tester.element(find.byType(GooeyToastLayer));
      final GooeyToastTheme theme = gooeyToastThemeOf(context);
      final colors = ShadcnTheme.of(context).colors;
      final Set<Color> tones = <Color>{
        for (final GooeyToastState state in GooeyToastState.values)
          state.tone(theme, colors),
      };
      expect(tones.length, GooeyToastState.values.length);
      controller.dispose();
    });

    testWidgets('the icon bubble uses the state tone', (tester) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(title: 'Headline'),
      );
      await tester.pump();
      final GooeyStateIcon icon = tester.widget<GooeyStateIcon>(
        find.byType(GooeyStateIcon).first,
      );
      final BuildContext context = tester.element(find.byType(GooeyStateIcon));
      expect(
        icon.color,
        GooeyToastState.success.tone(
          gooeyToastThemeOf(context),
          ShadcnTheme.of(context).colors,
        ),
      );
      controller.dispose();
    });

    testWidgets('a loading toast never expands', (tester) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(
          title: 'Uploading',
          description: 'Please wait',
          state: GooeyToastState.loading,
        ),
      );
      await _advance(tester, const Duration(seconds: 4));
      // The body content is built but the surface never opens: a loading toast
      // is a pill only.
      expect(_isOpen(tester), false);
      expect(find.text('Uploading'), findsOne);
      controller.dispose();
    });
  });

  group('action', () {
    testWidgets('the action chip fires its callback', (tester) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      int pressed = 0;
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        GooeyToastOptions(
          title: 'Message sent',
          description: 'It can still be undone.',
          action: GooeyToastAction(label: 'Undo', onPressed: () => pressed++),
        ),
      );
      await _advance(tester, const Duration(milliseconds: 900));
      expect(tester.getSize(find.byType(GooeyActionChip).first).height, 28);
      // The chip is only hit-testable once the body has faded in: its content
      // is wrapped in an `IgnorePointer` until then, exactly like the
      // reference's expand gating.
      await tester.tap(find.text('Undo'));
      expect(pressed, 1);
      controller.dispose();
    });
  });

  group('promise', () {
    testWidgets('loading pill morphs into the settled state', (tester) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      final String id = controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(title: 'Uploading', state: GooeyToastState.loading),
      );
      await tester.pump(const Duration(milliseconds: 1200));
      expect(find.text('Uploading'), findsOne);

      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(title: 'Upload Complete', description: 'Your file is ready.'),
        id: id,
      );
      // Staged handoff: collapse → compact → expand.
      await _advance(tester, const Duration(milliseconds: 750));
      await _advance(tester, const Duration(milliseconds: 800));
      await _advance(tester, const Duration(milliseconds: 900));
      expect(find.text('Upload Complete'), findsOne);
      expect(find.text('Your file is ready.'), findsOne);
      expect(find.text('Uploading'), findsNothing);
      controller.dispose();
    });
  });

  group('positions', () {
    for (final GooeyToastPosition position in GooeyToastPosition.values) {
      testWidgets('${position.name} anchors at a window edge', (tester) async {
        final GooeyToastController controller = GooeyToastController();
        await tester.binding.setSurfaceSize(const Size(1440, 900));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await tester.pumpWidget(_frame(controller: controller));
        controller.showGooeyToast(
          tester.element(find.byType(GooeyToastLayer)),
          _options(position: position),
        );
        await tester.pump(const Duration(milliseconds: 100));

        final Rect rect = _surfaceRect(tester);
        // The toast is anchored to a real window edge (16px inset), not to the
        // local box of the caller, and to the top edge when it grows down.
        expect(rect.top, closeTo(16, 0.5));
        switch (position) {
          case GooeyToastPosition.left:
            expect(rect.left, closeTo(16, 0.5));
          case GooeyToastPosition.center:
            expect(rect.width, closeTo(350, 0.5));
            expect(rect.center.dx, closeTo(720, 0.5));
          case GooeyToastPosition.right:
            expect(rect.right, closeTo(1440 - 16, 0.5));
        }
        controller.dispose();
      });
    }

    testWidgets('expandDirection.top anchors to the bottom edge', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(1440, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(direction: GooeyToastExpandDirection.top),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(_surfaceRect(tester).bottom, closeTo(900 - 16, 0.5));
      controller.dispose();
    });

    testWidgets('rtl mirrors the horizontal anchor', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1440, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(
        _frame(controller: controller, direction: TextDirection.rtl),
      );
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(position: GooeyToastPosition.left),
      );
      await tester.pump(const Duration(milliseconds: 100));
      // A leading toast mirrors to the right edge under RTL, so its surface
      // starts near 1440 - 16 - 350.
      expect(_surfaceRect(tester).left, greaterThan(1000));
      controller.dispose();
    });
  });

  group('presets', () {
    testWidgets('every animation preset opens within its own duration', (
      tester,
    ) async {
      for (final GooeyToastAnimationStyle style
          in GooeyToastAnimationStyle.values) {
        final GooeyToastController controller = GooeyToastController();
        await tester.pumpWidget(_frame(controller: controller));
        controller.showGooeyToast(
          tester.element(find.byType(GooeyToastLayer)),
          _options(description: 'Curve', animationStyle: style),
        );
        await _advance(tester, style.duration);
        expect(
          _isOpen(tester),
          isTrue,
          reason: '${style.name} did not open within ${style.duration}',
        );
        controller.dismiss(controller.activeToasts.first.id);
        await tester.pump();
      }
    });

    test('presets resolve different durations and curves', () {
      final Set<Duration> durations = <Duration>{
        for (final GooeyToastAnimationStyle style
            in GooeyToastAnimationStyle.values)
          style.duration,
      };
      final Set<Curve> curves = <Curve>{
        for (final GooeyToastAnimationStyle style
            in GooeyToastAnimationStyle.values)
          style.curve,
      };
      expect(durations.length, greaterThan(1));
      expect(curves.length, GooeyToastAnimationStyle.values.length);
    });

    test('all four shape styles resolve their own roundness', () {
      final Set<double> radii = <double>{
        for (final GooeyToastShapeStyle style in GooeyToastShapeStyle.values)
          style.roundness(18, 40),
      };
      expect(radii.length, GooeyToastShapeStyle.values.length);
    });
  });

  group('silhouette', () {
    test('the pill is the whole silhouette while closed', () {
      const GooeyShapeGeometry closed = GooeyShapeGeometry(
        roundness: 24,
        pillX: 20,
        pillWidth: 200,
      );
      expect(
        closed.buildSilhouette(const Size(350, 40)).computeMetrics().length,
        1,
      );
    });

    test('open is a union (pill + body + shoulders), wider than the pill', () {
      const GooeyShapeGeometry open = GooeyShapeGeometry(
        roundness: 24,
        pillX: 20,
        pillWidth: 200,
        bodyHeight: 120,
        bodyScaleY: 1,
      );
      final Path openPath = open.buildSilhouette(const Size(350, 160));
      // No stroke and a metaball pass, so the shape is a union of sub-paths
      // (pill RR + body RR + two shoulder ovals), never a single contour.
      expect(openPath.computeMetrics().length, greaterThan(1));
      // The body grows past the pill to the full canvas width.
      expect(openPath.getBounds().width, greaterThan(200));
      expect(openPath.getBounds().width, closeTo(350, 0.5));
    });

    test('the geometry constants equal the reference', () {
      // Ported verbatim from `main`: seam overlap 4, the body attaches at
      // pillHeight-4, and the shoulder blend radius is roundness*0.62.
      expect(kGooeySeamOverlap, 4);
      const GooeyShapeGeometry open = GooeyShapeGeometry(
        roundness: 20,
        pillX: 0,
        pillWidth: 200,
        pillHeight: 40,
        bodyHeight: 120,
        bodyScaleY: 1,
      );
      final Path path = open.buildSilhouette(const Size(350, 170));
      final Rect bounds = path.getBounds();
      // The body top sits at 40-4 = 36; the shoulders bloom just below it, so
      // the visible silhouette spans from 0 down to ~40-4+120+4 = 160.
      expect(bounds.top, closeTo(0, 0.01));
      expect(bounds.bottom, greaterThan(150));
      expect(bounds.bottom, lessThanOrEqualTo(170));
    });

    test('the pill never renders shorter than its content height', () {
      // The bug in the previous rewrite: the padded pill was scaled down to
      // `pillHeight / pillBase` AND drawn at `pillHeight`, so the silhouette
      // collapsed to roughly half the pill while the text stayed full size.
      const double pillHeight = 40;
      const double blur = 24 * 0.5;
      final double pillBase = pillHeight + blur * 3;
      final GooeyShapeGeometry geometry = GooeyShapeGeometry(
        roundness: 24,
        pillWidth: 200,
        pillHeight: pillHeight,
        pillCanvasHeight: pillBase,
        pillScaleY: pillHeight / pillBase,
      );
      expect(
        geometry
            .buildSilhouette(const Size(350, pillHeight))
            .getBounds()
            .height,
        closeTo(pillHeight, 0.001),
      );
    });
  });

  group('reduced motion', () {
    testReducedMotion('drops the morph but still shows the content', (
      WidgetTester tester,
    ) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(_frame(controller: controller));
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        _options(title: 'Calm', description: 'No motion'),
      );
      // No open animation to wait out (duration is zero), only the autopilot's
      // 150ms expand delay.
      await _advance(tester, const Duration(milliseconds: 300));
      expect(_isOpen(tester), true);
      expect(find.text('No motion'), findsOne);
      controller.dispose();
    });
  });
}
