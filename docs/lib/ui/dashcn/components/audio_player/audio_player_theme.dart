// User-owned overrides for the `audio_player` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `audioPlayerDefaults` and
// the global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise):
//
//   const AudioPlayerTheme audioPlayerThemeOverrides = AudioPlayerTheme(
//     accent: ThemedColor.ref(ColorRef.destructive),
//     controlSize: 56,
//   );

import 'audio_player_style.dart';

/// Per-app overrides applied app-wide through `ComponentThemes`.
const AudioPlayerTheme audioPlayerThemeOverrides = AudioPlayerTheme();
