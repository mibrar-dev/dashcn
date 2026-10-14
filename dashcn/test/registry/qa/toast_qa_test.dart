// QA for `toast` previews (P7-Q2): behaviour, spacing, functionality.
//
// Drives every `toastPreviews` example like a user: each example shows a
// persistent toast on mount, placement buttons fire additional toasts, and
// the action/destructive variants render. Controller lifecycle (dispose with
// a visible toast, auto-dismiss timers) is pinned in `toast_test.dart` and
// the edge probes; this file pins the *previews* wire controllers correctly.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/toast/preview.dart';
import 'package:dashcn/src/components/toast/toast.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  double width = 420,
}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: direction,
      child: Center(
        child: SizedBox(width: width, child: child),
      ),
    ),
  );
}

Future<void> _pumpPreview(
  WidgetTester tester,
  ComponentPreview preview, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  double width = 420,
}) async {
  // P7-WA: previews only render a trigger; the toast opens over the whole
  // app through the app-level `ToastLayer`, so the harness hosts one (as the
  // docs shell does) and the behaviour tests drive the trigger.
  await tester.pumpWidget(
    Theme(
      data: data,
      child: Directionality(
        textDirection: direction,
        child: ToastLayer(
          child: Center(
            child: SizedBox(
              width: width,
              child: Builder(builder: preview.builder),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  await tester.pump(const Duration(milliseconds: 300));
  expect(
    tester.takeException(),
    isNull,
    reason: 'preview "${preview.name}" threw',
  );
}

ComponentPreview _example(String name) => toastPreviews.firstWhere(
  (ComponentPreview preview) => preview.name == name,
);

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in toastPreviews) {
      for (final colors in <ThemeColors>[
        ThemeColors.lightFallback,
        ThemeColors.darkFallback,
      ]) {
        await tester.pumpWidget(
          _frame(
            Builder(builder: preview.builder),
            data: ThemeData(colors: colors),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          tester.takeException(),
          isNull,
          reason: '${preview.name} light/dark',
        );
      }
    }
  });

  testWidgets('Default preview: trigger shows the toast', (tester) async {
    await _pumpPreview(tester, _example('Default'));
    expect(find.text('Saved to your workspace.'), findsNothing);
    await tester.tap(find.text('Show toast'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
    expect(find.text('Saved to your workspace.'), findsOneWidget);
  });

  testWidgets('Positions preview: placement button fires', (tester) async {
    await _pumpPreview(tester, _example('Positions'));
    await tester.tap(find.text('bottomCenter'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
    expect(find.textContaining('Toast at bottomCenter'), findsOneWidget);
  });

  testWidgets('Destructive preview: trigger shows the error toast', (
    tester,
  ) async {
    await _pumpPreview(tester, _example('Destructive'));
    expect(find.text('Could not save the file.'), findsNothing);
    await tester.tap(find.text('Show destructive toast'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
    expect(find.text('Could not save the file.'), findsOneWidget);
    expect(find.text('Show destructive toast'), findsOneWidget);
  });

  testWidgets('With action preview: trigger shows the action toast', (
    tester,
  ) async {
    await _pumpPreview(tester, _example('With action'));
    expect(find.text('Deployment started.'), findsNothing);
    await tester.tap(find.text('Show toast with action'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
    expect(find.text('Deployment started.'), findsOneWidget);
    expect(find.text('View'), findsOneWidget);
    expect(find.text('Show toast with action'), findsOneWidget);
  });

  testWidgets('Default preview fits a 375px phone with no overflow', (
    tester,
  ) async {
    await _pumpPreview(tester, toastPreviews[0], width: 375);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('previews mirror in RTL with no exception', (tester) async {
    for (final preview in toastPreviews) {
      await _pumpPreview(tester, preview, direction: TextDirection.rtl);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: '${preview.name} RTL');
    }
  });

  testWidgets('swipe tracks the finger mid-drag (P7-Q2)', (tester) async {
    final ToastController controller = ToastController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        SizedBox(
          width: 360,
          height: 220,
          child: ToastLayer(
            controller: controller,
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
    controller.showToast(
      autoDismiss: false,
      builder: (BuildContext context) => const Text('Drag me'),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    final TestGesture gesture = await tester.startGesture(
      tester.getCenter(find.text('Drag me')),
    );
    await gesture.moveTo(
      tester.getCenter(find.text('Drag me')) + const Offset(40, 0),
    );
    await tester.pump();
    // The card follows the finger instead of sitting still until release.
    final Offset offset = tester
        .widget<AnimatedSlide>(find.byType(AnimatedSlide).first)
        .offset;
    expect(offset.dx, greaterThan(0));
    await gesture.up();
    await tester.pumpAndSettle();
    // Below the dismiss threshold: springs back, toast survives.
    expect(find.text('Drag me'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('close button is keyboard-operable (P7-Q2)', (tester) async {
    final ToastController controller = ToastController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        SizedBox(
          width: 360,
          height: 220,
          child: ToastLayer(
            controller: controller,
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
    controller.showToast(
      autoDismiss: false,
      builder: (BuildContext context) => const Text('Closable'),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    // The close affordance is the accessible tap primitive now.
    expect(
      find.descendant(of: find.byType(Clickable), matching: find.byType(Icon)),
      findsOneWidget,
    );
    // Focus the close control (Tab traversal itself is framework-provided
    // by WidgetsApp Shortcuts, absent from this bare harness) and activate
    // with Enter, then Space on a second toast.
    FocusableActionDetector detector() => tester
        .widget<FocusableActionDetector>(find.byType(FocusableActionDetector));
    detector().focusNode!.requestFocus();
    await tester.pump();
    expect(detector().focusNode!.hasPrimaryFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('Closable'), findsNothing);
    controller.showToast(
      autoDismiss: false,
      builder: (BuildContext context) => const Text('Closable again'),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    detector().focusNode!.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(find.text('Closable again'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
