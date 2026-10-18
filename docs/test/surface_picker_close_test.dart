// Surface pickers close on pick and track the live value (Theme Studio rail).
//
// Regression for the sticky surface popups: picking 90% from 70% used to
// leave the popup open with the old highlight. Preset taps now commit and
// close (like the font/preset/transition popups), the highlight reads the
// live document on every rebuild, and reopening shows the current choice.

import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_storage.dart';
import 'package:docs/ui/dashcn/components/menu/menu.dart';
import 'package:docs/widgets/rail_picker_rows.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

Future<DocsRouterDelegate> _themes(WidgetTester tester) async {
  final DocsRouterDelegate delegate = await pumpDocsApp(tester);
  await goTo(tester, delegate, '/themes');
  return delegate;
}

Future<void> _openRow(WidgetTester tester, String key) async {
  await tester.ensureVisible(find.byKey(ValueKey<String>(key)));
  await tester.pump();
  await tester.tap(find.byKey(ValueKey<String>(key)));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  expect(find.byType(MenuPopup), findsOneWidget, reason: key);
}

Finder _inPopup(Finder finder) =>
    find.descendant(of: find.byType(MenuPopup), matching: finder);

bool _popupRowSelected(WidgetTester tester, String label) {
  final Iterable<RailPickerRow> rows = tester.widgetList<RailPickerRow>(
    _inPopup(find.byType(RailPickerRow)),
  );
  for (final RailPickerRow row in rows) {
    if (row.label == label) {
      return row.selected;
    }
  }
  fail('popup row "$label" not found');
}

void main() {
  group('surface opacity picker', () {
    testWidgets('pick closes, commits, and reopen shows the live choice', (
      tester,
    ) async {
      await _themes(tester);
      docsState.themeModel.setSurfaceOpacity(0.7);
      await tester.pump();

      await _openRow(tester, 'rail-row-surface-opacity');
      expect(_popupRowSelected(tester, '70%'), isTrue);
      expect(_popupRowSelected(tester, '90%'), isFalse);

      await tester.tap(_inPopup(find.text('90%')).last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      expect(docsState.themeModel.document.surfaceOpacity, 0.9);

      await _openRow(tester, 'rail-row-surface-opacity');
      expect(_popupRowSelected(tester, '90%'), isTrue);
      expect(_popupRowSelected(tester, '70%'), isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('highlight follows an external change while open', (
      tester,
    ) async {
      await _themes(tester);
      docsState.themeModel.setSurfaceOpacity(0.7);
      await tester.pump();

      await _openRow(tester, 'rail-row-surface-opacity');
      expect(_popupRowSelected(tester, '70%'), isTrue);

      docsState.themeModel.setSurfaceOpacity(0.9);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(_popupRowSelected(tester, '90%'), isTrue);
      expect(_popupRowSelected(tester, '70%'), isFalse);
      expect(tester.takeException(), isNull);
    });
  });

  group('surface blur picker', () {
    testWidgets('pick closes, commits, and reopen shows the live choice', (
      tester,
    ) async {
      await _themes(tester);
      docsState.themeModel.setSurfaceBlur(4);
      await tester.pump();

      await _openRow(tester, 'rail-row-surface-blur');
      expect(_popupRowSelected(tester, 'Subtle'), isTrue);
      expect(_popupRowSelected(tester, 'Frosted'), isFalse);

      await tester.tap(_inPopup(find.text('Frosted')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      expect(docsState.themeModel.document.surfaceBlur, 8);

      await _openRow(tester, 'rail-row-surface-blur');
      expect(_popupRowSelected(tester, 'Frosted'), isTrue);
      expect(_popupRowSelected(tester, 'Subtle'), isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('highlight follows an external change while open', (
      tester,
    ) async {
      await _themes(tester);
      docsState.themeModel.setSurfaceBlur(4);
      await tester.pump();

      await _openRow(tester, 'rail-row-surface-blur');
      expect(_popupRowSelected(tester, 'Subtle'), isTrue);

      docsState.themeModel.setSurfaceBlur(8);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(_popupRowSelected(tester, 'Frosted'), isTrue);
      expect(_popupRowSelected(tester, 'Subtle'), isFalse);
      expect(tester.takeException(), isNull);
    });
  });

  group('other preset-only popup (transition)', () {
    testWidgets('pick closes, commits, and reopen shows the live choice', (
      tester,
    ) async {
      await _themes(tester);
      docsState.themeModel.setTransition(DocsThemeTransition.fade);
      await tester.pump();

      await _openRow(tester, 'rail-row-transition');
      expect(_popupRowSelected(tester, 'Fade'), isTrue);

      await tester.tap(_inPopup(find.text('Wipe')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      expect(docsState.themeModel.transition, DocsThemeTransition.wipe);

      await _openRow(tester, 'rail-row-transition');
      expect(_popupRowSelected(tester, 'Wipe'), isTrue);
      expect(_popupRowSelected(tester, 'Fade'), isFalse);
      expect(tester.takeException(), isNull);
    });
  });
}
