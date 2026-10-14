# Gooey Toast

Gooey-style transient notifications: a compact, tab-shaped pill (status icon +
coloured title) that grows a wider body below it through smooth concave
shoulders, holds, then collapses back into the pill and leaves. The pill and the
body merge into a single metaball silhouette, so the surface reads as one blob
instead of two stacked rectangles.

## Getting started

```dart
import 'package:<your_app>/ui/dashcn/components/gooey_toast/gooey_toast.dart';

// Wrap the app once.
GooeyToastLayer(child: myApp);

// Then show a toast from anywhere below the layer.
showGooeyToast(
  context,
  const GooeyToastOptions(
    title: 'Saved to your workspace',
    description: 'Everything is in sync.',
    state: GooeyToastState.success,
  ),
);
```

The layer inserts into the **root overlay**, so toasts anchor to the window edge
and never cover their own trigger, wherever the caller sits in the tree. Own the
controller to dismiss or inspect toasts:

```dart
final controller = GooeyToastController();
GooeyToastLayer(controller: controller, child: myApp);

controller.activeToasts;      // newest first
controller.containsToast(id); // is it still on screen?
controller.dismiss(id);       // dismiss it now
```

## Variants

| `state`     | Icon                 | Accent            | Body                          |
| ----------- | -------------------- | ----------------- | ----------------------------- |
| `success`   | check                | green `#16A34A`   | title + description           |
| `error`     | close                | `destructive` token | title + description           |
| `warning`   | warning triangle     | amber `#D97706`   | title + description           |
| `info`      | info                 | blue `#3B82F6`    | title + description           |
| `action`    | arrow (directional)  | indigo `#6366F1`  | + an inline action chip       |
| `loading`   | spinning glyph       | grey `#6B7280`    | pill only, never expands      |

Six variants of the same morph; `promise` and `custom` are combinations, not
extra states (see the previews).

### Status tones

dashcn ships no success/warning/info tokens, and the chart tokens change hue per
preset and mode, so the six status tones are **fixed defaults** declared in
`gooey_toast_style.dart` and overridable per app through
`gooey_toast_theme.dart`:

```dart
const GooeyToastTheme gooeyToastThemeOverrides = GooeyToastTheme(
  successTone: ThemedColor.value(Color(0xFF22C55E)),
);
```

Every tone passes through `ensureToneContrast`, which blends the tone toward the
`foreground` token until it clears the 3:1 non-text floor on the resolved
surface — so a fixed tone stays readable on a light `popover` and a dark one
alike. The icon bubble, the title and the action chip all share the tone.

## Positions and directions

`GooeyToastPosition` (`left`, `center`, `right`) picks the window edge and
`GooeyToastExpandDirection` picks which way the body grows; the six positions of
the reference are their combinations (`bottom` = top edge, `top` = bottom edge).

```dart
GooeyToastOptions(
  title: 'Pinned top-right',
  position: GooeyToastPosition.right,
  expandDirection: GooeyToastExpandDirection.bottom,
)
```

## Animation presets

| `animationStyle` | Duration | Curve                                     |
| ---------------- | -------- | ----------------------------------------- |
| `sileo`          | 600 ms   | `easeInOutCubic`                          |
| `smooth`         | 760 ms   | `easeInOutQuart`                          |
| `snappy`         | 420 ms   | `easeOutCubic`                            |
| `bouncy`         | 680 ms   | `elasticOut`                              |
| `fluid`          | 760 ms   | `Cubic(0.20, 0.95, 0.20, 1.18)`           |
| `springEasing`   | 600 ms   | piecewise Sileo spring stops              |

Body content animates through `bodyAnimationStyle` (`fade`, `fadeSlide`,
`fadeScale`, `none`) and the corners through `shapeStyle` (`defaultShape`,
`soft`, `sharp`, `capsule`).

## Lifecycle

