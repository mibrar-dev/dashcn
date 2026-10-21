# theme/ (layer 1)

Global tokens, ambient theme, and per-component theme resolution.
Widgets-only; no Material/Cupertino. No deprecated aliases or shims.

## Files

- `color_tokens.dart` — `ThemeColors` (32 tokens + brightness),
  `ColorRef`, `ThemedColor` (literal | ref + alpha multiply), `StateValue`.
- `tokens.dart` — `DesignTokens`, `ThemeFonts` (mode-independent),
  `SpacingScale`, `TrackingScale`, `ShadowScale` (+`derive`, `defaultShadowScale`).
- `theme.dart` — `ThemeData`, `Theme`, `AnimatedTheme`,
  `ComponentThemeData`, `ComponentTheme<T>`, `ComponentThemes` (app leg),
  `Mergeable`, `resolveComponentStyle`, `ThemeMode`.
- `typography.dart` — `Typography` (+`applyFonts`), `IconThemeProperties`.
- `density.dart` — `Density`, edge-insets helpers, `AdaptiveScaling`(+`AdaptiveScaler`).
- `density_tokens.dart` — `DensityTokens` (compact default, comfortable,
  touch), `DensityPreset`, spacing constants (`kSpace1..kSpace8`,
  `kSpacingScaleSteps`), icon resolvers (`resolveIconSize`,
  `buttonIconSize`), phone breakpoint (`kPhoneWidthBreakpoint`,
  `isPhoneWidth`) and `resolveDensityTokens`.
- `color_utils.dart` — `ColorShades`, `fromAHSL`, hex helpers, minimal `Colors`.

## Sizing and density (DESIGN.md)

Compact is the default everywhere: `ThemeData.densityTokens` defaults to
`DensityTokens.compact`, per-instance overrides default to null (inherit),
and every reference table below uses compact unless stated.

| preset      | control | icon | row       | hPad | vPad | gap | body | subtitle |
|-------------|---------|------|-----------|------|------|-----|------|----------|
| compact     | 32      | 16   | 32-36     | 12   | 6    | 8   | 14   | 13       |
| comfortable | 40      | 20   | 40-44     | 14   | 8    | 10  | 15   | 14       |
| touch       | 48      | 24   | 48-56     | 16   | 12   | 12  | 16   | 15       |

- Spacing scale: 4 px base (4, 8, 12, 16, 24, 32). No ad-hoc values.
- Icons: 16 / 20 / 24. Inside buttons never exceed 60% of the control
  height (`buttonIconSize`).
- Text: theme typography; subtitles one step smaller than titles; truncate
  with ellipsis, never grow the row.
- Overlays: min width 160 compact (180 comfortable, 200 touch), max 320
  compact (360 comfortable, 400 touch); item height = row height above.
- Phone widths (< 600) use touch automatically: `resolveDensityTokens`
  returns `DensityTokens.touch` unless the caller passes an explicit
  `override`. Users can override any token per instance or in the theme.

```dart
// Read the effective tokens (phone-aware) anywhere below Theme:
final DensityTokens tokens = resolveDensityTokens(context);
final double icon = resolveIconSize(tokens); // 16 / 20 / 24
final double capped = buttonIconSize(tokens); // <= control * 0.6

// Per theme:
Theme(data: const ThemeData(densityTokens: DensityTokens.comfortable), ...);

// Per instance (button + list_tile reference):
Button(densityTokens: DensityTokens.touch, ...);
ListTile(densityTokens: DensityTokens.comfortable, ...);

// Component theme leg:
const ButtonTheme(themeDensityTokens: DensityTokens.compact);
```

Reference components: `button` (`buttonMetricsForTokens`) and `list_tile`
(token-driven padding, gaps, type ramp, icon size) are the canonical
examples; other components keep their existing `Density`-scaled padding
until their own batches land.

## Tokens (32)

`background foreground card cardForeground popover popoverForeground`
`primary primaryForeground secondary secondaryForeground muted
mutedForeground accent accentForeground destructive destructiveForeground`
`border input ring chart1..5 sidebar sidebarForeground sidebarPrimary
sidebarPrimaryForeground sidebarAccent sidebarAccentForeground
sidebarBorder sidebarRing` (+ `brightness`; radius/spacing/tracking/shadows/fonts separate).

## Resolution order (per property, per state)

`widget arg > ComponentTheme<T> (tree) > ComponentThemes (user files at the
app root) > defaults`. Slices implement `Mergeable.merge` (receiver wins),
so a leg setting only `hovered` never wipes a lower leg's `rest`.
`ComponentTheme.maybeOf` is tree-only, never `ComponentThemes`.

## Component pattern

```dart
class ButtonVariantStyle implements Mergeable<ButtonVariantStyle> {
  const ButtonVariantStyle({this.background}); // + merge/forVariant…
  final StateValue<ThemedColor>? background;
  @override
  ButtonVariantStyle merge(ButtonVariantStyle? fallback) => …; // receiver wins
}
const buttonDefaults = ButtonTheme(primary: …); // refs only, registry-owned
const buttonThemeOverrides = ButtonTheme(primary: …); // user-owned file
// Generated once per app; DashcnApp puts it at the root:
const appComponentThemes = <ComponentThemeData>[buttonThemeOverrides];
final style = resolveComponentStyle<ButtonTheme, ButtonVariantStyle>(context,
  widget: widget.theme, select: (t) => t.forVariant(variant),
  defaults: buttonDefaults.forVariant(variant)!);
```
