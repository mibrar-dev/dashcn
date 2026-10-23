# w-fonts capture set

Fix branch: `fix/docs-script-fonts`

Build: `cd docs && flutter build web --release --no-tree-shake-icons`
Serve: `python3 -m http.server 8897 --directory build/web`
Capture: agent-browser (headless, muted), 10 s wait per locale for engine
Noto fallback download + rebuild. Page captured: home (`/#/`) at
`?locale=<tag>`.

Screenshots (home page, header/hero/previews):

- home_ar.png — ar (Arabic)
- home_he.png — he (Hebrew)
- home_fa.png — fa (Persian)
- home_ur.png — ur (Urdu)
- home_ps.png — ps (Pashto)
- home_hi.png — hi (Hindi/Devanagari)
- home_mr.png — mr (Marathi/Devanagari)
- home_bn.png — bn (Bengali)
- home_ta.png — ta (Tamil)
- home_te.png — te (Telugu)
- home_th.png — th (Thai)
- home_ko.png — ko (Korean)
- home_ja.png — ja (Japanese)
- home_zh.png — zh (Chinese)
- home_zh_Hans.png — zh_Hans (Simplified Chinese)
- home_zh_Hant.png — zh_Hant (Traditional Chinese)
- home_ru.png — ru (Russian/Cyrillic)
- home_bg.png — bg (Bulgarian/Cyrillic)
- home_uk.png — uk (Ukrainian/Cyrillic)
- home_el.png — el (Greek)
- home_de.png — de (German/Latin baseline)

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
