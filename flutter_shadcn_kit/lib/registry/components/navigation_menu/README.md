# NavigationMenu

Horizontal navigation bar: entries act as buttons, open dropdown content on
hover (after a short delay) or press (toggle), and show a chevron while open.
Content renders in a themed popover below the trigger's start edge: the panel
hugs its content up to `maxWidth` (480), never the window width, with popover
fill, border, radius and shadow. The panel follows between entries, survives a
hover grace period, and closes on Escape with focus returning to the trigger.
Widgets-only.

## When to use

- Top-level site/app navigation with rich dropdown panels.
- Mega-menu style grids via `NavigationMenuContentList`.

## Snippets

Minimal:

```dart
NavigationMenu(
  children: [
    NavigationMenuItem(onPressed: goHome, child: const Text('Home')),
    NavigationMenuItem(
      content: const NavigationMenuContentList(
        crossAxisCount: 2,
        children: [
          NavigationMenuContent(title: Text('Web Apps')),
          NavigationMenuContent(title: Text('Mobile Apps')),
        ],
      ),
      child: const Text('Products'),
    ),
  ],
);
```

Rich content entry:

```dart
NavigationMenuContent(
  leading: const Icon(LucideIcons.layoutDashboard, size: 16),
  title: const Text('Dashboard'),
  content: const Text('Analytics and insights'),
  onPressed: openDashboard,
);
```

## API

| Class | Key parameters |
|---|---|
| `NavigationMenu` | `children`, `surfaceOpacity` / `surfaceBlur`, `theme` |
| `NavigationMenuItem` | `child` (required), `content`, `onPressed` |
| `NavigationMenuContent` | `title` (required), `content`, `leading`, `trailing`, `onPressed` |
| `NavigationMenuContentList` | `children`, `crossAxisCount` (3), `spacing`, `runSpacing`, `reverse` |

Keyboard: Left/Right walk across entries (the panel follows), Down opens the
focused entry's panel and moves focus into it, Escape closes and returns focus
to the trigger, Enter/Space press through `Button`. Reach an entry's node via
`NavigationMenuItemState.focusNode`.

## Differences from old `navigation_menu`

- Dropped: the mobile adaptive path through `overlay_configuration`
  (desktop popover presentation only) and its `adaptiveOverlay` flag.
- `RadixIcons` becomes Lucide; the old `Button` style-closure API becomes a
  plain `theme` row (`ButtonVariant.ghost`, muted fill while active).
- Content entries close the menu before firing `onPressed`.
- The panel anchors below the trigger's start edge and hugs its content
  (capped by `NavigationMenuTheme.maxWidth`, default 480); descriptions
  clamp to two lines.
