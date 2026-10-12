// P7-TS1 bug 4: every Theme Studio change takes P7-WD's single-swap path —
// one commit, one notification, one cached resolution — and resolves far
// inside a frame budget.
//
// Widget-test timings are not device frames; these tests pin the mechanism
// the budget rests on (single notify, shared cached instance, lerp fast
// path) and measure model resolution so a regression shows up here first.

import 'package:docs/state/docs_state.dart';
import 'package:docs/state/docs_storage.dart';
import 'package:docs/ui/shadcn/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

SiteThemeModel _model() {
  final SiteThemeModel model = SiteThemeModel(
    storage: MemoryDocsStorage(<String, String>{}),
  );
  addTearDown(model.dispose);
  return model;
}

void main() {
  group('single-swap path', () {
    test('every Studio change notifies exactly once', () {
      final DocsState state = DocsState(storage: MemoryDocsStorage());
      addTearDown(state.dispose);
      int notifications = 0;
      state.addListener(() => notifications++);

      state.setPreset('tangerine');
      expect(notifications, 1);
      state.themeModel.setBaseColor(const Color(0xFF2563EB));
      expect(notifications, 2);
      state.themeModel.setAccentColor(const Color(0xFF16A34A));
      expect(notifications, 3);
      state.themeModel.setChartColors(const Color(0xFFD946EF));
      expect(notifications, 4);
      state.themeModel.setRadiusPx(4);
      expect(notifications, 5);
      state.themeModel.setSpacingRem(0.3);
      expect(notifications, 6);
      state.themeModel.setFont('heading', 'Playfair Display');
      expect(notifications, 7);
      state.themeModel.setFont('body', 'Inter');
      expect(notifications, 8);
      state.themeModel.setShadow(
        Brightness.light,
        state.themeModel.document.shadowOf(Brightness.light),
      );
      expect(notifications, 8, reason: 'an unchanged shadow stays silent');
      state.themeModel.setTransition(
        state.themeModel.transition == DocsThemeTransition.fade
            ? DocsThemeTransition.none
            : DocsThemeTransition.fade,
      );
      expect(notifications, 9);
      state.toggleBrightness();
      expect(notifications, 10);
    });

    test('themeFor shares one cached instance per commit', () {
      final SiteThemeModel model = _model();
      final ShadcnThemeData light = model.themeFor(Brightness.light);
      expect(identical(model.themeFor(Brightness.light), light), isTrue);
      model.setRadiusPx(4);
      expect(identical(model.themeFor(Brightness.light), light), isFalse);
      expect(
        identical(
          model.themeFor(Brightness.light),
          model.themeFor(Brightness.light),
        ),
        isTrue,
      );
    });

    test('lerp reuses identical legs instead of re-resolving styles', () {
      final SiteThemeModel model = _model();
      final ShadcnThemeData light = model.themeFor(Brightness.light);
      expect(identical(ShadcnThemeData.lerp(light, light, 0.5), light), isTrue);
      final ShadcnThemeData dark = model.themeFor(Brightness.dark);
      final ShadcnThemeData mid = ShadcnThemeData.lerp(light, dark, 0.5);
      expect(identical(mid.typography, light.typography), isTrue);
      expect(identical(mid.tokens, light.tokens), isTrue);
    });

    test('a full resolution costs a fraction of a frame', () {
      final SiteThemeModel model = _model();
      // Alternate presets so every iteration resolves fresh (no cache hit).
      final Stopwatch watch = Stopwatch()..start();
      const int commits = 50;
      for (int i = 0; i < commits; i++) {
        model.selectPreset(i.isEven ? 'tangerine' : 'neutral');
        model.themeFor(Brightness.light);
        model.themeFor(Brightness.dark);
      }
      watch.stop();
      final double perCommit = watch.elapsedMicroseconds / commits / 1000;
      // ignore: avoid_print
      debugPrint(
        'TS1 perf: one commit resolves light+dark '
        'in ${perCommit.toStringAsFixed(3)} ms (budget 32 ms)',
      );
      expect(
        perCommit,
        lessThan(32),
        reason:
            'one commit resolves light+dark in ${perCommit.toStringAsFixed(2)} ms',
      );
    });
  });
}
