// Named examples for the `table` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the default table is live — `onRowTap` selects a row and the picked
// row is reported under the grid, so the demo shows what a table selection
// looks like instead of a hard-coded one.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'table.dart';

/// The data rows, in display order; the header sits above them in [rows].
const List<(String, String, String)> _people = <(String, String, String)>[
  ('Avery', 'Designer', 'Active'),
  ('Jordan', 'Engineer', 'Active'),
  ('Casey', 'PM', 'Away'),
  ('Riley', 'Writer', 'Offline'),
];

/// Rows before the first data row (the header).
const int _tableHeaderRows = 1;

/// A data grid with a header, a live row selection and a footer.
class _TableDefault extends StatefulWidget {
  const _TableDefault();

  @override
  State<_TableDefault> createState() => _TableDefaultState();
}

class _TableDefaultState extends State<_TableDefault> {
  int? _selected;

  TableViewRow _row((String, String, String) person, bool selected) {
    final (String name, String role, String status) = person;
    return TableViewRow(
      selected: selected,
      cells: <TableViewCell>[
        TableViewCell(child: Text(name)),
        TableViewCell(child: Text(role)),
        TableViewCell(child: Text(status)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: TableView(
            columnWidths: const <int, TableSize>{
              0: FlexTableSize(flex: 2),
              1: FlexTableSize(),
              2: FixedTableSize(90),
            },
            onRowTap: (int index) =>
                setState(() => _selected = index - _tableHeaderRows),
            rows: <TableViewRow>[
              const TableViewHeader(
                cells: <TableViewCell>[
                  TableViewCell(child: Text('Name')),
                  TableViewCell(child: Text('Role')),
                  TableViewCell(child: Text('Status')),
                ],
              ),
              for (int i = 0; i < _people.length; i++)
                _row(_people[i], _selected == i),
              const TableViewFooter(
                cells: <TableViewCell>[
                  TableViewCell(columnSpan: 2, child: Text('4 people')),
                  TableViewCell(child: Text('—')),
                ],
              ),
            ],
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _selected == null || _selected! < 0 || _selected! >= _people.length
              ? 'Tap a row to select it'
              : 'Selected ${_people[_selected!].$1}',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// A resizable table; owns its resize and scroll controllers. The fixed box
/// is inherent: the table scrolls internally.
class _ResizableTable extends StatefulWidget {
  const _ResizableTable();

  @override
  State<_ResizableTable> createState() => _ResizableTableState();
}

class _ResizableTableState extends State<_ResizableTable> {
  final ResizableTableController _controller = ResizableTableController(
    defaultColumnWidth: 120,
    defaultRowHeight: 40,
  );
  final ScrollController _vertical = ScrollController();
  final ScrollController _horizontal = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _vertical.dispose();
    _horizontal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 170,
      child: TableView(
        resizeController: _controller,
        verticalController: _vertical,
        horizontalController: _horizontal,
        rows: const <TableViewRow>[
          TableViewHeader(
            cells: <TableViewCell>[
              TableViewCell(child: Text('Drag a divider')),
              TableViewCell(child: Text('Column')),
              TableViewCell(child: Text('Row')),
            ],
          ),
          TableViewRow(
            cells: <TableViewCell>[
              TableViewCell(child: Text('One')),
              TableViewCell(child: Text('Two')),
              TableViewCell(child: Text('Three')),
            ],
          ),
          TableViewRow(
            cells: <TableViewCell>[
              TableViewCell(child: Text('Four')),
              TableViewCell(child: Text('Five')),
              TableViewCell(child: Text('Six')),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _default(BuildContext context) => const _TableDefault();

Widget _resizable(BuildContext context) => const _ResizableTable();

/// Named docs examples for `table`; the first entry is the default.
const List<ComponentPreview> tablePreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Resizable', _resizable),
];
