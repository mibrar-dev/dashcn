// Typeset tables for the docs site (spec §2.3): border-collapse separate,
// 15/1.5 tabular-nums cells, 500-weight header, 1 px row rules. Wide layouts
// fit the article width (leading columns size to content with a cap, the
// last column takes the remainder and wraps); narrow layouts stack each row
// as a labelled block so nothing clips.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import 'docs_tokens.dart';
import 'typeset.dart';

/// One cell of a [TypesetTable].
class TypesetCell {
  /// Creates a cell.
  const TypesetCell({required this.text, this.mono = false});

  /// Cell content.
  final String text;

  /// Whether the cell renders in the mono face (parameter/field names).
  final bool mono;
}

/// One row of a [TypesetTable].
class TypesetRow {
  /// Creates a row.
  const TypesetRow(this.cells);

  /// The cells, in column order.
  final List<TypesetCell> cells;
}

/// A typeset-styled data table (spec §2.3).
///
/// Header cells are 500 weight; body cells are 400. Both use 15/1.5
/// tabular-nums. Rows are separated by 1 px rules. The table fits its
/// incoming width: the leading columns size to their content (capped) and
/// the trailing column flexes and wraps. Below 560 px each row stacks as a
/// labelled block instead of scrolling.
class TypesetTable extends StatelessWidget {
  /// Creates a table.
  const TypesetTable({super.key, required this.headers, required this.rows});

  /// Header cell text, in column order.
  final List<String> headers;

  /// Body rows.
  final List<TypesetRow> rows;

  /// Narrow widths stack instead of fitting columns.
  static const double _stackBreakpoint = 560;

  static double _capForColumn(int index) {
    switch (index) {
      case 0:
        return 140;
      case 1:
        return 200;
      case 2:
        return 180;
      default:
        return 160;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : DocsMetrics.articleWidth;
        if (maxWidth < _stackBreakpoint) {
          return _StackedTable(headers: headers, rows: rows);
        }
        return _FittedTable(headers: headers, rows: rows);
      },
    );
  }
}

/// Wide layout: a single [Table] whose leading columns size to content
/// (capped) and whose last column flexes and wraps.
class _FittedTable extends StatelessWidget {
  /// Creates the fitted table.
  const _FittedTable({required this.headers, required this.rows});

  /// Header labels.
  final List<String> headers;

  /// Body rows.
  final List<TypesetRow> rows;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle headerStyle = docsText(
      context,
      size: 15,
      weight: FontWeight.w500,
      height: 1.5,
    );
    final TextStyle bodyStyle = docsText(
      context,
      size: 15,
      height: 1.5,
      color: theme.colors.foreground,
    );
    final TextStyle monoStyle = theme.typography.mono.copyWith(
      fontSize: 15,
      height: 1.5,
      color: theme.colors.foreground,
    );
    final int columnCount = headers.length;
    final Map<int, TableColumnWidth> columnWidths = <int, TableColumnWidth>{
      for (int i = 0; i < columnCount; i++)
        if (i == columnCount - 1)
          i: const FlexColumnWidth(1)
        else
          i: MinColumnWidth(
            IntrinsicColumnWidth(),
            FixedColumnWidth(TypesetTable._capForColumn(i)),
          ),
    };
    return Table(
      columnWidths: columnWidths,
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: theme.colors.border)),
          ),
          children: <Widget>[
            for (int i = 0; i < columnCount; i++)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  i == 0 ? 16 : 8,
                  10,
                  i == columnCount - 1 ? 16 : 8,
                  10,
                ),
                child: Text(headers[i], style: headerStyle),
              ),
          ],
        ),
        for (final TypesetRow row in rows)
          TableRow(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colors.border.withValues(alpha: 0.5),
                ),
              ),
            ),
            children: <Widget>[
              for (int i = 0; i < columnCount; i++)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    i == 0 ? 16 : 8,
                    12,
                    i == columnCount - 1 ? 16 : 8,
                    12,
                  ),
                  child: _cellChild(
                    i < row.cells.length
                        ? row.cells[i]
                        : const TypesetCell(text: ''),
                    bodyStyle,
                    monoStyle,
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _cellChild(TypesetCell cell, TextStyle body, TextStyle mono) {
    if (cell.mono) {
      return Text(cell.text.isEmpty ? '—' : cell.text, style: mono);
    }
    return Text.rich(
      TextSpan(children: docsDocSpans(cell.text, body)),
      style: body,
    );
  }
}

