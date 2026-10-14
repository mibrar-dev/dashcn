// Widget tests for the `button` async status machine (P7-S1, dynamic width
// per user 2026-10-11).
//
// Covers the uncontrolled lifecycle (success, failure, reset timing, null
// reset), width hugging each state's content + animating between widths,
// disabled-while-loading, controlled mode and icon buttons. Semantics,
// reduced motion, theme overrides, group items, RTL, density and style units
// live in `button_status_extra_test.dart`; controller units in
// `button_status_controller_test.dart`.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/spinner/spinner.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
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

bool _clickableEnabled(WidgetTester tester) {
  return tester
      .widget<Clickable>(
        find.descendant(
          of: find.byType(Button),
          matching: find.byType(Clickable),
        ),
      )
      .enabled;
}

Size _buttonSize(WidgetTester tester) => tester.getSize(find.byType(Button));

void main() {
  testWidgets('success flow: loading, success, auto-reset, callbacks', (
    tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    final List<ButtonStatus> seen = <ButtonStatus>[];
    var calls = 0;
    await _pump(
      tester,
      Button(
        onPressedAsync: () {
          calls++;
          return gate.future;
        },
        onStatusChanged: seen.add,
        child: const Text('Save'),
      ),
    );
    final Size idle = _buttonSize(tester);

    await tester.tap(find.byType(Button));
    await tester.pump();
    expect(calls, 1);
    expect(find.byType(Spinner), findsOneWidget);
    expect(find.text('Save'), findsOneWidget, reason: 'label kept');
    expect(_clickableEnabled(tester), isFalse);
    expect(seen, <ButtonStatus>[ButtonStatus.loading]);
    // P7-TH1 dynamic width: no leading while idle, so loading (spinner 16 +
    // gap 8 + label) is wider than the idle label-only button. The
    // AnimatedSize glides there over the transition — measure past it.
    await tester.pump(const Duration(milliseconds: 200));
    final double loadingWidth = _buttonSize(tester).width;
    expect(loadingWidth, greaterThan(idle.width));
    expect(find.byType(AnimatedSize), findsOneWidget);

    gate.complete();
    await tester.pump();
    expect(find.byType(Spinner), findsNothing);
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(_clickableEnabled(tester), isTrue);
    expect(seen, <ButtonStatus>[ButtonStatus.loading, ButtonStatus.success]);
    // Success (check 16 + gap 8 + label) hugs the same width as loading:
    // both status icons are 16 wide.
    await tester.pump(const Duration(milliseconds: 200));
    expect(_buttonSize(tester).width, moreOrLessEquals(loadingWidth));

    await tester.pump(buttonDefaultStatusReset);
    // Past the 175ms exit fade: the outgoing icon unmounts only when its
    // AnimatedSwitcher transition completes.
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byIcon(LucideIcons.check), findsNothing);
    expect(seen.last, ButtonStatus.idle);
    // Back to the idle hug: the status icon + gap are gone.
    await tester.pump(const Duration(milliseconds: 200));
    expect(_buttonSize(tester).width, moreOrLessEquals(idle.width));
  });

  testWidgets('failure flow: glyph, tint, error callback, reset', (
    tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    final List<ButtonStatus> seen = <ButtonStatus>[];
    final List<Object> errors = <Object>[];
    await _pump(
      tester,
      Button(
        onPressedAsync: () => gate.future,
        onStatusChanged: seen.add,
        onAsyncError: (Object error, StackTrace _) => errors.add(error),
        child: const Text('Pay'),
      ),
    );
    final Size idle = _buttonSize(tester);

    await tester.tap(find.byType(Button));
    await tester.pump();
    gate.completeError(StateError('Card declined.'));
    await tester.pump();
    expect(find.byIcon(LucideIcons.x), findsOneWidget);
    expect(
      tester.widget<Icon>(find.byIcon(LucideIcons.x)).color,
      ThemeColors.lightFallback.destructive,
      reason: 'non-destructive variant uses the destructive tint',
    );
    expect(errors, hasLength(1));
    expect(seen, <ButtonStatus>[ButtonStatus.loading, ButtonStatus.failure]);
    // P7-TH1 dynamic width: failure (x 16 + gap + label) hugs wider than
    // the idle label-only button (past the AnimatedSize glide).
    await tester.pump(const Duration(milliseconds: 200));
    expect(_buttonSize(tester).width, greaterThan(idle.width));
    expect(tester.takeException(), isNull, reason: 'error never rethrown');

    await tester.pump(buttonDefaultStatusReset);
    // Past the 175ms exit fade (see the success flow).
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byIcon(LucideIcons.x), findsNothing);
    expect(seen.last, ButtonStatus.idle);
  });

  testWidgets('destructive variant failure keeps its foreground', (
    tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    await _pump(
      tester,
      Button(
        variant: ButtonVariant.destructive,
        onPressedAsync: () => gate.future,
        child: const Text('Delete'),
      ),
    );
    await tester.tap(find.byType(Button));
    await tester.pump();
    gate.completeError(StateError('Nope.'));
    await tester.pump();
    expect(
      tester.widget<Icon>(find.byIcon(LucideIcons.x)).color,
      ThemeColors.lightFallback.destructiveForeground,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('null reset duration stays on the end state', (tester) async {
    await _pump(
      tester,
      Button(
        statusResetDuration: null,
        onPressedAsync: () async {},
        child: const Text('Go'),
      ),
    );
    await tester.tap(find.byType(Button));
    await tester.pump();
    await tester.pump();
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    await tester.pump();
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
  });

  testWidgets('second press while loading is ignored', (tester) async {
    final Completer<void> gate = Completer<void>();
    var calls = 0;
    await _pump(
      tester,
      Button(
        onPressedAsync: () {
          calls++;
          return gate.future;
        },
        child: const Text('Go'),
      ),
    );
    await tester.tap(find.byType(Button));
    await tester.pump();
    await tester.tap(find.byType(Button));
    await tester.pump();
    expect(calls, 1);
    gate.complete();
    await tester.pump();
    expect(calls, 1);
  });

  testWidgets('onPressed and onPressedAsync both fire', (tester) async {
    var sync = 0;
    var async = 0;
    await _pump(
      tester,
      Button(
        onPressed: () => sync++,
        onPressedAsync: () async => async++,
        child: const Text('Go'),
      ),
    );
    await tester.tap(find.byType(Button));
    await tester.pump();
    await tester.pump();
    expect(sync, 1);
    expect(async, 1);
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
  });

  testWidgets('width hugs content in each state + animates between them', (
    tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    await _pump(
      tester,
      Button(
        leading: const Icon(LucideIcons.plus, size: 16),
        trailing: const Icon(LucideIcons.chevronRight, size: 16),
        onPressedAsync: () => gate.future,
        successLabel: const Text('Saved!'),
        failureLabel: const Text('Failed — retry'),
        child: const Text('Save changes'),
      ),
    );
    final Size idle = _buttonSize(tester);
    // The width glides (ease-out over the status transition) instead of
    // jumping between reserved slots.
    final AnimatedSize sizer = tester.widget<AnimatedSize>(
      find.byType(AnimatedSize),
    );
    expect(sizer.duration, buttonDefaultStatusTransition);
    expect(sizer.curve, Curves.easeOut);
    await tester.tap(find.byType(Button));
    await tester.pump();
    // Loading swaps the 16px leading for the 16px spinner: same content
    // size, so the hug lands on the same width — without reserving it.
    // (Past the AnimatedSize glide before measuring.)
    await tester.pump(const Duration(milliseconds: 200));
    expect(_buttonSize(tester).width, moreOrLessEquals(idle.width));
    // The idle leading is out of the tree (not faded behind a slot).
    expect(find.byIcon(LucideIcons.plus), findsNothing);
    expect(find.byType(Spinner), findsOneWidget);
    gate.complete();
    await tester.pump();
    expect(find.text('Saved!'), findsOneWidget);
    expect(find.text('Save changes'), findsNothing);
    // The short success label hugs narrower than the idle label.
    await tester.pump(const Duration(milliseconds: 200));
    expect(_buttonSize(tester).width, lessThan(idle.width));
    await tester.pump(buttonDefaultStatusReset);
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byIcon(LucideIcons.plus), findsOneWidget);
    expect(_buttonSize(tester).width, moreOrLessEquals(idle.width));
  });

  testWidgets('width animation is instant under reduced motion', (
    tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    await _pump(
      tester,
      Button(onPressedAsync: () => gate.future, child: const Text('Go')),
      disableAnimations: true,
    );
    // Zero-duration has no AnimatedSize: the hugging row swaps instantly
    // (a zero AnimatedSize would self-mutate inside its own layout).
    expect(find.byType(AnimatedSize), findsNothing);
    gate.complete();
  });

  testWidgets('icon button swaps the child inside the fixed box', (
    tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    await _pump(
      tester,
      Button(
        size: ButtonSize.icon,
        variant: ButtonVariant.outline,
        onPressedAsync: () => gate.future,
        child: const Icon(LucideIcons.settings, size: 16),
      ),
      // Painted sizes assert on desktop: `flutter test` runs as Android, where
      // `TouchHitArea` grows the hit box with transparent padding (48 tall).
      data: const ThemeData(platform: TargetPlatform.macOS),
    );
    expect(_buttonSize(tester), const Size(36, 36));
    await tester.tap(find.byType(Button));
    await tester.pump();
    expect(find.byType(Spinner), findsOneWidget);
    expect(_buttonSize(tester), const Size(36, 36));
    gate.complete();
    await tester.pump();
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
    expect(_buttonSize(tester), const Size(36, 36));
  });

  testWidgets('controlled mode renders the parent status', (tester) async {
    final List<ButtonStatus> seen = <ButtonStatus>[];
    Future<void> pumpStatus(ButtonStatus status) async {
      await _pump(
        tester,
        _ControlledProbe(status: status, onChanged: seen.add),
      );
      await tester.pump();
    }

    await pumpStatus(ButtonStatus.idle);
    expect(find.text('Checkout'), findsOneWidget);
    expect(find.byType(Spinner), findsNothing);

    await pumpStatus(ButtonStatus.loading);
    expect(find.byType(Spinner), findsOneWidget);
    expect(_clickableEnabled(tester), isFalse);

    await pumpStatus(ButtonStatus.success);
    expect(find.byIcon(LucideIcons.check), findsOneWidget);

    await pumpStatus(ButtonStatus.failure);
    expect(find.byIcon(LucideIcons.x), findsOneWidget);
    expect(seen, <ButtonStatus>[
      ButtonStatus.loading,
      ButtonStatus.success,
      ButtonStatus.failure,
    ]);
  });

  testWidgets('controlled press runs callbacks without internal change', (
    tester,
  ) async {
    var pressed = 0;
    var asyncCalls = 0;
    await _pump(
      tester,
      Button(
        status: ButtonStatus.success,
        onPressed: () => pressed++,
        onPressedAsync: () async => asyncCalls++,
        child: const Text('Go'),
      ),
    );
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
    await tester.tap(find.byType(Button));
    await tester.pump();
    await tester.pump();
    expect(pressed, 1);
    expect(asyncCalls, 1);
    expect(find.byIcon(LucideIcons.check), findsOneWidget);
  });
}

/// Controlled-mode probe: rebuilds with a parent-owned [status].
class _ControlledProbe extends StatelessWidget {
  const _ControlledProbe({required this.status, required this.onChanged});

  final ButtonStatus status;
  final ValueChanged<ButtonStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    return Button(
      status: status,
      onPressed: () {},
      onStatusChanged: onChanged,
      child: const Text('Checkout'),
    );
  }
}
