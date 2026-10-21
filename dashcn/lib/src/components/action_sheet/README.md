# ActionSheet

A density-sized bottom sheet of actions with title and message, destructive
and cancel actions, icons, scrollable list, drag to dismiss, and a centered
dialog variant on wide screens.

Compact by default: row height, icon size, title/subtitle spacing and padding
all resolve from the density tokens. Phones (< 600 px) get a full-width
bottom sheet; wider screens get a centered dialog capped at the token overlay
max width (320 compact). The open animation is the underlying dialog/sheet
route and honours reduced motion.

## Usage

```dart
showActionSheet<void>(
  context: context,
  title: 'Actions',
  actions: [
    ActionSheetAction(label: 'Edit', onPressed: () {}),
  ],
  cancelAction: ActionSheetAction(label: 'Cancel'),
);
```

## Density

```dart
ActionSheet<void>(
  densityTokens: DensityTokens.comfortable,
  title: 'Comfortable',
  actions: const [ActionSheetAction(label: 'Edit')],
);
```

Row min-height, icon size, horizontal/vertical padding and title/message gaps
come from `DensityTokens` (`compact` 32/16/12/6, `comfortable` 40/20/14/8,
`touch` 48/24/16/12). Override per instance via `densityTokens` or the theme
leg `themeDensityTokens`, or per field via `ActionSheetTheme` (`rowMinHeight`,
`iconSize`, `titleSpacing`, `messageSpacing`, `maxWidth`, `padding`).

## Customization

Theme every visual token through `ActionSheetTheme` (colours, radii, padding,
sizes, typography, `surfaceOpacity`/`surfaceBlur`, `transitionDuration`) and
swap any visible part through builders: `titleBuilder`, `messageBuilder`,
`actionBuilder`, `dividerBuilder`, plus per-action `icon`/`trailing` slots.
The sheet fill uses the shared surface primitive (`surfaceColor` +
`GlassSurface`), rows are keyboard reachable via `Clickable` with button
semantics, RTL correct, and touch platforms grow the hit box to 48 px.
```

