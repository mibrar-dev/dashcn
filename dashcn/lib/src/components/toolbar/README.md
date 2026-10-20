# Toolbar

A row or column of actions, toggles, separators and groups. The toolbar is
responsive: when the items no longer fit the space it was given, the trailing
ones move into an overflow menu and a "more" button takes their place. The
arrow keys walk the items (mirrored in RTL).

## When to use

- A row of formatting or editing actions.
- A vertical rail of navigation-ish actions.
- Any set of small actions that must stay reachable while the content
  scrolls.

Use `Tabs` for a navigation strip, `SegmentedControl` for a small set of
mutually exclusive choices and `Menu` for a list of commands.

## Snippets

```dart
Toolbar(
  children: <Widget>[
    ToolbarItem(
      tooltip: 'Undo',
      semanticLabel: 'Undo',
      onPressed: _undo,
      child: const Icon(LucideIcons.rotateCw),
    ),
    const ToolbarSeparator(),
    ToolbarToggleItem(
      value: bold,
      onChanged: (bool value) => setState(() => bold = value),
      tooltip: 'Bold',
      semanticLabel: 'Bold',
      child: const Icon(LucideIcons.bold),
    ),
  ],
);
```

Groups:

```dart
Toolbar(
  children: <Widget>[
    ToolbarGroup(
      children: <Widget>[
        ToolbarItem(child: const Icon(LucideIcons.bold), onPressed: _bold),
        ToolbarItem(child: const Icon(LucideIcons.italic), onPressed: _italic),
      ],
    ),
    const ToolbarSeparator(),
    ToolbarGroup(children: <Widget>[/* ... */]),
  ],
);
```

## `Toolbar` API

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `children` | `List<Widget>` | required | `ToolbarItem`, `ToolbarToggleItem`, `ToolbarSeparator`, `ToolbarGroup` |
| `axis` | `ToolbarAxis` | `horizontal` | `horizontal` / `vertical` |
| `size` | `ToolbarSize` | `md` | 32 / 36 / 40 px items |
| `overflow` | `bool` | true | collapse into an overflow menu when the items no longer fit |
| `overflowIcon` | `Widget?` | null | the overflow button's icon |
| `overflowLabel` | `String` | `More` | the overflow button's hover label |
| `overflowSemanticLabel` | `String` | `More actions` | the overflow button's accessible name |
| `style` / `theme` | `ToolbarStyle?` | null | widget legs for the whole toolbar |

## `ToolbarItem` API

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `child` | `Widget` | required | the icon or content |
| `label` | `Widget?` | null | text shown next to the icon |
| `onPressed` | `VoidCallback?` | null | a null callback disables the item |
| `enabled` | `bool` | true | |
| `tooltip` | `String?` | null | hover label |
| `semanticLabel` | `String?` | null | accessible name; falls back to the label's text |
| `style` | `ToolbarStyle?` | null | widget leg for this item |
| `focusNode` | `FocusNode?` | null | |

## `ToolbarToggleItem` API

Same as `ToolbarItem` plus:

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `value` | `bool` | false | controlled value |
| `onChanged` | `ValueChanged<bool>?` | null | reports the next value |
| `controller` | `ToolbarToggleController?` | null | uncontrolled mode; `value`/`onChanged` must be null (asserted) |

## Overflow

The toolbar measures its items after the layout. When the items no longer fit
the space the toolbar was given, the trailing ones move into an overflow
menu behind a "more" button. The row itself is laid out with unbounded
constraints, so the toolbar never reports a flex overflow.

Pass `overflow: false` to keep every item inline (the toolbar then relies on
its parent to scroll it).

## Keyboard

- `Tab` moves between the toolbar's items.
- The arrow keys walk the items (left/right in a horizontal toolbar, up/down
  in a vertical one). The horizontal map is mirrored in RTL.
- `Enter` and `Space` activate the focused item.

## Theme resolution

`widget (style/theme) > ComponentTheme<ToolbarTheme> in tree > app overrides
(toolbar_theme.dart) > toolbarDefaults`, merged per field and state.

| `ToolbarTheme` field | Default |
|---|---|
| `container` | 4 px padding, 8 px gap, no fill |
| `item` | transparent fill, `muted@0.8` on hover, 8 px horizontal padding, 13 / w500 label |
| `group` | `muted@0.4` fill, 2 px padding |
| `separator` | the `border` token, 1 px |

## Getting started

1. Install the component (`dashcn add toolbar`) or copy the folder.
2. Import `toolbar.dart`; it re-exports the items, `ToolbarStyle`,
   `ToolbarTheme` and `toolbarDefaults`.
3. App-wide overrides live in the user-owned `toolbar_theme.dart`.
