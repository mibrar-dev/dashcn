// User-owned overrides for the `sidebar` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `sidebarDefaults` and the
// global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise the rail):
//
//   const SidebarTheme sidebarThemeOverrides = SidebarTheme(
//     expandedWidth: 264,
//     activeBackground: ThemedColor.ref(ColorRef.primary, alpha: 0.12),
//   );

import 'sidebar_style.dart';

/// Sidebar overrides applied app-wide through `ComponentThemes`.
const SidebarTheme sidebarThemeOverrides = SidebarTheme();
