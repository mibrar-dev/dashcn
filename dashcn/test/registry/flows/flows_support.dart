// Shared harness for the flow tests (`test/registry/flows/**`).
//
// A flow is the layer-5 unit of the registry: `lib/src/flows/<id>/` with
// `flow.dart` (the public `<Name>Flow` widget owning a nested `Navigator`),
// `screens/*.dart`, `meta.json` (`type: flow`) and `README.md`. Every flow
// test walks every screen with taps/drags in light + dark and LTR + RTL.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Brightnesses every flow is walked under.
const List<Brightness> flowBrightnesses = <Brightness>[
  Brightness.light,
  Brightness.dark,
];

/// Directions every flow is walked under.
const List<TextDirection> flowDirections = <TextDirection>[
  TextDirection.ltr,
  TextDirection.rtl,
];

/// Theme for [brightness] with the fallback tokens.
ThemeData flowTheme(Brightness brightness) => ThemeData(
  colors: brightness == Brightness.dark
      ? ThemeColors.darkFallback
      : ThemeColors.lightFallback,
);

/// Pumps [flow] in a 390x844 stage and settles the entry transition.
///
/// No `pumpAndSettle`: screens hold focusable fields whose cursor blink never
/// settles.
Future<void> pumpFlow(
  WidgetTester tester,
  Widget flow, {
  required Brightness brightness,
  required TextDirection direction,
}) async {
  await tester.pumpWidget(
    Theme(
      data: flowTheme(brightness),
      child: Directionality(
        textDirection: direction,
        child: Overlay.wrap(
          child: Center(child: SizedBox(width: 390, height: 844, child: flow)),
        ),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 500));
  final Object? exception = tester.takeException();
  expect(exception, isNull, reason: 'flow threw on pump: $exception');
}

/// Pumps past a page-route transition (300 ms) without settling endlessly.
Future<void> pumpRoute(WidgetTester tester) =>
    tester.pump(const Duration(milliseconds: 500));

/// Settles after taps that submit forms, push routes or open dialogs:
/// one frame to start the work, one for async callbacks, one past the
/// 300 ms route transition, and one for the final build (a settle
/// animation's completing tick can land after its frame's build phase).
/// No `pumpAndSettle` (cursor blink never settles).
Future<void> flowSettle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump();
}

/// EditableText inside the widget keyed [key] (Input/InputOtp/composer).
Finder fieldOf(ValueKey<String> key) =>
    find.descendant(of: find.byKey(key), matching: find.byType(EditableText));

/// Pumps until the swipe row under [row] settles fully open or [tries] run
/// out.
///
/// The settle animation's first tick lands a frame after `forward()`, so a
/// fixed pump count catches it mid-flight and the next tap lands on the
/// still-covering row (closing it instead of firing the action). Polling the
/// row's translate transform is deterministic.
Future<void> settleSwipeOpen(
  WidgetTester tester,
  Finder row,
  TextDirection direction, {
  required double totalWidth,
  int tries = 20,
}) async {
  final double want = direction == TextDirection.rtl ? totalWidth : -totalWidth;
  for (var i = 0; i < tries; i++) {
    for (final Element element
        in find
            .descendant(of: row, matching: find.byType(Transform))
            .evaluate()) {
      final Transform transform = element.widget as Transform;
      if ((transform.transform.getTranslation().x - want).abs() < 1.0) {
        return;
      }
    }
    await tester.pump(const Duration(milliseconds: 100));
  }
  fail('swipe row never settled open');
}

/// Drags a swipe-actions row open without dismissing it.
///
/// `tester.drag` delivers its moves with no frames in between and the arena
/// swallows the first slop-sized move (~20 px), so the revealed fraction is
/// swallows the first slop-sized move (~20 px), so the revealed fraction is
/// `(distance - 20) / totalWidth`. This aims at 0.9: safely past the 0.5
/// open threshold and clear of the 1.05 dismiss line, with the release
/// velocity reading 0 (same-timestamp events) so the row settles by position.
/// Pumps during the gesture are avoided on purpose: rebuilding mid-gesture
/// wedges the arena and later taps stop firing inside scrollables.
Future<void> dragOpen(
  WidgetTester tester,
  Finder row,
  TextDirection direction, {
  required double totalWidth,
}) async {
  final double distance = totalWidth * 0.9 + 20;
  await tester.drag(
    row,
    direction == TextDirection.rtl ? Offset(distance, 0) : Offset(-distance, 0),
  );
}
