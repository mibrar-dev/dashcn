// Widget tests for the `table` component.
//
// Covers the token defaults, fixed sizing, spanning, header/footer styling,
// dark tokens (the old hard-coded white fill regression), hover highlighting,
// disabled foreground, the four theme-precedence legs, cell-theme merging and
// interactive resizing.

import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/table/table.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _green = Color(0xFF00FF00);
const Color _blue = Color(0xFF0000FF);

List<TableViewRow> _rows() {
  return <TableViewRow>[
    const TableViewHeader(
      cells: <TableViewCell>[
        TableViewCell(child: Text('Name')),
        TableViewCell(child: Text('Role')),
      ],
    ),
    const TableViewRow(
      cells: <TableViewCell>[
        TableViewCell(child: Text('Avery')),
        TableViewCell(child: Text('Designer')),
      ],
    ),
    const TableViewRow(
      cells: <TableViewCell>[
        TableViewCell(child: Text('Jordan')),
        TableViewCell(child: Text('Engineer'), enabled: false),
      ],
    ),
    const TableViewFooter(
      cells: <TableViewCell>[
        TableViewCell(child: Text('Total')),
        TableViewCell(child: Text('2')),
      ],
    ),
  ];
}

Widget _frame({
  required Widget child,
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TableTheme? scoped,
  Size size = const Size(400, 300),
}) {
  Widget body = child;
  if (scoped != null) {
    body = ComponentTheme<TableTheme>(data: scoped, child: body);
  }
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox.fromSize(size: size, child: body),
        ),
      ),
    ),
  );
}

Widget _table({
  List<TableViewRow>? rows,
  Map<int, TableSize>? columnWidths,
  ResizableTableController? resizeController,
  TableTheme? theme,
}) {
  return TableView(
    rows: rows ?? _rows(),
    columnWidths: columnWidths,
    resizeController: resizeController,
    theme: theme,
  );
}

Widget _scrolledTable({
  ResizableTableController? resizeController,
  Map<int, TableSize>? columnWidths,
  FrozenTableData? frozenCells,
}) {
  return TableView(
    rows: _rows(),
    columnWidths: columnWidths,
    resizeController: resizeController,
    frozenCells: frozenCells,
    verticalController: ScrollController(),
    horizontalController: ScrollController(),
  );
}

BoxDecoration _cellDecoration(WidgetTester tester, String text) {
  final DecoratedBox box = tester.widget<DecoratedBox>(
    find
        .ancestor(of: find.text(text), matching: find.byType(DecoratedBox))
        .first,
  );
  return box.decoration as BoxDecoration;
}

TextStyle _cellTextStyle(WidgetTester tester, String text) {
  return tester
      .widget<DefaultTextStyle>(
        find
            .ancestor(
              of: find.text(text),
              matching: find.byType(DefaultTextStyle),
            )
            .first,
      )
      .style;
}

BoxDecoration _tableDecoration(WidgetTester tester) {
  final Container container = tester.widget<Container>(
    find.descendant(
      of: find.byType(TableView),
      matching: find.byType(Container),
    ),
  );
  return container.decoration! as BoxDecoration;
}

