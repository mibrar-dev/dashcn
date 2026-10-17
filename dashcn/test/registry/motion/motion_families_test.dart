// Per-component-family motion contract: pump the default preview, trigger
// the behaviour, assert a transform/opacity/value moves at 50 ms, assert the
// settled state equals the no-motion state, and assert reduced motion runs
// no animation ticker (except intentional loops, which have their own
// static frames under reduced motion).

import 'dart:ui' show PointerDeviceKind;

import 'package:dashcn/src/components/accordion/preview.dart';
import 'package:dashcn/src/components/alert/preview.dart';
import 'package:dashcn/src/components/button/preview.dart';
import 'package:dashcn/src/components/calendar/preview.dart';
import 'package:dashcn/src/components/card/card.dart';
import 'package:dashcn/src/components/card/preview.dart';
import 'package:dashcn/src/components/carousel/preview.dart';
import 'package:dashcn/src/components/checkbox/preview.dart';
import 'package:dashcn/src/components/collapsible/preview.dart';
import 'package:dashcn/src/components/dialog/preview.dart';
import 'package:dashcn/src/components/dot_indicator/preview.dart';
import 'package:dashcn/src/components/drawer/preview.dart';
import 'package:dashcn/src/components/form/preview.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/components/input/preview.dart';
import 'package:dashcn/src/components/input_otp/input_otp.dart';
import 'package:dashcn/src/components/progress/progress.dart';
import 'package:dashcn/src/components/radio_group/preview.dart';
import 'package:dashcn/src/components/select/preview.dart';
import 'package:dashcn/src/components/slider/preview.dart';
import 'package:dashcn/src/components/slider/slider.dart';
import 'package:dashcn/src/components/switch/preview.dart';
import 'package:dashcn/src/components/switch/switch.dart' show kSwitchThumbKey;
import 'package:dashcn/src/components/tabs/preview.dart';
import 'package:dashcn/src/components/timeline/preview.dart';
import 'package:dashcn/src/components/toast/preview.dart';
import 'package:dashcn/src/components/toast/toast.dart';
import 'package:dashcn/src/components/toggle/preview.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/primitives/form_core/form_core.dart';
import 'package:dashcn/src/primitives/motion/error_shake.dart';
import 'package:dashcn/src/primitives/motion/fade_slide_in.dart';
import 'package:dashcn/src/primitives/selectable_radio/selectable_radio.dart'
    show kRadioIndicatorDotKey;
