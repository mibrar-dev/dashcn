// P7-WD: theme switching is one commit, one swap, one fade.
//
// The shell used to tween the whole tree through `AnimatedTheme` (~19
// full-tree rebuilds per switch). `ThemeSwitchTransition` swaps the theme
// exactly once per commit and fades a raster snapshot of the old frame over
// the new one; reduced motion (or a zero duration) swaps instantly.
//
// These tests pump the transition in isolation with real docs theme data, so
// they do not need the app shell (and stay green while other agents reshape
// unrelated widget files).

import 'package:docs/motion/ease.dart';
import 'package:docs/motion/motion_scope.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/theme_switch_transition.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// In-memory [DocsStorage] so tests do not touch the platform bridge.
class _MemoryStorage extends DocsStorage {
  final Map<String, String> values = <String, String>{};

  @override
  String? read(String key) => values[key];

  @override
  void write(String key, String value) => values[key] = value;
}

SiteThemeModel _model() {
  final SiteThemeModel model = SiteThemeModel(storage: _MemoryStorage());
  addTearDown(model.dispose);
  return model;
}

/// Records every rebuild of a theme dependent plus the last colour seen.
class _Probe {
  int builds = 0;
  Color? background;

  Widget build() {
    return Builder(
      builder: (BuildContext context) {
        builds++;
        background = Theme.of(context).colors.background;
        // Non-zero size: a zero-size boundary has no raster to snapshot, so
        // the transition (correctly) swaps without fading.
        return const SizedBox(width: 200, height: 200);
      },
    );
  }
}

Future<void> _pumpTransition(
  WidgetTester tester,
  ThemeData data, {
  required Widget child,
  bool reducedMotion = false,
  Duration duration = kDurationThemeSwitch,
}) async {
  await tester.pumpWidget(
    // Directionality stands in for the WidgetsApp that owns it in the app.
    Directionality(
      textDirection: TextDirection.ltr,
      child: MotionScope(
        prefersReducedMotion: reducedMotion,
        child: ThemeSwitchTransition(
          data: data,
          duration: duration,
          child: child,
        ),
      ),
    ),
  );
}

/// Pumps until a snapshot overlay is showing (the fade started).
Future<void> _waitForFade(WidgetTester tester) async {
  for (int i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 16));
    if (find.byType(RawImage).evaluate().isNotEmpty) {
      return;
    }
  }
}

