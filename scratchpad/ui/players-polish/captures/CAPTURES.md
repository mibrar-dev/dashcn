# players-polish captures

Harness: `dashcn/test/registry/visual/players_polish_captures_test.dart`
(device pixel ratio 2, Geist + Lucide fonts). 20 PNGs: 7 scenes x light/dark
(audio scenes at both viewports; video desktop at 1280x800, video phone at
375x812). Playing video scenes pin `controlsVisible` so the bar stays in
frame (the live player auto-hides after 3 s while playing).

## Audio compact pill (draggable seek, 32 px targets)

- `audio_compact_1280x800_light.png` — pill with play, elapsed/total, title,
  volume, speed, download; bottom-edge seek line.
- `audio_compact_1280x800_dark.png`
- `audio_compact_375x812_light.png` — no overflow at phone width.
- `audio_compact_375x812_dark.png`

## Audio expanded card (full 144 px disc, 16 px card, 12 px gaps)

- `audio_expanded_1280x800_light.png` — full disc centred fully inside the
  card (no half-circle crop), equaliser, artist, title, progress, times,
  5-button transport.
- `audio_expanded_1280x800_dark.png`
- `audio_expanded_375x812_light.png`
- `audio_expanded_375x812_dark.png`

## Audio details panel (tap disc)

- `audio_details_1280x800_light.png` — panel on top of the card: title,
  artist, album, duration, track position (`1 / 3`), dismiss control.
- `audio_details_1280x800_dark.png`
- `audio_details_375x812_light.png`
- `audio_details_375x812_dark.png`

## Video desktop 1280x800 (glass bar, centre play, speed menu)

- `video_desktop_paused_1280x800_light.png` — header, scrub, 10 s skips,
  volume, captions, fullscreen, more menu; centre 64 px play button.
- `video_desktop_paused_1280x800_dark.png`
- `video_desktop_playing_1280x800_light.png` — bar pinned for the capture.
- `video_desktop_playing_1280x800_dark.png`

## Video phone 375x812 (minimal thin bar, title until tap)

- `video_phone_paused_375x812_light.png` — single thin bar: play, draggable
  scrub, time, fullscreen; title overlay (hidden until tap in the live
  player).
- `video_phone_paused_375x812_dark.png`
- `video_phone_playing_375x812_light.png`
- `video_phone_playing_375x812_dark.png`

## Real-source playback (docs app + headless check)

- Docs app already plays the three SPEC sources (`docs/lib/media/live_video.dart`,
  `docs/lib/media/live_audio.dart`): online MP4, live HLS stream, live camera
  with a permission-denied fallback message.
- Headless check (agent-browser, file-URL page, browser closed afterwards):
  MP4 `https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4`
  loads (`readyState 4`, `duration 7.54`), `play()` unpauses
  (`paused=false`) and `currentTime` advances 1.00 -> 4.29 in 3 s.
  HLS `https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8` is reachable
  (`networkState 2`, `canPlayType "maybe"`); Chrome shows the plugin error
  path the docs app surfaces. Camera shows the docs fallback message when
  permission is denied (docs-side `webRequestCamera`).
