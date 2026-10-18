// Loop contract: spinners and skeletons keep animating while motion is on
// and park static with no ticker when reduced motion is on or motion is off.

import 'package:dashcn/src/components/border_loading/border_loading.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/progress/progress.dart';
import 'package:dashcn/src/components/refresh_trigger/refresh_trigger_indicator.dart';
import 'package:dashcn/src/components/refresh_trigger/refresh_trigger_style.dart';
import 'package:dashcn/src/components/skeleton/skeleton.dart';
import 'package:dashcn/src/components/spinner/spinner.dart';
import 'package:dashcn/src/theme/motion.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpLoop(
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

ThemeData get _noMotion => const ThemeData().copyWith(
  motion: () => const MotionTokens(enabled: false),
);

/// Pumps [child], advances 100 ms, and reports whether a ticker is running.
Future<bool> _hasTicker(WidgetTester tester, Widget child) async {
  await _pumpLoop(tester, child);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  return tester.binding.transientCallbackCount > 0;
}

Future<bool> _hasTickerReduced(WidgetTester tester, Widget child) async {
  await _pumpLoop(tester, child, disabled: true, theme: _noMotion);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  return tester.binding.transientCallbackCount > 0;
}

void main() {
  group('loops animate when on, static when off', () {
    testWidgets('spinner loops, static when reduced', (
      WidgetTester tester,
    ) async {
      expect(await _hasTicker(tester, const Spinner()), isTrue);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      expect(await _hasTickerReduced(tester, const Spinner()), isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('skeleton shimmers, static when reduced', (
      WidgetTester tester,
    ) async {
      Widget skeleton() =>
          const Skeleton(enabled: true, child: Text('Summary'));
      expect(await _hasTicker(tester, skeleton()), isTrue);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      expect(await _hasTickerReduced(tester, skeleton()), isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading button spinner loops, static when reduced', (
      WidgetTester tester,
    ) async {
      Widget loading() =>
          const Button(status: ButtonStatus.loading, child: Text('Save'));
      expect(await _hasTicker(tester, loading()), isTrue);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      expect(await _hasTickerReduced(tester, loading()), isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('progress indeterminate sweeps, static when reduced', (
      WidgetTester tester,
    ) async {
      const Widget bar = Progress();
      expect(await _hasTicker(tester, bar), isTrue);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      expect(await _hasTickerReduced(tester, bar), isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('refresh spinner loops, static when reduced', (
      WidgetTester tester,
    ) async {
      Widget refreshing() => DefaultRefreshIndicator(
        stage: RefreshTriggerStage(
          TriggerStage.refreshing,
          const AlwaysStoppedAnimation<double>(1.0),
          Axis.vertical,
          false,
        ),
      );
      expect(await _hasTicker(tester, refreshing()), isTrue);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      expect(await _hasTickerReduced(tester, refreshing()), isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('border loading loops, static when reduced', (
      WidgetTester tester,
    ) async {
      Widget loading() => const BorderLoading(child: Text('content'));
      expect(await _hasTicker(tester, loading()), isTrue);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      expect(await _hasTickerReduced(tester, loading()), isFalse);
      expect(tester.takeException(), isNull);
    });
  });
}
