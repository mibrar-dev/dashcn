// Playground widget tests: overlays, form field and kbd.

import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import 'package:docs/ui/dashcn/components/form/form.dart';
import 'package:docs/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'playground_harness.dart';

void main() {
  testWidgets('dialog trigger carries its configuration', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'dialog', <String, Object?>{
      'barrierDismissible': false,
      'fullScreen': true,
      'useRootNavigator': false,
      'useSafeArea': false,
      'barrierLabel': 'Dismiss',
    });
    expect(find.text('Open dialog'), findsOneWidget);

    // The dialog itself opens on tap with the configured body.
    await tester.tap(find.text('Open dialog'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this project?'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this project?'), findsNothing);
  });

  testWidgets('popup trigger carries its configuration', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'popup', <String, Object?>{
      'widthConstraint': 'intrinsic',
      'heightConstraint': 'intrinsic',
      'modal': false,
      'consumeOutsideTaps': false,
      'width': 200.0,
      'maxWidth': 300.0,
      'maxHeight': 400.0,
    });
    expect(find.text('Show popup'), findsOneWidget);

    await tester.tap(find.text('Show popup'));
    // The popup surface animates in and then idles its hover/focus loops,
    // so advance fixed frames instead of settling.
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('dropdown autofocus reaches the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'dropdown_menu', <String, Object?>{
      'autofocus': true,
    });
    expect(
      tester.widget<DropdownMenu>(find.byType(DropdownMenu)).autofocus,
      isTrue,
    );
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('form label reaches the field', (WidgetTester tester) async {
    await pumpPlayground(tester, 'form', <String, Object?>{'child': 'Email'});
    expect(find.text('Email'), findsOneWidget);
    expect(
      find.byWidgetPredicate((Widget widget) => widget is FormItem<dynamic>),
      findsOneWidget,
    );
  });

  testWidgets('keyboard spacing reaches the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'keyboard_shortcut', <String, Object?>{
      'spacing': 12.0,
    });
    expect(
      tester.widget<KeyboardShortcut>(find.byType(KeyboardShortcut)).spacing,
      12.0,
    );
  });

  // The dialog/popup triggers rebuild with their configuration: changing a
  // control swaps the trigger key, which the generic code test pins.
  testWidgets('dialog trigger key reflects the configuration', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'dialog', <String, Object?>{
      'fullScreen': true,
    });
    final Button trigger = tester.widget<Button>(find.byType(Button));
    expect('${trigger.key}', contains('true'));
  });
}
