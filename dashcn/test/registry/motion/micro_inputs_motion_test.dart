// Micro-animation contract for the input and control widgets (MOTION.md).
//
// Each widget gets a motion test that pumps frames, samples the animated
// value over time and checks it settles at the right end value, plus a
// reduced-motion test: with MediaQuery.disableAnimations set there is no
// movement and no scale, only the end state.

import 'dart:math' as math;

import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/checkbox/checkbox.dart';
import 'package:dashcn/src/components/checkbox/checkbox_mark.dart';
import 'package:dashcn/src/components/code_snippet/code_snippet.dart';
import 'package:dashcn/src/components/segmented_control/segmented_control.dart';
import 'package:dashcn/src/components/slider/slider.dart';
import 'package:dashcn/src/components/star_rating/star_rating.dart';
import 'package:dashcn/src/components/star_rating/star_rating_pop.dart';
import 'package:dashcn/src/components/switch/switch.dart';
import 'package:dashcn/src/components/text_area/text_area.dart';
import 'package:dashcn/src/components/toggle/toggle.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/focus_outline.dart';
import 'package:dashcn/src/primitives/motion/error_shake.dart';
import 'package:dashcn/src/primitives/selectable_radio/selectable_radio.dart';
import 'package:dashcn/src/primitives/slider/slider_painter.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const ValueKey<String> _radioToggleKey = ValueKey<String>('radio.toggle');

/// Inset of the switch thumb at rest and its travel to the on position.
const double switchInset = 0;
const double switchTravel = 14;

