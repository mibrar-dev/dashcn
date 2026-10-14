// Widget tests for the `button` status machine (P7-S1), part 2.
//
// Semantics announcements, reduced motion, theme overrides, group items,
// RTL mirroring, density and style merge/lerp. Core flows live in
// `button_status_test.dart`; controller units in
// `button_status_controller_test.dart`.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/spinner/spinner.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/density.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection textDirection = TextDirection.ltr,
  bool disableAnimations = false,
  required Widget child,
}) {
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(
        textDirection: textDirection,
        child: MediaQuery(
          data: MediaQueryData(disableAnimations: disableAnimations),
          child: Center(child: child),
        ),
      ),
    ),
  );
}

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection textDirection = TextDirection.ltr,
  bool disableAnimations = false,
}) {
  return tester.pumpWidget(
    _frame(
      data: data,
      app: app,
      textDirection: textDirection,
      disableAnimations: disableAnimations,
      child: child,
    ),
  );
}

void main() {
  testWidgets('semantics announce through a live region', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    final Completer<void> gate = Completer<void>();
    await _pump(
      tester,
      Button(onPressedAsync: () => gate.future, child: const Text('Go')),
    );
    expect(find.bySemanticsLabel('Loading'), findsNothing);
    await tester.tap(find.byType(Button));
    await tester.pump();
    // Past the enter fade: fully transparent widgets stay hidden from the
    // semantics tree until the transition completes.
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.bySemanticsLabel('Loading'), findsOneWidget);
    expect(
      tester
          .getSemantics(find.bySemanticsLabel('Loading'))
          .flagsCollection
          .isLiveRegion,
      isTrue,
    );
    gate.complete();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.bySemanticsLabel('Success'), findsOneWidget);
    expect(
      tester
          .getSemantics(find.bySemanticsLabel('Success'))
          .flagsCollection
          .isLiveRegion,
      isTrue,
    );
    handle.dispose();
  });

  testWidgets('reduced motion shows a static glyph, no spinner', (
    tester,
  ) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    final Completer<void> gate = Completer<void>();
    await _pump(
      tester,
      Button(onPressedAsync: () => gate.future, child: const Text('Go')),
      disableAnimations: true,
    );
    await tester.tap(find.byType(Button));
    await tester.pump();
    expect(find.byType(Spinner), findsNothing);
    expect(find.byIcon(LucideIcons.loaderCircle), findsOneWidget);
    // No fade to wait out: reduced motion swaps instantly.
    expect(find.bySemanticsLabel('Loading'), findsOneWidget);
    gate.complete();
    await tester.pump();
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
    handle.dispose();
    expect(tester.takeException(), isNull);
  });

  testWidgets('theme override changes the failure icon and color', (
    tester,
  ) async {
    const Color custom = Color(0xFF123456);
    final Completer<void> gate = Completer<void>();
    await _pump(
      tester,
      ComponentTheme<ButtonTheme>(
        data: const ButtonTheme(
          status: ButtonStatusStyle(
            failureIcon: LucideIcons.triangleAlert,
            failureColor: ThemedColor.value(custom),
          ),
        ),
        child: Button(
          onPressedAsync: () => gate.future,
          child: const Text('Go'),
        ),
      ),
    );
    await tester.tap(find.byType(Button));
    await tester.pump();
    gate.completeError(StateError('Nope.'));
    await tester.pump();
    expect(find.byIcon(LucideIcons.triangleAlert), findsOneWidget);
    expect(
      tester.widget<Icon>(find.byIcon(LucideIcons.triangleAlert)).color,
      custom,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('group items share the status core', (tester) async {
    final Completer<void> gate = Completer<void>();
    await _pump(
      tester,
      ButtonGroup(
        children: <Widget>[
          Button(
            variant: ButtonVariant.outline,
            onPressedAsync: () => gate.future,
            child: const Text('Prev'),
          ),
          Button(
            variant: ButtonVariant.outline,
            onPressed: () {},
            child: const Text('Next'),
          ),
        ],
      ),
    );
    await tester.tap(find.widgetWithText(Button, 'Prev'));
    await tester.pump();
    expect(find.byType(Spinner), findsOneWidget);
    gate.complete();
    await tester.pump();
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
  });

  testWidgets('leading slot mirrors under RTL', (tester) async {
    Future<double> slotDelta(TextDirection direction) async {
      await _pump(
        tester,
        Button(
          leading: const Icon(LucideIcons.plus, size: 16),
          onPressed: () {},
          child: const Text('Go'),
        ),
        textDirection: direction,
      );
      final double slot = tester.getCenter(find.byIcon(LucideIcons.plus)).dx;
      final double label = tester.getCenter(find.text('Go')).dx;
      return slot - label;
    }

    expect(await slotDelta(TextDirection.ltr), isNegative);
    expect(await slotDelta(TextDirection.rtl), isPositive);
  });

  testWidgets('compact density narrows the statusful padding', (tester) async {
    await _pump(
      tester,
      ComponentTheme<ButtonTheme>(
        data: const ButtonTheme(themeDensity: Density.compactDensity),
        child: Button(onPressedAsync: () async {}, child: const Text('Go')),
      ),
    );
    final Clickable clickable = tester.widget<Clickable>(
      find.descendant(
        of: find.byType(Button),
        matching: find.byType(Clickable),
      ),
    );
    expect(
      clickable.padding?.resolve(const <WidgetState>{}),
      const EdgeInsets.symmetric(horizontal: 8),
    );
  });

  test('ButtonStatusStyle merges and lerps through ButtonTheme', () {
    const Color blue = Color(0xFF0000FF);
    const ButtonStatusStyle receiver = ButtonStatusStyle(
      failureIcon: LucideIcons.triangleAlert,
      spinnerSize: 20,
    );
    const ButtonStatusStyle fallback = ButtonStatusStyle(
      failureIcon: LucideIcons.x,
      failureColor: ThemedColor.value(blue),
      spinnerSize: 16,
    );
    final ButtonStatusStyle merged = receiver.merge(fallback);
    expect(merged.failureIcon, LucideIcons.triangleAlert);
    expect(merged.failureColor, const ThemedColor.value(blue));
    expect(merged.spinnerSize, 20);

    const ButtonTheme a = ButtonTheme(
      status: ButtonStatusStyle(spinnerSize: 16),
    );
    const ButtonTheme b = ButtonTheme(
      status: ButtonStatusStyle(spinnerSize: 24),
    );
    expect(ButtonTheme.lerp(a, b, 0.25).status!.spinnerSize, 18);
    expect(ButtonTheme.lerp(a, b, 0.75).status!.spinnerSize, 22);
    expect(
      ButtonTheme.lerp(a, b, 0.25).status!.successIcon,
      isNull,
      reason: 'null icons stay null through lerp; resolve applies defaults',
    );
  });
}
