# video_player

SPEC glass control bar over a 16:9 frame (radius ~18, 1px dark border). The
bar sits inset ~16px (radius ~14): title (white 14) + muted subtitle header
with elapsed/total right, thin progress with dot thumb, then play / back 10s
/ forward 10s left and volume / captions / fullscreen / more right. The more
menu holds speeds `0.5x-3x`, captions on/off and quality. A 64px translucent
centre button shows when paused; the bar auto-hides ~3s after activity while
playing. The kit is dependency-free; the docs app wires
`package:video_player` (`docs/lib/media/video_adapter.dart`).

## Getting started

```dart
final inner = VideoPlayerController.networkUrl(Uri.parse(demoVideoSources[0].uri!));
await inner.initialize();
final controller = PluginVideoAdapter(inner); // docs-only

VideoPlayer(
  controller: controller,
  title: 'For Bigger Blazes',
  subtitle: 'Season 3 episode 6',
  content: controller.buildView(),
  onFullscreenRequested: () => enterFullscreen(),
)
```

Without a controller the player owns an internal fake (uncontrolled mode
with `initialPosition` / `initialVolume` / `initialMuted` / `initialSpeed` /
`initialLooping` / `initialCaptionsEnabled`); a passed controller is never
disposed by the player. Live sources set `isLive` (LIVE badge, no total);
the camera entry renders its fallback message as `content`.

## Keyboard

`space` / `k` play-pause, `←` / `→` seek 10s (5s with `Shift`), `↑` / `↓`
volume, `m` mute, `f` fullscreen, `c` captions. The scrub bar adds arrows,
`Home` and `End`, with spoken valuetext.

## API

| Member | Type | Notes |
|---|---|---|
| `controller` | `VideoPlaybackController?` | Null owns a `FakeVideoPlaybackController`. |
| `title` / `subtitle` | `String?` | Bar header (`headerBuilder` overrides). |
| `poster` / `content` | `Widget?` | Still / video frame. `posterBuilder` overrides the frame area. |
| `captions` | `Widget?` | Caption overlay above the control bar. |
| `aspectRatio` | `double` | Frame ratio, `16 / 9`. |
| `showControls` | `bool` | Control bar visibility. |
| `controlsVisible` | `bool?` | Pins the bar (null = auto-hide); screenshot hatch. |
| `showFullscreenButton` | `bool` | Fullscreen button visibility. |
| `supportedSpeeds` | `List<double>` | More-menu entries, default `kVideoSpeeds`. |
| `onFullscreenRequested` | `VoidCallback?` | Button and `f` key. |
| `progressBuilder` | builder | Overrides the scrub bar (`VideoScrubBar defaults`). |
| `headerBuilder` / `timeLabelBuilder` | builder | Override header / time labels. |
| `volumeBuilder` | builder | Overrides the volume cluster. |
| `speedBuilder` / `moreBuilder` | builder | Override speed section / whole more menu. |
| `fullscreenButtonBuilder` | builder | Overrides the fullscreen button. |
| `controlsBuilder` | builder | Overrides the whole bar. |
| `loadingBuilder` | builder | Overrides the loading indicator. |
| `errorBuilder` | `Widget Function(BuildContext, Object)?` | Error overlay. |

## Theme

`VideoPlayerTheme` with four resolving legs (widget > tree > app >
`videoPlayerDefaults`). The control bar frosts through `surfaceColor` +
`GlassSurface`, so `ThemeData(surfaceOpacity/surfaceBlur)` applies; motion
uses theme tokens and honours reduced motion.

Customise per instance with `theme:`, app-wide in `video_player_theme.dart`.
