# Popup

An anchored floating surface for arbitrary (non-menu) content. The surface
is the `menu` component's `MenuPopup`, re-exported here so installing
`popup` gives you the chrome; `showPopup` presents it with Escape and
outside-tap dismissal.

## When to use

Use for small floating panels anchored to a control: a profile card, a
colour swatch grid, a mini form. For menus use `showMenu` or
`dropdown_menu`; for pointer-positioned panels use `context_menu`; for
modal dialogs use `showDialog`.

## Snippets

```dart
await showPopup<void>(
  context: context,
  builder: (context) => Padding(
    padding: const EdgeInsets.all(8),
    child: Text('Signed in as ibrar@example.com'),
  ),
);
```

```dart
// Standalone surface (own overlay plumbing):
MenuPopup(children: [Text('Content')]);
```

## API

| Member | Props |
|---|---|
| `showPopup<T>` | `context`, `builder`, `alignment` (topCenter), `anchorAlignment`, `offset` (0,4), `widthConstraint` (flexible), `heightConstraint`, `modal` (true), `consumeOutsideTaps` (true), `theme: MenuPopupTheme?` |
| `MenuPopup` | re-exported from `menu`: `children`, `theme` |
| `MenuPopupTheme` | re-exported from `menu` |

## Theme fields

`MenuPopupTheme` (owned by `menu`; user overrides in `menu/menu_theme.dart`)
— see the `menu` README. `showPopup` accepts it as the widget-leg
override.

## Differences from old `popup`

- `MenuPopup`/`MenuPopupTheme` are re-exported from `menu` and never
  re-declared; the old duplicate `popup` copies are gone.
- The old `DialogOverlayHandler` padding sniffing and the `dialog`
  dependency dissolved with the menu pilot.
- The surface fields (`surfaceBlur`, `surfaceOpacity`, `fillColor`,
  `borderColor`, `borderRadius`, `padding`) are now the menu-owned
  `MenuPopupTheme` token fields.
- `showPopup` is new: the old component offered the surface only, so
  every caller had to build its own overlay plumbing.
