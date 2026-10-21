# Players overflow — preview 19px bottom overflow (PR 51)

Branch `feat/players-polish`, worktree `dashcn-w-audio`. Do NOT merge.

## Failure

`dashcn previews_test: audio_player neutral and claude, light and dark`:
`A RenderFlex overflowed by 19 pixels on the bottom`, example `Default`.

Reproduce (worktree root `dashcn-w-audio`, package `dashcn/`):

- `cd dashcn && flutter test test/registry/previews_test.dart --plain-name audio_player`
- Before fix: 4 failures (neutral/claude x light/dark), same 19px overflow.

The bottom-padding fix (`33a81dc91`, `_resolveBodyPadding` guaranteeing
16px density top/bottom for the expanded card) made the loose card
360x439 (405px column + 32px padding + border). The preview stage is a
tight 720x420 box (`_stageSize`), so the column only gets ~388px and the
fixed 144px disc overflows by 19px. Verified with a temporary
measurement test (since removed): loose `CARD size: Size(360.0, 439.0)`,
tight `CARD size: Size(720.0, 420.0)` with `HOST constraints:
BoxConstraints(w=720.0, h=420.0)` and disc `Size(144.0, 144.0)`.

`test/registry/previews_test.dart` untouched — expected 720x420 kept.

## Fix

`dashcn/lib/src/components/audio_player/audio_player_expanded.dart`
only (compact leg, transport, padding untouched):

- `AudioExpandedCard.build` now returns a `LayoutBuilder` (no `Expanded`,
  per preview contract) that picks a flexible disc diameter.
- Loose/unbounded/phone (`maxHeight` infinite or >= 424): `discSize = 144`
  — full circle, rotating via `_RotatingDisc` (20s/turn), existing
  `144px disc` and `56px play` contracts hold.
- Tight preview (`maxHeight` ~388): `discSize =
  (maxHeight - 280).clamp(96, 144)` → ~108px in the 720x420 stage.
  Reserve 280 covers the rest of the column (~261 measured) plus margin
  across densities; min 96 keeps the disc legible. Width clamp guards
  narrow stages.
- `_disc(context, discSize)` / `_tappableDisc(context, disc, discSize)`
  use `discSize` for the `SizedBox`, the circular `Container`, and the
  `FocusableTap` mins. Custom `coverBuilder` path uses the same min.
  Disc stays a full `ClipOval` circle, centred, rotating; transport row
  (56px play) unchanged and fully inside the card with the 16px bottom
  padding below it.

## Gates

Run one at a time, in order:

- `cd dashcn && flutter test test/registry/previews_test.dart --plain-name audio_player`: 6/6 passed (was 2 pass + 4 fail).
- `cd dashcn && flutter test test/registry/components/audio_player_test.dart`: 28/28 passed, including `expanded disc sits fully inside the card` (144px loose), `expanded big play button defaults to 56px`, `375px phone width has no overflow`.
- `cd dashcn && dart format lib/src/components/audio_player/audio_player_expanded.dart`: clean (1 file).
- `cd dashcn && dart analyze`: No issues found.

No browser used (flutter-test only; no audio played, nothing to close).
