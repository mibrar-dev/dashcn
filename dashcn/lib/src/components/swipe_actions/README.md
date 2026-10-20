# SwipeActions (`swipe_actions`)

Swipe a row to reveal trailing actions; drag past the actions to dismiss
(dismiss-to-delete). The settle is a critically-damped spring fed by the
release velocity, action buttons scale and fade in with the reveal progress
(staggered from the trailing edge outward), over-drag meets resistance
instead of a hard stop, and a full-swipe commit collapses the row height to
zero before `onDismissed` fires — so the caller removes an already-gone row.
RTL-aware; keyboard and screen-reader users get the same actions as real
buttons once revealed.

## Files

- `swipe_actions.dart`
- `swipe_action.dart`
- `swipe_action_buttons.dart`

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

## Motion

`motion` (`MotionSpec`) retimes the spring settle and the commit collapse for
one row, or snaps them via `MotionSpec.disabled`. Reduced motion
(`MediaQuery.disableAnimations` or `motion.enabled == false`) snaps every
phase with no ticker. `SwipeAction.builder` receives the per-button reveal
progress (0 closed, 1 open) to paint a custom action; `dismissThreshold`
moves the full-swipe commit line (1.0 is exactly the actions width).

## Declared dependencies

| Layer | Units |
|---|---|
| `theme` | `theme` |
| `primitives` | `motion_scope`, `motion_spec` |
| `components` | `button` |

## Notes

A drag toward the leading edge reveals the actions; release settles by
position + fling velocity. Tapping the row while open closes it. While closed
the actions are excluded from semantics and focus.

`SwipeActionsController` reveals, hides or dismisses the row programmatically
(close swiped rows when the list scrolls, deterministic reveals in tests).
