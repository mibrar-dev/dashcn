# video_player

Dependency-free video chrome: the UI drives a small `VideoPlaybackController`
interface (play, pause, seek, position, duration, buffered, volume, mute,
speed, looping). The docs app shows how to wire `package:video_player` to it;
the kit ships `FakeVideoPlaybackController` for previews and tests.

## Getting started

```dart
final controller = FakeVideoPlaybackController(
  duration: const Duration(minutes: 3, seconds: 42),
);

VideoPlayer(
  controller: controller,
  content: ColoredBox(color: Color(0xFF27272A)),
  captions: const Text('Hello, world'),
  onFullscreenRequested: () => enterFullscreen(),
)
```

Without a controller the player owns an internal fake (uncontrolled mode
with `initialPosition` / `initialVolume` / `initialMuted` / `initialSpeed` /
`initialLooping`); a passed controller is never disposed by the player.

## Keyboard

`space` / `k` play-pause, `←` / `→` seek 5s, `m` mute, `f` fullscreen,
`l` loop. The scrub bar adds arrows, `Home` and `End`.

## API

| Member | Type | Notes |
|---|---|---|
| `controller` | `VideoPlaybackController?` | Null owns a `FakeVideoPlaybackController`. |
| `poster` / `content` | `Widget?` | Still / video frame. `posterBuilder` overrides the frame area. |
| `captions` | `Widget?` | Caption overlay above the control bar. |
| `aspectRatio` | `double` | Frame ratio, `16 / 9`. |
| `showControls` | `bool` | Control bar visibility. |
| `showFullscreenButton` | `bool` | Fullscreen button visibility. |
| `supportedSpeeds` | `List<double>` | Speed menu entries. |
| `onFullscreenRequested` | `VoidCallback?` | Button and `f` key. |
| `progressBuilder` | builder | Overrides the scrub bar (`VideoScrubBar defaults`). |
| `timeLabelBuilder` | builder | Overrides the time labels. |
| `volumeBuilder` | builder | Overrides the volume cluster. |
| `speedBuilder` | builder | Overrides the speed menu. |
| `fullscreenButtonBuilder` | builder | Overrides the fullscreen button. |
| `controlsBuilder` | builder | Overrides the whole bar. |
| `loadingBuilder` | builder | Overrides the loading indicator. |
| `errorBuilder` | `Widget Function(BuildContext, Object)?` | Error overlay. |

## Theme

`VideoPlayerTheme` with four resolving legs (widget > tree > app >
`videoPlayerDefaults`). The control bar frosts through `surfaceColor` +
`GlassSurface`, so `ThemeData(surfaceOpacity/surfaceBlur)` applies.

Customise per instance with `theme:`, app-wide in `video_player_theme.dart`.
