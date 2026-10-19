// Responsive popups: anchored at >=768, bottom sheet at <768.
// Pumps each popup-style component at 1024/768/600/390 and asserts the
// popup rect is within 12px of its trigger (anchored) or at the bottom
// edge (sheet). Tooltips stay anchored on all widths. Also asserts
// overflow-free at 320px.

import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/autocomplete/autocomplete.dart';
import 'package:dashcn/src/components/context_menu/context_menu.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/components/dropdown_menu/dropdown_menu.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/popup/popup.dart';
import 'package:dashcn/src/components/select/select.dart';
import 'package:dashcn/src/components/time_picker/time_picker.dart';
import 'package:dashcn/src/components/tooltip/tooltip.dart';
import 'package:dashcn/src/primitives/form_core/object_form_field.dart';
import 'package:dashcn/src/primitives/input_features/input_features.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const ValueKey<String> _triggerKey = ValueKey<String>('resp-trigger');

Widget _frame(Widget child) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: TapRegionSurface(
        child: Overlay(
          initialEntries: <OverlayEntry>[
            OverlayEntry(
              builder: (context) => Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, top: 100),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> _setViewport(
  WidgetTester tester,
  double width,
  double height,
) async {
  tester.view.physicalSize = Size(width, height);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pump();
}

void _expectAnchored(WidgetTester tester, double width, double height) {
  final Rect trigger = tester.getRect(find.byKey(_triggerKey));
  Finder popupFinder = find.byType(MenuPopup);
  if (popupFinder.evaluate().isEmpty) {
    popupFinder = find.byType(TooltipContainer);
  }
  if (popupFinder.evaluate().isEmpty) {
    popupFinder = find.byType(MenuPopupSurface);
  }
  expect(popupFinder, findsWidgets);
  final Rect popup = tester.getRect(popupFinder.first);
  // Within viewport (clamped, never leaves screen).
  expect(popup.left, greaterThanOrEqualTo(-1));
  expect(popup.top, greaterThanOrEqualTo(-1));
  expect(popup.right, lessThanOrEqualTo(width + 1));
  expect(popup.bottom, lessThanOrEqualTo(height + 1));
  // Within 12px of trigger vertically (below or flipped above).
  final double belowGap = (popup.top - trigger.bottom).abs();
  final double aboveGap = (trigger.top - popup.bottom).abs();
  final double gap = belowGap < aboveGap ? belowGap : aboveGap;
  expect(
    gap,
    lessThanOrEqualTo(12),
    reason: 'popup $popup trigger $trigger width $width',
  );
  // Not centred: the popup centre must be far from the screen centre
  // (the reported bug placed popups in the centre).
  final Offset screenCenter = Offset(width / 2, height / 2);
  final double dist = (popup.center - screenCenter).distance;
  expect(dist, greaterThan(50), reason: 'popup centred at $width');
}

void _expectSheet(WidgetTester tester, double width, double height) {
  Finder popupFinder = find.byType(MenuPopup);
  if (popupFinder.evaluate().isEmpty) {
    popupFinder = find.byType(MenuPopupSurface);
  }
  // Sheet still uses the same popup surface.
  expect(popupFinder, findsWidgets);
  final Rect popup = tester.getRect(popupFinder.first);
  // Full width minus 12px gutters (12 each side).
  expect(
    popup.width,
    greaterThanOrEqualTo(width - 24 - 12),
    reason: 'sheet width ${popup.width} viewport $width',
  );
  expect(
    popup.width,
    lessThanOrEqualTo(width),
    reason: 'sheet width ${popup.width} viewport $width',
  );
  // At the bottom edge.
  expect(
    height - popup.bottom,
    lessThanOrEqualTo(24),
    reason: 'sheet bottom ${popup.bottom} viewport $height',
  );
  // Max height 70%.
  expect(
    popup.height,
    lessThanOrEqualTo(height * 0.7 + 24),
    reason: 'sheet height ${popup.height} viewport $height',
  );
  // Drag handle + tap-outside (barrier or TapRegion) present: handle key.
  expect(
    find.byKey(const ValueKey<String>('dashcn.popup.sheet.handle')),
    findsOneWidget,
    reason: 'sheet handle missing at $width',
  );
}

Future<void> _pumpPopupAt(
  WidgetTester tester,
  double width,
  Future<void> Function(BuildContext host) open,
) async {
  late BuildContext host;
  await _setViewport(tester, width, 800);
  await tester.pumpWidget(
    _frame(
      Builder(
        builder: (context) {
          host = context;
          return const SizedBox(key: _triggerKey, width: 120, height: 36);
        },
      ),
    ),
  );
  await tester.pump();
  await open(host);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  group('responsive popups', () {
    for (final double width in <double>[1024, 768]) {
      testWidgets('popup anchored at $width', (tester) async {
        await _pumpPopupAt(tester, width, (host) async {
          showPopup<void>(
            context: host,
            builder: (context) => const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Signed in'),
            ),
          );
        });
        _expectAnchored(tester, width, 800);
      });

      testWidgets('menu anchored at $width', (tester) async {
        await _pumpPopupAt(tester, width, (host) async {
          showMenu<void>(
            context: host,
            children: const <Widget>[
              MenuButton(child: Text('One')),
              MenuButton(child: Text('Two')),
            ],
          );
        });
        _expectAnchored(tester, width, 800);
      });

      testWidgets('dropdown anchored at $width', (tester) async {
        await _pumpPopupAt(tester, width, (host) async {
          showDropdown<void>(
            context: host,
            children: const <Widget>[MenuButton(child: Text('One'))],
          );
        });
        _expectAnchored(tester, width, 800);
      });

      testWidgets('context menu anchored at $width', (tester) async {
        await _setViewport(tester, width, 800);
        late BuildContext host;
        await tester.pumpWidget(
          _frame(
            Builder(
              builder: (context) {
                host = context;
                return const SizedBox(key: _triggerKey, width: 120, height: 36);
              },
            ),
          ),
        );
        await tester.pump();
        final Rect trigger = tester.getRect(find.byKey(_triggerKey));
        showContextMenu<void>(
          context: host,
          position: trigger.bottomLeft + const Offset(0, 4),
          children: const <Widget>[MenuButton(child: Text('One'))],
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        _expectAnchored(tester, width, 800);
      });

      testWidgets('select anchored at $width', (tester) async {
        await _setViewport(tester, width, 800);
        await tester.pumpWidget(
          _frame(
            Select<String>(
              key: const ValueKey<String>('resp-select'),
              value: null,
              onChanged: (_) {},
              placeholder: const SizedBox(
                key: _triggerKey,
                width: 120,
                height: 20,
              ),
              itemBuilder: (context, v) => Text(v),
              items: const <Widget>[
                SelectItem<String>(value: 'a', child: Text('a')),
              ],
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.byType(Select<String>));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        _expectAnchored(tester, width, 800);
      });

      testWidgets('tooltip anchored at $width', (tester) async {
        await _setViewport(tester, width, 800);
        await tester.pumpWidget(
          _frame(
            Tooltip(
              waitDuration: Duration.zero,
              anchorAlignment: Alignment.bottomCenter,
              alignment: Alignment.topCenter,
              tooltip: (context) => const Text('hi'),
              child: Container(
                key: _triggerKey,
                width: 120,
                height: 36,
                color: const Color(0xFF000001),
              ),
            ),
          ),
        );
        await tester.pump();
        final TestGesture gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.byType(Tooltip)));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        _expectAnchored(tester, width, 800);
      });
    }

    for (final double width in <double>[600, 390]) {
      testWidgets('popup sheet at $width', (tester) async {
        await _pumpPopupAt(tester, width, (host) async {
          showPopup<void>(
            context: host,
            builder: (context) => const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Signed in'),
            ),
          );
        });
        _expectSheet(tester, width, 800);
      });

      testWidgets('menu sheet at $width', (tester) async {
        await _pumpPopupAt(tester, width, (host) async {
          showMenu<void>(
            context: host,
            children: const <Widget>[
              MenuButton(child: Text('One')),
              MenuButton(child: Text('Two')),
            ],
          );
        });
        _expectSheet(tester, width, 800);
      });

      testWidgets('dropdown sheet at $width', (tester) async {
        await _pumpPopupAt(tester, width, (host) async {
          showDropdown<void>(
            context: host,
            children: const <Widget>[MenuButton(child: Text('One'))],
          );
        });
        _expectSheet(tester, width, 800);
      });

      testWidgets('select sheet at $width', (tester) async {
        await _setViewport(tester, width, 800);
        await tester.pumpWidget(
          _frame(
            Select<String>(
              value: null,
              onChanged: (_) {},
              placeholder: const SizedBox(
                key: _triggerKey,
                width: 120,
                height: 20,
              ),
              itemBuilder: (context, v) => Text(v),
              items: const <Widget>[
                SelectItem<String>(value: 'a', child: Text('a')),
              ],
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.byType(Select<String>));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        _expectSheet(tester, width, 800);
      });

      testWidgets('tooltip stays anchored at $width', (tester) async {
        await _setViewport(tester, width, 800);
        await tester.pumpWidget(
          _frame(
            Tooltip(
              waitDuration: Duration.zero,
              anchorAlignment: Alignment.bottomCenter,
              alignment: Alignment.topCenter,
              tooltip: (context) => const Text('hi'),
              child: Container(
                key: _triggerKey,
                width: 120,
                height: 36,
                color: const Color(0xFF000001),
              ),
            ),
          ),
        );
        await tester.pump();
        final TestGesture gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.byType(Tooltip)));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        _expectAnchored(tester, width, 800);
      });
    }

    testWidgets('date picker popover anchored at 1024, sheet at 390', (
      tester,
    ) async {
      await _setViewport(tester, 1024, 800);
      await tester.pumpWidget(
        _frame(
          DatePicker(value: null, onChanged: (_) {}, mode: PromptMode.popover),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(DatePicker));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      // Date popover uses ObjectFormPromptPopup (not MenuPopup): just check
      // it is on-screen and near the trigger.
      expect(find.byType(DatePickerDialog), findsOneWidget);
      await tester.tapAt(const Offset(750, 750));
      await tester.pumpAndSettle();

      await _setViewport(tester, 390, 800);
      await tester.pumpWidget(
        _frame(
          DatePicker(value: null, onChanged: (_) {}, mode: PromptMode.popover),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(DatePicker));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(DatePickerDialog), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('dashcn.popup.sheet.handle')),
        findsOneWidget,
      );
    });

    testWidgets('time picker popover anchored at 1024, sheet at 390', (
      tester,
    ) async {
      await _setViewport(tester, 1024, 800);
      await tester.pumpWidget(
        _frame(
          TimePicker(value: null, onChanged: (_) {}, mode: PromptMode.popover),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(TimePicker));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(TimePickerDialog), findsOneWidget);
      await tester.tapAt(const Offset(750, 750));
      await tester.pumpAndSettle();

      await _setViewport(tester, 390, 800);
      await tester.pumpWidget(
        _frame(
          TimePicker(value: null, onChanged: (_) {}, mode: PromptMode.popover),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(TimePicker));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(TimePickerDialog), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('dashcn.popup.sheet.handle')),
        findsOneWidget,
      );
    });

    testWidgets('autocomplete anchored at 1024', (tester) async {
      await _setViewport(tester, 1024, 800);
      await tester.pumpWidget(
        _frame(
          Input(
            features: <InputFeature>[
              AutoCompleteFeature(
                suggestions: (q) => <String>['apple', 'apricot'],
              ),
            ],
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(Input));
      await tester.pump();
      await tester.enterText(find.byType(Input), 'ap');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(MenuPopupSurface), findsOneWidget);
    });

    testWidgets('autocomplete sheet at 390', (tester) async {
      await _setViewport(tester, 390, 800);
      await tester.pumpWidget(
        _frame(
          Input(
            features: <InputFeature>[
              AutoCompleteFeature(
                suggestions: (q) => <String>['apple', 'apricot'],
              ),
            ],
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.byType(Input));
      await tester.pump();
      await tester.enterText(find.byType(Input), 'ap');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      _expectSheet(tester, 390, 800);
    });

    testWidgets('overflow-free at 320px', (tester) async {
      await _setViewport(tester, 320, 800);
      await tester.pumpWidget(
        _frame(
          Select<String>(
            value: null,
            onChanged: (_) {},
            placeholder: const Text('Pick'),
            itemBuilder: (context, v) => Text(v),
            items: const <Widget>[
              SelectItem<String>(
                value: 'averylongoptionthatwouldoverflow',
                child: Text('averylongoptionthatwouldoverflow'),
              ),
            ],
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      await tester.tap(find.byType(Select<String>));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);
      _expectSheet(tester, 320, 800);
    });

    testWidgets('overflow-free at 320px for all popups', (tester) async {
      Future<void> pumpClosed(Widget child) async {
        await _setViewport(tester, 320, 800);
        await tester.pumpWidget(_frame(child));
        await tester.pump();
        expect(tester.takeException(), isNull);
      }

      await pumpClosed(
        Select<String>(
          value: null,
          onChanged: (_) {},
          placeholder: const Text('Pick'),
          itemBuilder: (context, v) => Text(v),
          items: const <Widget>[
            SelectItem<String>(value: 'a', child: Text('a')),
          ],
        ),
      );
      await pumpClosed(
        DatePicker(value: null, onChanged: (_) {}, mode: PromptMode.popover),
      );
      await pumpClosed(
        TimePicker(value: null, onChanged: (_) {}, mode: PromptMode.popover),
      );
      await pumpClosed(
        const ContextMenu(
          items: <Widget>[MenuButton(child: Text('One'))],
          child: SizedBox(width: 120, height: 36),
        ),
      );
    });
  });
}
