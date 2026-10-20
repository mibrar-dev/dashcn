// User-owned overrides for the `fab` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `fabDefaults` and the
// global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise a shape):
//
//   const FabTheme fabThemeOverrides = FabTheme(
//     extended: FabStyle(
//       background: StateValue(
//         rest: ThemedColor.ref(ColorRef.accent),
//         hovered: ThemedColor.ref(ColorRef.accent, alpha: 0.9),
//         pressed: ThemedColor.ref(ColorRef.accent, alpha: 0.9),
//       ),
//     ),
//   );

import 'fab_style.dart';

/// App-wide overrides for the floating action button.
const FabTheme fabThemeOverrides = FabTheme();