import 'package:dashcn/src/theme/motion.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps a preview inside a routed, layered stage with the motion theme.
///
/// [disabled] wraps the tree in `MediaQuery.disableAnimations`. Each call
/// mounts with a fresh [UniqueKey] so preview state never leaks between
/// the enabled and reduced runs. The media query carries the standard
/// 800x600 test size: a bare `MediaQueryData` reports size zero, which
/// collapses edge-anchored panels (drawer, sheet) to a zero slide.
Future<void> pumpFamily(
  WidgetTester tester,
  ComponentPreview preview, {
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
          child: Navigator(
            onGenerateRoute: (_) => PageRouteBuilder<void>(
              pageBuilder: (_, _, _) => ToastLayer(
                child: Overlay.wrap(
                  child: Center(
                    child: SizedBox(
                      width: 720,
                      height: 420,
                      child: KeyedSubtree(
                        key: UniqueKey(),
                        child: Builder(builder: preview.builder),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

ThemeData get _noMotion => const ThemeData().copyWith(
  motion: () => const MotionTokens(enabled: false),
);

/// Any painted transform that is not the identity.
bool _hasLiveTransform(WidgetTester tester) => tester
    .widgetList<Transform>(find.byType(Transform))
    .any((Transform t) => t.transform != Matrix4.identity());

/// Border widths of every bordered box (focus rings resolve here).
List<double> _borderWidths(WidgetTester tester) {
  final List<double> out = <double>[];
  for (final Container container in tester.widgetList<Container>(
    find.byType(Container),
  )) {
    final Decoration? decoration = container.decoration;
    if (decoration is BoxDecoration && decoration.border is Border) {
      final Border border = decoration.border! as Border;
      out.add(border.top.width);
    }
  }
  return out;
}

/// One family: how to trigger it, what moves mid-flight, and the settled
/// fingerprint that must match with motion off.
class _Family {
  const _Family({
    required this.name,
    required this.preview,
    required this.interact,
    required this.expectMid,
    required this.fingerprint,
    this.release,
    this.settle = const Duration(milliseconds: 600),
    this.midExtra = Duration.zero,
  });

  final String name;
  final ComponentPreview preview;
  final Future<void> Function(WidgetTester tester) interact;
  final void Function(WidgetTester tester) expectMid;
  final String Function(WidgetTester tester) fingerprint;
  final Future<void> Function(WidgetTester tester)? release;
  final Duration settle;

  /// Extra elapse pumped after the delivery frames and before [expectMid].
  /// Families whose trigger lands late (async validation) use this to
  /// reach mid-flight deterministically.
  final Duration midExtra;
}

Future<String> _runEnabled(WidgetTester tester, _Family family) async {
  await pumpFamily(tester, family.preview);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  expect(tester.takeException(), isNull, reason: '${family.name} mount');
  await family.interact(tester);
  // Delivery frame (state changes retarget their animations) plus a
  // mid-flight frame. Widgets that restart from zero render their start
  // value in the delivery frame, so the mid assertion needs the second one.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
  if (family.midExtra != Duration.zero) {
    await tester.pump(family.midExtra);
  }
  family.expectMid(tester);
  expect(tester.takeException(), isNull, reason: '${family.name} mid');
  final Future<void> Function(WidgetTester)? release = family.release;
  if (release != null) {
    await release(tester);
    // Delivery frame: release work (route pops, label swaps) starts its
    // animations here so the settle pump below actually elapses them.
    await tester.pump();
  }
  await tester.pump(family.settle);
  await tester.pump(const Duration(milliseconds: 16));
  expect(tester.takeException(), isNull, reason: '${family.name} settle');
  return family.fingerprint(tester);
}

Future<String> _runDisabled(WidgetTester tester, _Family family) async {
  await pumpFamily(tester, family.preview, disabled: true, theme: _noMotion);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  expect(tester.takeException(), isNull, reason: '${family.name} mount');
  await family.interact(tester);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
  final Future<void> Function(WidgetTester)? release = family.release;
  if (release != null) {
    await release(tester);
    await tester.pump();
  }
  await tester.pump(family.settle);
  await tester.pump(const Duration(milliseconds: 16));
  expect(tester.takeException(), isNull, reason: '${family.name} settle');
  expect(
    tester.binding.transientCallbackCount,
    0,
    reason: '${family.name} reduced motion runs a ticker',
  );
  return family.fingerprint(tester);
}

void main() {
  final List<_Family> families = <_Family>[
    // Press family: button goes down and back up on press.
    _Family(
      name: 'button press',
      preview: buttonPreviews.first,
      interact: (WidgetTester tester) async {
        final TestGesture gesture = await tester.startGesture(
          tester.getCenter(find.text('Button').first),
        );
        _FamilyHolders.pressGesture = gesture;
      },
      expectMid: (WidgetTester tester) {
        expect(
          _hasLiveTransform(tester),
          isTrue,
          reason: 'press scale mid-flight',
        );
      },
      release: (WidgetTester tester) async {
        await _FamilyHolders.pressGesture!.up();
        _FamilyHolders.pressGesture = null;
      },
      fingerprint: (WidgetTester tester) =>
          'button=${find.text('Button').evaluate().isNotEmpty}'
          ',live=${_hasLiveTransform(tester)}',
    ),
    // Toggle shares the Clickable press mechanism; hold the press so the
    // down state spans frames (a tap completes before the first frame).
    _Family(
      name: 'toggle press',
      preview: togglePreviews.first,
      interact: (WidgetTester tester) async {
        final TestGesture gesture = await tester.startGesture(
          tester.getCenter(find.text('Off')),
        );
        _FamilyHolders.pressGesture = gesture;
      },
      expectMid: (WidgetTester tester) {
        expect(
          _hasLiveTransform(tester),
          isTrue,
          reason: 'press scale mid-flight',
        );
      },
      release: (WidgetTester tester) async {
        await _FamilyHolders.pressGesture!.up();
        _FamilyHolders.pressGesture = null;
      },
      fingerprint: (WidgetTester tester) =>
          'on=${find.text('On').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'checkbox check',
      preview: checkboxPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Accept terms'));
      },
      expectMid: (WidgetTester tester) {
        // Rendered fade: AnimatedOpacity builds a FadeTransition carrying
        // the current value (its own field is the target).
        final List<double> opacities = <double>[
          for (final FadeTransition f in tester.widgetList<FadeTransition>(
            find.byType(FadeTransition),
          ))
            f.opacity.value,
        ];
        expect(
          opacities.any((double o) => o > 0 && o < 1),
          isTrue,
          reason: 'indicator fade mid-flight: $opacities',
        );
      },
      fingerprint: (WidgetTester tester) {
        final List<double> opacities = <double>[
          for (final AnimatedOpacity o in tester.widgetList<AnimatedOpacity>(
            find.byType(AnimatedOpacity),
          ))
            o.opacity,
        ];
        return 'opacities=$opacities';
      },
    ),
    _Family(
      name: 'radio select',
      preview: radioGroupPreviews.first,
      interact: (WidgetTester tester) async {
        _FamilyHolders.dotBefore = tester.getSize(
          find.byKey(kRadioIndicatorDotKey).at(1),
        );
        await tester.tap(find.text('Pro'));
      },
      expectMid: (WidgetTester tester) {
        final Size mid = tester.getSize(
          find.byKey(kRadioIndicatorDotKey).at(1),
        );
        expect(
          mid.width,
          greaterThan(_FamilyHolders.dotBefore.width),
          reason: 'dot scales in',
        );
      },
      fingerprint: (WidgetTester tester) =>
          'dot=${tester.getSize(find.byKey(kRadioIndicatorDotKey).at(1))}',
    ),
    _Family(
      name: 'switch toggle',
      preview: switchPreviews.first,
      interact: (WidgetTester tester) async {
        _FamilyHolders.thumbBefore = tester.getTopLeft(
          find.byKey(kSwitchThumbKey),
        );
        await tester.tap(find.text('Airplane mode'));
      },
      expectMid: (WidgetTester tester) {
        final Offset mid = tester.getTopLeft(find.byKey(kSwitchThumbKey));
        expect(
          mid.dx,
          isNot(_FamilyHolders.thumbBefore.dx),
          reason: 'thumb slides',
        );
        expect(
          tester.binding.transientCallbackCount,
          greaterThan(0),
          reason: 'thumb/track animation runs',
        );
      },
      fingerprint: (WidgetTester tester) =>
          'thumb=${tester.getTopLeft(find.byKey(kSwitchThumbKey))}',
    ),
    _Family(
      name: 'slider jump',
      preview: sliderPreviews.first,
      interact: (WidgetTester tester) async {
        final Offset center = tester.getCenter(find.byType(Slider).first);
        await tester.tapAt(Offset(center.dx + 120, center.dy));
      },
      expectMid: (WidgetTester tester) {
        expect(
          tester.binding.transientCallbackCount,
          greaterThan(0),
          reason: 'fill eases to the new value',
        );
      },
      fingerprint: (WidgetTester tester) =>
          'semantics=${tester.getSemantics(find.byType(Slider).first).value}',
    ),
    _Family(
      name: 'input focus ring',
      preview: inputPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.byType(Input).first);
      },
      expectMid: (WidgetTester tester) {
        final List<double> widths = _borderWidths(tester);
        expect(
          widths.any((double w) => w > 0 && w < 3),
          isTrue,
          reason: 'focus ring fades in: $widths',
        );
      },
      fingerprint: (WidgetTester tester) =>
          'ring=${_borderWidths(tester).contains(3.0)}',
    ),
    _Family(
      name: 'form error shake',
      preview: formPreviews.first,
      // Submit validation lands a frame late and the mount shake needs
      // its own start frames, so the mid read waits an extra beat.
      midExtra: const Duration(milliseconds: 150),
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Submit'));
      },
      expectMid: (WidgetTester tester) {
        // The shake ran (count) and the message is mid-fade; exact
        // shake-frame timing varies with the async validation landing.
        final ErrorShakeState state = tester.state<ErrorShakeState>(
          find.byType(ErrorShake),
        );
        expect(state.shakeCount, 1);
        final FadeSlideInState fade = tester.state<FadeSlideInState>(
          find.byType(FadeSlideIn),
        );
        expect(fade.progress, greaterThan(0.0));
        expect(fade.progress, lessThan(1.0));
      },
      fingerprint: (WidgetTester tester) =>
          'error=${find.byType(ErrorShake).evaluate().isNotEmpty}'
          ',live=${_hasLiveTransform(tester)}',
    ),
    _Family(
      name: 'dialog open and close',
      preview: dialogPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Edit profile').first);
        await tester.pump();
      },
      expectMid: (WidgetTester tester) {
        final double scale = tester
            .widget<ScaleTransition>(find.byType(ScaleTransition).first)
            .scale
            .value;
        expect(scale, greaterThan(0.96));
        expect(scale, lessThan(1.0));
      },
      release: (WidgetTester tester) async {
        await tester.tap(find.text('Cancel').last);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 50));
        // With motion the close reverses through mid values; reduced
        // motion pops instantly, so there is nothing to observe.
        final Finder transitions = find.byType(ScaleTransition);
        if (transitions.evaluate().isNotEmpty) {
          final double scale = tester
              .widget<ScaleTransition>(transitions.first)
              .scale
              .value;
          expect(scale, lessThan(1.0), reason: 'close reverses');
        }
        await tester.pump(const Duration(milliseconds: 500));
      },
      settle: Duration.zero,
      fingerprint: (WidgetTester tester) =>
          'save=${find.text('Save').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'select popover',
      preview: selectPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Select a fruit'));
        await tester.pump();
      },
      expectMid: (WidgetTester tester) {
        final List<double> opacities = <double>[
          for (final FadeTransition f in tester.widgetList<FadeTransition>(
            find.byType(FadeTransition),
          ))
            f.opacity.value,
        ];
        expect(
          opacities.any((double o) => o > 0 && o < 1),
          isTrue,
          reason: 'popover fades in: $opacities',
        );
      },
      release: (WidgetTester tester) async {
        await tester.tap(find.text('Apple').last);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));
      },
      settle: Duration.zero,
      fingerprint: (WidgetTester tester) =>
          'apple=${find.text('Apple').evaluate().length}',
    ),
    _Family(
      name: 'drawer slide',
      preview: drawerPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Open left'));
        await tester.pump();
      },
      expectMid: (WidgetTester tester) {
        expect(
          _hasLiveTransform(tester),
          isTrue,
          reason: 'panel slides from the edge',
        );
      },
      release: (WidgetTester tester) async {
        // Let the panel finish arriving first: the Close button travels
        // with the slide and a mid-flight tap misses it.
        await tester.pump(const Duration(milliseconds: 400));
        await tester.tap(find.text('Close'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 700));
      },
      settle: Duration.zero,
      fingerprint: (WidgetTester tester) =>
          'content=${find.text('Drawer content').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'toast enter',
      preview: toastPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Show toast'));
        await tester.pump();
      },
      expectMid: (WidgetTester tester) {
        final List<Offset> offsets = <Offset>[
          for (final SlideTransition s in tester.widgetList<SlideTransition>(
            find.byType(SlideTransition),
          ))
            s.position.value,
        ];
        final List<double> opacities = <double>[
          for (final FadeTransition f in tester.widgetList<FadeTransition>(
            find.byType(FadeTransition),
          ))
            f.opacity.value,
        ];
        expect(
          offsets.any((Offset o) => o != Offset.zero) ||
              opacities.any((double o) => o > 0 && o < 1),
          isTrue,
          reason: 'toast slides and fades in',
        );
      },
      release: (WidgetTester tester) async {
        // Drain the auto-dismiss timer so no timer pends at test end.
        await tester.pump(const Duration(seconds: 4));
        await tester.pump(const Duration(milliseconds: 500));
      },
      settle: Duration.zero,
      fingerprint: (WidgetTester tester) =>
          'toast=${find.text('Saved to your workspace.').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'accordion expand',
      preview: accordionPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Is it accessible?'));
      },
      expectMid: (WidgetTester tester) {
        final double factor = tester
            .widget<SizeTransition>(find.byType(SizeTransition).first)
            .sizeFactor
            .value;
        expect(factor, greaterThan(0.0));
        expect(factor, lessThan(1.0));
      },
      fingerprint: (WidgetTester tester) =>
          'factor=${tester.widget<SizeTransition>(find.byType(SizeTransition).first).sizeFactor.value}',
    ),
    _Family(
      name: 'tabs switch',
      preview: tabsPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Password'));
      },
      expectMid: (WidgetTester tester) {
        // Rendered label scale: AnimatedScale builds a ScaleTransition
        // carrying the current value; the selected pill grows to 1.05.
        final List<double> scales = <double>[
          for (final ScaleTransition s in tester.widgetList<ScaleTransition>(
            find.byType(ScaleTransition),
          ))
            s.scale.value,
        ];
        expect(
          scales.any((double s) => s > 1.0 && s < 1.05),
          isTrue,
          reason: 'selected label scales up: $scales',
        );
      },
      fingerprint: (WidgetTester tester) {
        final List<double> scales = <double>[
          for (final AnimatedScale s in tester.widgetList<AnimatedScale>(
            find.byType(AnimatedScale),
          ))
            s.scale,
        ];
        return 'scales=$scales';
      },
    ),
    _Family(
      name: 'timeline stagger',
      preview: timelinePreviews.first,
      interact: (WidgetTester tester) async {},
      expectMid: (WidgetTester tester) async {},
      fingerprint: (WidgetTester tester) =>
          'kickoff=${find.text('Kickoff').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'card hover',
      preview: cardPreviews.first,
      interact: (WidgetTester tester) async {
        final TestGesture gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer();
        _FamilyHolders.hoverGesture = gesture;
        await gesture.moveTo(tester.getCenter(find.byType(Card).first));
      },
      expectMid: (WidgetTester tester) {
        expect(
          _hasLiveTransform(tester),
          isTrue,
          reason: 'card lifts on hover',
        );
      },
      release: (WidgetTester tester) async {
        await _FamilyHolders.hoverGesture!.moveTo(Offset.zero);
        await _FamilyHolders.hoverGesture!.removePointer();
        _FamilyHolders.hoverGesture = null;
      },
      fingerprint: (WidgetTester tester) =>
          'card=${find.byType(Card).evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'calendar month slide',
      preview: calendarPreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('>'));
      },
      expectMid: (WidgetTester tester) {
        final List<double> dx = <double>[
          for (final Transform t in tester.widgetList<Transform>(
            find.byType(Transform),
          ))
            t.transform.getTranslation().x,
        ];
        expect(
          dx.any((double x) => x != 0),
          isTrue,
          reason: 'grid slides with navigation: $dx',
        );
      },
      fingerprint: (WidgetTester tester) =>
          'header=${find.text('2024-4').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'carousel page',
      preview: carouselPreviews.first,
      // A drag release snaps through the carousel's internal transition
      // (preview buttons drive the controller directly, bypassing it).
      interact: (WidgetTester tester) async {
        await tester.drag(find.text('1').first, const Offset(-200, 0));
        await tester.pump();
      },
      expectMid: (WidgetTester tester) {
        expect(
          tester.binding.transientCallbackCount,
          greaterThan(0),
          reason: 'page transition eases',
        );
      },
      fingerprint: (WidgetTester tester) =>
          'slide=${find.text('Slide 2 of 5').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'alert enter',
      preview: alertPreviews.first,
      interact: (WidgetTester tester) async {},
      expectMid: (WidgetTester tester) async {},
      fingerprint: (WidgetTester tester) =>
          'title=${find.text('Heads up').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'collapsible expand',
      preview: collapsiblePreviews.first,
      interact: (WidgetTester tester) async {
        await tester.tap(find.text('Recent activity'));
      },
      expectMid: (WidgetTester tester) {
        expect(_hasLiveTransform(tester), isTrue, reason: 'chevron rotates');
      },
      fingerprint: (WidgetTester tester) =>
          'rows=${find.text('@flutter/flutter').evaluate().isNotEmpty}',
    ),
    _Family(
      name: 'dot indicator change',
      preview: dotIndicatorPreviews.first,
      interact: (WidgetTester tester) async {
        final Offset center = tester.getCenter(
          find.byType(AnimatedContainer).at(2),
        );
        final TestGesture gesture = await tester.startGesture(center);
        _FamilyHolders.pressGesture = gesture;
      },
      expectMid: (WidgetTester tester) {
        expect(
          _hasLiveTransform(tester),
          isTrue,
          reason: 'dot press feedback mid-flight',
        );
      },
      release: (WidgetTester tester) async {
        await _FamilyHolders.pressGesture!.up();
        _FamilyHolders.pressGesture = null;
      },
      fingerprint: (WidgetTester tester) =>
          'index=${find.text('index 2').evaluate().isNotEmpty}',
    ),
  ];

  for (final _Family family in families) {
    testWidgets('${family.name}: motion animates, final matches no-motion', (
      WidgetTester tester,
    ) async {
      final String enabled = await _runEnabled(tester, family);
      // Full teardown between runs: routes, overlays and popover entries
      // from the enabled run must be unmounted (not just replaced, which a
      // Navigator can survive) before the reduced run mounts.
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(milliseconds: 100));
      final String disabled = await _runDisabled(tester, family);
      await tester.pumpWidget(const SizedBox());
      expect(
        disabled,
        enabled,
        reason: '${family.name} final state differs without motion',
      );
    });
  }

  group('mount-only families', () {
    testWidgets('timeline staggers on first show', (WidgetTester tester) async {
      await pumpFamily(tester, timelinePreviews.first);
      await tester.pump(const Duration(milliseconds: 150));
      final List<double> mid = <double>[
        for (final FadeSlideInState s in tester.stateList<FadeSlideInState>(
          find.byType(FadeSlideIn),
        ))
          s.progress,
      ];
      expect(mid.length, greaterThan(1));
      expect(mid.first, greaterThan(mid.last), reason: 'entries stagger: $mid');
      await tester.pump(const Duration(milliseconds: 800));
      for (final FadeSlideInState s in tester.stateList<FadeSlideInState>(
        find.byType(FadeSlideIn),
      )) {
        expect(s.progress, 1.0);
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('alert enters on mount', (WidgetTester tester) async {
      await pumpFamily(tester, alertPreviews.first);
      await tester.pump(const Duration(milliseconds: 50));
      final FadeSlideInState state = tester.state<FadeSlideInState>(
        find.byType(FadeSlideIn),
      );
      expect(state.progress, greaterThan(0.0));
      expect(state.progress, lessThan(1.0));
      await tester.pump(const Duration(milliseconds: 400));
      expect(state.progress, 1.0);
      expect(tester.takeException(), isNull);
    });
  });

  group('progress value', () {
    testWidgets('determinate fill eases to the new value', (
      WidgetTester tester,
    ) async {
      final GlobalKey<_ValueHostState> key = GlobalKey<_ValueHostState>();
      await pumpFamily(
        tester,
        ComponentPreview('value', (_) => _ValueHost(key: key, initial: 0.25)),
      );
      await tester.pump();
      key.currentState!.setValue(0.75);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(
        tester.binding.transientCallbackCount,
        greaterThan(0),
        reason: 'fill eases to the new value',
      );
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion snaps the fill with no ticker', (
      WidgetTester tester,
    ) async {
      final GlobalKey<_ValueHostState> key = GlobalKey<_ValueHostState>();
      await pumpFamily(
        tester,
        ComponentPreview('value', (_) => _ValueHost(key: key, initial: 0.25)),
        disabled: true,
        theme: _noMotion,
      );
      await tester.pump();
      key.currentState!.setValue(0.75);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });
  });

  group('input_otp error', () {
    testWidgets('error shakes once and message fades in', (
      WidgetTester tester,
    ) async {
      await pumpFamily(
        tester,
        ComponentPreview(
          'otp',
          (_) => InputOtp(
            length: 4,
            validator: (String? code) => code == '1234' ? null : 'Wrong code',
            autovalidateMode: FormValidationMode.changed,
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(InputOtp).first);
      await tester.pump();
      await tester.enterText(find.byType(EditableText).first, '0000');
      await tester.pump();
      expect(find.text('Wrong code'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 150));
      // The shake ran and the message is mid-fade or settled; exact
      // shake-frame timing varies with the validation landing.
      final ErrorShakeState state = tester.state<ErrorShakeState>(
        find.byType(ErrorShake),
      );
      expect(state.shakeCount, 1);
      final FadeSlideInState fade = tester.state<FadeSlideInState>(
        find.byType(FadeSlideIn),
      );
      expect(fade.progress, greaterThan(0.0));
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });
  });
}

/// Shared holders for gestures and pre-interaction measurements.
class _FamilyHolders {
  static TestGesture? pressGesture;
  static TestGesture? hoverGesture;
  static Size dotBefore = Size.zero;
  static Offset thumbBefore = Offset.zero;
}

/// Host driving a raw [Progress] through programmatic value changes.
class _ValueHost extends StatefulWidget {
  const _ValueHost({super.key, required this.initial});

  final double initial;

  @override
  State<_ValueHost> createState() => _ValueHostState();
}

class _ValueHostState extends State<_ValueHost> {
  late double value = widget.initial;

  /// Sets the progress value.
  void setValue(double next) => setState(() => value = next);

  @override
  Widget build(BuildContext context) => Progress(value: value);
}
