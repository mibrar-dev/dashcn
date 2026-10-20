// Exit animations and per-instance overrides: MotionPresence keeps the child
// mounted while the exit plays, MotionCollapse shrinks it away, MotionSpec
// retimes or disables either, and the theme category legs retime them from
// one place. Reduced motion collapses everything to an instant swap.

import 'package:dashcn/src/primitives/motion/motion_collapse.dart';
import 'package:dashcn/src/primitives/motion/motion_presence.dart';
import 'package:dashcn/src/primitives/motion/motion_spec.dart';
import 'package:dashcn/src/theme/motion.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpExit(
  WidgetTester tester,
  Widget child, {
  bool disabled = false,
  ThemeData theme = const ThemeData(),
}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(800, 600),
      ).copyWith(disableAnimations: disabled),
      child: Theme(
        data: theme,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: child),
        ),
      ),
    ),
  );
}

void main() {
  group('MotionTokens categories', () {
    test('unset legs reproduce the caller defaults', () {
      const MotionTokens tokens = MotionTokens();
      expect(
        tokens.resolveOverlayEnterDuration(const Duration(milliseconds: 100)),
        const Duration(milliseconds: 100),
      );
      expect(
        tokens.resolveOverlayExitDuration(const Duration(milliseconds: 200)),
        const Duration(milliseconds: 200),
      );
      expect(
        tokens.resolveStateDuration(const Duration(milliseconds: 150)),
        const Duration(milliseconds: 150),
      );
    });

    test('category legs override the caller defaults', () {
      const MotionTokens tokens = MotionTokens(
        overlayEnterDuration: Duration(milliseconds: 500),
        overlayExitDuration: Duration(milliseconds: 400),
        stateDuration: Duration(milliseconds: 300),
      );
      expect(
        tokens.resolveOverlayEnterDuration(const Duration(milliseconds: 100)),
        const Duration(milliseconds: 500),
      );
      expect(
        tokens.resolveOverlayExitDuration(const Duration(milliseconds: 200)),
        const Duration(milliseconds: 400),
      );
      expect(
        tokens.resolveStateDuration(const Duration(milliseconds: 150)),
        const Duration(milliseconds: 300),
      );
    });

    test('intensity scales the category legs', () {
      const MotionTokens tokens = MotionTokens(
        intensity: MotionIntensity.expressive,
        overlayEnterDuration: Duration(milliseconds: 200),
      );
      expect(
        tokens.resolveOverlayEnterDuration(const Duration(milliseconds: 100)),
        const Duration(milliseconds: 300),
      );
    });

    test('explicit per-instance legs win over categories', () {
      const MotionTokens tokens = MotionTokens(
        overlayEnterDuration: Duration(milliseconds: 500),
      );
      expect(
        tokens.resolveOverlayEnterDuration(
          const Duration(milliseconds: 100),
          override: const Duration(milliseconds: 50),
        ),
        const Duration(milliseconds: 50),
      );
    });

    test('curves resolve per-instance, category, then base', () {
      const MotionTokens tokens = MotionTokens(overlayExitCurve: Curves.linear);
      expect(tokens.resolveOverlayExitCurve(Curves.easeIn), Curves.linear);
      expect(
        tokens.resolveOverlayExitCurve(
          Curves.easeIn,
          override: Curves.linearToEaseOut,
        ),
        Curves.linearToEaseOut,
      );
      expect(
        const MotionTokens().resolveOverlayExitCurve(Curves.easeIn),
        Curves.easeIn,
      );
    });

    test('copyWith, == and hashCode cover the new legs', () {
      const MotionTokens base = MotionTokens();
      final MotionTokens changed = base.copyWith(
        stateDuration: const Duration(milliseconds: 300),
      );
      expect(changed, isNot(base));
      expect(changed.stateDuration, const Duration(milliseconds: 300));
      expect(base.copyWith(), base);
      expect(changed.hashCode, isNot(base.hashCode));
    });
  });

  group('MotionSpec', () {
    testWidgets('resolves durations and honours reduced motion', (
      WidgetTester tester,
    ) async {
      Duration? enter;
      await pumpExit(
        tester,
        Builder(
          builder: (BuildContext context) {
            enter = const MotionSpec(
              enterDuration: Duration(milliseconds: 500),
            ).resolveEnterDuration(context, const Duration(milliseconds: 100));
            return const SizedBox.shrink();
          },
        ),
      );
      expect(enter, const Duration(milliseconds: 500));
    });

    testWidgets('reduced motion resolves to zero', (WidgetTester tester) async {
      Duration? enter;
      Duration? exit;
      await pumpExit(
        tester,
        Builder(
          builder: (BuildContext context) {
            const MotionSpec spec = MotionSpec(
              duration: Duration(milliseconds: 500),
            );
            enter = spec.resolveEnterDuration(
              context,
              const Duration(milliseconds: 100),
            );
            exit = spec.resolveExitDuration(
              context,
              const Duration(milliseconds: 100),
            );
            return const SizedBox.shrink();
          },
        ),
        disabled: true,
      );
      expect(enter, Duration.zero);
      expect(exit, Duration.zero);
    });

    testWidgets('disabled never animates', (WidgetTester tester) async {
      bool? animates;
      await pumpExit(
        tester,
        Builder(
          builder: (BuildContext context) {
            animates = const MotionSpec(disabled: true).animates(context);
            return const SizedBox.shrink();
          },
        ),
      );
      expect(animates, isFalse);
    });
  });

  group('MotionPresence', () {
    testWidgets('exit keeps the child mounted, then removes it', (
      WidgetTester tester,
    ) async {
      var exited = 0;
      await pumpExit(
        tester,
        MotionPresence(
          visible: true,
          onExited: () => exited++,
          child: const Text('banner'),
        ),
      );
      expect(find.text('banner'), findsOneWidget);
      // Let the enter finish first: the exit reverses from the live value.
      await tester.pumpAndSettle();
      await pumpExit(
        tester,
        MotionPresence(
          visible: false,
          onExited: () => exited++,
          child: const Text('banner'),
        ),
      );
      // Mid-exit the child is still mounted (exit is playing).
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('banner'), findsOneWidget);
      expect(exited, 0);
      await tester.pumpAndSettle();
      expect(find.text('banner'), findsNothing);
      expect(exited, 1);
    });

    testWidgets('re-show mid-exit replays the enter', (
      WidgetTester tester,
    ) async {
      Widget frame(bool visible) =>
          MotionPresence(visible: visible, child: const Text('banner'));
      await pumpExit(tester, frame(true));
      // Let the enter finish first: the exit reverses from the live value.
      await tester.pumpAndSettle();
      await pumpExit(tester, frame(false));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('banner'), findsOneWidget);
      await pumpExit(tester, frame(true));
      await tester.pumpAndSettle();
      expect(find.text('banner'), findsOneWidget);
    });

    testWidgets('reduced motion swaps instantly with no lingering ticker', (
      WidgetTester tester,
    ) async {
      var exited = 0;
      await pumpExit(
        tester,
        MotionPresence(
          visible: true,
          onExited: () => exited++,
          child: const Text('banner'),
        ),
        disabled: true,
      );
      await pumpExit(
        tester,
        MotionPresence(
          visible: false,
          onExited: () => exited++,
          child: const Text('banner'),
        ),
        disabled: true,
      );
      await tester.pump();
      expect(find.text('banner'), findsNothing);
      expect(exited, 1);
    });

    testWidgets('custom exit builder runs on removal', (
      WidgetTester tester,
    ) async {
      var built = 0;
      Widget frame(bool visible) => MotionPresence(
        visible: visible,
        exit: (Widget child, Animation<double> animation) {
          built++;
          return FadeTransition(opacity: animation, child: child);
        },
        child: const Text('banner'),
      );
      await pumpExit(tester, frame(true));
      expect(built, 0);
      await pumpExit(tester, frame(false));
      await tester.pump(const Duration(milliseconds: 50));
      expect(built, greaterThan(0));
      await tester.pumpAndSettle();
      expect(find.text('banner'), findsNothing);
    });
  });

  group('MotionCollapse', () {
    testWidgets('collapse shrinks the height, then removes the child', (
      WidgetTester tester,
    ) async {
      var exited = 0;
      await pumpExit(
        tester,
        MotionCollapse(
          visible: true,
          onExited: () => exited++,
          child: const SizedBox(width: 200, height: 48, child: Text('error')),
        ),
      );
      expect(find.text('error'), findsOneWidget);
      await pumpExit(
        tester,
        MotionCollapse(
          visible: false,
          onExited: () => exited++,
          child: const SizedBox(width: 200, height: 48, child: Text('error')),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      // Mid-exit the child is still mounted but no longer full height.
      expect(find.text('error'), findsOneWidget);
      final double factor = tester
          .widget<SizeTransition>(find.byType(SizeTransition))
          .sizeFactor
          .value;
      expect(factor, lessThan(1));
      expect(factor, greaterThan(0));
      expect(exited, 0);
      await tester.pumpAndSettle();
      expect(find.text('error'), findsNothing);
      expect(exited, 1);
    });

    testWidgets('reduced motion swaps instantly', (WidgetTester tester) async {
      await pumpExit(
        tester,
        const MotionCollapse(
          visible: true,
          child: SizedBox(height: 48, child: Text('error')),
        ),
        disabled: true,
      );
      await pumpExit(
        tester,
        const MotionCollapse(
          visible: false,
          child: SizedBox(height: 48, child: Text('error')),
        ),
        disabled: true,
      );
      await tester.pump();
      expect(find.text('error'), findsNothing);
    });
  });
}
