// Typing regression tests for `formatted_input` (P7-F1, 2026-10-11).
//
// The field dropped keystrokes: every `onChanged` wrote the value back into
// the focused controller (resetting the caret to `collapsed(-1)` and clearing
// the IME composing range) and the fixed `width: 32` boxes were narrower
// than three glyphs, so content scrolled out of view. These tests type for
// real (`enterText` / `sendKeyEvent` / `testTextInput`) in controlled,
// controller and uncontrolled modes and cover every preview.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/formatted_input/formatted_input.dart';
import 'package:dashcn/src/components/formatted_input/preview.dart';
import 'package:dashcn/src/primitives/text_editing/segmented_value.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({required Widget child}) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        initialEntries: <OverlayEntry>[
          OverlayEntry(builder: (_) => Center(child: child)),
        ],
      ),
    ),
  );
}

List<TextInputFormatter> get _digits => <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
];

SegmentedValue get _phone => SegmentedValue(<SegmentPart>[
  SegmentPart.editable(length: 3, inputFormatters: _digits),
  const SegmentPart.separator(' ('),
  SegmentPart.editable(length: 3, inputFormatters: _digits),
  const SegmentPart.separator(') '),
  SegmentPart.editable(length: 4, inputFormatters: _digits),
]);

List<String> _texts(WidgetTester tester) => tester
    .widgetList<EditableText>(find.byType(EditableText))
    .map((EditableText field) => field.controller.text)
    .toList();

List<bool> _focuses(WidgetTester tester) => tester
    .widgetList<EditableText>(find.byType(EditableText))
    .map((EditableText field) => field.focusNode.hasFocus)
    .toList();

