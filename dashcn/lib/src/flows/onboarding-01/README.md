# Onboarding 01 (`onboarding-01`)

Three swipeable intro pages (carousel + dot indicator) with Skip and
Next/Get started, ending in a notification permission ask. Mobile-first;
centres at desktop widths.

## Files

- `flow.dart` — `Onboarding01Flow` (owns the nested `Navigator`) and
  `Onboarding01Page` data.
- `screens/pages_screen.dart`, `screens/permission_screen.dart`

## Install

```sh
dashcn add flow:onboarding-01
```

```dart
import 'package:<your_app>/ui/dashcn/flows/onboarding-01/flow.dart';

Onboarding01Flow(
  onSkip: skip,
  onPermissionChanged: (granted) => requestPermission(granted),
  onFinished: finish,
)
```

## Declared dependencies

| Layer | Units |
|---|---|
| `foundation` | `gap`, `icons` |
| `theme` | `theme` |
| `components` | `button`, `card`, `carousel`, `dot_indicator`, `page_route` |

## Notes

The flow takes pages + callbacks in; there is no backend and no demo data in
the kit. `/` shows the pages, `/permission` the ask.
