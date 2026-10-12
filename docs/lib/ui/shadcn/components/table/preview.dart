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
const List<_Member> _members = <_Member>[
  _Member('Avery', 'Designer', 'Active'),
  _Member('Jordan', 'Engineer', 'Active'),
  _Member('Casey', 'Manager', 'Away'),
  _Member('Riley', 'Writer', 'Offline'),
  _Member('Quinn', 'Engineer', 'Active'),
  _Member('Skyler', 'Designer', 'Away'),
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
    final ShadcnColors colors = ShadcnTheme.of(context).colors;
    return Clickable(
      behavior: HitTestBehavior.opaque,
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label),
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
    defaultRowHeight: 44,
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
    final ShadcnThemeData theme = ShadcnTheme.of(context);
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
            // the controller's 44 px, so narrower viewports scroll instead of
            // overflowing and the stage centres the box.
            SizedBox(
              height: (_pageSize + 1) * 44,
              child: ShadcnTable(
                resizeController: _resize,
                horizontalController: _horizontal,
                verticalController: _vertical,
                rows: <ShadcnTableRow>[
                  ShadcnTableHeader(
                    cells: <ShadcnTableCell>[
                      ShadcnTableCell(
                        child: Checkbox(
                          tristate: true,
                          value: allChecked
                              ? CheckboxValue.checked
                              : (someChecked
                                    ? CheckboxValue.indeterminate
                                    : CheckboxValue.unchecked),
                          onChanged: (_) => _togglePage(visible),
                        ),
                      ),
                      ShadcnTableCell(
                        child: _SortHeader(
                          label: 'Name',
                          sorted: _sortColumn == _nameColumn,
                          ascending: _ascending,
                          onTap: () => _sort(_nameColumn),
                        ),
                      ),
                      ShadcnTableCell(
                        child: _SortHeader(
                          label: 'Role',
                          sorted: _sortColumn == _roleColumn,
                          ascending: _ascending,
                          onTap: () => _sort(_roleColumn),
                        ),
                      ),
                      const ShadcnTableCell(child: Text('Status')),
                    ],
                  ),
                  for (final _Member member in visible)
                    ShadcnTableRow(
                      selected: _selected.contains(member.name),
                      cells: <ShadcnTableCell>[
                        ShadcnTableCell(
                          child: Checkbox(
                            value: _selected.contains(member.name)
                                ? CheckboxValue.checked
                                : CheckboxValue.unchecked,
                            onChanged: (_) => _toggle(member.name),
                          ),
                        ),
                        ShadcnTableCell(child: Text(member.name)),
                        ShadcnTableCell(child: Text(member.role)),
                        ShadcnTableCell(
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Badge(
                              variant: _statusVariant(member.status),
                              child: Text(member.status),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Gap(theme.spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                      size: ButtonSize.sm,
                      onPressed: page > 0
                          ? () => setState(() => _page = page - 1)
                          : null,
                      leading: const Icon(LucideIcons.chevronLeft, size: 14),
                      child: const Text('Prev'),
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
                      size: ButtonSize.sm,
                      onPressed: page + 1 < totalPages
                          ? () => setState(() => _page = page + 1)
                          : null,
                      trailing: const Icon(LucideIcons.chevronRight, size: 14),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A small static invoice grid with a total footer.
class _InvoicesTable extends StatelessWidget {
  const _InvoicesTable();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ShadcnTable(
          columnWidths: <int, TableSize>{
            1: FixedTableSize(80),
            2: FixedTableSize(80),
            3: FixedTableSize(90),
          },
          rows: <ShadcnTableRow>[
            ShadcnTableHeader(
              cells: <ShadcnTableCell>[
                ShadcnTableCell(child: Text('Invoice')),
                ShadcnTableCell(child: Text('Status')),
                ShadcnTableCell(child: Text('Method')),
                ShadcnTableCell(child: Text('Amount')),
              ],
            ),
            ShadcnTableRow(
              cells: <ShadcnTableCell>[
                ShadcnTableCell(child: Text('INV-001')),
                ShadcnTableCell(child: Text('Paid')),
                ShadcnTableCell(child: Text('Card')),
                ShadcnTableCell(child: Text('\$250.00')),
              ],
            ),
            ShadcnTableRow(
              cells: <ShadcnTableCell>[
                ShadcnTableCell(child: Text('INV-002')),
                ShadcnTableCell(child: Text('Pending')),
                ShadcnTableCell(child: Text('PayPal')),
                ShadcnTableCell(child: Text('\$150.00')),
              ],
            ),
            ShadcnTableRow(
              cells: <ShadcnTableCell>[
                ShadcnTableCell(child: Text('INV-003')),
                ShadcnTableCell(child: Text('Overdue')),
                ShadcnTableCell(child: Text('Transfer')),
                ShadcnTableCell(child: Text('\$350.00')),
              ],
            ),
            ShadcnTableFooter(
              cells: <ShadcnTableCell>[
                ShadcnTableCell(columnSpan: 3, child: Text('Total')),
                ShadcnTableCell(child: Text('\$750.00')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Named docs examples for `table`; the first entry is the default.
const List<ComponentPreview> tablePreviews = <ComponentPreview>[
  ComponentPreview('Data table', _dataTable),
  ComponentPreview('Invoices', _invoices),
];

Widget _dataTable(BuildContext context) => const _DataTable();

Widget _invoices(BuildContext context) => const _InvoicesTable();