void main() {
  testWidgets('52 stays 52 with the caret at the end', (tester) async {
    await tester.pumpWidget(
      _frame(child: FormattedInput(initialValue: _phone)),
    );
    final Finder first = find.byType(EditableText).at(0);
    await tester.enterText(first, '5');
    await tester.pump();
    expect(_texts(tester).first, '5');
    expect(
      tester.widget<EditableText>(first).controller.selection.baseOffset,
      1,
    );
    await tester.enterText(first, '52');
    await tester.pump();
    expect(_texts(tester).first, '52');
    expect(
      tester.widget<EditableText>(first).controller.selection.baseOffset,
      2,
    );
  });

  testWidgets('555 fills and hands over with the caret at start', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(child: FormattedInput(initialValue: _phone)),
    );
    final Finder first = find.byType(EditableText).at(0);
    await tester.tap(first);
    await tester.pump();
    for (final String text in <String>['5', '55', '555']) {
      await tester.enterText(first, text);
      await tester.pump();
      expect(_texts(tester).first, text);
      // Caret follows the text while the box owns it.
      if (text.length < 3) {
        expect(
          tester.widget<EditableText>(first).controller.selection.baseOffset,
          text.length,
        );
      }
    }
    expect(_focuses(tester), <bool>[false, true, false]);
    expect(
      tester
          .widget<EditableText>(find.byType(EditableText).at(1))
          .controller
          .selection
          .baseOffset,
      0,
    );
  });

  testWidgets('typing 5551234567 across boxes fills the phone', (tester) async {
    await tester.pumpWidget(
      _frame(child: FormattedInput(initialValue: _phone)),
    );
    final Finder fields = find.byType(EditableText);
    await tester.tap(fields.at(0));
    await tester.pump();
    await tester.enterText(fields.at(0), '555');
    await tester.pump();
    await tester.enterText(fields.at(1), '123');
    await tester.pump();
    await tester.enterText(fields.at(2), '4567');
    await tester.pump();
    expect(_texts(tester), <String>['555', '123', '4567']);
  });

  testWidgets('pasting 10 digits distributes across boxes', (tester) async {
    await tester.pumpWidget(
      _frame(child: FormattedInput(initialValue: _phone)),
    );
    final Finder fields = find.byType(EditableText);
    await tester.tap(fields.at(0));
    await tester.pump();
    await tester.enterText(fields.at(0), '5551234567');
    await tester.pump();
    expect(_texts(tester), <String>['555', '123', '4567']);
    // All full: the caret rests at the end of the last box.
    expect(_focuses(tester).last, isTrue);
    expect(
      tester.widget<EditableText>(fields.at(2)).controller.selection.baseOffset,
      4,
    );
  });

  testWidgets('pasting a formatted number strips separators', (tester) async {
    await tester.pumpWidget(
      _frame(child: FormattedInput(initialValue: _phone)),
    );
    final Finder fields = find.byType(EditableText);
    await tester.tap(fields.at(0));
    await tester.pump();
    await tester.enterText(fields.at(0), '555 (123) 4567');
    await tester.pump();
    expect(_texts(tester), <String>['555', '123', '4567']);
  });

  testWidgets('testTextInput typing keeps the caret', (tester) async {
    await tester.pumpWidget(
      _frame(child: FormattedInput(initialValue: _phone)),
    );
    await tester.tap(find.byType(EditableText).at(0));
    await tester.pump();
    tester.testTextInput.enterText('5');
    await tester.pump();
    tester.testTextInput.enterText('55');
    await tester.pump();
    expect(_texts(tester).first, '55');
    expect(
      tester
          .widget<EditableText>(find.byType(EditableText).at(0))
          .controller
          .selection
          .baseOffset,
      2,
    );
    tester.testTextInput.enterText('555');
    await tester.pump();
    expect(_focuses(tester), <bool>[false, true, false]);
  });

  testWidgets('backspace in an empty box deletes in the previous one', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(child: FormattedInput(initialValue: _phone)),
    );
    final Finder fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), '555');
    await tester.pump();
    // Full: focus already moved to the second (empty) box.
    expect(_focuses(tester), <bool>[false, true, false]);
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pump();
    expect(_texts(tester).first, '55');
    expect(_focuses(tester).first, isTrue);
    expect(
      tester.widget<EditableText>(fields.at(0)).controller.selection.baseOffset,
      2,
    );
  });

  testWidgets('arrows cross box boundaries', (tester) async {
    await tester.pumpWidget(
      _frame(child: FormattedInput(initialValue: _phone)),
    );
    final Finder fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), '555');
    await tester.pump();
    expect(_focuses(tester), <bool>[false, true, false]);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pump();
    expect(_focuses(tester).first, isTrue);
    expect(
      tester.widget<EditableText>(fields.at(0)).controller.selection.baseOffset,
      3,
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(_focuses(tester), <bool>[false, true, false]);
  });

  testWidgets('controlled mode types, pastes and deletes like uncontrolled', (
    tester,
  ) async {
    SegmentedValue value = _phone;
    late StateSetter setOuter;
    await tester.pumpWidget(
      _frame(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            setOuter = setState;
            return FormattedInput(
              value: value,
              onChanged: (SegmentedValue next) => setOuter(() => value = next),
            );
          },
        ),
      ),
    );
    final Finder fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), '52');
    await tester.pump();
    expect(value.values.first.value, '52');
    expect(_texts(tester).first, '52');
    await tester.enterText(fields.at(0), '5551234567');
    await tester.pump();
    expect(value.text, '555 (123) 4567');
    expect(_texts(tester), <String>['555', '123', '4567']);
    // Backspace from the last box's start steps back without deleting it.
    tester.widget<EditableText>(fields.at(2)).controller.selection =
        const TextSelection.collapsed(offset: 0);
    await tester.pump();
    tester.widget<EditableText>(fields.at(2)).focusNode.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pump();
    expect(_focuses(tester), <bool>[false, true, false]);
    expect(value.values.elementAt(1).value, '123');
  });

  testWidgets('controller mode writes through without losing the caret', (
    tester,
  ) async {
    final FormattedInputController controller = FormattedInputController(
      _phone,
    );
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(child: FormattedInput(controller: controller)),
    );
    final Finder fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), '52');
    await tester.pump();
    expect(controller.value.values.first.value, '52');
    expect(
      tester.widget<EditableText>(fields.at(0)).controller.selection.baseOffset,
      2,
    );
    await tester.enterText(fields.at(0), '5551234567');
    await tester.pump();
    expect(controller.value.text, '555 (123) 4567');
    expect(_texts(tester), <String>['555', '123', '4567']);
  });

  testWidgets('every preview accepts a digit with the caret at 1', (
    tester,
  ) async {
    for (final preview in formattedInputPreviews) {
      await tester.pumpWidget(_frame(child: Builder(builder: preview.builder)));
      await tester.pump();
      final Finder fields = find.byType(EditableText);
      expect(fields, findsWidgets, reason: preview.name);
      await tester.enterText(fields.first, '1');
      await tester.pump();
      expect(
        tester.widget<EditableText>(fields.first).controller.text,
        '1',
        reason: preview.name,
      );
      expect(
        tester
            .widget<EditableText>(fields.first)
            .controller
            .selection
            .baseOffset,
        1,
        reason: preview.name,
      );
      expect(tester.takeException(), isNull, reason: preview.name);
    }
  });

  testWidgets('an explicit narrow width never shrinks below content', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: const FormattedInput(
          initialValue: SegmentedValue(<SegmentPart>[
            SegmentPart.editable(length: 3, width: 1),
          ]),
        ),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(EditableText), '555');
    await tester.pump();
    final double rendered = tester.getSize(find.byType(EditableText)).width;
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).controller.text,
      '555',
    );
    // Three test-font glyphs need well over 1 logical pixel.
    expect(rendered, greaterThan(32));
  });

  testWidgets('measured minimum fits length glyphs plus cursor', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: Builder(
          builder: (BuildContext context) {
            final ThemeData theme = Theme.of(context);
            final TextStyle style = theme.typography.small.merge(
              theme.typography.mono,
            );
            final double needed = segmentMinWidth(
              style: style,
              length: 3,
              densityScale: theme.scaling,
            );
            return Text('$needed', textDirection: TextDirection.ltr);
          },
        ),
      ),
    );
    await tester.pump();
    final double needed = double.parse(
      tester.widget<Text>(find.byType(Text)).data!,
    );
    expect(needed, greaterThan(32));
  });
}
