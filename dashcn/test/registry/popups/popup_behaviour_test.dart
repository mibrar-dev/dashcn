// Behaviour contracts for every popup-like kit component.
//
// One file audits the whole family instead of scattering the same assertions
// across twenty test files. Per component (and per contract where it
// applies):
//   - a single choice commits AND closes (select rows, menu rows, date pick,
//     item picker, the phone country list);
//   - multi-select stays open by design (multi_select, menu checkbox);
//   - the popup reflects the live value on reopen and while open;
//   - Escape and outside tap close WITHOUT committing;
//   - focus returns to the trigger on close;
//   - no overflow at 320 px wide.
//
// Root causes fixed alongside this file:
//   - `RovingGroup._key` swallowed printable keystrokes (menu typeahead) even
//     with focus inside a search field, so typing in any menu-hosted search
//     (select/country) inserted nothing on real keyboards while `enterText`
//     kept passing. The scope now ignores keys from editable fields (except
//     Up/Down/Escape).
//   - the select search field had no submit wiring: Enter did nothing. It now
//     activates the first enabled row (Enter-to-pick).
//   - `SelectPopupBody` handed the search field the body's own context (above
//     the `MenuGroup`), so group lookups failed. The field now gets the list
//     context inside the surface.

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/autocomplete/autocomplete.dart';
import 'package:dashcn/src/components/calendar/calendar.dart';
import 'package:dashcn/src/components/color/color.dart';
import 'package:dashcn/src/components/color_input/color_input.dart';
import 'package:dashcn/src/components/color_picker/color_picker.dart';
import 'package:dashcn/src/components/command/command.dart';
import 'package:dashcn/src/components/context_menu/context_menu.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/components/dialog/dialog.dart';
import 'package:dashcn/src/components/drawer/drawer.dart';
import 'package:dashcn/src/components/dropdown_menu/dropdown_menu.dart';
import 'package:dashcn/src/components/dropzone/dropzone.dart';
import 'package:dashcn/src/components/file_picker/file_picker.dart';
import 'package:dashcn/src/components/gooey_toast/gooey_toast.dart';
import 'package:dashcn/src/components/hover_card/hover_card.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/components/item_picker/item_picker.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/menubar/menubar.dart';
import 'package:dashcn/src/components/multi_select/multi_select.dart';
import 'package:dashcn/src/components/navigation_menu/navigation_menu.dart';
import 'package:dashcn/src/components/object_input/object_input.dart';
import 'package:dashcn/src/components/time_picker/time_picker.dart';
import 'package:dashcn/src/components/phone_input/phone_input.dart';
import 'package:dashcn/src/components/pinned_sheet/pinned_sheet.dart';
import 'package:dashcn/src/components/popup/popup.dart';
import 'package:dashcn/src/components/select/select.dart';
import 'package:dashcn/src/components/toast/toast.dart';
import 'package:dashcn/src/components/tooltip/tooltip.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/foundation/time_of_day.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/primitives/date_math.dart';
import 'package:dashcn/src/primitives/file_value/file_value.dart';
import 'package:dashcn/src/primitives/form_core/object_form_field.dart'
    show PromptMode;
import 'package:dashcn/src/primitives/input_features/input_features.dart';
import 'package:dashcn/src/primitives/localizations/localizations.dart';
import 'package:dashcn/src/primitives/phone_number.dart';
import 'package:dashcn/src/primitives/subfocus_list_item.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Overlay frame for popup tests: theme, localizations, directionality, tap
/// regions and a root overlay with the child top-left.
Widget _frame(Widget child) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Localizations(
        locale: const Locale('en'),
        delegates: const <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          ComponentLocalizations.delegate,
        ],
        child: TapRegionSurface(
          child: Overlay(
            initialEntries: <OverlayEntry>[
              OverlayEntry(
                builder: (BuildContext context) =>
                    Align(alignment: Alignment.topLeft, child: child),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Navigator frame for route popups (dialog, drawer, sheet): the opener keeps
/// a focus node so focus-return can be asserted.
Widget _navFrame(Widget child, {required ValueChanged<BuildContext> onHost}) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Localizations(
        locale: const Locale('en'),
        delegates: const <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          ComponentLocalizations.delegate,
        ],
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
            settings: settings,
            pageBuilder:
                (
                  BuildContext context,
                  Animation<double> _,
                  Animation<double> __,
                ) {
                  onHost(context);
                  return Align(alignment: Alignment.topLeft, child: child);
                },
          ),
        ),
      ),
    ),
  );
}

