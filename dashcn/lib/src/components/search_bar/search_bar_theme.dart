// User-owned overrides for the `search_bar` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `searchBarDefaults` and the
// global tokens, so an empty override keeps the exact token look.

import 'search_bar_style.dart';

/// Search bar overrides applied app-wide through `ComponentThemes`.
const SearchBarTheme searchBarThemeOverrides = SearchBarTheme();