1. enters as a thin pill,
2. expands after the autopilot expand delay (150 ms by default),
3. holds until the collapse delay (4 s by default),
4. collapses back into the pill,
5. leaves when the duration expires (6 s by default).

Hover, press or focus **pauses** the countdown and keeps the body open. Swipe in
the slot's dismiss direction, or call `controller.dismiss(id)`.

Turn the autopilot off to make a toast react to interaction only:

```dart
GooeyToastOptions(title: 'Hover me', description: '…', autopilot: null)
```

## Promise pattern

A `loading` toast never expands. Show it with an explicit id, await the work,
then show the settled state with the **same id**: the controller collapses the
body, swaps the compact state (morphing the icon and title), then reopens.

```dart
final id = showGooeyToast(
  context,
  const GooeyToastOptions(title: 'Uploading', state: GooeyToastState.loading),
);
await upload();
await showGooeyToast(
  context,
  const GooeyToastOptions(
    title: 'Upload Complete',
    description: 'Your file is ready.',
    state: GooeyToastState.success,
  ),
  id: id,
);
```

## Custom content

`compactChild` replaces the icon + title row and `expandedChild` replaces the
body entirely (a reply form, a tabbed workspace, a list). Both are measured, so
the silhouette still morphs around them.

```dart
GooeyToastOptions(
  title: 'Thread Reply',
  state: GooeyToastState.action,
  expandedChild: myReplyForm,
)
```

## Accessibility

- Status is carried by the icon glyph as well as colour.
- `MediaQueryData.disableAnimations` (reduced motion) drops the open morph, the
  shadow and the metaball blur, and the pill fades instead.
- Toasts render into the root overlay, so screen-reader focus order follows the
  document rather than the triggering button.

## API notes (clean break)

The previous rewrite went through `primitives/toast_queue`, which anchored toasts
inside the local box and lost the reference's timing. The ported controller keeps
the public entry points (`GooeyToastLayer`, `GooeyToastController`,
`GooeyToastOptions`, `showGooeyToast`) with these changes:

- `GooeyToastController.showGooeyToast` now takes the **build context first**,
  because it resolves the root overlay from it:
  `controller.showGooeyToast(context, options)`.
- Stacking settings that lived on the queue (`spacing`, `overlapStackOffset`,
  `pauseAutoDismissWhenMultiple`, `maxVisibleCount`,
  `dismissWholeStackWhenMultiple`) are gone: the stack uses the fixed 8 px
  `kGooeyStackGap` and the fixed 16 px `kGooeyEdgeInset` of the reference.
- Enums kept their names; `GooeyToastPosition` keeps three values instead of the
  unreachable `centerLeft`/`centerRight` (the direction covers them).

## Files

| File                          | Contents                                             |
| ----------------------------- | ---------------------------------------------------- |
| `gooey_toast.dart`            | layer, scope, `showGooeyToast`, the card             |
| `gooey_toast_controller.dart` | show/dismiss/transition, countdown, region order     |
| `gooey_toast_payload.dart`    | resolved payload + live overlay record               |
| `gooey_toast_stack.dart`      | overlay entry, anchors, stack offsets                |
| `gooey_toast_options.dart`    | state/position/direction enums, options, details     |
| `gooey_toast_style.dart`      | theme, variant tables, tone defaults                 |
| `gooey_toast_theme.dart`      | user-owned overrides (values only)                   |
| `preview.dart`                | the playground and the named examples                |

The reusable machinery lives in `primitives/gooey/`: `gooey_shape.dart` (the
merged silhouette), `gooey_paint.dart` (painter, clipper, compositing),
`gooey_surface.dart` / `gooey_surface_state.dart` (the state machine),
`gooey_frame.dart` (per-frame composition), `gooey_content.dart` /
`gooey_chip.dart` (content pieces), `gooey_stack.dart` (edge anchors),
`gooey_swipe.dart` (swipe to dismiss) and `gooey_close.dart` (an unused,
reference close-button widget kept for reference; the toast renders none).
