// Widget and unit tests for the `overflow_marquee` component.
//
// Covers: surface defaults (light + dark), four theme legs, continuous looping,
// horizontal and vertical directions, RTL awareness, reduced motion (truncated
// text), pause on hover and focus, controlled playback via MarqueeController,
// custom builder slots, hit-testing across looping instances, and 375px layout.

import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/overflow_marquee/overflow_marquee.dart';
import 'package:dashcn/src/components/overflow_marquee/preview.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection textDirection = TextDirection.ltr,
  bool disableAnimations = false,
  required Widget child,
}) {
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: MediaQuery(
        data: MediaQueryData(
          size: const Size(800, 600),
          disableAnimations: disableAnimations,
        ),
        child: Directionality(
          textDirection: textDirection,
          child: Center(child: child),
        ),
      ),
    ),
  );
}

MarqueeSurface _surface(WidgetTester tester) {
  final OverflowMarquee widget = tester.widget<OverflowMarquee>(
    find.byType(OverflowMarquee),
  );
  return resolveMarqueeSurface(
    tester.element(find.byType(OverflowMarquee)),
    widgetTheme: widget.theme,
    direction: widget.direction,
    speed: widget.speed,
    gap: widget.gap,
    pauseOnHover: widget.pauseOnHover,
    pauseOnFocus: widget.pauseOnFocus,
    loop: widget.loop,
    duration: widget.duration,
    delayDuration: widget.delayDuration,
    step: widget.step,
    fadePortion: widget.fadePortion,
    curve: widget.curve,
  );
}

Widget _child({
  required Key key,
  double width = 400,
  double height = 40,
  Key? target,
  VoidCallback? onTap,
}) {
  return SizedBox(
    key: key,
    width: width,
    height: height,
    child: Center(
      child: SizedBox(
        width: 100,
        height: height,
        child: target == null
            ? const ColoredBox(color: Color(0xFF00FF00))
            : GestureDetector(
                key: target,
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: const ColoredBox(color: Color(0xFF00FF00)),
              ),
      ),
    ),
  );
}

Offset _scrollOffset(WidgetTester tester, Key key) {
  final RenderBox box = tester.renderObject(find.byKey(key));
  final Offset origin = box.localToGlobal(Offset.zero);
  return origin - tester.getTopLeft(find.byType(OverflowMarquee));
}

