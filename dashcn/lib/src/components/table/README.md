# Table

A themed data grid built on a custom layout render object: span-aware cells,
per-column/row sizing strategies, frozen rows and columns, optional two-axis
scrolling and optional interactive column/row resizing. Widgets-only.

The public widgets are prefixed `TableView*` because `Table`, `TableRow` and
`TableCell` are also names in `package:flutter/widgets.dart` (the `image`
component resolved the same clash by renaming `Image` to `Picture`). No
`hide` workaround is needed when importing both.

## When to use

- Presenting tabular data with headers/footers and column alignment.
- A grid that must resize columns or rows interactively.
- A scrollable grid with pinned header rows or key columns.

## Snippets

Basic grid:

```dart
TableView(
  columnWidths: const {0: FlexTableSize(flex: 2), 2: FixedTableSize(90)},
  rows: <TableViewRow>[
    const TableViewHeader(cells: <TableViewCell>[
      TableViewCell(child: Text('Name')),
      TableViewCell(child: Text('Role')),
      TableViewCell(child: Text('Status')),
    ]),
    const TableViewRow(cells: <TableViewCell>[
      TableViewCell(child: Text('Avery')),
      TableViewCell(child: Text('Designer')),
      TableViewCell(child: Text('Active')),
    ]),
  ],
);
```

Spanning cell and a footer:

```dart
TableViewFooter(cells: <TableViewCell>[
  TableViewCell(columnSpan: 2, child: const Text('2 people')),
  const TableViewCell(child: Text('—')),
]);
```

Resizable + scrollable grid:

```dart
final controller = ResizableTableController(
  defaultColumnWidth: 120,
  defaultRowHeight: 40,
);
TableView(
  resizeController: controller,
  verticalController: scrollController,
  horizontalController: horizontalScrollController,
  rows: rows,
);
```

Frozen header row:

```dart
TableView(
  frozenCells: const FrozenTableData(frozenRows: <TableRef>[TableRef(0)]),
  verticalController: controller,
  rows: rows,
);
```

## API

| Member | Notes |
|---|---|
| `TableView.rows` | `List<TableViewRow>` (headers, rows, footers) |
| `defaultColumnWidth` / `defaultRowHeight` | `TableSize`, default flex / intrinsic |
| `columnWidths` / `rowHeights` | per-index `TableSize` overrides |
| `frozenCells` | `FrozenTableData` of pinned rows/columns |
| `horizontalOffset` / `verticalOffset` / `viewportSize` | manual viewport |
| `verticalController` / `horizontalController` | own the scrolling |
| `textDirection` | direction columns run in |
| `resizeController` | `ResizableTableController?`; enables resizing |
| `cellWidthResizeMode` / `cellHeightResizeMode` | `TableCellResizeMode` |
| `clipBehavior` | boundary clipping |
| `theme` | `TableTheme?` widget leg |

`TableSize` strategies: `FlexTableSize`, `FixedTableSize`,
`IntrinsicTableSize`, `FractionalTableSize`.

## Theme resolution

`widget theme > ComponentTheme<TableTheme> in tree > app overrides
(table_theme.dart) > tableDefaults`, merged per field.

Per cell, `TableTheme.cellTheme` merges over the row default
(`TableViewHeader` / `TableViewFooter` / body). The row defaults follow
dashcn: body cells are `p-2` with a bottom border, a `muted/50` row-hover
fill and a `muted` selected fill; header cells are compact `h-9 px-2` (36,
upstream v4 `h-10`) with medium
`mutedForeground` text (dashcn v4 `TableHead`); footer cells are muted with
no border. Every cell is `align-middle`: content hugs the leading edge and
centres vertically when its row grows taller than the content.

## Differences from the old `layout/table`

- `ResizableTable` is folded into `TableView` behind `resizeController`; the
  old separate widget and its duplicated cell-flattening state are gone.
- Public widgets are renamed `TableView` / `TableViewRow` /
  `TableViewHeader` / `TableViewFooter` / `TableViewCell` to avoid the
  Flutter `widgets.dart` name clash (clean break; no aliases).
- The layout engine, cell helpers, resize controller/handles, cell view and
  models live in `primitives/table_layout/` so the component folder holds only
  `table.dart`, `table_style.dart` and `table_theme.dart` (the same split the
  `slider` component uses). The theme classes (`TableTheme` / `TableCellTheme`)
  stay in `table_style.dart`: a primitive must not own a component's theme.
- The public models (`TableViewRow` / `TableViewCell`) are theme-free so the
  primitive never imports a component; the old per-row `cellTheme` and per-cell
  `theme` override fields are dropped. Use `TableTheme.cellTheme` to theme the
  grid, or a `ComponentTheme<TableTheme>` subtree for a region.
- The old `_impl/themes/{config,tokens,defaults,schema}` files collapse into
  `table_style.dart` + `table_theme.dart`.
- **Bug fixed:** the old cell fill defaulted to hard-coded white
  (`0xFFFFFFFF`), so dark tables rendered white; the default is now the `card`
  token.
- **Bug fixed:** `TableTheme.cellTheme` was declared but never read; it is now
  merged under the row/cell themes.
- **Bug fixed:** `TableRow`/`TableHeader`/`TableFooter.buildDefaultTheme` built
  a fresh `WidgetStateProperty.resolveWith` closure on every row on every
  build; the defaults are now const token rows.
- **Bug fixed:** cells read the old `Theme.of(context).colorScheme`; they now
  resolve `ThemeColors` through `ThemedColor` tokens, so presets and dark mode
  follow.
- **Bug fixed:** `TableTheme.copyWith` silently dropped `borderRadius`.
- `Data.inherit` (`package:data_widget`) is gone: the state builds the cells
  directly, so there is no hidden `Data` dependency.
- The `_impl/` `part` structure, `ignore_for_file` comments and
  `theme.schema.json` are gone.
- Resize handles carry a `Semantics` label from
  `ComponentLocalizations.tableResizeColumn` / `.tableResizeRow` (English fallback;
  no Flutter ARB equivalent exists). Every handle is focusable: arrows step the
  divider in 10 px increments (the shared `resizableHandleStep`, RTL-aware),
  Home/End jump the leading cell to its min/max bound, all clamped by the
  controller's constraints.