void main() {
  group('commits', () {
    test('a toggle, a preset and an edit notify exactly once each', () {
      final DocsState state = DocsState(storage: _MemoryStorage());
      addTearDown(state.dispose);
      int notifications = 0;
      state.addListener(() => notifications++);

      state.toggleBrightness();
      expect(notifications, 1);

      state.setPreset('tangerine');
      expect(notifications, 2);

      state.themeModel.setRadiusPx(4);
      expect(notifications, 3);

      state.themeModel.setRadiusPx(4);
      expect(notifications, 3, reason: 'no-op edits stay silent');

      state.setBrightness(Brightness.dark);
      expect(notifications, 3, reason: 'toggling twice lands back, no-op');
    });

    test('themeFor caches per document and drops on commit', () {
      final SiteThemeModel model = _model();
      final ThemeData light = model.themeFor(Brightness.light);
      expect(
        identical(model.themeFor(Brightness.light), light),
        isTrue,
        reason: 'repeated reads within one commit share one instance',
      );
      expect(
        identical(model.themeFor(Brightness.dark), light),
        isFalse,
        reason: 'each brightness resolves its own theme',
      );

      model.selectPreset('tangerine');
      expect(
        identical(model.themeFor(Brightness.light), light),
        isFalse,
        reason: 'a commit resolves fresh themes',
      );
      expect(
        identical(
          model.themeFor(Brightness.light),
          model.themeFor(Brightness.light),
        ),
        isTrue,
      );
    });
  });

  group('transition', () {
    testWidgets('a switch rebuilds content once, fades, then completes', (
      WidgetTester tester,
    ) async {
      final SiteThemeModel model = _model();
      final ThemeData light = model.themeFor(Brightness.light);
      final ThemeData dark = model.themeFor(Brightness.dark);
      final _Probe probe = _Probe();
      // One child instance: a new instance would rebuild content on its own
      // (the identical-instance fast path), which is not the swap cost.
      final Widget child = probe.build();
      await _pumpTransition(tester, light, child: child);
      await tester.pumpAndSettle();
      expect(probe.background, light.colors.background);
      probe.builds = 0;

      await _pumpTransition(tester, dark, child: child);
      await _waitForFade(tester);
      expect(
        find.byType(RawImage),
        findsOneWidget,
        reason: 'the old frame fades over the new one',
      );
      expect(
        probe.builds,
        1,
        reason: 'one swap per commit, not one rebuild per frame',
      );

      await tester.pumpAndSettle();
      expect(find.byType(RawImage), findsNothing);
      expect(probe.background, dark.colors.background);
      expect(
        probe.builds,
        1,
        reason: 'dropping the snapshot must not rebuild content',
      );
    });

    testWidgets('reduced motion swaps instantly with no snapshot', (
      WidgetTester tester,
    ) async {
      final SiteThemeModel model = _model();
      final ThemeData light = model.themeFor(Brightness.light);
      final ThemeData dark = model.themeFor(Brightness.dark);
      final _Probe probe = _Probe();
      final Widget child = probe.build();
      await _pumpTransition(tester, light, child: child, reducedMotion: true);
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTransition(tester, dark, child: child, reducedMotion: true);
      await tester.pumpAndSettle();
      expect(probe.background, dark.colors.background);
      expect(probe.builds, 1);
      expect(find.byType(RawImage), findsNothing);
    });

    testWidgets('a zero duration swaps instantly with no snapshot', (
      WidgetTester tester,
    ) async {
      final SiteThemeModel model = _model();
      final ThemeData light = model.themeFor(Brightness.light);
      final ThemeData dark = model.themeFor(Brightness.dark);
      final _Probe probe = _Probe();
      final Widget child = probe.build();
      await _pumpTransition(tester, light, child: child);
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTransition(
        tester,
        dark,
        child: child,
        duration: Duration.zero,
      );
      await tester.pumpAndSettle();
      expect(probe.background, dark.colors.background);
      expect(probe.builds, 1);
      expect(find.byType(RawImage), findsNothing);
    });

    testWidgets('a mid-fade commit swaps the base and still completes', (
      WidgetTester tester,
    ) async {
      final SiteThemeModel model = _model();
      final ThemeData light = model.themeFor(Brightness.light);
      final ThemeData dark = model.themeFor(Brightness.dark);
      final _Probe probe = _Probe();
      final Widget child = probe.build();
      await _pumpTransition(tester, light, child: child);
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTransition(tester, dark, child: child);
      await _waitForFade(tester);
      // A second commit while the first fade is still showing: the base
      // swaps instantly (no second capture piles up).
      await _pumpTransition(tester, light, child: child);
      await tester.pumpAndSettle();

      expect(probe.background, light.colors.background);
      expect(probe.builds, 2);
      expect(find.byType(RawImage), findsNothing);
    });

    testWidgets('an unchanged commit is a no-op with no snapshot', (
      WidgetTester tester,
    ) async {
      final SiteThemeModel model = _model();
      final ThemeData light = model.themeFor(Brightness.light);
      final _Probe probe = _Probe();
      final Widget child = probe.build();
      await _pumpTransition(tester, light, child: child);
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTransition(tester, light, child: child);
      await tester.pumpAndSettle();
      expect(probe.builds, 0, reason: 'identical data and child skip work');
      expect(find.byType(RawImage), findsNothing);
    });

    testWidgets('content state survives the switch', (
      WidgetTester tester,
    ) async {
      final SiteThemeModel model = _model();
      final ThemeData light = model.themeFor(Brightness.light);
      final ThemeData dark = model.themeFor(Brightness.dark);
      await _pumpTransition(tester, light, child: const _StatefulCounter());
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('counter')));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      await _pumpTransition(tester, dark, child: const _StatefulCounter());
      await tester.pumpAndSettle();
      expect(
        find.text('1'),
        findsOneWidget,
        reason: 'the overlay slot never remounts the content subtree',
      );
    });
  });
}

/// Minimal stateful content: proves the transition never remounts its child.
class _StatefulCounter extends StatefulWidget {
  const _StatefulCounter();

  @override
  State<_StatefulCounter> createState() => _StatefulCounterState();
}

class _StatefulCounterState extends State<_StatefulCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return GestureDetector(
      key: const ValueKey<String>('counter'),
      onTap: () => setState(() => count++),
      child: Text('$count'),
    );
  }
}
