// User-owned overrides for the `chart` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `chartDefaults` and the
// global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise the palette):
//
//   const ChartTheme chartThemeOverrides = ChartTheme(
//     strokeWidth: 2.5,
//     showMarkers: true,
//   );

import 'chart_style.dart';

/// Overrides applied app-wide through `ComponentThemes`.
const ChartTheme chartThemeOverrides = ChartTheme();
