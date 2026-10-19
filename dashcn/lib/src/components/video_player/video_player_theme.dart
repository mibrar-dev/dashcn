// User-owned overrides for the `video_player` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `videoPlayerDefaults` and
// the global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise):
//
//   const VideoPlayerTheme videoPlayerThemeOverrides = VideoPlayerTheme(
//     accent: ThemedColor.ref(ColorRef.destructive),
//     controlSize: 64,
//   );

import 'video_player_style.dart';

/// Per-app overrides applied app-wide through `ComponentThemes`.
const VideoPlayerTheme videoPlayerThemeOverrides = VideoPlayerTheme();
