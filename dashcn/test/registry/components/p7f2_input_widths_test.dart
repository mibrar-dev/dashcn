// Width contract for date/time/object/formatted/phone inputs (P7-F2).
//
// Every field here hugs its content in a loose parent: the rendered width is
// the intrinsic content width (never the parent's), labels keep the trigger
// padding from the border, picker icons lead, formatted separators render in
// declared order, and the phone group is one bordered box. Tight parents
// still fill; `expand` fills on request.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/components/formatted_input/formatted_input.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/components/object_input/object_input.dart';
import 'package:dashcn/src/components/phone_input/phone_input.dart';
import 'package:dashcn/src/components/select/select.dart';
import 'package:dashcn/src/components/time_picker/time_picker.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [child] on a [width]-wide screen: loose (like a `start`-aligned
/// `Column`) unless [tight], which sizes the child to exactly [width] (like
/// a stretched form column). The overlay entry fills the screen, so the
/// screen itself is the constraint source.
Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  double width = 1000,
  bool tight = false,
  TextDirection direction = TextDirection.ltr,
}) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = Size(width, 600);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final Widget body = tight
      ? Align(
          alignment: Alignment.topLeft,
          child: SizedBox(width: width, child: child),
        )
      : Align(alignment: Alignment.topLeft, child: child);
  await tester.pumpWidget(
    Theme(
      data: const ThemeData(),
      child: Directionality(
        textDirection: direction,
        child: MediaQuery(
          data: const MediaQueryData(),
          child: Overlay(
            initialEntries: <OverlayEntry>[OverlayEntry(builder: (_) => body)],
          ),
        ),
      ),
    ),
  );
}

const SegmentedValue _usPhone = SegmentedValue(<SegmentPart>[
  SegmentPart.separator('('),
  SegmentPart.editable(length: 3, value: '555'),
  SegmentPart.separator(') '),
  SegmentPart.editable(length: 3, value: '123'),
  SegmentPart.separator('-'),
  SegmentPart.editable(length: 4, value: '4567'),
]);