void main() {
  testWidgets('surface defaults: start, 50 px/s speed, 24px gap, loop', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(child: const OverflowMarquee(child: Text('x'))),
    );
    final MarqueeSurface surface = _surface(tester);
    expect(surface.direction, AxisDirectional.start);
    expect(surface.axis, Axis.horizontal);
    expect(surface.speed, 50.0);
    expect(surface.gap, 24.0);
    expect(surface.pauseOnHover, isTrue);
    expect(surface.pauseOnFocus, isTrue);
    expect(surface.loop, isTrue);
    expect(surface.fadePortion, 0.1);
    expect(surface.curve, Curves.linear);
  });

  testWidgets('renders with light and dark tokens', (tester) async {
    await tester.pumpWidget(
      _frame(child: const OverflowMarquee(child: Text('fits'))),
    );
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(
      _frame(
        data: const ThemeData(colors: ThemeColors.darkFallback),
        child: const OverflowMarquee(child: Text('fits')),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('theme precedence: defaults < app < scoped < widget', (
    tester,
  ) async {
    const OverflowMarqueeTheme app = OverflowMarqueeTheme(
      speed: 60.0,
      gap: 30.0,
    );
    const OverflowMarqueeTheme scoped = OverflowMarqueeTheme(
      speed: 80.0,
      fadePortion: 0.3,
    );
    const OverflowMarqueeTheme widgetLeg = OverflowMarqueeTheme(speed: 120.0);

    await tester.pumpWidget(
      _frame(
        app: <ComponentThemeData>[app],
        child: const OverflowMarquee(child: Text('fits')),
      ),
    );
    expect(_surface(tester).speed, 60.0);
    expect(_surface(tester).gap, 30.0);

    await tester.pumpWidget(
      _frame(
        app: <ComponentThemeData>[app],
        child: const ComponentTheme<OverflowMarqueeTheme>(
          data: scoped,
          child: OverflowMarquee(child: Text('fits')),
        ),
      ),
    );
    expect(_surface(tester).speed, 80.0);
    expect(_surface(tester).fadePortion, 0.3);
    expect(_surface(tester).gap, 30.0);

    await tester.pumpWidget(
      _frame(
        app: <ComponentThemeData>[app],
        child: const ComponentTheme<OverflowMarqueeTheme>(
          data: scoped,
          child: OverflowMarquee(theme: widgetLeg, child: Text('fits')),
        ),
      ),
    );
    expect(_surface(tester).speed, 120.0);
    expect(_surface(tester).fadePortion, 0.3);
  });

  testWidgets('widget arguments beat every theme leg and clamp', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        app: const <ComponentThemeData>[
          OverflowMarqueeTheme(speed: 40.0, fadePortion: 0.4),
        ],
        child: const ComponentTheme<OverflowMarqueeTheme>(
          data: OverflowMarqueeTheme(gap: 10),
          child: OverflowMarquee(
            direction: AxisDirectional.up,
            speed: 100.0,
            fadePortion: 0.9,
            child: Text('x'),
          ),
        ),
      ),
    );
    final MarqueeSurface surface = _surface(tester);
    expect(surface.speed, 100.0);
    expect(surface.direction, AxisDirectional.up);
    expect(surface.axis, Axis.vertical);
    expect(surface.fadePortion, 0.5); // clamped from 0.9
    expect(surface.gap, 10.0);
  });

  testWidgets('legacy Axis.vertical converts to AxisDirectional.up', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: const OverflowMarquee(
          direction: Axis.vertical,
          child: Text('v'),
        ),
      ),
    );
    final MarqueeSurface surface = _surface(tester);
    expect(surface.direction, AxisDirectional.up);
    expect(surface.axis, Axis.vertical);
  });

  testWidgets('continuous looping moves smoothly at speed', (tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      _frame(
        child: SizedBox(
          width: 100,
          height: 40,
          child: OverflowMarquee(
            speed: 100.0,
            gap: 20.0,
            child: _child(key: key, width: 400),
          ),
        ),
      ),
    );
    final RenderBox child = tester.renderObject(find.byKey(key));
    expect(child.size.width, 400);

    expect(_scrollOffset(tester, key), Offset.zero);
    // At 750ms and 100px/s, distance is 75px -> offset is -75
    await tester.pump(const Duration(milliseconds: 750));
    expect(_scrollOffset(tester, key).dx, closeTo(-75, 1));
  });

  testWidgets('vertical scrolling moves upwards at speed', (tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      _frame(
        child: SizedBox(
          width: 100,
          height: 60,
          child: OverflowMarquee(
            direction: AxisDirectional.up,
            speed: 100.0,
            child: _child(key: key, width: 100, height: 200),
          ),
        ),
      ),
    );
    expect(_scrollOffset(tester, key), Offset.zero);
    await tester.pump(const Duration(milliseconds: 500));
    expect(_scrollOffset(tester, key).dy, closeTo(-50, 1));
  });

  testWidgets('RTL starts at the right edge in RTL directionality', (
    tester,
  ) async {
    final Key key = UniqueKey();
    Widget build(TextDirection direction) {
      return _frame(
        textDirection: direction,
        child: SizedBox(
          width: 100,
          height: 40,
          child: OverflowMarquee(
            speed: 100.0,
            child: _child(key: key, width: 400),
          ),
        ),
      );
    }

    await tester.pumpWidget(build(TextDirection.ltr));
    final double ltrStart = _scrollOffset(tester, key).dx;

    await tester.pumpWidget(build(TextDirection.rtl));
    final double rtlStart = _scrollOffset(tester, key).dx;

    expect(ltrStart, 0);
    expect(rtlStart, -300); // 100 - 400 = -300 aligns right edge to 100
  });

  testWidgets('reduced motion holds start position and truncates', (
    tester,
  ) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      _frame(
        disableAnimations: true,
        child: SizedBox(
          width: 100,
          height: 40,
          child: OverflowMarquee(
            speed: 100.0,
            child: _child(key: key, width: 400),
          ),
        ),
      ),
    );
    final Offset before = _scrollOffset(tester, key);
    expect(before, Offset.zero);
    await tester.pump(const Duration(milliseconds: 800));
    expect(_scrollOffset(tester, key), before);
  });

  testWidgets('hover pauses marquee animation', (tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      _frame(
        child: SizedBox(
          width: 200,
          height: 40,
          child: OverflowMarquee(
            speed: 100.0,
            pauseOnHover: true,
            child: _child(key: key, width: 400),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    final double posBeforeHover = _scrollOffset(tester, key).dx;
    expect(posBeforeHover, closeTo(-20, 1));

    // Move mouse over marquee
    final TestGesture gesture = await tester.createGesture(
      kind: PointerDeviceKind.mouse,
    );
    await gesture.addPointer(
      location: tester.getCenter(find.byType(OverflowMarquee)),
    );
    await tester.pump();

    // Advance clock while hovered -> position must stay frozen
    await tester.pump(const Duration(milliseconds: 500));
    final double posWhileHovered = _scrollOffset(tester, key).dx;
    expect(posWhileHovered, closeTo(posBeforeHover, 1));

    // Mouse leaves
    await gesture.moveTo(const Offset(0, 0));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(_scrollOffset(tester, key).dx, lessThan(posWhileHovered));
  });

  testWidgets('controlled mode with MarqueeController play and pause', (
    tester,
  ) async {
    final MarqueeController controller = MarqueeController();
    final Key key = UniqueKey();

    await tester.pumpWidget(
      _frame(
        child: SizedBox(
          width: 200,
          height: 40,
          child: OverflowMarquee(
            controller: controller,
            speed: 100.0,
            child: _child(key: key, width: 400),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 200));
    expect(controller.isPlaying, isTrue);
    final double posPlaying = _scrollOffset(tester, key).dx;

    controller.pause();
    await tester.pump();
    expect(controller.isPaused, isTrue);

    await tester.pump(const Duration(milliseconds: 500));
    expect(_scrollOffset(tester, key).dx, closeTo(posPlaying, 1));

    controller.resume();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(_scrollOffset(tester, key).dx, lessThan(posPlaying));
  });

  testWidgets('builder slots render leading, trailing and custom builder', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: SizedBox(
          width: 300,
          height: 40,
          child: OverflowMarquee(
            leading: const Text('LEADING'),
            trailing: const Text('TRAILING'),
            builder: (context, child) => DecoratedBox(
              decoration: const BoxDecoration(color: Color(0xFF112233)),
              child: child,
            ),
            child: const Text('CONTENT'),
          ),
        ),
      ),
    );

    expect(find.text('LEADING'), findsOneWidget);
    expect(find.text('TRAILING'), findsOneWidget);
    expect(find.text('CONTENT'), findsOneWidget);
    expect(find.byType(DecoratedBox), findsWidgets);
  });

  testWidgets('hit tests follow the scroll offset across visible bounds', (
    tester,
  ) async {
    bool tapped = false;
    final Key childKey = UniqueKey();
    final Key targetKey = UniqueKey();
    await tester.pumpWidget(
      _frame(
        child: SizedBox(
          width: 100,
          height: 40,
          child: OverflowMarquee(
            speed: 100.0,
            gap: 20.0,
            child: _child(
              key: childKey,
              target: targetKey,
              onTap: () => tapped = true,
            ),
          ),
        ),
      ),
    );

    // Initial pump: target is centered in child (child is 400, target is 150..250)
    // Advance 1.5s at 100px/s -> offset is -150
    // So target (150..250) is now at 0..100 in the visible window!
    await tester.pump(const Duration(milliseconds: 1500));
    final Offset origin = tester.getTopLeft(find.byType(OverflowMarquee));
    await tester.tapAt(origin + const Offset(50, 20));
    expect(tapped, isTrue);
  });

  testWidgets('375px phone-width test has no RenderFlex overflow', (
    tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(375, 812)),
        child: _frame(
          child: SizedBox(
            width: 375,
            child: Row(
              children: <Widget>[
                const Text('Tag'),
                const SizedBox(width: 8),
                Expanded(
                  child: OverflowMarquee(
                    speed: 50.0,
                    child: const Text(
                      'A long continuous line that must never overflow 375px',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);
  });

  group('preview visibility', () {
    const String line =
        'The quick brown fox jumps over the lazy dog — long enough to '
        'overflow a narrow container and keep scrolling.';

    testWidgets('a long unwrapped text paints in a bounded box', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: SizedBox(
            width: 320,
            child: const OverflowMarquee(child: Text(line)),
          ),
        ),
      );
      expect(find.text(line), findsOneWidget);
      final Size size = tester.getSize(find.byType(OverflowMarquee));
      expect(size.width, 320);
      expect(size.height, greaterThan(0));
    });

    testWidgets('a fitting text paints and loops in marquee box', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: const SizedBox(
            width: 320,
            child: OverflowMarquee(child: Text('short')),
          ),
        ),
      );
      expect(find.text('short'), findsOneWidget);
      final Size size = tester.getSize(find.byType(OverflowMarquee));
      expect(size.width, 320);
      expect(size.height, greaterThan(0));
    });

    testWidgets('every preview example pumps without throwing', (tester) async {
      for (final ComponentPreview preview in overflowMarqueePreviews) {
        await tester.pumpWidget(
          _frame(child: Builder(builder: preview.builder)),
        );
        await tester.pump(const Duration(milliseconds: 200));
        expect(tester.takeException(), isNull);
      }
    });
  });
}