/// Wraps [child] in the theme, text direction and reduced-motion flag.
Widget _frame(Widget child, {bool disableAnimations = false}) {
  return MediaQuery(
    data: MediaQueryData(disableAnimations: disableAnimations),
    child: Theme(
      data: const ThemeData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        // EditableText needs an Overlay ancestor (magnifier, toolbar).
        child: Overlay(
          initialEntries: <OverlayEntry>[
            OverlayEntry(
              builder: (BuildContext context) => Center(child: child),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Alpha of the slider value label's background (0 hidden, 1 shown).
double labelAlpha(WidgetTester tester) {
  final Iterable<BoxDecoration> decorations = find
      .ancestor(of: find.text('0.5'), matching: find.byType(DecoratedBox))
      .evaluate()
      .map((Element e) => (e.widget as DecoratedBox).decoration)
      .whereType<BoxDecoration>();
  return decorations.map((BoxDecoration d) => d.color?.a ?? 0).reduce(math.max);
}

/// Vertical rise of the slider value label (4 px at rest, 0 when settled).
double labelRise(WidgetTester tester) {
  final Iterable<Transform> transforms = find
      .ancestor(of: find.text('0.5'), matching: find.byType(Transform))
      .evaluate()
      .map((Element e) => e.widget as Transform);
  return transforms
      .map((Transform t) => t.transform.storage[13])
      .reduce((double a, double b) => a > b ? a : b);
}

/// Scale (x) of the first `Transform` under [finder] (the press transform).
double _pressScale(WidgetTester tester, Finder finder) {
  final Transform transform = tester.widget<Transform>(
    find.descendant(of: finder, matching: find.byType(Transform)).first,
  );
  return transform.transform.storage[0];
}

void main() {
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (
          MethodCall call,
        ) async {
          return null;
        });
  });

  group('button', () {
    testWidgets('press scales to 0.97 and springs back to 1.0', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(Button(onPressed: () {}, child: const Text('Save'))),
      );
      final Finder button = find.byType(Button);
      expect(_pressScale(tester, button), closeTo(1.0, 1e-6));

      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(button),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      final double mid = _pressScale(tester, button);
      expect(mid, lessThan(1.0), reason: 'the press starts immediately');
      expect(mid, greaterThan(0.9));

      await tester.pump(const Duration(milliseconds: 300));
      expect(_pressScale(tester, button), closeTo(0.97, 1e-3));

      await gesture.up();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(_pressScale(tester, button), closeTo(1.0, 1e-3));
    });

    testWidgets('reduced motion never scales the press', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          Button(onPressed: () {}, child: const Text('Save')),
          disableAnimations: true,
        ),
      );
      final Finder button = find.byType(Button);
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(button),
      );
      await tester.pump();
      expect(_pressScale(tester, button), closeTo(1.0, 1e-6));
      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  group('toggle', () {
    testWidgets('press scales to 0.97 and springs back to 1.0', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          Toggle(value: false, onChanged: (_) {}, child: const Text('Bold')),
        ),
      );
      final Finder toggle = find.byType(Toggle);
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(toggle),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(_pressScale(tester, toggle), lessThan(1.0));
      await tester.pump(const Duration(milliseconds: 300));
      expect(_pressScale(tester, toggle), closeTo(0.97, 1e-3));
      await gesture.up();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(_pressScale(tester, toggle), closeTo(1.0, 1e-3));
    });

    testWidgets('reduced motion never scales the press', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          Toggle(value: false, onChanged: (_) {}, child: const Text('Bold')),
          disableAnimations: true,
        ),
      );
      final Finder toggle = find.byType(Toggle);
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(toggle),
      );
      await tester.pump();
      expect(_pressScale(tester, toggle), closeTo(1.0, 1e-6));
      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  group('switch', () {
    // Rendered geometry: the AnimatedPositioned widget only carries the
    // target values, so the thumb is measured where it is painted.
    Rect trackRect(WidgetTester tester) =>
        tester.getRect(find.byKey(kSwitchTrackKey));
    Rect thumbRect(WidgetTester tester) =>
        tester.getRect(find.byKey(kSwitchThumbKey));
    double thumbLeft(WidgetTester tester) =>
        thumbRect(tester).left - trackRect(tester).left;
    double thumbWidth(WidgetTester tester) => thumbRect(tester).width;

    testWidgets('thumb slides with a spring and widens while pressed', (
      WidgetTester tester,
    ) async {
      bool value = false;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Switch(
                value: value,
                onChanged: (bool next) => setState(() => value = next),
              );
            },
          ),
        ),
      );
      expect(thumbLeft(tester), closeTo(switchInset, 0.01));
      final double restWidth = thumbWidth(tester);

      // Press: the thumb widens about 20 % and stays put.
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(find.byType(Switch)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(thumbWidth(tester), closeTo(restWidth * 1.2, 0.1));
      // Cancel (not release) so the press does not count as a toggle.
      await gesture.cancel();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(thumbWidth(tester), closeTo(restWidth, 0.1));

      // Toggle on: the thumb slides from the left edge to the travel stop.
      await tester.tap(find.byType(Switch));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 80));
      final double mid = thumbLeft(tester);
      expect(mid, greaterThan(switchInset + 0.5));
      expect(mid, lessThan(switchInset + switchTravel - 0.5));
      await tester.pump(const Duration(milliseconds: 400));
      expect(thumbLeft(tester), closeTo(switchInset + switchTravel, 0.01));
    });

    testWidgets('track colour cross-fades over 150 ms', (
      WidgetTester tester,
    ) async {
      bool value = false;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Switch(
                value: value,
                onChanged: (bool next) => setState(() => value = next),
              );
            },
          ),
        ),
      );
      Color trackColor() {
        final BoxDecoration decoration =
            tester
                    .widget<DecoratedBox>(
                      find
                          .descendant(
                            of: find.byKey(kSwitchTrackKey),
                            matching: find.byType(DecoratedBox),
                          )
                          .first,
                    )
                    .decoration
                as BoxDecoration;
        return decoration.color!;
      }

      final Color start = trackColor();
      await tester.tap(find.byType(Switch));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));
      final Color mid = trackColor();
      expect(mid, isNot(equals(start)));
      await tester.pump(const Duration(milliseconds: 300));
      expect(trackColor(), isNot(equals(start)));
      expect(trackColor(), isNot(equals(mid)));
    });

    testWidgets('reduced motion: the thumb does not widen and jumps', (
      WidgetTester tester,
    ) async {
      bool value = false;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Switch(
                value: value,
                onChanged: (bool next) => setState(() => value = next),
              );
            },
          ),
          disableAnimations: true,
        ),
      );
      final double restWidth = thumbWidth(tester);
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(find.byType(Switch)),
      );
      await tester.pump();
      expect(thumbWidth(tester), closeTo(restWidth, 0.01));
      // A completed tap toggles on, and the thumb jumps with no slide.
      await gesture.up();
      await tester.pump();
      expect(thumbLeft(tester), closeTo(switchInset + switchTravel, 0.01));
    });
  });

  group('checkbox', () {
    testWidgets('fills, then the check path draws in over 150 ms after 50 ms', (
      WidgetTester tester,
    ) async {
      bool checked = false;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Checkbox(
                value: checked
                    ? CheckboxValue.checked
                    : CheckboxValue.unchecked,
                onChanged: (CheckboxValue next) =>
                    setState(() => checked = next == CheckboxValue.checked),
              );
            },
          ),
        ),
      );
      double progress() =>
          tester.state<CheckboxMarkState>(find.byType(CheckboxMark)).progress;

      expect(progress(), 0.0);
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      // Still inside the 50 ms lead: nothing drawn yet.
      await tester.pump(const Duration(milliseconds: 25));
      expect(progress(), 0.0);
      // Mid-draw.
      await tester.pump(const Duration(milliseconds: 100));
      expect(progress(), greaterThan(0.0));
      expect(progress(), lessThan(1.0));
      // Settled.
      await tester.pump(const Duration(milliseconds: 300));
      expect(progress(), 1.0);
    });

    testWidgets('reduced motion snaps the check with no draw', (
      WidgetTester tester,
    ) async {
      bool checked = false;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Checkbox(
                value: checked
                    ? CheckboxValue.checked
                    : CheckboxValue.unchecked,
                onChanged: (CheckboxValue next) =>
                    setState(() => checked = next == CheckboxValue.checked),
              );
            },
          ),
          disableAnimations: true,
        ),
      );
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      expect(
        tester.state<CheckboxMarkState>(find.byType(CheckboxMark)).progress,
        1.0,
      );
    });
  });

  group('radio', () {
    testWidgets('dot scales in with a spring and out on deselect', (
      WidgetTester tester,
    ) async {
      bool selected = false;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioIndicator(selected: selected),
                  GestureDetector(
                    key: _radioToggleKey,
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => selected = !selected),
                    child: const SizedBox(width: 40, height: 40),
                  ),
                ],
              );
            },
          ),
        ),
      );
      // Painted scale: the dot's child box measured through the transform.
      double dotScale() {
        final Rect rect = tester.getRect(
          find
              .descendant(
                of: find.byKey(kRadioIndicatorDotKey),
                matching: find.byType(Container),
              )
              .first,
        );
        return rect.width / 8.0;
      }

      expect(dotScale(), 0.0);

      await tester.tap(find.byKey(_radioToggleKey));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 40));
      final double mid = dotScale();
      expect(mid, greaterThan(0.0));
      expect(mid, lessThan(1.2));
      await tester.pump(const Duration(milliseconds: 300));
      expect(dotScale(), 1.0);

      await tester.tap(find.byKey(_radioToggleKey));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(dotScale(), 0.0);
    });

    testWidgets('reduced motion sets the dot at once', (
      WidgetTester tester,
    ) async {
      bool selected = false;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioIndicator(selected: selected),
                  GestureDetector(
                    key: _radioToggleKey,
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => selected = !selected),
                    child: const SizedBox(width: 40, height: 40),
                  ),
                ],
              );
            },
          ),
          disableAnimations: true,
        ),
      );
      await tester.tap(find.byKey(_radioToggleKey));
      await tester.pump();
      expect(
        tester
                .getRect(
                  find
                      .descendant(
                        of: find.byKey(kRadioIndicatorDotKey),
                        matching: find.byType(Container),
                      )
                      .first,
                )
                .width /
            8.0,
        closeTo(1.0, 1e-6),
      );
    });
  });

  group('slider', () {
    testWidgets('thumb grows to 1.2 on press and the label rises in', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 240,
            child: Slider(value: 0.5, onChanged: (double _) {}),
          ),
        ),
      );
      SliderPainter painter() => tester
          .widgetList<CustomPaint>(find.byType(CustomPaint))
          .map((CustomPaint p) => p.painter)
          .whereType<SliderPainter>()
          .first;
      expect(painter().thumbScale, closeTo(1.0, 1e-6));

      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(find.byType(Slider)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      final double mid = painter().thumbScale;
      expect(mid, greaterThan(1.0));
      expect(mid, lessThan(1.2));
      await tester.pump(const Duration(milliseconds: 200));
      expect(painter().thumbScale, closeTo(1.2, 1e-3));

      // The label fades in (alpha of its background) and rises 4 px into place
      // while the thumb is pressed.
      expect(labelAlpha(tester), closeTo(1.0, 1e-3));
      expect(labelRise(tester), closeTo(0.0, 1e-3));

      await gesture.up();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(painter().thumbScale, closeTo(1.0, 1e-3));
    });

    testWidgets('reduced motion: no thumb scale and no label rise', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 240,
            child: Slider(value: 0.5, onChanged: (double _) {}),
          ),
          disableAnimations: true,
        ),
      );
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(find.byType(Slider)),
      );
      await tester.pump();
      final SliderPainter painter = tester
          .widgetList<CustomPaint>(find.byType(CustomPaint))
          .map((CustomPaint p) => p.painter)
          .whereType<SliderPainter>()
          .first;
      expect(painter.thumbScale, closeTo(1.0, 1e-3));
      expect(labelAlpha(tester), closeTo(1.0, 1e-3));
      expect(labelRise(tester), closeTo(0.0, 1e-3));
      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  group('segmented control', () {
    testWidgets('selection pill slides to the new segment over 200 ms', (
      WidgetTester tester,
    ) async {
      String value = 'a';
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SegmentedControl<String>(
                value: value,
                onChanged: (String next) => setState(() => value = next),
                segments: const <SegmentedControlSegment<String>>[
                  SegmentedControlSegment<String>(value: 'a', label: Text('A')),
                  SegmentedControlSegment<String>(value: 'b', label: Text('B')),
                  SegmentedControlSegment<String>(value: 'c', label: Text('C')),
                ],
              );
            },
          ),
        ),
      );
      await tester.pump();
      // The thumb is measured where it is painted, relative to the control.
      double pillLeft() =>
          tester
              .getRect(
                find
                    .descendant(
                      of: find.byType(AnimatedPositioned),
                      matching: find.byType(DecoratedBox),
                    )
                    .first,
              )
              .left -
          tester.getRect(find.byType(SegmentedControl<String>)).left;
      final double start = pillLeft();

      await tester.tap(find.text('B'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));
      final double mid = pillLeft();
      expect(mid, greaterThan(start));
      expect(mid, lessThan(start + 1000));
      await tester.pump(const Duration(milliseconds: 300));
      final double end = pillLeft();
      expect(end, greaterThan(mid));
      await tester.pump(const Duration(milliseconds: 200));
      expect(pillLeft(), closeTo(end, 1e-6));
    });
  });

  group('text area and input', () {
    testWidgets('focus ring fades in over 100 ms', (WidgetTester tester) async {
      final FocusNode focus = FocusNode();
      addTearDown(focus.dispose);
      await tester.pumpWidget(_frame(TextArea(focusNode: focus)));
      double ringTop() => tester
          .widget<Positioned>(
            find
                .descendant(
                  of: find.byType(FocusOutline),
                  matching: find.byType(Positioned),
                )
                .last,
          )
          .top!;
      expect(ringTop(), closeTo(0, 1e-6));

      focus.requestFocus();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(ringTop(), greaterThan(-3));
      expect(ringTop(), lessThan(0));
      await tester.pump(const Duration(milliseconds: 150));
      expect(ringTop(), closeTo(-3, 1e-3));
    });

    testWidgets('an error shakes once for 300 ms, then settles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          TextArea(
            validator: (String? value) =>
                (value ?? '').length < 4 ? 'Too short' : null,
          ),
        ),
      );
      await tester.enterText(find.byType(TextArea), 'ab');
      await tester.pump();
      double offsetX() {
        final Transform transform = tester.widget<Transform>(
          find
              .descendant(
                of: find.byType(ErrorShake),
                matching: find.byType(Transform),
              )
              .first,
        );
        return transform.transform.storage[12];
      }

      // Sample the first 200 ms: the field moves off-centre, never beyond the
      // 4 px amplitude, and is still moving past 150 ms (a 150 ms shake would
      // have finished).
      double peak = 0;
      for (int i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 10));
        peak = math.max(peak, offsetX().abs());
        expect(offsetX().abs(), lessThanOrEqualTo(4.0 + 1e-6));
      }
      expect(peak, greaterThan(0.5));
      expect(offsetX().abs(), greaterThan(0.0));
      // Settled at the end of the 300 ms run.
      await tester.pump(const Duration(milliseconds: 300));
      expect(offsetX(), closeTo(0, 1e-6));
      expect(find.text('Too short'), findsOneWidget);
    });

    testWidgets('reduced motion: no focus travel and no shake', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          TextArea(
            validator: (String? value) =>
                (value ?? '').length < 4 ? 'Too short' : null,
          ),
          disableAnimations: true,
        ),
      );
      await tester.enterText(find.byType(TextArea), 'ab');
      await tester.pump();
      // No shake transform is built at all: the message simply appears.
      expect(
        find.descendant(
          of: find.byType(ErrorShake),
          matching: find.byType(Transform),
        ),
        findsNothing,
      );
      expect(find.text('Too short'), findsOneWidget);
    });
  });

  group('star rating', () {
    testWidgets('a selected star pops 1.0 to 1.2 and back', (
      WidgetTester tester,
    ) async {
      double value = 0;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return StarRating(
                value: value,
                onChanged: (double next) => setState(() => value = next),
              );
            },
          ),
        ),
      );
      double scaleOf(int index) =>
          tester.state<StarPopState>(find.byType(StarPop).at(index)).scale;
      expect(scaleOf(2), closeTo(1.0, 1e-6));

      await tester.tap(find.byType(StarPop).at(2));
      // The fill eases to the tapped value, so star 2 becomes selected a few
      // frames after the tap. Wait for that, then sample the pop.
      bool selectedAt2() =>
          tester.widget<StarPop>(find.byType(StarPop).at(2)).selected;
      for (int i = 0; i < 60 && !selectedAt2(); i++) {
        await tester.pump(const Duration(milliseconds: 10));
      }
      expect(selectedAt2(), isTrue);
      await tester.pump(const Duration(milliseconds: 60));
      final double peak = scaleOf(2);
      expect(peak, greaterThan(1.0));
      expect(peak, lessThanOrEqualTo(1.2 + 1e-6));
      await tester.pump(const Duration(milliseconds: 300));
      expect(scaleOf(2), closeTo(1.0, 1e-6));
    });

    testWidgets('reduced motion never pops', (WidgetTester tester) async {
      double value = 0;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return StarRating(
                value: value,
                onChanged: (double next) => setState(() => value = next),
              );
            },
          ),
          disableAnimations: true,
        ),
      );
      await tester.tap(find.byType(StarPop).at(2));
      await tester.pump();
      expect(
        tester.state<StarPopState>(find.byType(StarPop).at(2)).scale,
        closeTo(1.0, 1e-6),
      );
    });
  });

  group('code snippet copy button', () {
    testWidgets('icon swaps to a check, then reverts after 1.5 s', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_frame(const CodeSnippet(code: Text('hello()'))));
      await tester.tap(find.byIcon(LucideIcons.copy));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 75));
      // Mid cross-scale: the new icon is still scaling in.
      expect(find.byIcon(LucideIcons.check), findsOneWidget);
      // Still copied just before 1.5 s.
      await tester.pump(const Duration(milliseconds: 1300));
      expect(find.byIcon(LucideIcons.check), findsOneWidget);
      // Step in 50 ms frames until the check has faded out: the revert lands
      // at 1.5 s and the 150 ms cross-scale ends shortly after.
      int elapsed = 1375;
      while (find.byIcon(LucideIcons.check).evaluate().isNotEmpty &&
          elapsed < 3000) {
        await tester.pump(const Duration(milliseconds: 50));
        elapsed += 50;
      }
      expect(elapsed, inInclusiveRange(1500, 1800));
      expect(find.byIcon(LucideIcons.copy), findsOneWidget);
    });

    testWidgets('reduced motion only fades the swap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          const CodeSnippet(code: Text('hello()')),
          disableAnimations: true,
        ),
      );
      await tester.tap(find.byIcon(LucideIcons.copy));
      await tester.pump();
      expect(
        find.descendant(
          of: find.byType(AnimatedSwitcher),
          matching: find.byType(ScaleTransition),
        ),
        findsNothing,
      );
      await tester.pump(const Duration(milliseconds: 1600));
    });
  });
}
