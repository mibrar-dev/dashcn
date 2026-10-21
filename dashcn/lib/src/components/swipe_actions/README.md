# SwipeActions (`swipe_actions`)

Swipe a row to reveal trailing actions; drag past the actions to dismiss
(dismiss-to-delete). Density-sized by default: compact tile ~56 px wide with
a 16 px icon and 12 px label; comfortable (~64) and touch (~72) grow from the
tokens. The row min-height follows the tokens, the reveal scales with the
drag, and a full swipe collapses the row height to zero before `onDismissed`
fires — so the caller removes an already-gone row. RTL-aware; keyboard and
screen-reader users get the same actions as density tiles once revealed.

## Files

- `swipe_actions.dart`
- `swipe_action.dart`
- `swipe_action_buttons.dart`
- `swipe_actions_style.dart`
- `swipe_actions_theme.dart`

## Install

```sh
dashcn add swipe_actions
```

```dart
import 'package:<your_app>/ui/dashcn/components/swipe_actions/swipe_actions.dart';

SwipeActions(
  actions: <SwipeAction>[
    SwipeAction(label: 'Delete', destructive: true, onPressed: deleteRow),
  ],
  onDismissed: deleteRow,
  child: const Text('Row content'),
)
```

## Density

```dart
SwipeActions(
  densityTokens: DensityTokens.comfortable,
  actions: [SwipeAction(label: 'Delete', onPressed: () {})],
  child: const Text('Row'),
)
```

Tile width resolves `control + 24` (56 / 64 / 72), icon from `tokens.iconSize`
(16 / 20 / 24), label from `tokens.subtitleTextSize - 1` (12 / 13 / 14), gap
from `tokens.gap / 2`, row min from `tokens.rowMinHeight`. Override per
instance via `densityTokens`/`actionExtent` or the theme (`actionWidth`,
`iconSize`, `labelStyle`, `iconLabelGap`, `rowMinHeight`).

## Motion

`motion` (`MotionSpec`) retimes the spring settle and the commit collapse for
one row, or snaps them via `MotionSpec.disabled`. Reduced motion
(`MediaQuery.disableAnimations` or `motion.enabled == false`) snaps every
phase with no ticker. `SwipeAction.builder` receives the per-button reveal
progress (0 closed, 1 open) to paint a custom action; `runBuilder` swaps the
whole run and `contentBuilder` swaps the row content; `dismissThreshold`
moves the full-swipe commit line (1.0 is exactly the actions width).

## Declared dependencies

| Layer | Units |
|---|---|
| `theme` | `color_tokens`, `density_tokens`, `theme`, `motion` |
| `primitives` | `clickable`, `motion` |
| `components` | [] |

## Notes

A drag toward the leading edge reveals the actions; release settles by
position + fling velocity. Tapping the row while open closes it. While closed
the actions are excluded from semantics and focus.

`SwipeActionsController` reveals, hides or dismisses the row programmatically
(close swiped rows when the list scrolls, deterministic reveals in tests).
