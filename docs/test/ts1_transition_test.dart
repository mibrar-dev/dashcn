// P7-TS1 bug 5: the rail `Transition` row persists a switch animation and
// every animation swaps the theme exactly once, snapshot based.
//
// Each kind is pumped in isolation (like P7-WD's `theme_switch_test.dart`,
// which owns the fade path — this file owns the kinds, the rail wiring and
// the persistence). Reduced motion always swaps instantly, whatever is
// picked.

import 'package:docs/motion/motion_scope.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/state/docs_storage.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/theme_switch_transition.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

SiteThemeModel _model([Map<String, String>? seed]) {
  final SiteThemeModel model = SiteThemeModel(
    storage: MemoryDocsStorage(seed ?? <String, String>{}),
  );
  addTearDown(model.dispose);
  return model;
}

/// Records every rebuild of a theme dependent plus the last colour seen.
class _Ts1Probe {
  int builds = 0;
  Color? background;

  Widget build() {
    return Builder(
      builder: (BuildContext context) {
        builds++;
        background = Theme.of(context).colors.background;
        // Non-zero size: a zero-size boundary has no raster to snapshot, so
        // the transition (correctly) swaps without animating.
        return const SizedBox(width: 200, height: 200);
      },
    );
  }
}

Future<void> _pumpTs1(
  WidgetTester tester,
  ThemeData data, {
  required Widget child,
  bool reducedMotion = false,
  DocsThemeTransition kind = DocsThemeTransition.fade,
}) async {
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: MotionScope(
        prefersReducedMotion: reducedMotion,
        child: ThemeSwitchTransition(
          data: data,
          kind: kind,
          duration: docsTransitionDuration(kind),
          child: child,
        ),
      ),
    ),
  );
}

/// Pumps until a snapshot overlay is showing (the animation started).
Future<void> _waitForSnapshot(WidgetTester tester) async {
  for (int i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 16));
    if (find.byType(RawImage).evaluate().isNotEmpty) {
      return;
    }
  }
}

