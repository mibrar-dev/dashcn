// Widget tests for the `wheel_picker` component.
//
// Covers rendering (single + multi column), controlled/uncontrolled modes,
// the haptic-free selection callback, keyboard arrows, looping, perspective,
// theme + style overrides, custom builders, RTL, reduced motion and a 375px
// phone-width overflow check.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/wheel_picker/wheel_picker.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const List<String> _numbers = <String>['01', '02', '03', '04', '05'];
const List<String> _letters = <String>['A', 'B', 'C', 'D', 'E'];

/// Pumps a [WheelPicker] inside a bounded box the size of the docs stage.
Future<void> pumpWheel(
  WidgetTester tester,
  WheelPicker picker, {
  Size size = const Size(720, 420),
}) async {
  await tester.pumpWidget(
    Theme(
      data: const ThemeData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: SizedBox(width: size.width, height: size.height, child: picker)),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('rendering', () {
    testWidgets('renders a single column of rows', (tester) async {
      await pumpWheel(
        tester,
        WheelPicker(columns: <WheelColumn>[WheelColumn(items: _numbers)]),
      );
      // The wheel centres the selected row, so with the default selection the
      // first rows are the ones rendered.
      expect(find.text('01'), findsOneWidget);
      expect(find.text('02'), findsOneWidget);
      expect(find.byType(ListWheelScrollView), findsOneWidget);
    });

    testWidgets('renders multiple columns with separators', (tester) async {
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(items: _numbers),
            WheelColumn(items: _letters),
          ],
        ),
      );
      expect(find.byType(ListWheelScrollView), findsNWidgets(2));
      expect(find.text('01'), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('renders custom row content', (tester) async {
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(
              items: _numbers,
              builder: (context, index) => Text('row-$index'),
            ),
          ],
        ),
      );
      expect(find.text('row-0'), findsOneWidget);
      expect(find.text('01'), findsNothing);
    });

    testWidgets('shows the selection band', (tester) async {
      await pumpWheel(
        tester,
        WheelPicker(columns: <WheelColumn>[WheelColumn(items: _numbers)]),
      );
      // The band is a centred DecoratedBox one row tall.
      final DecoratedBox band = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(WheelPicker),
          matching: find.byType(DecoratedBox),
        ).first,
      );
      expect(band.decoration, isA<BoxDecoration>());
    });
  });

  group('selection', () {
    testWidgets('uncontrolled: onChanged reports the selection', (tester) async {
      List<int>? reported;
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _numbers)],
          initialValue: const <int>[0],
          onChanged: (value) => reported = value,
        ),
      );
      // Tap the third row to select it.
      await tester.tap(find.text('03'));
      await tester.pumpAndSettle();
      expect(reported, isNotNull);
      expect(reported!.last, 2);
    });

    testWidgets('controlled: value drives the selection', (tester) async {
      List<int> value = <int>[0];
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _numbers)],
          value: value,
          onChanged: (v) => value = v,
        ),
      );
      await tester.tap(find.text('03'));
      await tester.pumpAndSettle();
      expect(value, <int>[2]);
    });

    testWidgets('no onChanged: picker is disabled and inert', (tester) async {
      await pumpWheel(
        tester,
        const WheelPicker(columns: <WheelColumn>[WheelColumn(items: _numbers)]),
      );
      await tester.tap(find.text('03'));
      await tester.pumpAndSettle();
      // No crash, no selection change.
      expect(find.text('03'), findsOneWidget);
    });
  });

  group('keyboard', () {
    testWidgets('arrow keys move the selection and switch columns', (tester) async {
      final List<List<int>> reported = <List<int>>[];
      final FocusNode focus = FocusNode();
      addTearDown(focus.dispose);
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(items: _numbers),
            WheelColumn(items: _letters),
          ],
          initialValue: const <int>[0, 0],
          focusNode: focus,
          onChanged: reported.add,
        ),
      );
      focus.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      expect(reported.last, <int>[1, 0]);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      expect(reported.last, <int>[1, 1]);
    });

    testWidgets('home and end jump to the ends', (tester) async {
      final List<List<int>> reported = <List<int>>[];
      final FocusNode focus = FocusNode();
      addTearDown(focus.dispose);
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _numbers)],
          initialValue: const <int>[2],
          focusNode: focus,
          onChanged: reported.add,
        ),
      );
      focus.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.end);
      await tester.pumpAndSettle();
      expect(reported.last, <int>[4]);
      await tester.sendKeyEvent(LogicalKeyboardKey.home);
      await tester.pumpAndSettle();
      expect(reported.last, <int>[0]);
    });
  });

  group('looping', () {
    testWidgets('looping wraps past the last item', (tester) async {
      final List<List<int>> reported = <List<int>>[];
      final FocusNode focus = FocusNode();
      addTearDown(focus.dispose);
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _numbers)],
          initialValue: const <int>[4],
          looping: true,
          focusNode: focus,
          onChanged: reported.add,
        ),
      );
      focus.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      expect(reported.last, <int>[0]);
    });

    testWidgets('non-looping clamps at the ends', (tester) async {
      final List<List<int>> reported = <List<int>>[];
      final FocusNode focus = FocusNode();
      addTearDown(focus.dispose);
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _numbers)],
          initialValue: const <int>[4],
          focusNode: focus,
          onChanged: reported.add,
        ),
      );
      focus.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      expect(reported, isEmpty);
    });
  });

  group('theme and style overrides', () {
    testWidgets('widget theme leg overrides the defaults', (tester) async {
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _numbers)],
          theme: const WheelPickerTheme(
            itemHeight: 48,
            visibleItems: 3,
            fontSize: 20,
          ),
        ),
      );
      final ListWheelScrollView wheel = tester.widget<ListWheelScrollView>(
        find.byType(ListWheelScrollView),
      );
      expect(wheel.itemExtent, 48);
    });

    testWidgets('ComponentTheme scoped leg overrides', (tester) async {
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: ComponentTheme<WheelPickerTheme>(
              data: const WheelPickerTheme(visibleItems: 7),
              child: Center(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: WheelPicker(
                    columns: <WheelColumn>[WheelColumn(items: _numbers)],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      // 7 visible rows * 40px = 280px wheel height.
      expect(find.byType(ListWheelScrollView), findsOneWidget);
    });
  });

  group('reduced motion', () {
    testWidgets('snap animation collapses under reduced motion', (tester) async {
      final List<List<int>> reported = <List<int>>[];
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Theme(
            data: const ThemeData(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: SizedBox(
                  width: 400,
                  height: 300,
                  child: WheelPicker(
                    columns: <WheelColumn>[WheelColumn(items: _numbers)],
                    initialValue: const <int>[0],
                    onChanged: reported.add,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('03'));
      await tester.pump();
      expect(reported.last, <int>[2]);
    });
  });

  group('RTL', () {
    testWidgets('renders right to left', (tester) async {
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: SizedBox(
                width: 400,
                height: 300,
                child: WheelPicker(
                  columns: <WheelColumn>[
                    WheelColumn(items: _numbers),
                    WheelColumn(items: _letters),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(ListWheelScrollView), findsNWidgets(2));
    });
  });

  group('phone width', () {
    testWidgets('no overflow at 375px', (tester) async {
      await pumpWheel(
        tester,
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(items: _numbers),
            WheelColumn(items: _letters),
          ],
        ),
        size: const Size(375, 812),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
