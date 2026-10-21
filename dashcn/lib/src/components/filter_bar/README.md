# FilterBar (`filter_bar`)

Search, sort, date-range and custom filters in one bar, with removable chips,
a clear action, and an overflow menu or mobile sheet presentation. Backed by the
typed filter engine in `primitives/filter_core/` (matchers, bindings, controller).

Rewritten on DESIGN.md density tokens: compact default (control 32 px, icon 16 px,
spacing 8 px on the 4 px scale, row height 32-36 px), overflow to a compact menu
on narrow widths, full token and style override surface, and builder slots for
all visible parts.

## When to use

- You need a controlled or uncontrolled filter bar over a list/table.
- You want a filter value you can also apply to models outside the UI
  (`FilterState.whereMatches`).

Avoid when a single control is enough — use `input` or `select` directly.

## Install

```bash
dashcn add filter_bar
```

## Import

```dart
import 'package:<your_app>/ui/dashcn/filter_bar/filter_bar.dart';
```

## Minimal example

```dart
FilterBar(
  state: _state,
  sortOptions: const <FilterSortOption>[
    FilterSortOption(id: 'newest', label: 'Newest'),
    FilterSortOption(id: 'oldest', label: 'Oldest'),
  ],
  resultsCount: 42,
  onStateChanged: (next) => setState(() => _state = next),
)
```

## Common patterns

### Controller (Controlled mode)

```dart
final controller = FilterBarController(const FilterState(sortId: 'newest'));

FilterBar(controller: controller, sortOptions: _sortOptions)
```

### Uncontrolled mode

```dart
FilterBar(
  initialState: const FilterState(sortId: 'newest'),
  sortOptions: _sortOptions,
)
```

### Typed custom filter

```dart
final statusField = FilterField<String>(id: 'status', matcher: FilterMatchers.exact());

FilterBar(
  state: _state,
  customFilters: <FilterCustomFilter>[
    FilterCustomFilter.typed<String>(
      field: statusField,
      builder: (context, value, onChanged) => Select<String>(
        value: value,
        canUnselect: true,
        placeholder: const Text('Status'),
        onChanged: onChanged,
        itemBuilder: (context, value) => Text(value),
        items: const <Widget>[
          SelectItem<String>(value: 'open', child: Text('Open')),
          SelectItem<String>(value: 'closed', child: Text('Closed')),
        ],
      ),
    ),
  ],
  onStateChanged: (next) => setState(() => _state = next),
)
```

### Filtering models

```dart
final bindings = <FilterBinding<Order>>[
  TypedFilterBinding<Order, String>(field: emailField, selector: (o) => o.email),
];
final filtered = _state.whereMatches(orders, bindings);
```

### Overflow to compact menu on narrow widths

By default (`FilterBarPresentation.autoMenu`), when the width falls below
`sheetBreakpoint` (720 px), secondary controls overflow to a compact menu:

```dart
FilterBar(
  state: _state,
  presentation: FilterBarPresentation.autoMenu,
  sheetBreakpoint: 720,
  sortOptions: _sortOptions,
  enableDateRange: true,
  onStateChanged: (next) => setState(() => _state = next),
)
```

### Sheet presentation

To present as a bottom drawer on mobile:

```dart
FilterBar(
  state: _state,
  presentation: FilterBarPresentation.autoSheet,
  sheetBreakpoint: 720,
  enableDateRange: true,
  onStateChanged: (next) => setState(() => _state = next),
)
```

### Custom visual style and density override

```dart
FilterBar(
  state: _state,
  densityTokens: DensityTokens.comfortable,
  style: FilterBarStyle(
    borderRadius: BorderRadius.circular(16),
    padding: const EdgeInsets.all(12),
    controlHeight: 40,
    searchWidth: 260,
  ),
  onStateChanged: (next) => setState(() => _state = next),
)
```

## API

- `FilterBar(state, onStateChanged, controller, initialState, sortOptions,
  enableDateRange, resultsCount, searchDebounce, trailingFilters, customFilters,
  clearPolicy, onClearAll, showClearAllWhenEmpty, presentation, sheetBreakpoint,
  sheetPosition, useRootNavigator, sheetContentPadding, groups, theme, style,
  densityTokens, leading, trailing, searchBuilder, sortBuilder, dateBuilder,
  clearAllBuilder, triggerBuilder, chipBuilder, counterBuilder,
  overflowMenuBuilder, sheetBuilder)`
- `FilterBarStyle`: per-instance style overrides for visual tokens (colors,
  radii, padding, sizes, typography, elevation, surface opacity/blur, menu width).
- `FilterBarTheme`: theme data with density tokens support.
- Sub-widgets: `FilterBarSearchField`, `FilterBarSortControl`, `FilterBarDateControl`,
  `FilterBarClearButton`, `FilterBarSheetTrigger`, `FilterBarOverflowTrigger`,
  `FilterBarOverflowMenu`, `FilterBarSheetScaffold`.
- Functions: `openFilterBarMenu`, `openFilterBarSheet`.

### Theme fields

| Field | Default | Effect |
|---|---|---|
| `spacing` | 8 | gap between controls (4 px scale) |
| `runSpacing` | 8 | gap between wrapped runs |
| `searchWidth` | 220 | search field width |
| `controlWidth` | 180 | sort/date control width |
| `controlHeight` | 36 | control height (compact row max) |
| `iconSize` | 16 | icon size across controls |
| `dense` | false | compact padding and small buttons |

Resolution: widget `style` > widget `theme` > nearest `ComponentTheme<FilterBarTheme>` >
`ComponentThemes` app overrides > `filterBarDefaults`.