/// Runs [body] at a 320 px wide viewport; restores the surface afterwards.
Future<void> _at320(WidgetTester tester, Future<void> Function() body) async {
  tester.view.physicalSize = const Size(320, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
  await body();
}

Future<void> _escape(WidgetTester tester) async {
  await tester.sendKeyEvent(LogicalKeyboardKey.escape);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

Future<void> _tapOutside(WidgetTester tester) async {
  await tester.tapAt(const Offset(790, 590));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

/// Whether the popup row showing [label] currently shows the check.
bool _rowChecked(WidgetTester tester, String label) {
  final Finder row = find.ancestor(
    of: find.descendant(of: find.byType(MenuPopup), matching: find.text(label)),
    matching: find.byType(RovingRow),
  );
  if (row.evaluate().isEmpty) return false;
  return find
      .descendant(of: row.first, matching: find.byIcon(LucideIcons.check))
      .evaluate()
      .isNotEmpty;
}

Select<String> _fruitSelect({
  String? value,
  ValueChanged<String?>? onChanged,
  List<String?>? queries,
}) {
  return Select<String>(
    value: value,
    onChanged: onChanged,
    placeholder: const Text('Pick a fruit'),
    itemBuilder: (BuildContext context, String value) => Text(value),
    searchPlaceholder: const Text('Search fruit'),
    builder: (BuildContext context, String? query) {
      queries?.add(query);
      return <Widget>[
        for (final String fruit in <String>['Apple', 'Banana', 'Cherry'])
          if (query == null ||
              fruit.toLowerCase().contains(query.toLowerCase()))
            SelectItem<String>(value: fruit, child: Text(fruit)),
      ];
    },
  );
}

Future<void> _openSelect(WidgetTester tester, Finder trigger) async {
  await tester.tap(trigger);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  group('select (single choice)', () {
    testWidgets('picking commits and closes', (tester) async {
      String? value;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                _fruitSelect(
                  value: value,
                  onChanged: (String? next) => setState(() => value = next),
                ),
          ),
        ),
      );
      await _openSelect(tester, find.text('Pick a fruit'));
      await tester.tap(
        find.descendant(
          of: find.byType(MenuPopup),
          matching: find.text('Banana'),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(value, 'Banana');
      expect(find.byType(MenuPopup), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the check follows the value while open and on reopen', (
      tester,
    ) async {
      String? value = 'Apple';
      late StateSetter setValue;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              setValue = setState;
              return _fruitSelect(
                value: value,
                onChanged: (String? next) => setState(() => value = next),
              );
            },
          ),
        ),
      );
      await _openSelect(tester, find.text('Apple'));
      expect(_rowChecked(tester, 'Apple'), isTrue);
      expect(_rowChecked(tester, 'Banana'), isFalse);
      // An external change while open moves the check without reopening.
      setValue(() => value = 'Banana');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(_rowChecked(tester, 'Banana'), isTrue);
      expect(_rowChecked(tester, 'Apple'), isFalse);
      await _escape(tester);
      // Reopen shows the committed value.
      await _openSelect(tester, find.text('Banana'));
      expect(_rowChecked(tester, 'Banana'), isTrue);
      await _escape(tester);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Escape and outside tap close without committing', (
      tester,
    ) async {
      String? value = 'Apple';
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                _fruitSelect(
                  value: value,
                  onChanged: (String? next) => setState(() => value = next),
                ),
          ),
        ),
      );
      await _openSelect(tester, find.text('Apple'));
      await _escape(tester);
      expect(value, 'Apple');
      expect(find.byType(MenuPopup), findsNothing);

      await _openSelect(tester, find.text('Apple'));
      await _tapOutside(tester);
      expect(value, 'Apple');
      expect(find.byType(MenuPopup), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('focus returns to the trigger on close', (tester) async {
      await tester.pumpWidget(_frame(_fruitSelect(onChanged: (_) {})));
      await _openSelect(tester, find.text('Pick a fruit'));
      await _escape(tester);
      await tester.pump();
      expect(find.byType(MenuPopup), findsNothing);
      final Finder label = find.descendant(
        of: find.byType(Select<String>),
        matching: find.text('Pick a fruit'),
      );
      expect(Focus.of(tester.element(label)).hasFocus, isTrue);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no overflow at 320 px wide', (tester) async {
      await _at320(tester, () async {
        await tester.pumpWidget(_frame(_fruitSelect(onChanged: (_) {})));
        await _openSelect(tester, find.text('Pick a fruit'));
        expect(find.byType(MenuPopup), findsOneWidget);
        expect(tester.takeException(), isNull);
        await _escape(tester);
      });
    });
  });

  group('select search (typing, arrows, Enter)', () {
    testWidgets('the search field takes focus on open', (tester) async {
      await tester.pumpWidget(_frame(_fruitSelect(onChanged: (_) {})));
      await _openSelect(tester, find.text('Pick a fruit'));
      final Finder fields = find.descendant(
        of: find.byType(MenuPopup),
        matching: find.byType(EditableText),
      );
      expect(fields, findsOneWidget);
      expect(tester.widget<EditableText>(fields).focusNode.hasFocus, isTrue);
      expect(tester.takeException(), isNull);
    });

    testWidgets('real keys stay in the field instead of moving focus', (
      tester,
    ) async {
      // Regression: menu typeahead consumed printable keys from the focused
      // search field, so physical typing never reached the field (widget
      // tests using enterText stayed green because enterText bypasses keys).
      await tester.pumpWidget(_frame(_fruitSelect(onChanged: (_) {})));
      await _openSelect(tester, find.text('Pick a fruit'));
      final Finder fields = find.descendant(
        of: find.byType(MenuPopup),
        matching: find.byType(EditableText),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.keyB);
      await tester.pump();
      expect(tester.widget<EditableText>(fields).focusNode.hasFocus, isTrue);
      expect(tester.takeException(), isNull);
    });

    testWidgets('typing filters, arrows move, Enter picks', (tester) async {
      String? value;
      final List<String?> queries = <String?>[];
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                _fruitSelect(
                  value: value,
                  onChanged: (String? next) => setState(() => value = next),
                  queries: queries,
                ),
          ),
        ),
      );
      await _openSelect(tester, find.text('Pick a fruit'));
      final Finder field = find.descendant(
        of: find.byType(MenuPopup),
        matching: find.byType(EditableText),
      );
      await tester.enterText(field, 'Ban');
      await tester.pump();
      expect(queries.last, 'Ban');
      expect(
        find.descendant(
          of: find.byType(MenuPopup),
          matching: find.text('Banana'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(MenuPopup),
          matching: find.text('Apple'),
        ),
        findsNothing,
      );
      // Arrows move focus into the rows without closing.
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      expect(find.byType(MenuPopup), findsOneWidget);
      // Enter on the focused row picks the match and closes (the field
      // released the input connection when focus moved, so this must be a
      // real key event, not a text-input action).
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(value, 'Banana');
      expect(find.byType(MenuPopup), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Enter with an empty query never picks', (tester) async {
      String? value;
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                _fruitSelect(
                  value: value,
                  onChanged: (String? next) => setState(() => value = next),
                ),
          ),
        ),
      );
      await _openSelect(tester, find.text('Pick a fruit'));
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(value, isNull);
      expect(find.byType(MenuPopup), findsOneWidget);
      await _escape(tester);
      expect(tester.takeException(), isNull);
    });
  });

  group('multi_select (stays open by design)', () {
    testWidgets('toggling keeps the popup open and commits each toggle', (
      tester,
    ) async {
      Set<String> value = <String>{};
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                MultiSelect<String>(
                  value: value,
                  onChanged: (Iterable<String>? next) =>
                      setState(() => value = next?.toSet() ?? <String>{}),
                  placeholder: const Text('Pick fruits'),
                  itemBuilder: (BuildContext context, String item) =>
                      Text(item),
                  items: <Widget>[
                    for (final String fruit in <String>['Apple', 'Banana'])
                      MultiSelectItem<String>(value: fruit, child: Text(fruit)),
                  ],
                ),
          ),
        ),
      );
      await _openSelect(tester, find.text('Pick fruits'));
      await tester.tap(
        find.descendant(
          of: find.byType(MenuPopup),
          matching: find.text('Apple'),
        ),
      );
      await tester.pump();
      expect(value, <String>{'Apple'});
      // Documented: multi-select stays open after a pick.
      expect(find.byType(MenuPopup), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: find.byType(MenuPopup),
          matching: find.text('Banana'),
        ),
      );
      await tester.pump();
      expect(value, <String>{'Apple', 'Banana'});
      expect(find.byType(MenuPopup), findsOneWidget);
      await _escape(tester);
      expect(find.byType(MenuPopup), findsNothing);
      // Reopen reflects the committed set.
      await _openSelect(tester, find.byType(MultiSelect<String>));
      expect(_rowChecked(tester, 'Apple'), isTrue);
      expect(_rowChecked(tester, 'Banana'), isTrue);
      await _escape(tester);
      expect(tester.takeException(), isNull);
    });
  });

  group('phone_input country popup', () {
    testWidgets('typing filters and Enter picks Andorra (+376)', (
      tester,
    ) async {
      PhoneNumber? value = const PhoneNumber(
        Country(dialCode: '+1', code: 'US'),
        '555',
      );
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => PhoneInput(
              initialValue: value,
              onChanged: (PhoneNumber? next) => setState(() => value = next),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(Select<Country>));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(MenuPopup), findsOneWidget);
      final Finder field = find.descendant(
        of: find.byType(MenuPopup),
        matching: find.byType(EditableText),
      );
      expect(field, findsOneWidget);
      expect(tester.widget<EditableText>(field).focusNode.hasFocus, isTrue);
      await tester.enterText(field, 'Ando');
      await tester.pump();
      expect(
        find.descendant(
          of: find.byType(MenuPopup),
          matching: find.text('Andorra'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(MenuPopup),
          matching: find.text('United States'),
        ),
        findsNothing,
      );
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(value?.country, const Country(dialCode: '+376', code: 'AD'));
      expect(find.byType(MenuPopup), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Escape closes without changing the country', (tester) async {
      await tester.pumpWidget(
        _frame(
          PhoneInput(
            initialCountry: const Country(dialCode: '+1', code: 'US'),
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(Select<Country>));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await _escape(tester);
      expect(find.byType(MenuPopup), findsNothing);
      expect(find.text('+1'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('menu', () {
    Future<void> openMenu(
      WidgetTester tester, {
      required List<Widget> children,
      required ValueChanged<Future<void>> onOpen,
    }) async {
      await tester.pumpWidget(
        // The anchor is a transparent ColoredBox (not a bare SizedBox): a
        // childless box is not hit-testable, so outside taps would pass
        // through it and the tap-region surface would never see them.
        _frame(
          const ColoredBox(
            color: Color(0x00000000),
            child: SizedBox(width: 120, height: 36),
          ),
        ),
      );
      await tester.pump();
      // Read the anchor from the mounted element: re-pumping an identical
      // frame schedules no rebuilds, so a Builder capture would go stale
      // (LateError) on the second openMenu of a test.
      final BuildContext host = tester.element(find.byType(SizedBox));
      onOpen(showMenu<void>(context: host, children: children));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
    }

    testWidgets('a row press commits and closes', (tester) async {
      bool picked = false;
      late Future<void> opened;
      await openMenu(
        tester,
        onOpen: (Future<void> future) => opened = future,
        children: <Widget>[
          MenuButton(child: const Text('Cut'), onPressed: (_) => picked = true),
        ],
      );
      await tester.tap(find.text('Cut'));
      await tester.pumpAndSettle();
      expect(picked, isTrue);
      expect(find.text('Cut'), findsNothing);
      await opened;
      expect(tester.takeException(), isNull);
    });

    testWidgets('a checkbox stays open by design; Escape closes', (
      tester,
    ) async {
      bool checked = false;
      late Future<void> opened;
      await openMenu(
        tester,
        onOpen: (Future<void> future) => opened = future,
        children: <Widget>[
          MenuCheckboxItem(
            value: checked,
            onChanged: (_, bool next) => checked = next,
            child: const Text('Bold'),
          ),
        ],
      );
      await tester.tap(find.text('Bold'));
      await tester.pump();
      expect(checked, isTrue);
      // Documented: checkboxes do not auto-close.
      expect(find.text('Bold'), findsOneWidget);
      await _escape(tester);
      expect(find.text('Bold'), findsNothing);
      await opened;
      expect(tester.takeException(), isNull);
    });

    testWidgets('a radio commits, closes, and reopen reflects it', (
      tester,
    ) async {
      String order = 'asc';
      Future<void> reopen(ValueChanged<Future<void>> onOpen) => openMenu(
        tester,
        onOpen: onOpen,
        children: <Widget>[
          MenuRadioGroup<String>(
            value: order,
            onChanged: (_, String next) => order = next,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final String each in <String>['asc', 'desc'])
                  MenuRadioItem<String>(value: each, child: Text(each)),
              ],
            ),
          ),
        ],
      );
      late Future<void> opened;
      await reopen((Future<void> future) => opened = future);
      await tester.tap(find.text('desc').last);
      await tester.pumpAndSettle();
      expect(order, 'desc');
      expect(find.text('desc'), findsNothing);
      await opened;
      await reopen((Future<void> future) => opened = future);
      // Reopen reflects the committed radio: desc shows the dot.
      final Finder row = find.ancestor(
        of: find.text('desc'),
        matching: find.byType(RovingRow),
      );
      expect(
        find
            .descendant(of: row, matching: find.byIcon(LucideIcons.dot))
            .evaluate()
            .isNotEmpty,
        isTrue,
      );
      await _escape(tester);
      await opened;
      expect(tester.takeException(), isNull);
    });

    testWidgets('Escape and outside tap close without committing', (
      tester,
    ) async {
      bool picked = false;
      late Future<void> opened;
      await openMenu(
        tester,
        onOpen: (Future<void> future) => opened = future,
        children: <Widget>[
          MenuButton(child: const Text('Cut'), onPressed: (_) => picked = true),
        ],
      );
      await _escape(tester);
      expect(picked, isFalse);
      expect(find.text('Cut'), findsNothing);
      await opened;

      await openMenu(
        tester,
        onOpen: (Future<void> future) => opened = future,
        children: <Widget>[
          MenuButton(child: const Text('Cut'), onPressed: (_) => picked = true),
        ],
      );
      // Outside tap on hittable page content (the 120x36 anchor at top
      // left, outside the popup below it). Empty frame areas are not
      // hit-testable, so they would never reach the tap-region surface —
      // in a real app the page fills the screen and any outside tap does.
      await tester.tapAt(const Offset(110, 18));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(picked, isFalse);
      expect(find.text('Cut'), findsNothing);
      await opened;
      expect(tester.takeException(), isNull);
    });

    testWidgets('no overflow at 320 px wide', (tester) async {
      await _at320(tester, () async {
        late Future<void> opened;
        await openMenu(
          tester,
          onOpen: (Future<void> future) => opened = future,
          children: <Widget>[
            MenuButton(child: const Text('Cut'), onPressed: (_) {}),
          ],
        );
        expect(find.text('Cut'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await _escape(tester);
        await opened;
      });
    });
  });

  group('dropdown_menu and context_menu', () {
    testWidgets('dropdown rows commit and close; Escape cancels', (
      tester,
    ) async {
      bool picked = false;
      late BuildContext host;
      await tester.pumpWidget(
        _frame(
          Builder(
            builder: (BuildContext context) {
              host = context;
              return const SizedBox(width: 120, height: 36);
            },
          ),
        ),
      );
      Future<void> open(ValueChanged<Future<void>> onOpen) async {
        onOpen(
          showDropdown<void>(
            context: host,
            children: <Widget>[
              MenuButton(
                child: const Text('Profile'),
                onPressed: (_) => picked = true,
              ),
            ],
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
      }

      late Future<void> opened;
      await open((Future<void> future) => opened = future);
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(picked, isTrue);
      expect(find.text('Profile'), findsNothing);
      await opened;

      await open((Future<void> future) => opened = future);
      await _escape(tester);
      expect(picked, isTrue);
      expect(find.text('Profile'), findsNothing);
      await opened;
      expect(tester.takeException(), isNull);
    });

    testWidgets('context menu rows commit and close', (tester) async {
      bool picked = false;
      late BuildContext host;
      await tester.pumpWidget(
        _frame(
          Builder(
            builder: (BuildContext context) {
              host = context;
              return const SizedBox(width: 120, height: 36);
            },
          ),
        ),
      );
      final Future<void> opened = showContextMenu<void>(
        context: host,
        position: const Offset(100, 100),
        children: <Widget>[
          MenuButton(
            child: const Text('Copy'),
            onPressed: (_) => picked = true,
          ),
        ],
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Copy'), findsOneWidget);
      await tester.tap(find.text('Copy'));
      await tester.pumpAndSettle();
      expect(picked, isTrue);
      expect(find.text('Copy'), findsNothing);
      await opened;
      expect(tester.takeException(), isNull);
    });
  });

  group('menubar', () {
    testWidgets('a submenu pick commits and closes the menu', (tester) async {
      bool picked = false;
      await tester.pumpWidget(
        _frame(
          Menubar(
            children: <Widget>[
              MenuButton(
                child: const Text('File'),
                subMenu: <Widget>[
                  MenuButton(
                    child: const Text('New'),
                    onPressed: (_) => picked = true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      await tester.tap(find.text('File'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('New'), findsOneWidget);
      await tester.tap(find.text('New'));
      await tester.pumpAndSettle();
      expect(picked, isTrue);
      expect(find.text('New'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('popup (generic surface)', () {
    testWidgets('Escape and outside tap close', (tester) async {
      late BuildContext host;
      await tester.pumpWidget(
        _frame(
          Builder(
            builder: (BuildContext context) {
              host = context;
              return const SizedBox(width: 120, height: 36);
            },
          ),
        ),
      );
      Future<void> open(ValueChanged<Future<void>> onOpen) async {
        onOpen(
          showPopup<void>(
            context: host,
            builder: (BuildContext context) => const Text('Body'),
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
      }

      late Future<void> opened;
      await open((Future<void> future) => opened = future);
      expect(find.text('Body'), findsOneWidget);
      await _escape(tester);
      expect(find.text('Body'), findsNothing);
      await opened;

      await open((Future<void> future) => opened = future);
      await _tapOutside(tester);
      expect(find.text('Body'), findsNothing);
      await opened;
      expect(tester.takeException(), isNull);
    });
  });

  group('tooltip and hover_card (hover previews, no selection)', () {
    testWidgets('tooltip shows on hover and hides after', (tester) async {
      await tester.pumpWidget(
        _frame(
          Tooltip(
            waitDuration: Duration.zero,
            tooltip: (BuildContext context) => const Text('Tip'),
            child: const Text('Anchor'),
          ),
        ),
      );
      final TestGesture mouse = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await mouse.addPointer(location: Offset.zero);
      await tester.pump();
      await mouse.moveTo(tester.getCenter(find.text('Anchor')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Tip'), findsOneWidget);
      // Off the surface entirely (existing tooltip-test convention):
      // empty frame areas are not hit-testable, so only a surface-external
      // point reliably ends the hover. Hide is debounced + animated out.
      await mouse.moveTo(const Offset(5000, 5000));
      await tester.pump();
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(find.text('Tip'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('hover card shows on hover and hides after', (tester) async {
      await tester.pumpWidget(
        _frame(
          HoverCard(
            wait: Duration.zero,
            debounce: Duration.zero,
            hoverBuilder: (BuildContext context) => const Text('Card'),
            child: const Text('Anchor'),
          ),
        ),
      );
      final TestGesture mouse = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await mouse.addPointer(location: Offset.zero);
      await tester.pump();
      await mouse.moveTo(tester.getCenter(find.text('Anchor')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Card'), findsOneWidget);
      // Off the surface entirely (existing tooltip-test convention):
      // empty frame areas are not hit-testable, so only a surface-external
      // point reliably ends the hover. Hide is debounced + animated out.
      await mouse.moveTo(const Offset(5000, 5000));
      await tester.pump();
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(find.text('Card'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('command palette', () {
    Stream<List<Widget>> results(BuildContext context, String? query) async* {
      yield <Widget>[
        for (final String name in <String>['Alpha', 'Beta'])
          if (query == null || name.toLowerCase().contains(query.toLowerCase()))
            SubFocusListItem(title: Text(name)),
      ];
    }

    testWidgets('typing filters; Escape closes without committing', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(Command(debounceDuration: Duration.zero, builder: results)),
      );
      await tester.pump();
      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsOneWidget);
      await tester.enterText(find.byType(EditableText), 'alp');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsNothing);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);
    });

    testWidgets('the field takes focus on mount; arrows reach the rows', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(Command(debounceDuration: Duration.zero, builder: results)),
      );
      await tester.pump();
      final Finder field = find.byType(EditableText);
      expect(field, findsOneWidget);
      expect(tester.widget<EditableText>(field).focusNode.hasFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('autocomplete (field-attached suggestions)', () {
    Input field(ValueChanged<String>? onSelected) {
      return Input(
        features: <InputFeature>[
          AutoCompleteFeature(
            suggestions: (String query) => <String>[
              for (final String fruit in <String>['apple', 'apricot', 'fig'])
                if (fruit.startsWith(query)) fruit,
            ],
            onSuggestionSelected: onSelected,
          ),
        ],
      );
    }

    testWidgets('typing opens the list; Enter applies; Escape dismisses', (
      tester,
    ) async {
      String? applied;
      await tester.pumpWidget(_frame(field((String next) => applied = next)));
      await tester.pump();
      await tester.enterText(find.byType(EditableText), 'ap');
      // Park the caret at the end the way a real editor would before Enter.
      tester
          .widget<EditableText>(find.byType(EditableText))
          .controller
          .selection = const TextSelection.collapsed(
        offset: 2,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('apple'), findsOneWidget);
      expect(find.text('fig'), findsNothing);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(applied, isNotNull);
      expect(tester.takeException(), isNull);
    });
  });

  group('calendar (inline single date)', () {
    const CalendarView march = CalendarView(2024, 3);
    testWidgets('tapping a day commits; tapping again clears', (tester) async {
      CalendarValue? value;
      final List<CalendarValue?> log = <CalendarValue?>[];
      await tester.pumpWidget(
        _frame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Calendar(
              view: march,
              selectionMode: CalendarSelectionMode.single,
              value: value,
              onChanged: (CalendarValue? next) =>
                  setState(() => log.add(value = next)),
            ),
          ),
        ),
      );
      await tester.tap(find.text('5'));
      await tester.pump();
      expect(value, CalendarValue.single(DateTime(2024, 3, 5)));
      await tester.tap(find.text('5'));
      await tester.pump();
      expect(value, isNull);
      expect(log, <CalendarValue?>[
        CalendarValue.single(DateTime(2024, 3, 5)),
        null,
      ]);
      expect(tester.takeException(), isNull);
    });
  });

  group('object_input date field (dialog prompt)', () {
    testWidgets('picking a day commits and closes; Escape cancels', (
      tester,
    ) async {
      DateTime? value;
      await tester.pumpWidget(
        _navFrame(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => DateInput(
              value: value,
              mode: PromptMode.dialog,
              initialView: const CalendarView(2024, 3),
              onChanged: (DateTime? next) => setState(() => value = next),
            ),
          ),
          onHost: (_) {},
        ),
      );
      await tester.pump();
      await tester.tap(find.byIcon(LucideIcons.calendarDays));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('15'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(value, DateTime(2024, 3, 15));
      // The dialog closed on pick (no calendar surface left).
      expect(find.byType(Calendar), findsNothing);

      await tester.tap(find.byIcon(LucideIcons.calendarDays));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await _escape(tester);
      expect(value, DateTime(2024, 3, 15));
      expect(tester.takeException(), isNull);
    });
  });

  group('item_picker', () {
    testWidgets('picking commits and closes', (tester) async {
      late BuildContext host;
      await tester.pumpWidget(
        _frame(
          Builder(
            builder: (BuildContext context) {
              host = context;
              return const SizedBox(width: 120, height: 36);
            },
          ),
        ),
      );
      await tester.pump();
      final Future<String?> opened = showItemPicker<String>(
        host,
        items: const ItemList<String>(<String>['red', 'green']),
        builder: (BuildContext context, String item) =>
            ItemPickerOption(value: item, child: Text(item)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('green'), findsOneWidget);
      await tester.tap(find.text('green'));
      await tester.pumpAndSettle();
      expect(await opened, 'green');
      expect(find.text('green'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('dialog and alert_dialog', () {
    testWidgets('dialog confirm commits; Escape and barrier cancel', (
      tester,
    ) async {
      final FocusNode opener = FocusNode(debugLabel: 'opener');
      addTearDown(opener.dispose);
      late BuildContext host;
      await tester.pumpWidget(
        _navFrame(
          Focus(
            focusNode: opener,
            child: const SizedBox(width: 10, height: 10),
          ),
          onHost: (BuildContext context) => host = context,
        ),
      );
      opener.requestFocus();
      await tester.pump();

      Future<bool?> open() => showDialog<bool>(
        context: host,
        builder: (BuildContext context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Confirm?'),
            Builder(
              builder: (BuildContext context) => GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      );

      Future<bool?> opened = open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Confirm?'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(await opened, isTrue);
      expect(find.text('Confirm?'), findsNothing);
      // Focus returns to the opener after a commit-close.
      expect(opener.hasFocus, isTrue);

      opened = open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await _escape(tester);
      await tester.pumpAndSettle();
      expect(await opened, isNull);
      expect(find.text('Confirm?'), findsNothing);
      expect(opener.hasFocus, isTrue);

      opened = open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      expect(await opened, isNull);
      expect(find.text('Confirm?'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('alert dialog action commits; Escape cancels', (tester) async {
      late BuildContext host;
      await tester.pumpWidget(
        _navFrame(
          const SizedBox(width: 10, height: 10),
          onHost: (BuildContext context) => host = context,
        ),
      );
      Future<bool?> open() => showAlertDialog<bool>(
        context: host,
        title: const Text('Delete?'),
        actionsBuilder: (BuildContext dialogContext) => <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      );

      Future<bool?> opened = open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(await opened, isTrue);

      opened = open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await _escape(tester);
      await tester.pumpAndSettle();
      expect(await opened, isNull);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no overflow at 320 px wide', (tester) async {
      await _at320(tester, () async {
        late BuildContext host;
        await tester.pumpWidget(
          _navFrame(
            const SizedBox(width: 10, height: 10),
            onHost: (BuildContext context) => host = context,
          ),
        );
        final Future<bool?> opened = showDialog<bool>(
          context: host,
          builder: (BuildContext context) => const Text('Confirm?'),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.text('Confirm?'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await _escape(tester);
        await tester.pumpAndSettle();
        await opened;
      });
    });
  });

  group('drawer and sheet', () {
    testWidgets('drawer confirm commits; Escape and barrier cancel', (
      tester,
    ) async {
      final FocusNode opener = FocusNode(debugLabel: 'opener');
      addTearDown(opener.dispose);
      late BuildContext host;
      await tester.pumpWidget(
        _navFrame(
          Focus(
            focusNode: opener,
            child: const SizedBox(width: 10, height: 10),
          ),
          onHost: (BuildContext context) => host = context,
        ),
      );
      opener.requestFocus();
      await tester.pump();

      Future<String?> open() => openDrawer<String>(
        context: host,
        builder: (BuildContext context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Drawer body'),
            Builder(
              builder: (BuildContext context) => GestureDetector(
                onTap: () => closeDrawer(context, 'saved'),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      );

      Future<String?> opened = open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Drawer body'), findsOneWidget);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(await opened, 'saved');
      expect(opener.hasFocus, isTrue);

      opened = open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await _escape(tester);
      await tester.pumpAndSettle();
      expect(await opened, isNull);

      opened = open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      expect(await opened, isNull);
      expect(tester.takeException(), isNull);
    });

    testWidgets('sheet confirm commits and closes', (tester) async {
      late BuildContext host;
      await tester.pumpWidget(
        _navFrame(
          const SizedBox(width: 10, height: 10),
          onHost: (BuildContext context) => host = context,
        ),
      );
      final Future<String?> opened = openSheet<String>(
        context: host,
        builder: (BuildContext context) => Builder(
          builder: (BuildContext context) => GestureDetector(
            onTap: () => closeSheet(context, 'picked'),
            child: const Text('Pick'),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Pick'), findsOneWidget);
      await tester.tap(find.text('Pick'));
      await tester.pumpAndSettle();
      expect(await opened, 'picked');
      expect(find.text('Pick'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('pinned_sheet (in-tree panel, no route)', () {
    testWidgets('controller opens; modal barrier tap closes', (tester) async {
      final SheetController controller = SheetController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          PinnedSheet(
            controller: controller,
            modal: true,
            barrierDismissible: true,
            barrierColor: ThemedColor.value(const Color(0x80000000)),
            child: const Text('Sheet body'),
          ),
        ),
      );
      await tester.pump();
      expect(controller.isOpen, isFalse);
      // Do not await the open future before pumping: the open animation
      // only advances on frames, so awaiting it first deadlocks the test.
      unawaited(controller.open());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(controller.isOpen, isTrue);
      expect(find.text('Sheet body'), findsOneWidget);
      // The barrier sits at the top edge for a bottom sheet.
      await tester.tapAt(const Offset(160, 10));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(controller.isOpen, isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Escape is a deliberate no-op (documented)', (tester) async {
      final SheetController controller = SheetController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          PinnedSheet(controller: controller, child: const Text('Sheet body')),
        ),
      );
      unawaited(controller.open());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(controller.isOpen, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      // Documented: the pinned sheet has no DismissIntent; Escape never
      // closes it (close with the controller or the barrier instead).
      expect(controller.isOpen, isTrue);
      expect(tester.takeException(), isNull);
    });
  });

  group('navigation_menu', () {
    testWidgets('tapping an item opens its panel; Escape closes it', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          NavigationMenu(
            children: <Widget>[
              NavigationMenuItem(
                onPressed: () {},
                content: const Text('Docs panel'),
                child: const Text('Docs'),
              ),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Docs'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Docs panel'), findsOneWidget);
      // Keyboard path (the non-modal panel never steals focus on mouse
      // open): focus the item, ArrowDown opens and moves focus into the
      // panel, Escape closes and returns focus to the item.
      final NavigationMenuItemState docs = tester.state(
        find.byType(NavigationMenuItem),
      );
      docs.focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Docs panel'), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Docs panel'), findsNothing);
      expect(docs.focusNode.hasFocus, isTrue);
      expect(tester.takeException(), isNull);
    });
  });

  group('toast (non-modal queue, no focus move)', () {
    testWidgets('manual dismiss removes the toast', (tester) async {
      final ToastController controller = ToastController();
      addTearDown(controller.dispose);
      late BuildContext host;
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: 400,
              height: 400,
              child: ToastLayer(
                controller: controller,
                child: Builder(
                  builder: (BuildContext context) {
                    host = context;
                    return const SizedBox.expand();
                  },
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      final String id = showToast(
        host,
        builder: (BuildContext context) => const Text('Saved'),
        autoDismiss: false,
      );
      await tester.pump();
      expect(find.text('Saved'), findsOneWidget);
      controller.dismiss(id);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Saved'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('gooey_toast (non-modal, no focus move)', () {
    testWidgets('manual dismiss removes the toast', (tester) async {
      final GooeyToastController controller = GooeyToastController();
      addTearDown(controller.dispose);
      late BuildContext host;
      await tester.pumpWidget(
        _frame(
          GooeyToastLayer(
            controller: controller,
            child: Builder(
              builder: (BuildContext context) {
                host = context;
                return const SizedBox(width: 400, height: 400);
              },
            ),
          ),
        ),
      );
      await tester.pump();
      final String id = showGooeyToast(
        host,
        const GooeyToastOptions(title: 'Hi'),
        autoDismiss: false,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Hi'), findsOneWidget);
      controller.dismiss(id);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Hi'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('dropzone and file_picker (inline, no overlay)', () {
    testWidgets('browse fires onBrowse; Enter activates', (tester) async {
      int taps = 0;
      await tester.pumpWidget(_frame(Dropzone(onBrowse: () => taps++)));
      await tester.tap(find.byKey(dropzoneActionKey));
      await tester.pump();
      expect(taps, 1);
      // Keyboard: focus the action and press Enter.
      final Finder action = find.byKey(dropzoneActionKey);
      Focus.of(tester.element(action)).requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(taps, 2);
      expect(tester.takeException(), isNull);
    });

    testWidgets('picking files reports them and renders the row', (
      tester,
    ) async {
      final List<FileValue> pending = <FileValue>[
        FileValue(id: 'a', name: 'a.pdf', size: 1, mimeType: 'application/pdf'),
      ];
      List<FileValue>? reported;
      await tester.pumpWidget(
        _frame(
          FileUpload(
            pick: (_) async => pending,
            onFilesChanged: (List<FileValue> next) => reported = next,
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.byKey(dropzoneActionKey));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(reported, hasLength(1));
      expect(find.text('a.pdf'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('color_picker (inline panel)', () {
    testWidgets('typing a channel commits through onChanged', (tester) async {
      ColorDerivative? changed;
      await tester.pumpWidget(
        _frame(
          ColorPicker(
            value: ColorDerivative.fromColor(const Color(0xFFFF0000)),
            enableEyeDropper: false,
            showHistoryButton: false,
            onChanged: (ColorDerivative value) => changed = value,
          ),
        ),
      );
      await tester.pump();
      final Finder first = find
          .descendant(
            of: find.byType(Input).first,
            matching: find.byType(EditableText),
          )
          .first;
      await tester.enterText(first, '64');
      await tester.pump();
      expect(changed, isNotNull);
      expect(changed!.red, 64);
      expect(tester.takeException(), isNull);
    });
  });

  group('color_input (well + hex + prompt)', () {
    Widget harness({ValueChanged<ColorDerivative>? onChanged}) {
      return Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Localizations(
            locale: const Locale('en'),
            delegates: const <LocalizationsDelegate<dynamic>>[
              DefaultWidgetsLocalizations.delegate,
              ComponentLocalizations.delegate,
            ],
            child: TapRegionSurface(
              child: Overlay(
                initialEntries: <OverlayEntry>[
                  OverlayEntry(
                    builder: (BuildContext context) => Align(
                      alignment: Alignment.topLeft,
                      child: ColorInput(
                        value: ColorDerivative.fromColor(
                          const Color(0xFFFF0000),
                        ),
                        mode: PromptMode.popover,
                        onChanged: onChanged,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Finder hexEditable() => find
        .descendant(
          of: find.byType(ColorInput),
          matching: find.byType(EditableText),
        )
        .first;

    testWidgets('typing hex commits inline', (tester) async {
      ColorDerivative? changed;
      await tester.pumpWidget(
        harness(onChanged: (ColorDerivative value) => changed = value),
      );
      await tester.pump();
      await tester.enterText(hexEditable(), '#00ff00');
      await tester.pump();
      expect(changed, isNotNull);
      expect(changed!.toColor(), const Color(0xFF00FF00));
      expect(tester.takeException(), isNull);
    });

    testWidgets('the prompt opens; Escape closes without committing', (
      tester,
    ) async {
      final List<ColorDerivative> commits = <ColorDerivative>[];
      await tester.pumpWidget(harness(onChanged: commits.add));
      await tester.pump();
      await tester.tap(find.byType(Clickable));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(ColorPicker), findsOneWidget);
      await _escape(tester);
      expect(commits, isEmpty);
      expect(find.byType(ColorPicker), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('time input (inline segments)', () {
    testWidgets('typing a full time commits; incomplete reports null', (
      tester,
    ) async {
      final List<TimeOfDay?> log = <TimeOfDay?>[];
      await tester.pumpWidget(
        _frame(TimeInput(onChanged: (TimeOfDay? next) => log.add(next))),
      );
      await tester.pump();
      final Finder fields = find.descendant(
        of: find.byType(TimeInput),
        matching: find.byType(EditableText),
      );
      expect(fields.evaluate().length, greaterThanOrEqualTo(2));
      await tester.enterText(fields.at(0), '10');
      await tester.enterText(fields.at(1), '30');
      await tester.pump();
      expect(log.last, const TimeOfDay(hour: 10, minute: 30));
      expect(tester.takeException(), isNull);
    });
  });

  group('date_picker (dialog draft + popover live editors)', () {
    testWidgets('dialog Save commits and closes; reopen reflects it', (
      tester,
    ) async {
      DateTime? value = DateTime(2024, 3, 14);
      await tester.pumpWidget(
        _navFrame(
          StatefulBuilder(
            builder: (context, setState) => DatePicker(
              value: value,
              onChanged: (next) => setState(() => value = next),
            ),
          ),
          onHost: (_) {},
        ),
      );
      await tester.tap(find.text('March 14, 2024'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('March 2024'), findsOneWidget);
      // The draft does not commit before Save.
      await tester.tap(find.text('20'));
      await tester.pump();
      expect(value, DateTime(2024, 3, 14));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(value, DateTime(2024, 3, 20));
      expect(find.text('March 2024'), findsNothing);
      // Reopen reflects the committed day; focus is back on the trigger
      // whichever way the dialog closed.
      await tester.tap(find.text('March 20, 2024'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('March 2024'), findsOneWidget);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(
        FocusManager.instance.primaryFocus?.context
            ?.findAncestorWidgetOfExactType<DatePicker>(),
        isNotNull,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('dialog Escape and Cancel discard the draft', (tester) async {
      DateTime? value = DateTime(2024, 3, 14);
      await tester.pumpWidget(
        _navFrame(
          StatefulBuilder(
            builder: (context, setState) => DatePicker(
              value: value,
              onChanged: (next) => setState(() => value = next),
            ),
          ),
          onHost: (_) {},
        ),
      );
      await tester.tap(find.text('March 14, 2024'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('20'));
      await tester.pump();
      await _escape(tester);
      await tester.pumpAndSettle();
      expect(find.text('March 2024'), findsNothing);
      expect(value, DateTime(2024, 3, 14));

      await tester.tap(find.text('March 14, 2024'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('21'));
      await tester.pump();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('March 2024'), findsNothing);
      expect(value, DateTime(2024, 3, 14));
      expect(tester.takeException(), isNull);
    });

    testWidgets('popover reports live and stays open; Escape closes', (
      tester,
    ) async {
      DateTime? value = DateTime(2024, 3, 14);
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) => _frame(
            DatePicker(
              value: value,
              onChanged: (next) => setState(() => value = next),
              mode: PromptMode.popover,
            ),
          ),
        ),
      );
      await tester.tap(find.text('March 14, 2024'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('March 2024'), findsOneWidget);
      // Live editor by design: every pick reports, the popover stays open.
      await tester.tap(find.text('15'));
      await tester.pump();
      expect(value, DateTime(2024, 3, 15));
      expect(find.text('March 2024'), findsOneWidget);
      await _escape(tester);
      expect(find.text('March 2024'), findsNothing);
      expect(value, DateTime(2024, 3, 15));
      expect(tester.takeException(), isNull);
    });

    testWidgets('range dialog Save commits the span', (tester) async {
      DateTimeRange? value;
      await tester.pumpWidget(
        _navFrame(
          StatefulBuilder(
            builder: (context, setState) => DateRangePicker(
              value: value,
              onChanged: (next) => setState(() => value = next),
              initialView: const CalendarView(2024, 3),
            ),
          ),
          onHost: (_) {},
        ),
      );
      await tester.tap(find.byType(Clickable).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('March 2024'), findsOneWidget);
      await tester.tap(find.text('15'));
      await tester.pump();
      await tester.tap(find.text('20'));
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(value?.start, DateTime(2024, 3, 15));
      expect(value?.end, DateTime(2024, 3, 20));
      expect(find.text('March 2024'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no overflow at 320 px wide', (tester) async {
      await _at320(tester, () async {
        await tester.pumpWidget(
          _navFrame(
            DatePicker(value: DateTime(2024, 3, 14), onChanged: (_) {}),
            onHost: (_) {},
          ),
        );
        await tester.tap(find.text('March 14, 2024'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.text('March 2024'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });
  });

  group('time_picker (dialog draft + popover live editors)', () {
    testWidgets('dialog Save commits and closes; Escape discards', (
      tester,
    ) async {
      TimeOfDay? value = const TimeOfDay(hour: 9, minute: 0);
      await tester.pumpWidget(
        _navFrame(
          StatefulBuilder(
            builder: (context, setState) => TimePicker(
              value: value,
              onChanged: (next) => setState(() => value = next),
              use24HourFormat: true,
            ),
          ),
          onHost: (_) {},
        ),
      );
      await tester.tap(find.text('09:00'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.enterText(find.byType(EditableText).first, '10');
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(value, const TimeOfDay(hour: 10, minute: 0));
      expect(find.text('Save'), findsNothing);
      // Reopen reflects the committed time.
      expect(find.text('10:00'), findsOneWidget);

      await tester.tap(find.text('10:00'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.enterText(find.byType(EditableText).first, '11');
      await tester.pump();
      await _escape(tester);
      await tester.pumpAndSettle();
      expect(find.text('Save'), findsNothing);
      expect(value, const TimeOfDay(hour: 10, minute: 0));
      expect(tester.takeException(), isNull);
    });

    testWidgets('popover reports live and stays open; outside tap closes', (
      tester,
    ) async {
      TimeOfDay? value = const TimeOfDay(hour: 9, minute: 0);
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) => _frame(
            TimePicker(
              value: value,
              onChanged: (next) => setState(() => value = next),
              use24HourFormat: true,
              mode: PromptMode.popover,
            ),
          ),
        ),
      );
      await tester.tap(find.text('09:00'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.enterText(find.byType(EditableText).first, '10');
      await tester.pump();
      expect(value, const TimeOfDay(hour: 10, minute: 0));
      await _tapOutside(tester);
      await tester.pumpAndSettle();
      expect(value, const TimeOfDay(hour: 10, minute: 0));
      expect(tester.takeException(), isNull);
    });

    testWidgets('duration dialog Save commits and closes', (tester) async {
      Duration? value = const Duration(hours: 1);
      await tester.pumpWidget(
        _navFrame(
          StatefulBuilder(
            builder: (context, setState) => DurationPicker(
              value: value,
              onChanged: (next) => setState(() => value = next),
            ),
          ),
          onHost: (_) {},
        ),
      );
      await tester.tap(find.byType(Clickable).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(value, const Duration(hours: 1));
      expect(find.text('Save'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no overflow at 320 px wide', (tester) async {
      await _at320(tester, () async {
        await tester.pumpWidget(
          _navFrame(
            TimePicker(
              value: const TimeOfDay(hour: 9, minute: 0),
              onChanged: (_) {},
              use24HourFormat: true,
            ),
            onHost: (_) {},
          ),
        );
        await tester.tap(find.text('09:00'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.text('Save'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });
  });
}
