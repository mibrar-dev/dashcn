# Segmented Control

A row of mutually exclusive (or multi-selectable) choices with a sliding
thumb. It selects a value; it does not own content.

## When to use

- A small set of two to five options shown side by side (Day / Week / Month).
- A view switch (list / grid) where the choice is visible at all times.
- A multi-select filter row.

Use `Tabs` for navigation (the tab strip owns content), `Toggle` for a
standalone on/off button, `RadioGroup` for a list of options and `Toolbar` for
actions.

## Snippets

Single, controlled:

```dart
SegmentedControl<String>(
  value: range,
  onChanged: (String value) => setState(() => range = value),
  segments: const <SegmentedControlSegment<String>>[
    SegmentedControlSegment<String>(value: 'day', label: Text('Day')),
    SegmentedControlSegment<String>(value: 'week', label: Text('Week')),
  ],
);
```

Multiple, controlled:

```dart
SegmentedControl<String>(
  selection: SegmentedControlSelection.multiple,
  values: selected,
  onValuesChanged: (Set<String> values) => setState(() => selected = values),
  segments: segments,
);
```

Uncontrolled:

```dart
final controller = SegmentedControlController<String>(<String>{'day'});
SegmentedControl<String>(controller: controller, segments: segments);
```

## `SegmentedControl` API

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `segments` | `List<SegmentedControlSegment<T>>` | required | the choices |
| `selection` | `SegmentedControlSelection` | `single` | `single` / `multiple` |
| `value` | `T?` | null | the selected value (single, controlled) |
| `onChanged` | `ValueChanged<T>?` | null | reports the next value (single, controlled) |
| `values` | `Set<T>?` | null | the selected values (multiple, controlled) |
| `onValuesChanged` | `ValueChanged<Set<T>>?` | null | reports the next selection (multiple, controlled) |
| `controller` | `SegmentedControlController<T>?` | null | uncontrolled mode; exclusive with the controlled legs |
| `size` | `SegmentedControlSize` | `md` | 28 / 32 / 36 px tall |
| `expand` | `bool` | false | fill the width the control is given |
| `disabledValues` | `Set<T>` | empty | values that cannot be picked |
| `segmentBuilder` | `SegmentedControlSegmentBuilder<T>?` | null | builder slot for the segments' content |
| `style` / `theme` | `SegmentedControlStyle?` | null | widget legs for the whole control |

An uncontrolled single-select control starts with its first enabled segment
selected; an uncontrolled multiple-select control starts empty.

## `SegmentedControlSegment` API

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `value` | `T` | required | the value the segment stands for |
| `icon` | `Widget?` | null | the segment's icon |
| `label` | `Widget?` | null | the segment's label |
| `enabled` | `bool` | true | |
| `semanticLabel` | `String?` | null | accessible name; falls back to the label's text |
| `tooltip` | `String?` | null | hover label |

## The thumb

In single-selection mode one thumb slides between the segments. In
multiple-selection mode every selected segment gets its own thumb. The slide
uses the theme motion tokens (the `fast` duration and the `spring` curve) and
collapses to zero under reduced motion.

## Touch targets

The painted track always measures the resolved height (the size table, or the
`height` a style or theme overrides). On touch platforms the control's *box*
grows to the platform minimum (48 px on Android, 44 px on iOS) so every
segment stays a full-size tap target; the growth is transparent space around
the track, never a change of the painted control. Apps that prefer tight
layouts can opt out with `ThemeData(touchTargets: TouchTargets.shrinkWrap)`.

## Keyboard

- `Tab` moves into the control.
- The arrow keys walk the segments and pick them, like a radio group. The
  horizontal map is mirrored in RTL.
- `Enter` and `Space` pick the focused segment.

## Theme resolution

`widget (style/theme) > ComponentTheme<SegmentedControlTheme> in tree > app
overrides (segmented_control_theme.dart) > segmentedControlDefaults`, merged
per field and state.

| `SegmentedControlTheme` field | Default |
|---|---|
| `control` | `muted@0.6` track, `background` thumb with a 1 px `border` |
| `segment` | `mutedForeground` at rest, `foreground` when selected |
| `borderRadius` | 8 |
| `padding` | 3 |
| `segmentPadding` | 8 horizontal |
| `textStyle` | 13 / w500 |

## Getting started

1. Install the component (`dashcn add segmented_control`) or copy the folder.
2. Import `segmented_control.dart`; it re-exports the segments, the
   controller, `SegmentedControlStyle`, `SegmentedControlTheme` and
   `segmentedControlDefaults`.
3. App-wide overrides live in the user-owned `segmented_control_theme.dart`.
