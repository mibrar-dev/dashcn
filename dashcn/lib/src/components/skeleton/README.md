# Skeleton

Widgets-only loading placeholder with a repeating shimmer sweep. No Material,
no Cupertino, no component dependency, and no `package:skeletonizer`.

Shape placeholders render the shimmer in content geometry (text lines,
avatar) so loading states match content size; composed placeholders cover
card, list and table loading states; `SkeletonMirror` sizes any placeholder
from the real child's box.

## When to use

- A block of content is loading and you do not want the layout to jump.
- A list of rows, a card or a media tile needs a neutral placeholder.
- A table is fetching rows and the header should stay aligned.

## Snippets

Wrap any widget; it keeps its box and is painted only once the data arrived:

```dart
Skeleton(
  enabled: loading,
  child: Text('Summary'),
);
```

Text lines and avatar shapes (sizes from the density scale):

```dart
const SkeletonLine(lines: 3);
const SkeletonAvatar();
const SkeletonBlock(width: 120);
```

Composed loading states with builder slots for every visible part:

```dart
const SkeletonList(itemCount: 3);
const SkeletonCard(showAvatar: true, contentLines: 2, showFooter: true);
const SkeletonTable(columns: 3, rows: 4);
```

Mirror the real child's box so the placeholder never shifts layout:

```dart
SkeletonMirror(
  enabled: loading,
  placeholderBuilder: (context) => const SkeletonLine(lines: 2),
  child: ProfileRow(user: user),
);
```

Custom shape per line/row/cell:

```dart
SkeletonLine(
  lines: 3,
  lineBuilder: (context, index, isLast, bar) => bar,
);
SkeletonList(
  itemCount: 3,
  leadingBuilder: (context, index, avatar) => avatar,
  titleBuilder: (context, index, title) => title,
);
```

Widget-leg theme override (beats the app and the tree legs):

```dart
Skeleton(
  enabled: loading,
  theme: SkeletonTheme(duration: Duration(milliseconds: 1600)),
  child: content,
);
```

App-wide override in `skeleton_theme.dart`:

```dart
const SkeletonTheme skeletonThemeOverrides = SkeletonTheme(
  fromColor: ThemedColor.ref(ColorRef.accent),
  toColor: ThemedColor.ref(ColorRef.secondary),
);
```

## API

| Widget | Parameter | Default | Notes |
|---|---|---|---|
| `Skeleton` | `child` | required | laid out always, painted only when `enabled` is false |
| | `enabled` | `true` | false renders the child unchanged |
| | `borderRadius` | null | null uses `SkeletonTheme.borderRadius`, then `borderRadiusMd` |
| | `theme` / `style` | null | widget legs of `SkeletonTheme` (`style` wins) |
| | `densityTokens` | null | per-instance density; null follows theme then ambient (touch on phones) |
| | `semanticsLabel` | `Loading` | accessible label for the placeholder |
| `SkeletonBlock` | `width`/`height` | fill / body step | generic rounded-box placeholder |
| | `blockBuilder` | null | custom builder receiving the default box |
| `SkeletonLine` | `lines` | `2` | number of bars; last bar renders short |
| | `lastLineFraction` | `0.6` | width fraction of the last bar |
| | `lineHeight`/`lineGap` | null | null follows density body step / gap |
| | `lineBuilder` | null | per-bar custom builder |
| `SkeletonAvatar` | `size` | null | null follows density control height (32 compact) |
| | `circle` | `true` | false renders a rounded tile |
| | `avatarBuilder` | null | custom builder receiving the default disc |
| `SkeletonCard` | `showAvatar`/`contentLines`/`showFooter` | true/2/false | card loading state; frosted like `Card` |
| | `leadingBuilder`/`titleBuilder`/`contentBuilder`/`footerBuilder` | null | builder slots for every part |
| | `surfaceOpacity`/`surfaceBlur` | null | null follows theme then ambient surface legs |
| `SkeletonList` | `itemCount` | `3` | repeated avatar + text rows |
| | `showAvatar`/`showTrailing` | true/false | row geometry switches |
| | `leadingBuilder`/`titleBuilder`/`trailingBuilder`/`separatorBuilder` | null | builder slots |
| `SkeletonTable` | `columns`/`rows` | 3/4 | header plus body grid |
| | `showHeader` | `true` | header row switch |
| | `headerBuilder`/`cellBuilder` | null | per-cell custom builders |
| `SkeletonMirror` | `child` | required | real content; laid out invisibly while loading |
| | `placeholderBuilder` | required | builds the placeholder filling the child's box |
| | `enabled` | `true` | false paints `child` |

## Theme fields

| Field | Default | Notes |
|---|---|---|
| `fromColor` | `ColorRef.muted` | leading sweep fill |
| `toColor` | `ColorRef.accent` | trailing sweep fill |
| `duration` | 800 ms | one full sweep; scaled by motion intensity, zero under reduced motion |
| `curve` | motion standard | sweep easing; null falls back to `motion.curves.standard` |
| `borderRadius` | `borderRadiusMd` | corner radius |
| `lineHeight` | density `bodyTextSize` | 14 compact, 15 comfortable, 16 touch |
| `lineGap` | density `gap` | 8 compact, 10 comfortable, 12 touch |
| `avatarSize` | density `controlHeight` | 32 compact, 40 comfortable, 48 touch |
| `rowHeight` | density `rowMinHeight` | 32 compact, 40 comfortable, 48 compact floor |
| `surfaceOpacity` | ambient | card surface opacity via the shared surface primitive |
| `surfaceBlur` | ambient | card surface blur via `GlassSurface` |

Sizes resolve from the density scale (compact default); phone widths
(< 600 px) use touch tokens unless a per-instance or theme override is set.
The sweep duration scales with `MotionTokens` intensity and collapses under
reduced motion (`MediaQuery.disableAnimations` or `motion.enabled: false`).

## Migrating from the old skeleton

| Old | New |
|---|---|
| `DashcnSkeletonizerConfigLayer(theme: material.ThemeData(...))` | deleted; wrap the content in `Skeleton` |
| `content.asSkeleton()` | `Skeleton(child: content)` |
| `content.asSkeleton(enabled: loading)` | `Skeleton(enabled: loading, child: content)` |
| `content.asSkeleton(snapshot: s)` | `Skeleton(enabled: !s.hasData, child: content)` |
| `content.asSkeletonSliver()` | `Skeleton(child: content)` inside a `SliverToBoxAdapter` |
| `content.ignoreSkeleton()` | `Skeleton(enabled: false, child: content)` |
| `content.excludeSkeleton()` | `Skeleton(enabled: false, child: content)` |
| `SkeletonTheme(fromColor:, toColor:, duration:, enableSwitchAnimation:)` | `SkeletonTheme(fromColor:, toColor:, duration:)`; `enableSwitchAnimation` is gone (it never affected any widget in the old component) |
