# SearchBar

A search field with a ranked result list. Typing filters `items` (or
`groups`) through the shared `primitives/search` tiered matcher — the same
files the `command` palette ranks through — and paints the matched
characters. Arrow keys move the highlight, Enter selects, Escape clears.
Widgets-only.

## When to use

- A filter field over a local list: fruit, commands, contacts, files.
- Grouped results with headings (`SearchBarGroup`).
- A command-palette-style field embedded in a page instead of a dialog (the
  dialog palette itself stays in `command`).

For a bare text field with no list, use `input`. For an async Widget-stream
palette with a dialog entry point, use `command`.

## Quick start

```dart
import 'package:<your_app>/ui/dashcn/components/search_bar/search_bar.dart';

SearchBar<String>(
  items: const <String>['Apple', 'Apricot', 'Banana'],
  hintText: 'Search fruit',
  onSelected: (item) => _run(item),
);
```

Grouped results:

```dart
SearchBar<String>(
  groups: const <SearchBarGroup<String>>[
    SearchBarGroup(label: 'Suggestions', items: ['Calendar', 'Launch']),
    SearchBarGroup(label: 'Settings', items: ['Profile', 'Mail']),
  ],
  onSelected: (item) => _run(item),
);
```

A cancel button beside the field (clears, reports, unfocuses):

```dart
SearchBar<String>(
  items: fruits,
  showCancelButton: true,
  onCancelled: _reset,
);
```

## `SearchBar` API

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `controller` / `initialValue` | `TextEditingController?` / `String?` | null | mutually exclusive |
| `focusNode` | `FocusNode?` | null | created when null |
| `items` | `List<T>` | `[]` | used when `groups` is empty |
| `groups` | `List<SearchBarGroup<T>>` | `[]` | non-empty wins over `items` |
| `itemLabel` | `SearchBarLabel<T>?` | null | `'$item'`; filtered and displayed |
| `itemBuilder` | `SearchBarRowBuilder<T>?` | null | custom row; args are `(context, item, highlight, highlighted)` |
| `onChanged` | `ValueChanged<String>?` | null | fires `debounce` after the last keystroke; clearing emits immediately |
| `onCleared` | `VoidCallback?` | null | fires when the text becomes empty |
| `onSelected` | `ValueChanged<T>?` | null | tap, or Enter on the highlighted row |
| `onSubmitted` | `ValueChanged<String>?` | null | Enter (or the search action) with no highlighted row |
| `onCancelled` | `VoidCallback?` | null | cancel button, or Escape on an empty field |
| `debounce` | `Duration` | 120 ms | `Duration.zero` fires synchronously |
| `hintText` | `String?` | localized "Search" | |
| `leading` | `Widget?` | null | replaces the search icon when set |
| `enabled` / `readOnly` | `bool` | `true` / `false` | passed to the field |
| `validator` | `String? Function(String?)?` | null | error message paints below the field |
| `showCancelButton` | `bool` | `false` | cancel button beside the field |
| `cancelLabel` | `String?` | localized "Cancel" | |
| `emptyBuilder` | `WidgetBuilder?` | null | shown with no rows; default is the localized empty row |
| `autofocus` | `bool` | `false` | |
| `theme` | `SearchBarTheme?` | null | widget leg of the resolver |

An empty query shows every item unfiltered (no highlight); a query with no
hits shows the empty state. The keyboard highlight starts on the first row.

## Ranking

Best tier wins per item; ties break by label length, then input order:

1. exact match, 2. prefix match, 3. word-start / initials match, 4. fzf-style
fuzzy subsequence (bonuses: word boundary +8, after separator +9/+10,
camelCase +7, consecutive run; penalties: gap start -3, gap extension -1),
5. typo tolerance over tokens (1 edit for 3-5 characters, 2 for 6+), used
only when tiers 1-4 find nothing list-wide.

Lists over 2,000 items build a character-bigram prefilter; tiers 1-3 still
scan every label while the fuzzy DP and the typo fallback run on the
bigram-union candidates.

## Theme resolution

`widget theme > ComponentTheme<SearchBarTheme> in tree > app overrides
(search_bar_theme.dart) > searchBarDefaults`, merged per field.

| `SearchBarTheme` field | Default |
|---|---|
| `background` | `popover` |
| `foreground` / `mutedForeground` | `foreground` / `mutedForeground` |
| `borderColor` / `borderWidth` | `border` / 1 |
| `borderRadius` | ambient `radiusLg` |
| `padding` | p-1 (4) around the list |
| `itemHighlight` | `accent` on hover/press/highlight |
| `itemHighlightForeground` | `accentForeground` on hover/press/highlight |
| `itemPadding` | px-2 py-1.5 (8/6) |
| `highlightColor` | `primary` (matched characters) |
| `textStyle` | text-sm (14) |
| `shadows` | `shadowLg` |
| `maxHeight` | 300 |
| `minRowHeight` | 48 |
| `minRowHeight` | 48 |
| `showLeading` / `showClear` | `true` / `true` |
| `iconSize` | 16 |
