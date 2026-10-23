# w-fonts capture set

Fix branch: `fix/docs-script-fonts`

Build: `cd docs && flutter build web --release --no-tree-shake-icons`
Serve: `python3 -m http.server 8897 --directory build/web`
Capture: agent-browser (headless), 10 s wait per locale for engine Noto fallback download + rebuild.

Screenshots are the docs home page (`/#/`) at `?locale=<tag>` for each
script-bearing locale (plus `de` as a Latin baseline):

- ar.png, he.png, fa.png, ur.png, ps.png — RTL scripts
- hi.png, mr.png, bn.png, ta.png, te.png, th.png — Indic / Thai
- ko.png, ja.png, zh.png, zh_Hans.png, zh_Hant.png — CJK
- ru.png, bg.png, uk.png, el.png — Cyrillic / Greek
- de.png — Latin baseline

Root cause: `Typography._withFamily` split CSS font specs like
`"GeistSans, sans-serif"` into a Flutter `fontFamily` plus a
`fontFamilyFallback` containing the generic CSS name `sans-serif`.
CanvasKit could not resolve that name and it masked the engine's Noto
fallback, so non-Latin glyphs stayed as tofu. The fallback list also only
carried `NotoSansSymbols2`, which has no script coverage.

Fix:
- Drop unresolvable generic CSS family names from `fontFamilyFallback`
  and merge with the base style's bundled fallback.
- Listen to `PaintingBinding.instance.systemFonts` in `DocsApp` and call
  `setState` when fallback fonts finish loading, forcing a rebuild so
  paragraphs are recreated with the newly registered Noto fonts (the
  CanvasKit paragraph cache otherwise keeps the old font list even after
  `markNeedsLayout`).

Verification: `flutter analyze` (docs) passes; `website_i18n_test.dart`
passes.
