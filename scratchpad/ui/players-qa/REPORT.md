# Players QA — expanded audio card bottom padding

Branch `feat/players-polish`, worktree `dashcn-w-audio`. Do NOT merge.

## QA finding

Expanded audio card (`AudioPlayerVariant.full`) at 375x812 dark (and same at
1280x800 / light): the large round play/pause button sat on the bottom edge
of the card — touching the bottom border with no padding under it. The top
of the 144 px disc also touched the top border. Requirement: the controls
row sits inside the card with the bottom padding from the density tokens
(16 px compact) below the button, button fully inside, disc fully visible
and rotating.

Before (pre-fix `scratchpad/ui/players-polish/captures/audio_expanded_*`,
commit `d457e79ed`):
- `audio_expanded_375x812_dark.png`: white play disc overlaps the bottom
  card border; disc ring touches the top border.
- Same at 1280x800 and light: transport row paints on the card edge.

## Root cause

`dashcn/lib/src/components/audio_player/audio_player.dart`
`_resolveBodyPadding`: the expanded fallback `pxAll(16)` never applied
because `style.padding` is non-null — `audioPlayerDefaults.padding` is
`pxSymmetric(horizontal: 16)`. For `!compact` the function returned
`resolved` directly, i.e. horizontal-only with top/bottom = 0.

## Fix

`audio_player.dart` `_resolveBodyPadding` (expanded leg only):
- Resolve the 16 px density token (`EdgeInsetsDensity.pxAll(16)` vs
  `densityBase`) for vertical.
- Keep any explicit non-zero vertical from the theme; when `resolved.top`
  / `resolved.bottom <= 0`, substitute the token value.
- Return `EdgeInsets.only(left/right from theme, top/bottom guaranteed)`.
- Compact leg untouched (`EdgeInsets.only(left/right)` so the pill stays
  ~48 px). Disc / `_RotatingDisc` (20 s/turn) untouched — still fully
  visible and rotating.

## After

Re-captured `audio_expanded` at 375x812 and 1280x800, light and dark
(`flutter test test/registry/visual/players_polish_captures_test.dart
--plain-name "audio_expanded"`), then copied to
`scratchpad/ui/players-qa/captures/` (4 PNGs, dpr 2). Bottom edge checked
by reading each PNG:
- `scratchpad/ui/players-qa/captures/audio_expanded_375x812_dark.png`:
  play button fully inside, clear padding to the bottom border; disc fully
  inside with padding above.
- `audio_expanded_375x812_light.png`: same, black disc inside white card.
- `audio_expanded_1280x800_dark.png` / `audio_expanded_1280x800_light.png`:
  same — controls row inside card at desktop width.

`scratchpad/ui/players-polish/captures/audio_expanded_*` refreshed with the
same fixed PNGs.

## Gates

- `cd dashcn && flutter test test/registry/components/audio_player_test.dart`: 28/28.
- `dart format lib/src/components/audio_player/audio_player.dart`: clean (1 file).
- `dart analyze`: No issues found.
- Capture run `players_polish_captures_test.dart --plain-name "audio_expanded"`: 4/4.

No browser used (flutter-test captures only; no audio played).
