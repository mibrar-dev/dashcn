import 'package:docs/motion/ease.dart';
import 'package:docs/motion/motion_scope.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/docs_header.dart';
import 'package:docs/widgets/heading_anchor.dart';
import 'package:docs/widgets/theme_switch_transition.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  test('durations match the amended motion spec (dashcn-site)', () {
    expect(kDurationFast, const Duration(milliseconds: 150));
    expect(kDurationPopper, const Duration(milliseconds: 100));
    expect(kDurationPalette, const Duration(milliseconds: 200));
    expect(kDurationHeadingAnchor, const Duration(milliseconds: 200));
    expect(kDurationTheme, const Duration(milliseconds: 300));
    expect(kDurationThemeSwitch, const Duration(milliseconds: 200));
    expect(kDurationCopyFeedback, const Duration(milliseconds: 2000));
    // Removed motions have no constants: no route/reveal/hero/marquee/float.
    expect(kEaseOutExpo, isA<Cubic>());
    expect(kEaseStandard, Curves.fastOutSlowIn);
  });

  testWidgets('an explicit reduced-motion override wins', (
    WidgetTester tester,
  ) async {
    late bool reduced;
    late Duration duration;
    late double offset;
    await tester.pumpWidget(
      MotionScope(
        prefersReducedMotion: true,
        child: Builder(
          builder: (BuildContext context) {
            reduced = MotionScope.of(context);
            duration = context.motionDuration(kDurationTheme);
            offset = context.motionOffset(12);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(reduced, isTrue);
    expect(duration, kDurationFast);
    expect(offset, 0);
  });

  testWidgets('MediaQuery.disableAnimations reduces motion', (
    WidgetTester tester,
  ) async {
    late bool reduced;
    late Duration duration;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MotionScope(
          child: Builder(
            builder: (BuildContext context) {
              reduced = MotionScope.of(context);
              duration = context.motionDuration(kDurationTheme);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    expect(reduced, isTrue);
    expect(duration, kDurationFast);
  });

  testWidgets('motion passes through when nothing asks to reduce', (
    WidgetTester tester,
  ) async {
    late bool reduced;
    late Duration duration;
    late double offset;
    await tester.pumpWidget(
      MotionScope(
        prefersReducedMotion: false,
        child: Builder(
          builder: (BuildContext context) {
            reduced = MotionScope.of(context);
            duration = context.motionDuration(kDurationTheme);
            offset = context.motionOffset(12);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(reduced, isFalse);
    expect(duration, kDurationTheme);
    expect(offset, 12);
  });

  test('palette route caps its transition under reduced motion', () {
    Widget build(BuildContext context) => const SizedBox.shrink();
    final DocsPaletteRoute normal = DocsPaletteRoute(builder: build);
    final DocsPaletteRoute reduced = DocsPaletteRoute(
      builder: build,
      reduceMotion: true,
    );
    expect(normal.transitionDuration, kDurationPalette);
    expect(normal.reverseTransitionDuration, kDurationFast);
    expect(reduced.transitionDuration, kDurationFast);
    expect(reduced.reverseTransitionDuration, kDurationFast);
  });

  testWidgets('reduced motion swaps the app theme instantly', (
    WidgetTester tester,
  ) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await pumpDocsApp(tester);
    final ThemeSwitchTransition transition = tester
        .widget<ThemeSwitchTransition>(
          find.byType(ThemeSwitchTransition).first,
        );
    expect(
      transition.duration,
      Duration.zero,
      reason: 'the shell snapshot transition is instant under reduced motion',
    );
  });

  testWidgets('reduced motion caps the heading anchor reveal to 150 ms', (
    WidgetTester tester,
  ) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    final DocsRouterDelegate delegate = await pumpDocsApp(tester);
    await goTo(tester, delegate, '/docs');
    final AnimatedOpacity opacity = tester.widget<AnimatedOpacity>(
      find
          .descendant(
            of: find.byType(HeadingAnchor),
            matching: find.byType(AnimatedOpacity),
          )
          .first,
    );
    expect(opacity.duration, kDurationFast);
  });

  testWidgets('the mobile drawer animates over 200 ms', (
    WidgetTester tester,
  ) async {
    await pumpDocsApp(tester, width: 800, height: 900);
    await tester.tap(find.text('Menu'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    // Drawer scrim fades and panel slides out over 200 ms (popper x2).
    final List<AnimatedSlide> slides = tester
        .widgetList<AnimatedSlide>(find.byType(AnimatedSlide))
        .toList(growable: false);
    expect(
      slides.any(
        (AnimatedSlide s) =>
            s.duration == kDurationPopper * 2 && s.curve == kEaseStandard,
      ),
      isTrue,
      reason: 'drawer panel slides over 200 ms',
    );
    expect(find.byType(DocsMobileNav), findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('the mobile drawer close animates over 200 ms', (
    WidgetTester tester,
  ) async {
    Finder headerToggle(String label) => find.descendant(
      of: find.byType(DocsHeader),
      matching: find.text(label),
    );
    Finder getScrimFade() => find.ancestor(
      of: find.byWidgetPredicate(
        (Widget w) => w is ColoredBox && w.color == const Color(0x66000000),
      ),
      matching: find.byType(FadeTransition),
    );
    Finder getPanelSlide() => find.ancestor(
      of: find.byType(DocsMobileNav),
      matching: find.byType(SlideTransition),
    );
    await pumpDocsApp(tester, width: 375, height: 900);
    await tester.tap(headerToggle('Menu'));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.byType(DocsMobileNav), findsOneWidget);

    await tester.tap(headerToggle('Close'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    // The panel is still mounted and moving mid-close: part slid out and
    // part faded, not snapped away.
    expect(find.byType(DocsMobileNav), findsOneWidget);
    final double dx = tester
        .widget<SlideTransition>(getPanelSlide())
        .position
        .value
        .dx;
    expect(dx, greaterThan(-1));
    expect(dx, lessThan(0));
    final double opacity = tester
        .widget<FadeTransition>(getScrimFade())
        .opacity
        .value;
    expect(opacity, greaterThan(0));
    expect(opacity, lessThan(1));
    // After the ~200 ms slide-out/fade-out the drawer unmounts.
    await tester.pumpAndSettle();
    expect(find.byType(DocsMobileNav), findsNothing);
  });

  testWidgets('a stale drawer-close timer never cuts a newer close short', (
    WidgetTester tester,
  ) async {
    Finder headerToggle(String label) => find.descendant(
      of: find.byType(DocsHeader),
      matching: find.text(label),
    );
    Finder getPanelSlide() => find.ancestor(
      of: find.byType(DocsMobileNav),
      matching: find.byType(SlideTransition),
    );
    await pumpDocsApp(tester, width: 375, height: 900);
    await tester.tap(headerToggle('Menu'));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(headerToggle('Close')); // close#1 arms its unmount timer
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(headerToggle('Menu')); // reopen mid-close
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(headerToggle('Close')); // close#2 restarts the animation
    await tester.pump();
    // close#1's timer fires here (~250 ms after close#1): the drawer must
    // still be mounted and mid-slide for close#2, not snapped away.
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(DocsMobileNav), findsOneWidget);
    final double dx = tester
        .widget<SlideTransition>(getPanelSlide())
        .position
        .value
        .dx;
    expect(dx, greaterThan(-1));
    expect(dx, lessThan(0));
    await tester.pumpAndSettle();
    expect(find.byType(DocsMobileNav), findsNothing);
  });
}
