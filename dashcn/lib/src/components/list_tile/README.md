# ListTile

A single-line to three-line list row with leading, title, subtitle and trailing slots.

Compact by default: row height, icon size, avatar size, padding and gaps all
resolve from the density tokens (`compact` 32/16/12/6, `comfortable` 40/20/14/8,
`touch` 48/24/16/12). The leading slot fits a density avatar (32 / 40 / 48)
with breathing room; dividers are hairlines and spacing comes from the scale.

## Usage

```dart
ListTile(
  leading: Icon(LucideIcons.user),
  title: Text('Title'),
  subtitle: Text('Subtitle'),
  trailing: Icon(LucideIcons.chevronRight),
  onTap: () {},
)
```

## Density

```dart
ListTile(
  densityTokens: DensityTokens.comfortable,
  leading: Avatar(initials: 'IB', size: 40),
  title: Text('Comfortable'),
  subtitle: Text('Row 40-44, icon 20'),
)
```

Icon size follows `tokens.iconSize`, title `tokens.bodyTextSize`, subtitle
`tokens.subtitleTextSize` (one step smaller, truncates), padding
`tokens.horizontalPadding`/`verticalPadding`, gap `tokens.gap`. Override per
instance via `densityTokens` or the theme leg `themeDensityTokens`, or per
field via `ListTileTheme` (`minLeadingWidth`, `horizontalTitleGap`,
`minVerticalPadding`, `padding`, colours, `dense`).

Grouped rows use `ListTileGroup`, which separates children with hairline
dividers from the border token.
