// Playground widget tests: navigation components.

import 'package:docs/ui/dashcn/components/accordion/accordion.dart';
import 'package:docs/ui/dashcn/components/calendar/calendar.dart';
import 'package:docs/ui/dashcn/components/date_picker/date_picker.dart';
import 'package:docs/ui/dashcn/components/pagination/pagination.dart';
import 'package:docs/ui/dashcn/components/tabs/tabs.dart';
import 'package:docs/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:flutter_test/flutter_test.dart';

import 'playground_harness.dart';

void main() {
  testWidgets('tabs controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'tabs', <String, Object?>{
      'index': 2,
      'expand': true,
    });
    final Tabs tabs = tester.widget<Tabs>(find.byType(Tabs));
    expect(tabs.index, 2);
    expect(tabs.expand, isTrue);
    expect(find.byType(TabItem), findsNWidgets(3));
  });

  testWidgets('accordion builds its items', (WidgetTester tester) async {
    await pumpPlayground(tester, 'accordion');
    expect(find.byType(AccordionItem), findsNWidgets(2));
  });

  testWidgets('calendar controls reach the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'calendar', <String, Object?>{
      'viewType': 'month',
      'selectionMode': 'single',
      'firstDayOfWeek': 7,
      'autofocus': true,
    });
    final Calendar calendar = tester.widget<Calendar>(find.byType(Calendar));
    expect(calendar.viewType, CalendarViewType.month);
    expect(calendar.selectionMode, CalendarSelectionMode.single);
    expect(calendar.firstDayOfWeek, 7);
    expect(calendar.autofocus, isTrue);
  });

  testWidgets('date picker controls reach the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'date_picker', <String, Object?>{
      'placeholder': 'Pick a date',
      'mode': 'popover',
      'initialViewType': 'month',
      'enabled': false,
      'expand': true,
    });
    final DatePicker picker = tester.widget<DatePicker>(
      find.byType(DatePicker),
    );
    expect(picker.mode, PromptMode.popover);
    expect(picker.initialViewType, CalendarViewType.month);
    expect(picker.enabled, isFalse);
    expect(picker.expand, isTrue);
    expect(find.text('Pick a date'), findsOneWidget);
  });

  testWidgets('pagination controls reach the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'pagination', <String, Object?>{
      'page': 4,
      'totalPages': 10,
      'maxPages': 5,
      'showSkipToFirstPage': false,
      'showSkipToLastPage': false,
      'hidePreviousOnFirstPage': true,
      'hideNextOnLastPage': true,
      'showLabel': true,
      'gap': 12.0,
    });
    final Pagination pagination = tester.widget<Pagination>(
      find.byType(Pagination),
    );
    expect(pagination.page, 4);
    expect(pagination.totalPages, 10);
    expect(pagination.maxPages, 5);
    expect(pagination.showSkipToFirstPage, isFalse);
    expect(pagination.showSkipToLastPage, isFalse);
    expect(pagination.hidePreviousOnFirstPage, isTrue);
    expect(pagination.hideNextOnLastPage, isTrue);
    expect(pagination.showLabel, isTrue);
    expect(pagination.gap, 12.0);
  });
}
