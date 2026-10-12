# Settings 01 (`settings-01`)

Grouped settings list with nested pages, toggles, an account sheet and a
sign-out confirm dialog. Mobile-first; centres at desktop widths.

## Files

- `flow.dart` — `Settings01Flow` (owns the nested `Navigator`).
- `screens/home_screen.dart`, `screens/detail_screens.dart`,
  `screens/account_sheet.dart`

## Install

```sh
dashcn add flow:settings-01
```

```dart
import 'package:<your_app>/ui/dashcn/flows/settings-01/flow.dart';

Settings01Flow(
  userName: 'Ada Lovelace',
  userEmail: 'ada@example.com',
  onNotificationsChanged: (value) => save(value),
  onSignOut: signOut,
)
```

## Declared dependencies

| Layer | Units |
|---|---|
| `foundation` | `gap` |
| `theme` | `theme` |
| `components` | `alert_dialog`, `avatar`, `button`, `card`, `drawer_container`, `page_route`, `pinned_sheet`, `switch` |

## Notes

The flow takes profile data + callbacks in; it stores nothing. `/` home,
`/notifications`, `/appearance`; the account panel is a `PinnedSheet` over
home and sign-out confirms through an alert dialog.
