// Widget tests for the `refresh_trigger` component.
//
// Covers the default pill per stage, the programmatic refresh lifecycle,
// custom indicators, pull gating on null `onRefresh` and the four
// theme-precedence legs. Regression tests cover the retired pieces: no
// Material progress/arrow widgets, no fake refresh cycle without a callback
// and no division by zero for a zero arming extent. P7-WB adds the three
// input paths: touch drags (threshold), mouse drags (trackpad-style gesture
// the child scrollable never claims) and wheel/trackpad ticks, plus the
// child scroll lock while a pull is in flight.

import 'package:flutter/gestures.dart'
    show PointerDeviceKind, PointerScrollEvent;
import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/card/card.dart';
import 'package:flutter_shadcn_kit/registry/components/refresh_trigger/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/refresh_trigger/refresh_trigger.dart';
import 'package:flutter_shadcn_kit/registry/foundation/component_preview.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  required Widget child,
  ShadcnThemeData data = const ShadcnThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  RefreshTriggerTheme? scoped,
}) {
  Widget body = child;
  if (scoped != null) {
    body = ComponentTheme<RefreshTriggerTheme>(data: scoped, child: body);
  }
  return ShadcnTheme(
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

RefreshTriggerStage _stageOf(TriggerStage stage, [double extent = 0.5]) {
  return RefreshTriggerStage(
    stage,
    AlwaysStoppedAnimation<double>(extent),
    Axis.vertical,
    false,
  );
}

Widget _scrollable({Future<void> Function()? onRefresh, Key? key}) {
  return RefreshTrigger(
    key: key,
    onRefresh: onRefresh,
    completeDuration: const Duration(milliseconds: 1),
    child: ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) =>
          SizedBox(height: 40, child: Text('row $index')),
    ),
  );
}

