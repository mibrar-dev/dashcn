# dashcn brand kit

An original round, Flutter-blue bird in the spirit of Flutter's Dash: light face, big eye, three-leaf crest, forked
tail. Its beak is a glowing **dash**, the "dash" in dashcn. This is our own artwork. It is not Google's Dash asset or
the Flutter logo, which are Google trademarks; don't swap those in.

Wordmark: Geist SemiBold (SIL OFL, `tool/Geist-OFL.txt`), outlined to paths. "dash" in ink/paper, "cn" in the
blue → cyan gradient.

| Token | Value |
|---|---|
| Ink (dark tile) | `#09090B` |
| Paper | `#FAFAFA` |
| Body gradient | `#47D4FF` → `#0562D2` |
| Wing | `#0B5BC9` → `#03398F` |
| Beak / accent | `#E9F8FF` → `#2EE6D6` |

## Files
- `svg/`: `mark-dark` (primary app/tile icon), `mark-light`, `mark-square-dark` (full-bleed; iOS/Apple touch),
  `mark-maskable` (PWA safe zone), `mark-macos`, `glyph` (bird only), `glyph-mono` (`currentColor`, for one-colour
  use), `wordmark-on-dark|light`, `lockup-on-dark|light`, `og-image` (1200×630 social card).
- `png/`: mark 16–1024, light 512, maskable 192/512, apple-touch-icon 180, glyph 512, wordmark/lockup @2x, og-image.
- `ico/`: `favicon.ico` (16/32/48/64), `app_icon.ico` (Windows, 16–256).

## Regenerate
```
pip install fonttools pillow && npm i -g playwright
python3 brand/tool/build.py --apply   # --apply also writes the docs app's web/iOS/Android/macOS/Windows icons
```
Edit the bird once in `tool/build.py` (`bird()`). Every variant is derived from it.
