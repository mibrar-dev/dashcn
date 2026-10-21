# audio_player

SPEC compact pill and expanded playlist card sharing one dependency-free
controller. The UI drives a small `AudioPlaybackController` interface (play,
pause, seek, volume, mute, speed, playlist, shuffle, looping); the docs app
wires `just_audio` to it (`docs/lib/media/audio_adapter.dart`) and the kit
ships `FakeAudioPlaybackController` for previews and tests.

The compact pill is a ~48px pill (radius 14, bottom-edge progress): icon-only
play, elapsed/total, truncated title, volume icon with hover/focus slider,
speed number cycling `1x, 1.25x, 1.5x, 2x, 3x`, download. The expanded card is
a ~360px portrait (radius 20): half-circle cover, equaliser glyph, uppercase
artist, large centred title, full-width progress with centred mono times, and
shuffle / previous / 56px black play / next / repeat wired to the playlist.

## Getting started

```dart
final controller = FakeAudioPlaybackController(tracks: demoAudioTracks);

// Compact pill (default):
AudioPlayer(controller: controller, onDownload: () {})

// Expanded card:
AudioPlayer(
  controller: controller,
  variant: AudioPlayerVariant.full,
  cover: Image.network(demoAudioTracks.first.coverUrl!),
)
```

Without a controller the player owns an internal fake (uncontrolled mode
with `initialPosition` / `initialVolume` / `initialMuted` / `initialSpeed` /
`initialLooping`); a passed controller is never disposed by the player.
`next()` / `previous()` move through `tracks`; `toggleShuffle()` shuffles;
live URLs, downloaded files and live streams all flow through the same
`play` / `seekTo` / `setPlaybackSpeed` surface.

## Keyboard

`space` / `k` play-pause, `←` / `→` seek 5s, `j` / `l` skip back/forward,
`m` mute. The progress bar adds arrows, `Home` and `End`.

## API

| Member | Type | Notes |
|---|---|---|
| `controller` | `AudioPlaybackController?` | Null owns a `FakeAudioPlaybackController`. |
| `variant` | `AudioPlayerVariant` | `compact` pill (default) or `full` card. |
| `title` / `subtitle` | `String?` | Fallbacks when the controller has no track. |
| `cover` | `Widget?` | Half-circle art (`coverBuilder` overrides). |
| `supportedSpeeds` | `List<double>` | Cycled by the pill chip, default `kAudioSpeeds`. |
| `onDownload` | `VoidCallback?` | Compact download tap (`downloadBuilder` overrides). |
| `waveformBuilder` | builder | Replaces progress / equaliser. |
| `progressBuilder` | builder | Overrides the progress bar. |
| `controlsBuilder` | builder | Overrides the transport row. |
| `playButtonBuilder` | builder | Overrides the play button. |
| `previousBuilder` / `nextBuilder` | builder | Override track buttons. |
| `shuffleBuilder` / `repeatBuilder` | builder | Override toggle buttons. |
| `volumeBuilder` / `speedBuilder` | builder | Override volume / speed. |
| `loadingBuilder` | builder | Overrides the buffering indicator. |

## Theme

`AudioPlayerTheme` with four resolving legs (widget > tree > app >
`audioPlayerDefaults`). Surfaces frost through `surfaceColor` +
`GlassSurface`, so `ThemeData(surfaceOpacity/surfaceBlur)` applies; motion
uses theme tokens and honours reduced motion.

Customise per instance with `theme:`, app-wide in `audio_player_theme.dart`.
