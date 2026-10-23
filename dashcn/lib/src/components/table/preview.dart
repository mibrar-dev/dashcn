// Named examples for the `table` component (P6-F3 preview contract).
//
// The default is a live data table: sortable headers, row-selection
// checkboxes, status badges, pagination and resizable columns with min/max
// bounds. `Invoices` is the small static grid. Spacing comes from the ambient
// theme, so the examples follow the selected preset and the site light/dark
// toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/clickable.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../badge/badge.dart';
import '../button/button.dart';
import '../checkbox/checkbox.dart';
import 'table.dart';

/// One member row of the data-table example.
class _Member {
  const _Member(this.name, this.role, this.status);

  final String name;
  final String role;
  final String status;
}

/// Six rows so pagination has two pages of four.
List<_Member> _members = <_Member>[
  _Member(
    docsSample(null, 'Avery'),
    docsSample(null, 'Designer'),
    docsSample(null, 'Active'),
  ),
  _Member(
    docsSample(null, 'Jordan'),
    docsSample(null, 'Engineer'),
    docsSample(null, 'Active'),
  ),
  _Member(
    docsSample(null, 'Casey'),
    docsSample(null, 'Manager'),
    docsSample(null, 'Away'),
  ),
  _Member(
    docsSample(null, 'Riley'),
    docsSample(null, 'Writer'),
    docsSample(null, 'Offline'),
  ),
  _Member(
    docsSample(null, 'Quinn'),
    docsSample(null, 'Engineer'),
    docsSample(null, 'Active'),
  ),
  _Member(
    docsSample(null, 'Skyler'),
    docsSample(null, 'Designer'),
    docsSample(null, 'Away'),
  ),
];

/// Badge variant for a member status.
BadgeVariant _statusVariant(String status) {
  switch (status) {
    case 'Active':
      return BadgeVariant.primary;
    case 'Away':
      return BadgeVariant.secondary;
    default:
      return BadgeVariant.outline;
  }
}

/// A sortable column header: label plus direction arrow.
class _SortHeader extends StatelessWidget {
  const _SortHeader({
    required this.label,
    required this.sorted,
    required this.ascending,
    required this.onTap,
  });

  final String label;
  final bool sorted;
  final bool ascending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return Clickable(
      behavior: HitTestBehavior.opaque,
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(docsSample(context, label)),
          const Gap(4),
          Icon(
            sorted
                ? (ascending ? LucideIcons.arrowUp : LucideIcons.arrowDown)
                : LucideIcons.chevronsUpDown,
            size: 12,
            color: colors.mutedForeground,
          ),
        ],
      ),
    );
  }
}

/// A live data table: sorting, selection, badges, pagination and column
/// resizing with min/max bounds.
class _DataTable extends StatefulWidget {
  const _DataTable();

  @override
  State<_DataTable> createState() => _DataTableState();
}

class _DataTableState extends State<_DataTable> {
  static const int _pageSize = 4;
  static const int _nameColumn = 1;
  static const int _roleColumn = 2;

  final ResizableTableController _resize = ResizableTableController(
    defaultColumnWidth: 120,
    // Compact density row height (32-40 band; header uses 36): the grid
    // scrolls inside its frame via the controllers below, and every header
    // divider drags to resize its column while row dividers resize rows.
    defaultRowHeight: 36,
    columnWidths: <int, double>{0: 40},
    widthConstraints: <int, ConstrainedTableSize>{
      0: ConstrainedTableSize(min: 32, max: 64),
      1: ConstrainedTableSize(min: 80, max: 220),
      2: ConstrainedTableSize(min: 80, max: 220),
      3: ConstrainedTableSize(min: 80, max: 200),
    },
  );
  final ScrollController _horizontal = ScrollController();
  final ScrollController _vertical = ScrollController();

  int _sortColumn = _nameColumn;
  bool _ascending = true;
  int _page = 0;
  final Set<String> _selected = <String>{};

  @override
  void dispose() {
    _resize.dispose();
    _horizontal.dispose();
    _vertical.dispose();
    super.dispose();
  }

  List<_Member> get _sorted {
    final List<_Member> rows = List<_Member>.of(_members);
    int compare(_Member a, _Member b) => _sortColumn == _roleColumn
        ? a.role.compareTo(b.role)
        : a.name.compareTo(b.name);
    rows.sort(
      (_Member a, _Member b) => _ascending ? compare(a, b) : compare(b, a),
    );
    return rows;
  }

