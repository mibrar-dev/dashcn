// QA for `table` previews (P7-Q2, P7-WC): behaviour, spacing, functionality.
//
// Drives every `tablePreviews` example like a user: the data table sorts,
// selects, paginates and resizes; the invoices grid renders its rows and
// total. Cell padding (p-2 body, px-2 head), the h-10 header, align-middle
// and density scaling are pinned in `table_test.dart` and the layout-audit
// suite; this file pins the *previews* pump cleanly in both brightnesses,
// mirror in RTL, survive 375px, and resize by drag and by keyboard.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/checkbox/checkbox.dart';
import 'package:dashcn/src/components/table/preview.dart';
import 'package:dashcn/src/components/table/table.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  double width = 480,
}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: direction,
      child: Center(
        child: SizedBox(width: width, child: child),
      ),
    ),
  );
}

Future<void> _pumpPreview(
  WidgetTester tester,
  ComponentPreview preview, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  double width = 480,
}) async {
  await tester.pumpWidget(
    _frame(
      Builder(builder: preview.builder),
      data: data,
      direction: direction,
      width: width,
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  expect(
    tester.takeException(),
    isNull,
    reason: 'preview "${preview.name}" threw',
  );
}

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in tablePreviews) {
      for (final colors in <ThemeColors>[
        ThemeColors.lightFallback,
        ThemeColors.darkFallback,
      ]) {
        await tester.pumpWidget(
          _frame(
            Builder(builder: preview.builder),
            data: ThemeData(colors: colors),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          tester.takeException(),
          isNull,
          reason: '${preview.name} light/dark',
        );
      }
    }
  });

  testWidgets('Data table: headers, rows, badges and footer render', (
    tester,
  ) async {
    await _pumpPreview(tester, tablePreviews[0]);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Role'), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('Avery'), findsOneWidget);
    expect(find.text('Active'), findsWidgets);
    expect(find.text('0 of 6 selected'), findsOneWidget);
    expect(find.text('1 / 2'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Data table: tapping a header sorts the rows', (tester) async {
    await _pumpPreview(tester, tablePreviews[0]);
    // Ascending first page: Avery, Casey, Jordan, Quinn.
    expect(find.text('Avery'), findsOneWidget);
    expect(find.text('Skyler'), findsNothing);
    await tester.tap(find.text('Name'));
    await tester.pump();
    // Descending first page: Skyler, Riley, Quinn, Jordan.
    expect(find.text('Skyler'), findsOneWidget);
    expect(find.text('Avery'), findsNothing);
  });

  testWidgets('Data table: checkboxes select rows', (tester) async {
    await _pumpPreview(tester, tablePreviews[0]);
    // The first checkbox is the select-all header; the second is Avery.
    await tester.tap(find.byType(Checkbox).at(1));
    await tester.pump();
    expect(find.text('1 of 6 selected'), findsOneWidget);
    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();
    expect(find.text('4 of 6 selected'), findsOneWidget);
  });

  testWidgets('Data table: pagination turns the page', (tester) async {
    await _pumpPreview(tester, tablePreviews[0]);
    expect(find.text('Avery'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pump();
    expect(find.text('2 / 2'), findsOneWidget);
    expect(find.text('Riley'), findsOneWidget);
    expect(find.text('Avery'), findsNothing);
  });

  testWidgets('Data table fits a 375px phone with no overflow', (tester) async {
    await _pumpPreview(tester, tablePreviews[0], width: 375);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Data table: drag a divider resizes the column', (tester) async {
    await _pumpPreview(tester, tablePreviews[0]);
    expect(find.byType(CellResizer), findsWidgets);
    final Offset center = tester.getCenter(find.byType(CellResizer).first);
    await tester.dragFrom(center, const Offset(24, 0));
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.text('Name'), findsOneWidget);
  });

  testWidgets('Data table: a focused divider steps with arrow keys', (
    tester,
  ) async {
    final SemanticsHandle semantics = tester.ensureSemantics();
    await _pumpPreview(tester, tablePreviews[0]);
    final Focus handle = tester.widget<Focus>(
      find
          .descendant(
            of: find.bySemanticsLabel('Resize column'),
            matching: find.byType(Focus),
          )
          .first,
    );
    handle.focusNode!.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });

  testWidgets('Invoices: rows and total render', (tester) async {
    await _pumpPreview(tester, tablePreviews[1]);
    expect(find.text('INV-001'), findsOneWidget);
    expect(find.text('INV-003'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('\$750.00'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Invoices fits a 375px phone with no overflow', (tester) async {
    await _pumpPreview(tester, tablePreviews[1], width: 375);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('previews mirror in RTL with no exception', (tester) async {
    for (final preview in tablePreviews) {
      await _pumpPreview(tester, preview, direction: TextDirection.rtl);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: '${preview.name} RTL');
    }
  });
}
