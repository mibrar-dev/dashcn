# audio_player

Dependency-free audio chrome with compact and full layouts. The UI drives a
small `AudioPlaybackController` interface (play, pause, seek, volume, mute,
speed, looping); the docs app shows how to wire an audio plugin to it and the
kit ships `FakeAudioPlaybackController` for previews and tests.

## Getting started

```dart
final controller = FakeAudioPlaybackController(
  duration: const Duration(minutes: 4, seconds: 5),
);

AudioPlayer(
  controller: controller,
  title: 'Midnight drive',
  subtitle: 'Neon Coastline',
)

// Compact row:
AudioPlayer(
  controller: controller,
  variant: AudioPlayerVariant.compact,
  title: 'Compact episode',
)
```

Without a controller the player owns an internal fake (uncontrolled mode
with `initialPosition` / `initialVolume` / `initialMuted` / `initialSpeed` /
`initialLooping`); a passed controller is never disposed by the player.

## Keyboard

`space` / `k` play-pause, `←` / `→` seek 5s, `j` / `l` skip back/forward,
`m` mute. The progress bar adds arrows, `Home` and `End`.

## API

| Member | Type | Notes |
|---|---|---|
| `controller` | `AudioPlaybackController?` | Null owns a `FakeAudioPlaybackController`. |
| `variant` | `AudioPlayerVariant` | `compact` row or `full` card. |
| `title` / `subtitle` | `String?` | Track labels (`titleBuilder` / `subtitleBuilder` override). |
| `cover` | `Widget?` | Cover art (`coverBuilder` overrides). |
| `skipBack` / `skipForward` | `Duration` | Transport steps, 10s each. |
| `waveformBuilder` | builder | Replaces the progress bar with a waveform. |
| `progressBuilder` | builder | Overrides the progress bar. |
| `controlsBuilder` | builder | Overrides the transport row. |
| `playButtonBuilder` | builder | Overrides the play button. |
| `volumeBuilder` / `speedBuilder` | builder | Override volume / speed. |
| `loadingBuilder` | builder | Overrides the buffering indicator. |

## Theme

`AudioPlayerTheme` with four resolving legs (widget > tree > app >
`audioPlayerDefaults`). The card frosts through `surfaceColor` +
`GlassSurface`, so `ThemeData(surfaceOpacity/surfaceBlur)` applies.

Customise per instance with `theme:`, app-wide in `audio_player_theme.dart`.
