// Playground widget tests: text-field and selection controls.

import 'package:docs/ui/dashcn/components/input/input.dart';
import 'package:docs/ui/dashcn/components/select/select.dart';
import 'package:docs/ui/dashcn/components/slider/slider.dart';
import 'package:docs/ui/dashcn/components/text_area/text_area.dart';
import 'package:docs/ui/dashcn/primitives/form_core/form_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'playground_harness.dart';

Finder _selectOf() =>
    find.byWidgetPredicate((Widget widget) => widget is Select<dynamic>);

void main() {
  testWidgets('input controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'input', <String, Object?>{
      'hintText': 'Name',
      'enabled': false,
      'maxLines': 3,
      'minLines': 2,
      'maxLength': 20,
      'readOnly': true,
      'autofocus': true,
      'autocorrect': false,
      'enableSuggestions': false,
      'cursorColor': 'destructive',
      'cursorWidth': 4.0,
      'cursorHeight': 20.0,
      'filled': true,
      'autovalidateMode': 'submitted',
      'showFocusRing': false,
      'initialValue': 'Ada',
    });
    final Input input = tester.widget<Input>(find.byType(Input));
    expect(input.hintText, 'Name');
    expect(input.enabled, isFalse);
    expect(input.maxLines, 3);
    expect(input.minLines, 2);
    expect(input.maxLength, 20);
    expect(input.readOnly, isTrue);
    expect(input.autofocus, isTrue);
    expect(input.autocorrect, isFalse);
    expect(input.enableSuggestions, isFalse);
    expect(input.cursorWidth, 4.0);
    expect(input.cursorHeight, 20.0);
    expect(input.cursorColor, isNotNull);
    expect(input.filled, isTrue);
    expect(input.autovalidateMode, FormValidationMode.submitted);
    expect(input.showFocusRing, isFalse);
    expect(input.initialValue, 'Ada');

    // Obscured fields are single-line by framework contract.
    await pumpPlayground(tester, 'input', <String, Object?>{
      'obscureText': true,
      'obscuringCharacter': '#',
      'maxLines': 1,
    });
    final Input obscured = tester.widget<Input>(find.byType(Input));
    expect(obscured.obscureText, isTrue);
    expect(obscured.obscuringCharacter, '#');

    await pumpPlayground(tester, 'input', <String, Object?>{'expands': true});
    expect(tester.widget<Input>(find.byType(Input)).expands, isTrue);
  });

  testWidgets('text area controls reach the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'text_area', <String, Object?>{
      'hintText': 'Bio',
      'minLines': 4,
      'maxLines': 8,
      'maxLength': 140,
      'enabled': false,
      'cursorColor': 'primary',
      'autovalidateMode': 'submitted',
      'initialValue': 'Hello',
    });
    final TextArea area = tester.widget<TextArea>(find.byType(TextArea));
    expect(area.hintText, 'Bio');
    expect(area.minLines, 4);
    expect(area.maxLines, 8);
    expect(area.maxLength, 140);
    expect(area.enabled, isFalse);
    expect(area.cursorColor, isNotNull);
    expect(area.autovalidateMode, FormValidationMode.submitted);
    expect(area.initialValue, 'Hello');
  });

  testWidgets('select controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'select', <String, Object?>{
      'placeholder': 'Pick one',
      'enabled': false,
      'canUnselect': true,
      'autoClose': false,
    });
    final Select<dynamic> select = tester.widget<Select<dynamic>>(_selectOf());
    expect(select.enabled, isFalse);
    expect(select.canUnselect, isTrue);
    expect(select.autoClose, isFalse);
    expect(find.text('Pick one'), findsOneWidget);
  });

  testWidgets('slider controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'slider', <String, Object?>{
      'value': 0.75,
      'min': 0.25,
      'max': 2.0,
      'variant': 'soft',
      'enabled': false,
      'semanticLabel': 'Volume',
    });
    final Slider slider = tester.widget<Slider>(find.byType(Slider));
    expect(slider.value, 0.75);
    expect(slider.min, 0.25);
    expect(slider.max, 2.0);
    expect(slider.variant, SliderVariant.soft);
    expect(slider.enabled, isFalse);
    expect(slider.semanticLabel, 'Volume');
  });
}
