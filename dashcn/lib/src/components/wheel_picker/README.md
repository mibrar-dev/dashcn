# wheel_picker

A scrolling wheel picker: one or more columns that snap to row boundaries,
with a centred selection band, an optional 3D cylinder look, optional infinite
looping, and a haptic-free selection callback.

Each column is a `ListWheelScrollView` with a `FixedExtentScrollController`,
so drag, mouse wheel and fling all snap to rows. Keyboard arrows move the
selection and switch columns; tapping a row selects it.

## Getting started

```dart
WheelPicker(
  columns: <WheelColumn>[
    WheelColumn(items: <String>['01', '02', '03']),
    WheelColumn(items: <String>['Jan', 'Feb', 'Mar']),
  ],
  onChanged: (indices) => print(indices),
)
```

A time picker with three columns:

```dart
WheelPicker(
  columns: <WheelColumn>[
    WheelColumn(items: hours),
    WheelColumn(items: minutes),
    WheelColumn(items: <String>['AM', 'PM']),
  ],
  value: _value,
  onChanged: (value) => setState(() => _value = value),
)
```

## API

| Member | Type | Notes |
|---|---|---|
| `columns` | `List<WheelColumn>` | Required. The wheel columns, left to right. |
| `value` | `List<int>?` | Controlled selection (one index per column). |
| `initialValue` | `List<int>?` | Uncontrolled initial selection. |
| `onChanged` | `ValueChanged<List<int>>?` | Reports the selected index of every column; never fires haptics. |
| `itemHeight` | `double?` | Row height; null = theme (48). |
| `visibleItems` | `int?` | Rows shown; null = theme (5). |
| `looping` | `bool` | Infinite loop instead of clamping. Default false. |
| `perspective` | `bool` | 3D cylinder instead of flat rows. Default false. |
| `enabled` | `bool?` | null = `onChanged != null`. |
| `focusNode` | `FocusNode?` | Keyboard control. |
| `semanticLabel` | `String?` | Accessible label for the picker. |
| `bandBuilder` | `WheelBandBuilder?` | Replaces the centred selection band. |
| `separatorBuilder` | `WheelSeparatorBuilder?` | Replaces the separator after a column. |
| `theme` | `WheelPickerTheme?` | Widget-leg theme override. |

`WheelColumn` carries `items` (the row labels), an optional `builder` for
custom row content, an optional fixed `width`, a `flex` share when width is
null, and a `semanticLabel`.

## Theme

`WheelPickerTheme` (see `wheel_picker_style.dart`) with four resolving legs —
widget argument > nearest `ComponentTheme<WheelPickerTheme>` > `ComponentThemes`
app entry > `wheelPickerDefaults`:

| Field | Default |
|---|---|
| `itemHeight` | 48 |
| `visibleItems` | 5 |
| `selectionColor` | `accent` at 12% alpha |
| `selectionBorderColor` | `border` token |
| `selectionBorderWidth` | 1 |
| `selectionBorderRadius` | `radiusMd` |
| `foreground` | `foreground` token |
| `mutedForeground` | `mutedForeground` token |
| `fontSize` | 16 |
| `fontWeight` | w600 |
| `fadeColor` | `background` token |
| `fadeHeight` | 32 |
| `perspective` | 0.003 (3D amount) |
| `diameterRatio` | 1.6 |
| `surfaceColor` | `background` token |
| `borderRadius` | `radiusLg` |
| `separatorColor` | `border` token |
| `separatorWidth` | 1 |

Customise app-wide in `wheel_picker_theme.dart` (values only, never overwritten
by a CLI update).

## Keyboard

| Key | Action |
|---|---|
| ArrowUp / ArrowDown | Move the selection in the active column |
| ArrowLeft / ArrowRight | Switch the active column |
| PageUp / PageDown | Page by the visible row count |
| Home / End | Jump to the first / last row |

## Notes

- The selection callback is haptic-free: it reports the selected index of every
  column and never fires `HapticFeedback`, so the caller decides when to give
  feedback.
- Looping repeats the items 10000 times and maps the controller index back
  with modulo, so the wheel never clamps.
- The 3D look reuses `ListWheelScrollView`'s `perspective`/`diameterRatio`;
  the flat default sets `perspective` to 0.
