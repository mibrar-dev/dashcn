# Chart

One widget for line, area, bar (grouped + stacked), donut/pie, sparkline
and scatter families, painted with pure `CustomPainter` on
`package:flutter/widgets.dart` only.

```dart
const Chart(data: [1, 2, 3]);

const Chart(
  type: ChartType.bar,
  series: [
    ChartSeries(label: 'Web', values: [4, 6, 5]),
    ChartSeries(label: 'Mobile', values: [3, 4, 6]),
  ],
);
```

## When to use

- A line or area trend with one list of doubles.
- Grouped or stacked bars via `barMode`.
- A donut or pie share from a single series.
- A sparkline (`ChartType.sparkline`) for tables and rows.
- Live data via `ChartController(maxPoints: 40)` and `append`.

## API

| Parameter | Default | Notes |
|---|---|---|
| `data` | null | single-series shorthand |
| `series` | `[]` | wins over `data` |
| `labels` | null | x category labels |
| `type` | `line` | line, area, bar, donut, pie, sparkline, scatter |
| `barMode` | `grouped` | grouped or stacked |
| `height` | 220 | plot height |
| `showGrid` / `showAxes` / `showTicks` / `showLabels` | true | every part can be hidden |
| `showLegend` / `showTooltip` | true | legend wraps, tooltip follows selection |
| `showMarkers` | false | line/scatter dots |
| `gridColor` / `axisColor` | border token | |
| `strokeWidth` / `markerRadius` | 2 / 3 | |
| `barRadius` / `barGap` / `barGroupGap` | 4 / 0.2 / 0.25 | |
| `fillOpacity` | 0.25 | area/bar fill |
| `contentPadding` | 8,8,12,8 | plot inset |
| `animationDuration` / `animationCurve` | 700ms / easeOutCubic | entrance + value tweens |
| `disableAnimation` | false | jumps to final state |
| `donutHole` | 0.55 | 0 is a pie |
| `xAxis` / `yAxis` | `ChartAxis()` | range, ticks, formatting; `ChartAxis.hidden` hides all |
| `maxPoints` | 0 | trailing window for static data |
| `controller` | null | streaming owner, `append` trims to `maxPoints` |
| `semanticsLabel` | summary | screen-reader label |
| `showDataTable` | false | textual fallback below the plot |
| `theme` | null | widget-leg `ChartTheme` |

`ChartSeries` carries per-series `label`, `values`, `color`, `gradient`,
`strokeWidth`, `dash` (`[6, 4]`), `showMarkers`, `markerRadius`,
`fillOpacity` and `barRadius`. The controller trims each series to the
trailing `maxPoints` entries.

Reduced motion (`MediaQuery.disableAnimations` or `Theme.motion.enabled`)
resolves durations to zero: entrance and value tweens settle immediately
with no tickers.

## Accessibility

Every chart reports a `Semantics` summary (`Line chart with 2 series,
6 points`) and optionally renders a text table (`showDataTable`). The
legend is a `Wrap` so 320 px viewports do not overflow.

## Theming

`ChartTheme` follows the standard four legs: widget `theme` argument >
nearest `ComponentTheme<ChartTheme>` > app `ComponentThemes` >
`chartDefaults`. Overrides are values only; see `chart_theme.dart`.
