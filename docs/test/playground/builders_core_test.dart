// Playground widget tests: press/toggle controls reach their widgets.
//
// Each control is set through the builder and read back through finders and
// the widget's public properties.

import 'package:docs/ui/dashcn/components/badge/badge.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:docs/ui/dashcn/components/radio_group/radio_group.dart';
import 'package:docs/ui/dashcn/components/switch/switch.dart';
import 'package:docs/ui/dashcn/components/toggle/toggle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'playground_harness.dart';

void main() {
  testWidgets('button controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'button', <String, Object?>{
      'variant': 'outline',
      'size': 'lg',
      'child': 'Save',
      'autofocus': true,
    });
    final Button button = tester.widget<Button>(find.byType(Button));
    expect(button.variant, ButtonVariant.outline);
    expect(button.size, ButtonSize.lg);
    expect(button.autofocus, isTrue);
    expect(button.onPressed, isNotNull);
    expect(find.text('Save'), findsOneWidget);

    await pumpPlayground(tester, 'button', <String, Object?>{'enabled': false});
    expect(tester.widget<Button>(find.byType(Button)).onPressed, isNull);
  });

  testWidgets('badge controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'badge', <String, Object?>{
      'variant': 'destructive',
      'child': 'New',
      'showAsDot': true,
      'autofocus': true,
    });
    final Badge badge = tester.widget<Badge>(find.byType(Badge));
    expect(badge.variant, BadgeVariant.destructive);
    expect(badge.showAsDot, isTrue);
    expect(badge.autofocus, isTrue);
    expect(badge.onPressed, isNotNull);

    await pumpPlayground(tester, 'badge', <String, Object?>{'enabled': false});
    expect(tester.widget<Badge>(find.byType(Badge)).onPressed, isNull);
  });

  testWidgets('toggle controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'toggle', <String, Object?>{
      'value': true,
      'size': 'sm',
      'child': 'Play',
      'enabled': false,
      'autofocus': true,
    });
    final Toggle toggle = tester.widget<Toggle>(find.byType(Toggle));
    expect(toggle.value, isTrue);
    expect(toggle.size, ToggleSize.sm);
    expect(toggle.enabled, isFalse);
    expect(toggle.autofocus, isTrue);
    expect(find.text('Play'), findsOneWidget);
  });

  testWidgets('switch controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'switch', <String, Object?>{
      'value': true,
      'label': 'Wi-Fi',
      'enabled': false,
      'autofocus': true,
    });
    final Switch value = tester.widget<Switch>(find.byType(Switch));
    expect(value.value, isTrue);
    expect(value.enabled, isFalse);
    expect(value.autofocus, isTrue);
    expect(find.text('Wi-Fi'), findsOneWidget);
  });

  testWidgets('checkbox controls reach the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'checkbox', <String, Object?>{
      'value': 'checked',
      'tristate': true,
      'enabled': false,
      'label': 'Accept',
      'size': 24.0,
      'gap': 12.0,
      'autofocus': true,
    });
    final Checkbox box = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(box.value, CheckboxValue.checked);
    expect(box.tristate, isTrue);
    expect(box.enabled, isFalse);
    expect(box.size, 24.0);
    expect(box.gap, 12.0);
    expect(box.autofocus, isTrue);
    expect(find.text('Accept'), findsOneWidget);
  });

  testWidgets('radio group enabled reaches the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'radio_group', <String, Object?>{
      'enabled': false,
    });
    final Finder set = find.byWidgetPredicate(
      (Widget widget) => widget is RadioSet<dynamic>,
    );
    expect(set, findsOneWidget);
    expect(tester.widget<RadioSet<dynamic>>(set).enabled, isFalse);
  });
}
