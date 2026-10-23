# Floating Action Button

A raised button that floats over the page content: round by default, a pill
when a label is added, in three sizes. It is a *floating surface*, so its
fill goes through the shared `primitives/surface.dart` primitive and the
ambient `ThemeData.surfaceOpacity` / `surfaceBlur` apply to it.

## When to use

- The one primary action of a screen ("compose", "add", "create").
- A speed dial for a small set of related actions.
- A button that hides while the user scrolls down and comes back on the way
  up.

Use `Button` for actions inside the page flow; the FAB is for the floating
one.

## Snippets

```dart
Fab(
  icon: const Icon(LucideIcons.plus),
  semanticLabel: 'Add item',
  tooltip: 'Add item',
  onPressed: _add,
);
```

Extended (pill) shape:

```dart
Fab(
  icon: const Icon(LucideIcons.pencil),
  label: const Text('Compose'),
  onPressed: _compose,
);
```

Speed dial:

```dart
FabSpeedDial(
  icon: const Icon(LucideIcons.plus),
  actions: <FabSpeedDialAction>[
    FabSpeedDialAction(icon: const Icon(LucideIcons.image), onPressed: _photo),
    FabSpeedDialAction(icon: const Icon(LucideIcons.camera), onPressed: _camera),
  ],
);
```

Positions helper (inside a `Stack`):

```dart
Stack(
  children: <Widget>[
    FabPositioner(
      position: FabPosition.bottomEnd,
      child: Fab(icon: const Icon(LucideIcons.plus), onPressed: _add),
    ),
  ],
);
```

Hide on scroll:

```dart
FabHideOnScroll(
  controller: scrollController,
  child: Fab(icon: const Icon(LucideIcons.plus), onPressed: _add),
);
```

## `Fab` API

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `icon` | `Widget?` | null | the leading icon slot |
| `label` | `Widget?` | null | the trailing label slot; its presence makes the button a pill |
| `content` | `Widget?` | null | replaces the whole inner content (icon plus label) |
| `size` | `FabSize` | `FabSize.md` | 40 / 56 / 64 px box |
| `onPressed` | `VoidCallback?` | null | a null callback disables the button |
| `enabled` | `bool` | true | |
| `tooltip` | `String?` | null | hover label |
| `semanticLabel` | `String?` | null | accessible name; falls back to the label's text |
| `style` / `theme` | `FabStyle?` | null | widget legs for the button's visuals |
| `shape` | `FabShape?` | null | forces the painted shape |
| `focusNode` / `autofocus` | | null / false | |

Pass `semanticLabel` or `tooltip`: an icon alone carries no accessible name.

## Sizes

| `FabSize` | Box | Icon |
|---|---|---|
| `sm` | 40 x 40 | 18 px |
| `md` | 56 x 56 | 24 px |
| `lg` | 64 x 64 | 28 px |

On touch platforms the hit-test region and semantics tap target expand to
the platform minimum (48 px on Android, 44 px on iOS) with no layout or
paint change; the painted circle never changes.

## `FabSpeedDial`

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `icon` | `Widget` | required | the main button's icon |
| `actions` | `List<FabSpeedDialAction>` | required | closest to the main button first |
| `label` | `Widget?` | null | makes the main button a pill |
| `direction` | `FabSpeedDialDirection` | `up` | `up` / `down` / `start` / `end` (directional, mirrors in RTL) |
| `expanded` | `bool?` | null | controlled expansion state; null means the dial owns it |
| `onExpandedChanged` | `ValueChanged<bool>?` | null | reports the next expansion state |
| `actionBuilder` | `FabSpeedDialActionBuilder?` | null | builder slot for the mini actions |
| `miniSize` | `FabSize?` | null | size of the mini buttons |

The mini actions unfold with a stagger along the dial's axis and collapse
back into the main button.

## `FabHideOnScroll`

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `child` | `Widget` | required | the floating button |
| `controller` | `ScrollController?` | null | when null the helper reads scroll notifications |
| `direction` | `FabHideOnScrollDirection` | `down` | `down` / `up` / `both` |
| `threshold` | `double` | 6 | pixels of scroll before the button reacts |
| `offset` | `double` | 32 | how far the button slides away |
| `duration` / `curve` | `Duration?` / `Curve?` | null | theme motion tokens |

The child keeps its layout box, so nothing around it moves.

## `FabPositioner`

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `position` | `FabPosition` | required | nine anchor positions; the alignment is directional |
| `child` | `Widget` | required | the floating button |
| `padding` | `EdgeInsetsGeometry?` | 16 px | inset from the parent's edges |
| `offset` | `Offset` | zero | extra nudge (directional) |

## Theme resolution

`widget (style/theme) > ComponentTheme<FabTheme> in tree > app overrides
(fab_theme.dart) > fabDefaults`, merged per field and state. The fill is a
floating surface: `surfaceColor` applies the ambient opacity and
`GlassSurface` applies the ambient blur.

| `FabTheme` field | Default |
|---|---|
| `standard` / `extended` | `primary` fill / `primaryForeground`, elevation 3 |
| `mini` | `secondary` fill / `secondaryForeground`, elevation 2 |
| `gap` | 8 |
| `textStyle` | 14 / w600 |

## Getting started

1. Install the component (`dashcn add fab`) or copy the folder.
2. Import `fab.dart`; it re-exports `FabStyle`, `FabTheme`, `fabDefaults`,
   `FabSpeedDial`, `FabPositioner` and `FabHideOnScroll`.
3. App-wide overrides live in the user-owned `fab_theme.dart`.