void main() {
  group('date/time triggers hug', () {
    testWidgets('date trigger is intrinsic, not parent-wide', (tester) async {
      await _pump(tester, DatePicker(value: null, onChanged: (_) {}));
      final double width = tester.getSize(find.byType(DatePicker)).width;
      expect(width, greaterThanOrEqualTo(240));
      expect(width, lessThan(560));
    });

    testWidgets('date trigger keeps px-3 padding from the border', (
      tester,
    ) async {
      await _pump(tester, DatePicker(value: null, onChanged: (_) {}));
      final Rect trigger = tester.getRect(find.byType(IntrinsicWidth).first);
      final Rect label = tester.getRect(find.text('Pick a date'));
      expect(label.left - trigger.left, greaterThanOrEqualTo(8));
    });

    testWidgets('date icon leads the label (LTR)', (tester) async {
      await _pump(tester, DatePicker(value: null, onChanged: (_) {}));
      final Rect icon = tester.getRect(find.byIcon(LucideIcons.calendarDays));
      final Rect label = tester.getRect(find.text('Pick a date'));
      expect(icon.right, lessThanOrEqualTo(label.left));
    });

    testWidgets('date icon stays on the leading side in RTL', (tester) async {
      await _pump(
        tester,
        DatePicker(value: null, onChanged: (_) {}),
        direction: TextDirection.rtl,
      );
      final Rect icon = tester.getRect(find.byIcon(LucideIcons.calendarDays));
      final Rect label = tester.getRect(find.text('Pick a date'));
      expect(icon.left, greaterThanOrEqualTo(label.right));
    });

    testWidgets('range trigger hugs too', (tester) async {
      await _pump(tester, DateRangePicker(value: null, onChanged: (_) {}));
      final double width = tester.getSize(find.byType(DateRangePicker)).width;
      expect(width, greaterThanOrEqualTo(240));
      expect(width, lessThan(560));
    });

    testWidgets('expand fills the loose parent', (tester) async {
      await _pump(
        tester,
        DatePicker(value: null, onChanged: (_) {}, expand: true),
      );
      expect(tester.getSize(find.byType(DatePicker)).width, 1000);
    });

    testWidgets('a tight parent still fills (no overflow)', (tester) async {
      await _pump(
        tester,
        DatePicker(value: null, onChanged: (_) {}),
        width: 200,
        tight: true,
      );
      expect(tester.getSize(find.byType(DatePicker)).width, 200);
      expect(tester.takeException(), isNull);
    });

    testWidgets('time trigger hugs with a smaller minimum', (tester) async {
      await _pump(tester, TimePicker(value: null, onChanged: (_) {}));
      final double width = tester.getSize(find.byType(TimePicker)).width;
      expect(width, greaterThanOrEqualTo(140));
      expect(width, lessThan(560));
      final Rect icon = tester.getRect(find.byIcon(LucideIcons.clock));
      final Rect label = tester.getRect(find.text('Select a time'));
      expect(icon.right, lessThanOrEqualTo(label.left));
    });

    testWidgets('duration trigger hugs with a leading icon', (tester) async {
      await _pump(tester, DurationPicker(value: null, onChanged: (_) {}));
      final double width = tester.getSize(find.byType(DurationPicker)).width;
      expect(width, greaterThanOrEqualTo(140));
      expect(width, lessThan(560));
      expect(find.byIcon(LucideIcons.clock), findsOneWidget);
    });

    testWidgets('long labels grow the trigger past the minimum', (
      tester,
    ) async {
      DateTimeRange? range = DateTimeRange(
        DateTime(2024, 3, 5),
        DateTime(2024, 3, 9),
      );
      late StateSetter setRange;
      await _pump(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            setRange = setState;
            return DateRangePicker(value: range, onChanged: (_) {});
          },
        ),
      );
      final double filled = tester.getSize(find.byType(DateRangePicker)).width;
      setRange(() => range = null);
      await tester.pump();
      final double empty = tester.getSize(find.byType(DateRangePicker)).width;
      expect(filled, greaterThan(empty));
    });
  });

  group('formatted input order and width', () {
    testWidgets('separators render exactly where declared', (tester) async {
      await _pump(tester, FormattedInput(value: _usPhone, onChanged: (_) {}));
      final List<double> order = <double>[
        tester.getRect(find.text('(')).left,
        tester.getRect(find.text('555')).left,
        tester.getRect(find.text(') ')).left,
        tester.getRect(find.text('123')).left,
        tester.getRect(find.text('-')).left,
        tester.getRect(find.text('4567')).left,
      ];
      final List<double> sorted = List<double>.of(order)..sort();
      expect(order, orderedEquals(sorted));
    });

    testWidgets('formatted field hugs its content', (tester) async {
      await _pump(tester, FormattedInput(value: _usPhone, onChanged: (_) {}));
      final double width = tester.getSize(find.byType(FormattedInput)).width;
      expect(width, lessThan(500));
    });

    testWidgets('formatted field fills a tight parent', (tester) async {
      await _pump(
        tester,
        FormattedInput(value: _usPhone, onChanged: (_) {}),
        width: 400,
        tight: true,
      );
      expect(tester.getSize(find.byType(FormattedInput)).width, 400);
      expect(tester.takeException(), isNull);
    });
  });

  group('object input hugs', () {
    testWidgets('date segments hug with the trailing icon at the end', (
      tester,
    ) async {
      await _pump(tester, DateInput(onChanged: (_) {}));
      final double width = tester.getSize(find.byType(DateInput)).width;
      expect(width, lessThan(280));
      final Rect icon = tester.getRect(find.byIcon(LucideIcons.calendarDays));
      final Rect field = tester.getRect(find.byType(FormattedInput));
      // Trailing icon sits at the end with padding, not flush or detached.
      expect(icon.right, lessThanOrEqualTo(field.right));
      expect(icon.left, greaterThan(field.left + 40));
    });

    testWidgets('time segments hug', (tester) async {
      await _pump(tester, TimeInput(onChanged: (_) {}));
      expect(tester.getSize(find.byType(TimeInput)).width, lessThan(280));
    });
  });

  group('phone group', () {
    testWidgets('one bordered box with a divider, hugging', (tester) async {
      await _pump(tester, PhoneInput(onChanged: (_) {}));
      // The divider between the trigger and the field.
      expect(
        find.byKey(const ValueKey<String>('dashcn.phone_input.divider')),
        findsOneWidget,
      );
      // Exactly one visible bordered box owns the shared border (the inner
      // fields paint zero-width placeholder borders).
      final List<Container> bordered = tester
          .widgetList<Container>(find.byType(Container))
          .where(
            (Container c) =>
                c.decoration is BoxDecoration &&
                (c.decoration! as BoxDecoration).border != null &&
                (c.decoration! as BoxDecoration).border!.dimensions.horizontal >
                    0,
          )
          .toList();
      expect(bordered.length, 1);
      // The number field is borderless inside the group.
      final Input number = tester.widget<Input>(find.byType(Input));
      expect(number.decoration, const BoxDecoration());
      // The country trigger is borderless (ghost) inside the group.
      final ComponentTheme<SelectTheme> tree = tester
          .widgetList<ComponentTheme<SelectTheme>>(
            find.byType(ComponentTheme<SelectTheme>),
          )
          .firstWhere(
            (ComponentTheme<SelectTheme> t) => t.data.variant != null,
          );
      expect(tree.data.variant, ButtonVariant.ghost);
      // Hugs: far narrower than the 1000px loose parent.
      expect(tester.getSize(find.byType(PhoneInput)).width, lessThan(1000));
    });
  });
}