void main() {
  group('transition durations', () {
    test('every animated kind lands in the 250-400 ms band', () {
      expect(docsTransitionDuration(DocsThemeTransition.none), Duration.zero);
      for (final DocsThemeTransition kind in <DocsThemeTransition>{
        DocsThemeTransition.fade,
        DocsThemeTransition.circular,
        DocsThemeTransition.wipe,
        DocsThemeTransition.blur,
      }) {
        final Duration duration = docsTransitionDuration(kind);
        expect(duration.inMilliseconds, greaterThanOrEqualTo(250));
        expect(duration.inMilliseconds, lessThanOrEqualTo(400));
      }
    });

    test('stored names parse, unknown names fall back to fade', () {
      expect(DocsThemeTransition.parse('none'), DocsThemeTransition.none);
      expect(DocsThemeTransition.parse('fade'), DocsThemeTransition.fade);
      expect(
        DocsThemeTransition.parse('circular'),
        DocsThemeTransition.circular,
      );
      expect(DocsThemeTransition.parse('wipe'), DocsThemeTransition.wipe);
      expect(DocsThemeTransition.parse('blur'), DocsThemeTransition.blur);
      expect(DocsThemeTransition.parse(null), DocsThemeTransition.fade);
      expect(DocsThemeTransition.parse('zoom'), DocsThemeTransition.fade);
      expect(
        DocsThemeTransition.values.map((DocsThemeTransition k) => k.name),
        containsAll(<String>['none', 'fade', 'circular', 'wipe', 'blur']),
      );
    });

    test('every kind has a rail label', () {
      expect(
        DocsThemeTransition.values.map(docsTransitionLabel).toSet(),
        <String>{'None', 'Fade', 'Circular', 'Wipe', 'Blur'},
      );
    });
  });

  group('transition persistence', () {
    test('setTransition persists without touching the document', () {
      final MemoryDocsStorage storage = MemoryDocsStorage();
      final SiteThemeModel model = SiteThemeModel(storage: storage);
      addTearDown(model.dispose);
      final String before = model.document.json;
      int notifications = 0;
      model.addListener(() => notifications++);

      model.setTransition(DocsThemeTransition.circular);
      expect(model.transition, DocsThemeTransition.circular);
      expect(notifications, 1);
      expect(model.document.json, before);
      expect(storage.values[kDocsTransitionKey], 'circular');

      model.setTransition(DocsThemeTransition.circular);
      expect(notifications, 1, reason: 're-picking the kind stays silent');
    });

    test('restore reloads the persisted kind', () {
      final Map<String, String> seed = <String, String>{
        kDocsTransitionKey: 'wipe',
      };
      final SiteThemeModel model = _model(seed);
      expect(model.transition, DocsThemeTransition.fade);
      model.restore();
      expect(model.transition, DocsThemeTransition.wipe);
    });

    test('reset keeps the picked kind (chrome, not content)', () {
      final SiteThemeModel model = _model();
      model.setTransition(DocsThemeTransition.blur);
      model.reset();
      expect(model.transition, DocsThemeTransition.blur);
    });
  });

  group('transition kinds', () {
    testWidgets('fade cross-fades the snapshot', (tester) async {
      final SiteThemeModel model = _model();
      final _Ts1Probe probe = _Ts1Probe();
      final Widget child = probe.build();
      await _pumpTs1(tester, model.themeFor(Brightness.light), child: child);
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTs1(tester, model.themeFor(Brightness.dark), child: child);
      await _waitForSnapshot(tester);
      expect(find.byType(RawImage), findsOneWidget);
      expect(find.byType(FadeTransition), findsWidgets);
      expect(probe.builds, 1);
      await tester.pumpAndSettle();
      expect(find.byType(RawImage), findsNothing);
      expect(
        probe.background,
        model.themeFor(Brightness.dark).colors.background,
      );
    });

    testWidgets('circular reveals through an expanding hole', (tester) async {
      final SiteThemeModel model = _model();
      final _Ts1Probe probe = _Ts1Probe();
      final Widget child = probe.build();
      await _pumpTs1(
        tester,
        model.themeFor(Brightness.light),
        child: child,
        kind: DocsThemeTransition.circular,
      );
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTs1(
        tester,
        model.themeFor(Brightness.dark),
        child: child,
        kind: DocsThemeTransition.circular,
      );
      await _waitForSnapshot(tester);
      expect(find.byType(RawImage), findsOneWidget);
      expect(find.byType(ClipPath), findsOneWidget);
      expect(probe.builds, 1);
      await tester.pumpAndSettle();
      expect(find.byType(RawImage), findsNothing);
      expect(
        probe.background,
        model.themeFor(Brightness.dark).colors.background,
      );
      expect(probe.builds, 1);
    });

    testWidgets('wipe slides the old frame away', (tester) async {
      final SiteThemeModel model = _model();
      final _Ts1Probe probe = _Ts1Probe();
      final Widget child = probe.build();
      await _pumpTs1(
        tester,
        model.themeFor(Brightness.light),
        child: child,
        kind: DocsThemeTransition.wipe,
      );
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTs1(
        tester,
        model.themeFor(Brightness.dark),
        child: child,
        kind: DocsThemeTransition.wipe,
      );
      await _waitForSnapshot(tester);
      expect(find.byType(RawImage), findsOneWidget);
      expect(find.byType(Transform), findsWidgets);
      expect(probe.builds, 1);
      await tester.pumpAndSettle();
      expect(find.byType(RawImage), findsNothing);
      expect(
        probe.background,
        model.themeFor(Brightness.dark).colors.background,
      );
    });

    testWidgets('blur dissolves the old frame', (tester) async {
      final SiteThemeModel model = _model();
      final _Ts1Probe probe = _Ts1Probe();
      final Widget child = probe.build();
      await _pumpTs1(
        tester,
        model.themeFor(Brightness.light),
        child: child,
        kind: DocsThemeTransition.blur,
      );
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTs1(
        tester,
        model.themeFor(Brightness.dark),
        child: child,
        kind: DocsThemeTransition.blur,
      );
      await _waitForSnapshot(tester);
      expect(find.byType(RawImage), findsOneWidget);
      expect(find.byType(ImageFiltered), findsOneWidget);
      expect(probe.builds, 1);
      await tester.pumpAndSettle();
      expect(find.byType(RawImage), findsNothing);
      expect(
        probe.background,
        model.themeFor(Brightness.dark).colors.background,
      );
    });

    testWidgets('none swaps instantly with no snapshot', (tester) async {
      final SiteThemeModel model = _model();
      final _Ts1Probe probe = _Ts1Probe();
      final Widget child = probe.build();
      await _pumpTs1(
        tester,
        model.themeFor(Brightness.light),
        child: child,
        kind: DocsThemeTransition.none,
      );
      await tester.pumpAndSettle();
      probe.builds = 0;

      await _pumpTs1(
        tester,
        model.themeFor(Brightness.dark),
        child: child,
        kind: DocsThemeTransition.none,
      );
      await tester.pumpAndSettle();
      expect(
        probe.background,
        model.themeFor(Brightness.dark).colors.background,
      );
      expect(probe.builds, 1);
      expect(find.byType(RawImage), findsNothing);
    });

    testWidgets('reduced motion swaps instantly for every kind', (
      tester,
    ) async {
      for (final DocsThemeTransition kind in DocsThemeTransition.values) {
        final SiteThemeModel model = _model();
        final _Ts1Probe probe = _Ts1Probe();
        final Widget child = probe.build();
        await _pumpTs1(
          tester,
          model.themeFor(Brightness.light),
          child: child,
          kind: kind,
          reducedMotion: true,
        );
        await tester.pumpAndSettle();
        probe.builds = 0;

        await _pumpTs1(
          tester,
          model.themeFor(Brightness.dark),
          child: child,
          kind: kind,
          reducedMotion: true,
        );
        await tester.pumpAndSettle();
        expect(
          probe.background,
          model.themeFor(Brightness.dark).colors.background,
        );
        expect(probe.builds, 1);
        expect(find.byType(RawImage), findsNothing);
      }
    });
  });
}