  void _sort(int column) {
    setState(() {
      if (_sortColumn == column) {
        _ascending = !_ascending;
      } else {
        _sortColumn = column;
        _ascending = true;
      }
      _page = 0;
    });
  }

  void _toggle(String name) {
    setState(() {
      if (!_selected.remove(name)) {
        _selected.add(name);
      }
    });
  }

  void _togglePage(List<_Member> visible) {
    final Iterable<String> names = visible.map((_Member m) => m.name);
    setState(() {
      if (names.every(_selected.contains)) {
        _selected.removeAll(names);
      } else {
        _selected.addAll(names);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<_Member> sorted = _sorted;
    final int totalPages = (sorted.length + _pageSize - 1) ~/ _pageSize;
    final int page = _page.clamp(0, totalPages - 1);
    final List<_Member> visible = sorted.sublist(
      page * _pageSize,
      ((page + 1) * _pageSize).clamp(0, sorted.length),
    );
    final bool allChecked =
        visible.isNotEmpty &&
        visible.map((_Member m) => m.name).every(_selected.contains);
    final bool someChecked =
        !allChecked &&
        visible.map((_Member m) => m.name).any(_selected.contains);
    return Center(
      // Fixed widths sum to 400 (40 + 3 x 120), so the box hugs the grid
      // exactly and the stage centres it; narrower viewports scroll.
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Fixed rows (header + page) fill this box exactly: every row is
            // the controller's 36 px compact height, so narrower viewports
            // scroll instead of overflowing and the stage centres the box.
            // Drag any header divider to resize that column; drag a row
            // divider to resize the row.
            SizedBox(
              height: (_pageSize + 1) * 36,
              child: TableView(
                resizeController: _resize,
                horizontalController: _horizontal,
                verticalController: _vertical,
                rows: <TableViewRow>[
                  TableViewHeader(
                    cells: <TableViewCell>[
                      TableViewCell(
                        child: Checkbox(
                          tristate: true,
                          // Labels the tappable node for assistive tech.
                          semanticLabel: docsSample(context, 'Select all rows'),
                          value: allChecked
                              ? CheckboxValue.checked
                              : (someChecked
                                    ? CheckboxValue.indeterminate
                                    : CheckboxValue.unchecked),
                          onChanged: (_) => _togglePage(visible),
                        ),
                      ),
                      TableViewCell(
                        child: _SortHeader(
                          label: docsSample(context, 'Name'),
                          sorted: _sortColumn == _nameColumn,
                          ascending: _ascending,
                          onTap: () => _sort(_nameColumn),
                        ),
                      ),
                      TableViewCell(
                        child: _SortHeader(
                          label: docsSample(context, 'Role'),
                          sorted: _sortColumn == _roleColumn,
                          ascending: _ascending,
                          onTap: () => _sort(_roleColumn),
                        ),
                      ),
                      TableViewCell(child: Text(docsSample(context, 'Status'))),
                    ],
                  ),
                  for (final _Member member in visible)
                    TableViewRow(
                      selected: _selected.contains(member.name),
                      cells: <TableViewCell>[
                        TableViewCell(
                          child: Checkbox(
                            // Labels the tappable node for assistive tech.
                            semanticLabel: docsSample(context, 'Select row'),
                            value: _selected.contains(member.name)
                                ? CheckboxValue.checked
                                : CheckboxValue.unchecked,
                            onChanged: (_) => _toggle(member.name),
                          ),
                        ),
                        TableViewCell(child: Text(member.name)),
                        TableViewCell(
                          child: Text(docsSample(context, member.role)),
                        ),
                        TableViewCell(
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Badge(
                              variant: _statusVariant(member.status),
                              child: Text(docsSample(context, member.status)),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // Narrow frames cut the last column: say the grid scrolls sideways.
            if (MediaQuery.widthOf(context) < 600) ...<Widget>[
              Gap(theme.spacing.sm),
              Text(
                'Scroll sideways for more columns',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
            Gap(theme.spacing.md),
            Builder(
              builder: (context) {
                // Narrow touch viewports hide the selection count and use
                // icon-only pagination so the touch-sized controls fit.
                final bool narrow = MediaQuery.widthOf(context) < 600;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (!narrow)
                      Flexible(
                        child: Text(
                          '${_selected.length} of ${_members.length} selected',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colors.mutedForeground,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Button(
                          variant: ButtonVariant.outline,
                          size: narrow ? ButtonSize.icon : ButtonSize.sm,
                          onPressed: page > 0
                              ? () => setState(() => _page = page - 1)
                              : null,
                          leading: narrow
                              ? null
                              : const Icon(LucideIcons.chevronLeft, size: 14),
                          child: narrow
                              ? const Icon(LucideIcons.chevronLeft, size: 14)
                              : Text(docsSample(context, 'Prev')),
                        ),
                        Gap(theme.spacing.sm),
                        Text(
                          '${page + 1} / $totalPages',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colors.mutedForeground,
                          ),
                        ),
                        Gap(theme.spacing.sm),
                        Button(
                          variant: ButtonVariant.outline,
                          size: narrow ? ButtonSize.icon : ButtonSize.sm,
                          onPressed: page + 1 < totalPages
                              ? () => setState(() => _page = page + 1)
                              : null,
                          trailing: narrow
                              ? null
                              : const Icon(LucideIcons.chevronRight, size: 14),
                          child: narrow
                              ? const Icon(LucideIcons.chevronRight, size: 14)
                              : Text(docsSample(context, 'Next')),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// A small static invoice grid with a total footer.
///
/// Scrolls inside its frame and supports column/row resize via header and
/// row divider drags, like the data table above.
class _InvoicesTable extends StatefulWidget {
  const _InvoicesTable();

  @override
  State<_InvoicesTable> createState() => _InvoicesTableState();
}

class _InvoicesTableState extends State<_InvoicesTable> {
  final ResizableTableController _resize = ResizableTableController(
    defaultColumnWidth: 90,
    defaultRowHeight: 36,
  );
  final ScrollController _horizontal = ScrollController();
  final ScrollController _vertical = ScrollController();

  @override
  void dispose() {
    _resize.dispose();
    _horizontal.dispose();
    _vertical.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SizedBox(
          // Header + 4 body rows + footer at the 36 px compact row height.
          height: 6 * 36,
          child: TableView(
            resizeController: _resize,
            horizontalController: _horizontal,
            verticalController: _vertical,
            columnWidths: <int, TableSize>{
              1: FixedTableSize(80),
              2: FixedTableSize(80),
              3: FixedTableSize(90),
            },
            rows: <TableViewRow>[
              TableViewHeader(
                cells: <TableViewCell>[
                  TableViewCell(child: Text(docsSample(context, 'Invoice'))),
                  TableViewCell(child: Text(docsSample(context, 'Status'))),
                  TableViewCell(child: Text(docsSample(context, 'Method'))),
                  TableViewCell(child: Text(docsSample(context, 'Amount'))),
                ],
              ),
              TableViewRow(
                cells: <TableViewCell>[
                  TableViewCell(child: Text('INV-001')),
                  TableViewCell(child: Text(docsSample(context, 'Paid'))),
                  TableViewCell(child: Text('Card')),
                  TableViewCell(child: Text('\$250.00')),
                ],
              ),
              TableViewRow(
                cells: <TableViewCell>[
                  TableViewCell(child: Text('INV-002')),
                  TableViewCell(child: Text(docsSample(context, 'Pending'))),
                  TableViewCell(child: Text('PayPal')),
                  TableViewCell(child: Text('\$150.00')),
                ],
              ),
              TableViewRow(
                cells: <TableViewCell>[
                  TableViewCell(child: Text('INV-003')),
                  TableViewCell(child: Text(docsSample(context, 'Overdue'))),
                  TableViewCell(child: Text(docsSample(context, 'Transfer'))),
                  TableViewCell(child: Text('\$350.00')),
                ],
              ),
              TableViewFooter(
                cells: <TableViewCell>[
                  TableViewCell(
                    columnSpan: 3,
                    child: Text(docsSample(context, 'Total')),
                  ),
                  TableViewCell(child: Text('\$750.00')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Named docs examples for `table`; the first entry is the default.
List<ComponentPreview> get tablePreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Data table'), _dataTable),
  ComponentPreview(docsSample(null, 'Invoices'), _invoices),
];

Widget _dataTable(BuildContext context) => const _DataTable();

Widget _invoices(BuildContext context) => const _InvoicesTable();
