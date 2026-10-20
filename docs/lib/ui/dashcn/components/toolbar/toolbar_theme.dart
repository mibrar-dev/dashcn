// User-owned overrides for the `toolbar` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `toolbarDefaults` and the
// global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise the items):
//
//   const ToolbarTheme toolbarThemeOverrides = ToolbarTheme(
//     item: ToolbarStyle(
//       itemBackground: StateValue(
//         rest: ThemedColor.ref(ColorRef.accent, alpha: 0.12),
//         hovered: ThemedColor.ref(ColorRef.accent, alpha: 0.2),
//         pressed: ThemedColor.ref(ColorRef.accent, alpha: 0.2),
//       ),
//     ),
//   );

import 'toolbar_style.dart';

/// App-wide overrides for the toolbar.
const ToolbarTheme toolbarThemeOverrides = ToolbarTheme();