/// Narrow layout: each row becomes a labelled block with a visible frame,
/// so nothing clips and no horizontal scroll is needed.
class _StackedTable extends StatelessWidget {
  /// Creates the stacked table.
  const _StackedTable({required this.headers, required this.rows});

  /// Header labels used as field labels.
  final List<String> headers;

  /// Body rows.
  final List<TypesetRow> rows;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle labelStyle = docsText(
      context,
      size: 12,
      weight: FontWeight.w500,
      color: theme.colors.mutedForeground,
    );
    final TextStyle bodyStyle = docsText(
      context,
      size: 15,
      height: 1.5,
      color: theme.colors.foreground,
    );
    final TextStyle monoStyle = theme.typography.mono.copyWith(
      fontSize: 15,
      height: 1.5,
      color: theme.colors.foreground,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final TypesetRow row in rows)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < headers.length; i++) ...<Widget>[
                  if (i > 0) const Gap(8),
                  Text(headers[i], style: labelStyle),
                  const Gap(4),
                  _fieldValue(
                    i < row.cells.length
                        ? row.cells[i]
                        : const TypesetCell(text: ''),
                    bodyStyle,
                    monoStyle,
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _fieldValue(TypesetCell cell, TextStyle body, TextStyle mono) {
    if (cell.mono) {
      return Text(cell.text.isEmpty ? '—' : cell.text, style: mono);
    }
    return Text.rich(
      TextSpan(children: docsDocSpans(cell.text, body)),
      style: body,
    );
  }
}

/// A key/value table for CLI flags (name, alias, description).
class TypesetFlagTable extends StatelessWidget {
  /// Creates a flag table.
  const TypesetFlagTable({super.key, required this.flags});

  /// The flags to display.
  final List<({String name, String? alias, String description})> flags;

  @override
  Widget build(BuildContext context) {
    return TypesetTable(
      headers: const <String>['Flag', 'Alias', 'Description'],
      rows: <TypesetRow>[
        for (final flag in flags)
          TypesetRow(<TypesetCell>[
            TypesetCell(text: flag.name, mono: true),
            TypesetCell(text: flag.alias ?? '—'),
            TypesetCell(text: flag.description),
          ]),
      ],
    );
  }
}

/// A two-column key/value table (used for theme fields).
class TypesetKeyValueTable extends StatelessWidget {
  /// Creates a key/value table.
  const TypesetKeyValueTable({super.key, required this.rows});

  /// The key/value pairs.
  final List<({String key, String value})> rows;

  @override
  Widget build(BuildContext context) {
    return TypesetTable(
      headers: const <String>['Property', 'Value'],
      rows: <TypesetRow>[
        for (final row in rows)
          TypesetRow(<TypesetCell>[
            TypesetCell(text: row.key, mono: true),
            TypesetCell(text: row.value),
          ]),
      ],
    );
  }
}

/// A simple labelled value row (used in the themes rail).
class TypesetLabelledRow extends StatelessWidget {
  /// Creates a labelled row.
  const TypesetLabelledRow({
    super.key,
    required this.label,
    required this.value,
  });

  /// The label (12 px muted).
  final String label;

  /// The value (14 px).
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: docsText(
            context,
            size: 12,
            weight: FontWeight.w500,
            color: theme.colors.mutedForeground,
          ),
        ),
        const Gap(4),
        Text(value, style: docsText(context, size: 14)),
      ],
    );
  }
}