void main() {
  group('default indicator', () {
    testWidgets('shows the localized label per stage', (tester) async {
      final Map<TriggerStage, String> labels = <TriggerStage, String>{
        TriggerStage.idle: 'Pull to refresh',
        TriggerStage.pulling: 'Pull to refresh',
        TriggerStage.refreshing: 'Refreshing...',
        TriggerStage.completed: 'Refresh complete',
      };
      for (final MapEntry<TriggerStage, String> entry in labels.entries) {
        await tester.pumpWidget(
          _frame(child: DefaultRefreshIndicator(stage: _stageOf(entry.key))),
        );
        // Finish the stage switch transition; single pumps leave both
        // children mounted. (No settle: the refresh spinner repeats.)
        await tester.pump(const Duration(milliseconds: 200));
        expect(find.text(entry.value), findsOneWidget);
      }
    });

    testWidgets('release label past the arming extent', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: DefaultRefreshIndicator(
            stage: _stageOf(TriggerStage.pulling, 1.2),
          ),
        ),
      );
      expect(find.text('Release to refresh'), findsOneWidget);
    });

    testWidgets('indicator paints on a card surface', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: DefaultRefreshIndicator(stage: _stageOf(TriggerStage.idle)),
        ),
      );
      expect(find.byType(Card), findsOneWidget);
    });
  });

  group('refresh lifecycle', () {
    testWidgets('programmatic refresh runs the callback', (tester) async {
      bool called = false;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async {
              called = true;
            },
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      expect(key.currentState!.stage, TriggerStage.idle);
      final Future<void> pending = key.currentState!.refresh();
      await tester.pump();
      await pending;
      expect(called, isTrue);
      expect(key.currentState!.stage, TriggerStage.completed);
      // Fire the completion timer, then let the extent animation finish.
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 300));
      expect(key.currentState!.stage, TriggerStage.idle);
    });

    testWidgets('concurrent refresh calls serialize', (tester) async {
      int active = 0;
      int peak = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async {
              active++;
              peak = active > peak ? active : peak;
              await Future<void>.delayed(const Duration(milliseconds: 5));
              active--;
            },
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      final Future<void> first = key.currentState!.refresh();
      final Future<void> second = key.currentState!.refresh();
      // Advance the fake clock past the 5ms refresh delays, then join.
      await tester.pump(const Duration(milliseconds: 10));
      await Future.wait(<Future<void>>[first, second]);
      expect(peak, 1);
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('null onRefresh disables programmatic refresh work', (
      tester,
    ) async {
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(_frame(child: _scrollable(key: key)));
      await key.currentState!.refresh();
      expect(key.currentState!.stage, TriggerStage.completed);
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 300));
      expect(key.currentState!.stage, TriggerStage.idle);
    });
  });

  group('pull gating', () {
    testWidgets('pulling without onRefresh never leaves idle', (tester) async {
      await tester.pumpWidget(_frame(child: _scrollable()));
      final RefreshTriggerState state = tester.state<RefreshTriggerState>(
        find.byType(RefreshTrigger),
      );
      expect(state.stage, TriggerStage.idle);
      await tester.drag(find.byType(ListView), const Offset(0, 200));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      expect(state.stage, TriggerStage.idle);
    });

    testWidgets('a drag below the arming extent never refreshes', (
      tester,
    ) async {
      var calls = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async => calls++,
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      await tester.drag(find.byType(ListView), const Offset(0, 30));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(calls, 0);
      expect(key.currentState!.stage, TriggerStage.idle);
    });

    testWidgets('a drag past the arming extent refreshes on release', (
      tester,
    ) async {
      var calls = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async => calls++,
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      await tester.drag(find.byType(ListView), const Offset(0, 250));
      await tester.pump();
      expect(calls, 1);
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 300));
      expect(key.currentState!.stage, TriggerStage.idle);
    });

    testWidgets('a mouse drag past the arming extent refreshes', (
      tester,
    ) async {
      // P7-WB: scrollables never claim mouse drags, so the trigger tracks
      // them itself. This is the desktop-web drag path.
      var calls = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async => calls++,
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      await tester.drag(
        find.byType(ListView),
        const Offset(0, 250),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      expect(calls, 1);
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 300));
      expect(key.currentState!.stage, TriggerStage.idle);
    });

    testWidgets('a short mouse drag snaps back without refreshing', (
      tester,
    ) async {
      var calls = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async => calls++,
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      await tester.drag(
        find.byType(ListView),
        const Offset(0, 30),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(calls, 0);
      expect(key.currentState!.stage, TriggerStage.idle);
    });

    testWidgets('mouse hover moves never arm a pull', (tester) async {
      // Hover moves carry no buttons; only a pressed drag may pull.
      var calls = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async => calls++,
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      final TestGesture gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.byType(ListView)));
      await tester.pump();
      await gesture.moveTo(
        tester.getCenter(find.byType(ListView)) + const Offset(0, 200),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(calls, 0);
      expect(key.currentState!.stage, TriggerStage.idle);
    });
  });

  group('wheel pull', () {
    Future<void> wheel(WidgetTester tester, Offset delta) async {
      final Offset center = tester.getCenter(find.byType(ListView));
      await tester.sendEventToBinding(
        PointerScrollEvent(position: center, scrollDelta: delta),
      );
      await tester.pump();
    }

    testWidgets('wheel ticks at the edge arm and fire the refresh', (
      tester,
    ) async {
      // P7-WB: pointer scrolls bypass the gesture arena, so the trigger
      // accumulates them itself. This is the trackpad path.
      var calls = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async => calls++,
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      await wheel(tester, const Offset(0, -120));
      expect(key.currentState!.stage, TriggerStage.pulling);
      // The settle timer (150ms) fires the armed pull.
      await tester.pump(const Duration(milliseconds: 200));
      expect(calls, 1);
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 300));
      expect(key.currentState!.stage, TriggerStage.idle);
    });

    testWidgets('wheel ticks below the threshold snap back', (tester) async {
      var calls = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async => calls++,
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      await wheel(tester, const Offset(0, -30));
      expect(key.currentState!.stage, TriggerStage.pulling);
      await tester.pump(const Duration(milliseconds: 200));
      expect(calls, 0);
      expect(key.currentState!.stage, TriggerStage.idle);
    });

    testWidgets('wheel ticks into content never pull', (tester) async {
      var calls = 0;
      final GlobalKey<RefreshTriggerState> key = GlobalKey<RefreshTriggerState>(
        debugLabel: 'trigger',
      );
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            key: key,
            onRefresh: () async => calls++,
            completeDuration: const Duration(milliseconds: 1),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      await wheel(tester, const Offset(0, 120));
      await tester.pump(const Duration(milliseconds: 200));
      expect(calls, 0);
      expect(key.currentState!.stage, TriggerStage.idle);
    });
  });

  group('custom indicator', () {
    testWidgets('indicatorBuilder replaces the default pill', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            onRefresh: () async {},
            indicatorBuilder: (context, stage) => const Text('custom pill'),
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      expect(find.text('custom pill'), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });
  });

  group('theme precedence', () {
    testWidgets('widget > scoped > app > defaults', (tester) async {
      RefreshTriggerTheme resolve(
        BuildContext context,
        RefreshTriggerTheme? widget,
      ) {
        return resolveComponentStyle<RefreshTriggerTheme, RefreshTriggerTheme>(
          context,
          widget: widget,
          select: (t) => t,
          defaults: refreshTriggerDefaults,
        );
      }

      RefreshTriggerTheme? seen;
      Future<void> pump({
        RefreshTriggerTheme? widget,
        RefreshTriggerTheme? scoped,
        List<ComponentThemeData> app = const <ComponentThemeData>[],
      }) async {
        await tester.pumpWidget(
          _frame(
            app: app,
            scoped: scoped,
            child: Builder(
              builder: (context) {
                seen = resolve(context, widget);
                return const SizedBox();
              },
            ),
          ),
        );
      }

      await pump();
      expect(seen!.minExtent, refreshTriggerDefaults.minExtent);
      expect(seen!.minExtent, 75);
      await pump(
        app: const <ComponentThemeData>[RefreshTriggerTheme(minExtent: 60)],
      );
      expect(seen!.minExtent, 60);
      await pump(
        scoped: const RefreshTriggerTheme(minExtent: 50),
        app: const <ComponentThemeData>[RefreshTriggerTheme(minExtent: 60)],
      );
      expect(seen!.minExtent, 50);
      await pump(
        widget: const RefreshTriggerTheme(minExtent: 40),
        scoped: const RefreshTriggerTheme(minExtent: 50),
        app: const <ComponentThemeData>[RefreshTriggerTheme(minExtent: 60)],
      );
      expect(seen!.minExtent, 40);
    });

    testWidgets('zero arming extent does not divide by zero', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: RefreshTrigger(
            minExtent: 0,
            onRefresh: () async {},
            child: ListView(children: const <Widget>[Text('row')]),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('pull input unit table', () {
    RefreshPullInput input({
      required List<String> calls,
      double minExtent = 75,
    }) {
      return RefreshPullInput(
        minExtent: minExtent,
        onChanged: () => calls.add('changed'),
        onFire: () => calls.add('fire'),
      );
    }

    test('one transition table serves every path', () {
      // Touch.
      final List<String> touch = <String>[];
      final RefreshPullInput a = input(calls: touch);
      a.scrollStart();
      a.scrollDelta(100);
      expect(a.phase, PullPhase.pulling);
      expect(a.extent, 100);
      a.scrollEnd();
      expect(touch, contains('fire'));

      // Wheel.
      final List<String> wheel = <String>[];
      final RefreshPullInput b = input(calls: wheel);
      b.wheelTick(100);
      expect(b.phase, PullPhase.pulling);
      b.dispose();

      // Mouse.
      final List<String> mouse = <String>[];
      final RefreshPullInput c = input(calls: mouse);
      c.mouseDown();
      c.mouseMove(100, true);
      expect(c.phase, PullPhase.pulling);
      c.mouseUp();
      expect(mouse, contains('fire'));
    });

    test('below-threshold pulls snap back without firing', () {
      final List<String> calls = <String>[];
      final RefreshPullInput tracker = input(calls: calls);
      tracker.scrollStart();
      tracker.scrollDelta(30);
      tracker.scrollEnd();
      expect(calls, isNot(contains('fire')));
      expect(tracker.phase, PullPhase.idle);
      expect(tracker.extent, 0);
    });

    test('starting a pull requires the edge', () {
      final List<String> calls = <String>[];
      final RefreshPullInput tracker = input(calls: calls)..atEdge = false;
      tracker.accumulate(100);
      expect(tracker.phase, PullPhase.idle);
      expect(calls, isEmpty);
    });

    test('negative deltas shrink but never fire', () {
      final List<String> calls = <String>[];
      final RefreshPullInput tracker = input(calls: calls);
      tracker.accumulate(100);
      tracker.accumulate(-40);
      expect(tracker.extent, 60);
      tracker.accumulate(-100);
      expect(tracker.extent, 0);
      expect(tracker.phase, PullPhase.pulling);
      expect(calls, isNot(contains('fire')));
    });

    test('a drag takes over from wheel and mouse arms', () {
      final List<String> calls = <String>[];
      final RefreshPullInput tracker = input(calls: calls);
      tracker.wheelTick(100);
      tracker.mouseDown();
      tracker.scrollStart();
      // The drag owns it now: the wheel settle was cancelled.
      tracker.scrollDelta(10);
      tracker.scrollEnd();
      expect(calls, contains('fire'));
    });

    test('inward wheel abandons only a wheel pull', () {
      final List<String> calls = <String>[];
      final RefreshPullInput tracker = input(calls: calls);
      tracker.wheelTick(100);
      tracker.wheelTick(-10);
      expect(tracker.phase, PullPhase.idle);
      expect(calls, isNot(contains('fire')));
      tracker.dispose();
    });

    test('mouse release below threshold snaps back', () {
      final List<String> calls = <String>[];
      final RefreshPullInput tracker = input(calls: calls);
      tracker.mouseDown();
      tracker.mouseMove(10, true);
      tracker.mouseUp();
      expect(calls, isNot(contains('fire')));
      expect(tracker.phase, PullPhase.idle);
    });

    test('reset returns to idle silently', () {
      final List<String> calls = <String>[];
      final RefreshPullInput tracker = input(calls: calls);
      tracker.wheelTick(100);
      calls.clear();
      tracker.reset();
      expect(tracker.phase, PullPhase.idle);
      expect(tracker.extent, 0);
      expect(calls, isEmpty);
      tracker.dispose();
    });
  });

  group('regressions', () {
    testWidgets('no Material progress widget in the indicator', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: DefaultRefreshIndicator(
            stage: _stageOf(TriggerStage.refreshing),
          ),
        ),
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget.runtimeType.toString() == 'CircularProgressIndicator',
        ),
        findsNothing,
      );
    });

    testWidgets('every preview example pumps without throwing', (tester) async {
      for (final ComponentPreview preview in refreshTriggerPreviews) {
        await tester.pumpWidget(
          _frame(child: Builder(builder: preview.builder)),
        );
        await tester.pump(const Duration(milliseconds: 200));
        expect(tester.takeException(), isNull);
      }
    });
  });
}
