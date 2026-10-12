# SwipeActions (`swipe_actions`)

Swipe a row to reveal trailing actions; drag past the actions to dismiss
(dismiss-to-delete). RTL-aware; keyboard and screen-reader users get the same
actions as real buttons once revealed.

## Files

- `swipe_actions.dart`

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

## Declared dependencies

| Layer | Units |
|---|---|
| `theme` | `theme` |
| `components` | `button` |

## Notes

A drag toward the leading edge reveals the actions; release settles by
position + fling velocity. Tapping the row while open closes it. While closed
the actions are excluded from semantics and focus.

`SwipeActionsController` reveals or hides the row programmatically (close
swiped rows when the list scrolls, deterministic reveals in tests).