void main() {
  testWidgets('renders headers, rows and footers', (tester) async {
    await tester.pumpWidget(_frame(child: _table()));
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Avery'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
  });

  testWidgets('uses card fill and border-token bottom border', (tester) async {
    final ThemeColors colors = ThemeColors.lightFallback;
    await tester.pumpWidget(_frame(child: _table()));
    expect(_tableDecoration(tester).color, colors.card);
    final BoxDecoration cell = _cellDecoration(tester, 'Avery');
    expect(
      cell.border,
      Border(bottom: BorderSide(color: colors.border, width: 1)),
    );
  });

  testWidgets('header cells are medium muted, footer has no border', (
    tester,
  ) async {
    final ThemeColors colors = ThemeColors.lightFallback;
    await tester.pumpWidget(_frame(child: _table()));
    expect(_cellTextStyle(tester, 'Name').fontWeight, FontWeight.w500);
    expect(_cellTextStyle(tester, 'Name').color, colors.mutedForeground);
    expect(_cellDecoration(tester, 'Total').border, isNull);
  });

  testWidgets('fixed column widths are respected', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: _table(
          columnWidths: const <int, TableSize>{
            0: FixedTableSize(120),
            1: FixedTableSize(80),
          },
        ),
      ),
    );
    final Rect first = tester.getRect(
      find
          .ancestor(of: find.text('Avery'), matching: find.byType(RawCell))
          .first,
    );
    final Rect second = tester.getRect(
      find
          .ancestor(of: find.text('Designer'), matching: find.byType(RawCell))
          .first,
    );
    expect(first.width, 120);
    expect(second.width, 80);
    expect(second.left - first.left, 120);
  });

  testWidgets('a spanning cell occupies the spanned columns', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: _table(
          rows: <TableViewRow>[
            const TableViewRow(
              cells: <TableViewCell>[
                TableViewCell(columnSpan: 2, child: Text('Wide')),
              ],
            ),
            const TableViewRow(
              cells: <TableViewCell>[
                TableViewCell(child: Text('A')),
                TableViewCell(child: Text('B')),
              ],
            ),
          ],
          columnWidths: const <int, TableSize>{
            0: FixedTableSize(100),
            1: FixedTableSize(60),
          },
        ),
      ),
    );
    final Rect wide = tester.getRect(
      find
          .ancestor(of: find.text('Wide'), matching: find.byType(RawCell))
          .first,
    );
    expect(wide.width, 160);
  });

  testWidgets('regression: dark tables use the card token, not white', (
    tester,
  ) async {
    const ThemeColors dark = ThemeColors.darkFallback;
    await tester.pumpWidget(
      _frame(
        data: const ThemeData(colors: dark),
        child: _table(),
      ),
    );
    expect(_tableDecoration(tester).color, dark.card);
    expect(_cellDecoration(tester, 'Avery').color, isNull);
  });

  testWidgets('hovering a cell highlights its row', (tester) async {
    final ThemeColors colors = ThemeColors.lightFallback;
    await tester.pumpWidget(_frame(child: _table()));
    final TestGesture gesture = await tester.createGesture(
      kind: PointerDeviceKind.mouse,
    );
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();
    await gesture.moveTo(tester.getCenter(find.text('Avery')));
    await tester.pumpAndSettle();
    expect(
      _cellDecoration(tester, 'Designer').color,
      colors.muted.withValues(alpha: 0.5),
    );
  });

  testWidgets('a disabled cell uses the muted foreground', (tester) async {
    final ThemeColors colors = ThemeColors.lightFallback;
    await tester.pumpWidget(_frame(child: _table()));
    expect(_cellTextStyle(tester, 'Engineer').color, colors.mutedForeground);
  });

  group('theme precedence', () {
    testWidgets('app leg overrides the defaults', (tester) async {
      await tester.pumpWidget(
        _frame(
          app: const <ComponentThemeData>[
            TableTheme(background: ThemedColor.value(_green)),
          ],
          child: _table(),
        ),
      );
      expect(_tableDecoration(tester).color, _green);
    });

    testWidgets('scoped leg overrides the app leg', (tester) async {
      await tester.pumpWidget(
        _frame(
          app: const <ComponentThemeData>[
            TableTheme(background: ThemedColor.value(_green)),
          ],
          scoped: const TableTheme(background: ThemedColor.value(_blue)),
          child: _table(),
        ),
      );
      expect(_tableDecoration(tester).color, _blue);
    });

    testWidgets('widget leg overrides the scoped leg', (tester) async {
      await tester.pumpWidget(
        _frame(
          scoped: const TableTheme(background: ThemedColor.value(_green)),
          child: _table(
            theme: const TableTheme(background: ThemedColor.value(_blue)),
          ),
        ),
      );
      expect(_tableDecoration(tester).color, _blue);
    });

    testWidgets('a leg setting only padding keeps the token fill', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          scoped: const TableTheme(padding: EdgeInsets.all(4)),
          child: _table(),
        ),
      );
      expect(_tableDecoration(tester).color, ThemeColors.lightFallback.card);
    });
  });

  testWidgets('table-level cell theme merges under the header style', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: _table(
          theme: const TableTheme(
            cellTheme: TableCellTheme(
              background: StateValue<ThemedColor>(
                rest: ThemedColor.value(_green),
              ),
            ),
          ),
        ),
      ),
    );
    expect(_cellDecoration(tester, 'Avery').color, _green);
    // The header's medium weight survives the table-level cell theme.
    expect(_cellTextStyle(tester, 'Name').fontWeight, FontWeight.w500);
    expect(_cellDecoration(tester, 'Name').color, _green);
  });

  testWidgets('a resize controller adds handles and a drag resizes', (
    tester,
  ) async {
    final ResizableTableController controller = ResizableTableController(
      defaultColumnWidth: 120,
      defaultRowHeight: 40,
    );
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(child: _table(resizeController: controller)),
    );
    final Finder handles = find.byWidgetPredicate(
      (Widget widget) =>
          widget is MouseRegion &&
          widget.cursor == SystemMouseCursors.resizeColumn,
    );
    expect(handles, findsWidgets);
    final double before = controller.getColumnWidth(0);
    await tester.dragFrom(tester.getCenter(handles.first), const Offset(30, 0));
    await tester.pumpAndSettle();
    expect(controller.getColumnWidth(0), greaterThan(before));
  });

  testWidgets('resize handles expose localized semantics labels', (
    tester,
  ) async {
    final SemanticsHandle semantics = tester.ensureSemantics();
    final ResizableTableController controller = ResizableTableController(
      defaultColumnWidth: 120,
      defaultRowHeight: 40,
    );
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(child: _table(resizeController: controller)),
    );
    expect(find.bySemanticsLabel('Resize column'), findsWidgets);
    expect(find.bySemanticsLabel('Resize row'), findsWidgets);
    semantics.dispose();
  });

  group('keyboard resizing', () {
    Future<Focus> focusColumnHandle(
      WidgetTester tester,
      ResizableTableController controller,
    ) async {
      await tester.pumpWidget(
        _frame(child: _table(resizeController: controller)),
      );
      final Focus handle = tester.widget<Focus>(
        find
            .descendant(
              of: find.bySemanticsLabel('Resize column'),
              matching: find.byType(Focus),
            )
            .first,
      );
      final FocusNode? node = handle.focusNode;
      expect(node, isNotNull, reason: 'the divider owns a focus node');
      node!.requestFocus();
      await tester.pump();
      return handle;
    }

    testWidgets('arrow keys step the divider in both directions', (
      tester,
    ) async {
      final SemanticsHandle semantics = tester.ensureSemantics();
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 120,
        defaultRowHeight: 40,
      );
      addTearDown(controller.dispose);
      await focusColumnHandle(tester, controller);
      expect(controller.getColumnWidth(0), 120);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      // The default width mode reallocates: column 0 grows, column 1 shrinks.
      expect(controller.getColumnWidth(0), 130);
      expect(controller.getColumnWidth(1), 110);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      expect(controller.getColumnWidth(0), 120);
      expect(controller.getColumnWidth(1), 120);
      semantics.dispose();
    });

    testWidgets('arrow keys step a single row divider', (tester) async {
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 120,
        defaultRowHeight: 40,
      );
      addTearDown(controller.dispose);
      final SemanticsHandle semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        _frame(child: _table(resizeController: controller)),
      );
      final Focus handle = tester.widget<Focus>(
        find
            .descendant(
              of: find.bySemanticsLabel('Resize row'),
              matching: find.byType(Focus),
            )
            .first,
      );
      final FocusNode? node = handle.focusNode;
      expect(node, isNotNull, reason: 'the divider owns a focus node');
      node!.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      expect(controller.getRowHeight(0), 50);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pump();
      expect(controller.getRowHeight(0), 40);
      semantics.dispose();
    });

    testWidgets('Home and End jump to the min and max bounds', (tester) async {
      final SemanticsHandle semantics = tester.ensureSemantics();
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
        widthConstraints: const <int, ConstrainedTableSize>{
          0: ConstrainedTableSize(min: 50, max: 150),
        },
      );
      addTearDown(controller.dispose);
      await focusColumnHandle(tester, controller);
      await tester.sendKeyEvent(LogicalKeyboardKey.end);
      await tester.pump();
      expect(controller.getColumnWidth(0), 150);
      await tester.sendKeyEvent(LogicalKeyboardKey.home);
      await tester.pump();
      expect(controller.getColumnWidth(0), 50);
      semantics.dispose();
    });
  });

  testWidgets('header is h-9 px-2 and body cells are p-2', (tester) async {
    await tester.pumpWidget(_frame(child: _table()));
    final Rect header = tester.getRect(
      find
          .ancestor(of: find.text('Name'), matching: find.byType(RawCell))
          .first,
    );
    expect(header.height, greaterThanOrEqualTo(36));
    final Padding headPadding = tester.widget<Padding>(
      find
          .ancestor(of: find.text('Name'), matching: find.byType(Padding))
          .first,
    );
    expect(headPadding.padding, const EdgeInsets.symmetric(horizontal: 8));
    final Padding bodyPadding = tester.widget<Padding>(
      find
          .ancestor(of: find.text('Avery'), matching: find.byType(Padding))
          .first,
    );
    expect(bodyPadding.padding, const EdgeInsets.all(8));
  });

  testWidgets('cells hug the leading edge and centre vertically', (
    tester,
  ) async {
    await tester.pumpWidget(_frame(child: _table()));
    // upstream `text-left align-middle`: one Align per cell, leading + middle.
    for (final String text in <String>['Name', 'Avery']) {
      final Align align = tester.widget<Align>(
        find.ancestor(of: find.text(text), matching: find.byType(Align)).first,
      );
      expect(align.alignment, AlignmentDirectional.centerStart);
    }
  });

  testWidgets('a selected row uses the muted fill', (tester) async {
    final ThemeColors colors = ThemeColors.lightFallback;
    await tester.pumpWidget(
      _frame(
        child: _table(
          rows: <TableViewRow>[
            const TableViewHeader(
              cells: <TableViewCell>[
                TableViewCell(child: Text('Name')),
                TableViewCell(child: Text('Role')),
              ],
            ),
            const TableViewRow(
              selected: true,
              cells: <TableViewCell>[
                TableViewCell(child: Text('Avery')),
                TableViewCell(child: Text('Designer')),
              ],
            ),
          ],
        ),
      ),
    );
    expect(_cellDecoration(tester, 'Avery').color, colors.muted);
  });

  group('ResizableTableController', () {
    test('resizeColumn clamps to the constraints', () {
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
        widthConstraints: const <int, ConstrainedTableSize>{
          0: ConstrainedTableSize(min: 50, max: 150),
        },
      );
      addTearDown(controller.dispose);
      expect(controller.resizeColumn(0, 500), isTrue);
      expect(controller.getColumnWidth(0), 150);
      expect(controller.resizeColumn(0, 10), isTrue);
      expect(controller.getColumnWidth(0), 50);
    });

    test('resizeColumnBorder moves width between neighbours', () {
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
      );
      addTearDown(controller.dispose);
      final double moved = controller.resizeColumnBorder(0, 1, 30);
      expect(moved, 30);
      expect(controller.getColumnWidth(0), 130);
      expect(controller.getColumnWidth(1), 70);
    });
  });

  // Regression (P4-T4): the table's sizing budget used to go negative when the
  // resized columns already overflowed the viewport, which surfaced as
  // "the height argument to getMaxIntrinsicWidth was negative" from the
  // intrinsic pass and as a negative `BoxConstraints` minimum for the cells.
  group('resized columns in a cramped viewport', () {
    testWidgets('resized columns wider than the viewport', (tester) async {
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
      );
      addTearDown(controller.dispose);
      controller.resizeColumn(0, 400);
      await tester.pumpWidget(
        _frame(
          size: const Size(200, 200),
          child: _scrolledTable(resizeController: controller),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('resized columns in a zero-width viewport', (tester) async {
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
      );
      addTearDown(controller.dispose);
      controller.resizeColumn(0, 400);
      await tester.pumpWidget(
        _frame(
          size: const Size(0, 0),
          child: _scrolledTable(resizeController: controller),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('resized columns with frozen cells under a narrow viewport', (
      tester,
    ) async {
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
      );
      addTearDown(controller.dispose);
      controller.resizeColumn(0, 400);
      await tester.pumpWidget(
        _frame(
          size: const Size(150, 150),
          child: _scrolledTable(
            resizeController: controller,
            frozenCells: const FrozenTableData(
              frozenRows: <TableRef>[TableRef(0)],
              frozenColumns: <TableRef>[TableRef(0)],
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('dragging a divider past the viewport keeps the grid valid', (
      tester,
    ) async {
      final ResizableTableController controller = ResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 40,
      );
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          size: const Size(180, 200),
          child: _scrolledTable(resizeController: controller),
        ),
      );
      // Drag the first column divider far past the 180px viewport.
      final Finder handles = find.byWidgetPredicate(
        (Widget widget) =>
            widget is MouseRegion &&
            widget.cursor == SystemMouseCursors.resizeColumn,
      );
      await tester.dragFrom(
        tester.getCenter(handles.first),
        const Offset(900, 0),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final Map<int, double> widths = controller.columnWidths!;
      expect(widths, isNotEmpty);
      for (final double width in widths.values) {
        expect(width, greaterThanOrEqualTo(0));
      }
    });
  });
}
