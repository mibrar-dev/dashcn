# Docs Script Font Captures

All captures taken with `agent-browser` (headless, muted) against the release web build served on port 8897 (`http://127.0.0.1:8897/?locale=<locale>#/`), after the font-fallback fix.

## Captures Index

| File | Locale / Script | Description | Status |
|------|-----------------|-------------|--------|
| `home_ar.png` | ar (Arabic) | Home page, header/hero/previews | Real glyphs via engine Noto fallback |
| `home_bg.png` | bg (Cyrillic) | Home page | Real glyphs |
| `home_bn.png` | bn (Bengali) | Home page | Real glyphs |
| `home_el.png` | el (Greek) | Home page | Real glyphs |
| `home_fa.png` | fa (Persian/Arabic) | Home page | Real glyphs |
| `home_he.png` | he (Hebrew) | Home page | Real glyphs |
| `home_hi.png` | hi (Devanagari) | Home page | Real glyphs |
| `home_ja.png` | ja (Japanese) | Home page | Real glyphs |
| `home_ko.png` | ko (Korean) | Home page | Real glyphs |
| `home_mr.png` | mr (Devanagari) | Home page | Real glyphs |
| `home_ps.png` | ps (Pashto/Arabic) | Home page | Real glyphs |
| `home_ru.png` | ru (Cyrillic) | Home page | Real glyphs |
| `home_ta.png` | ta (Tamil) | Home page | Real glyphs |
| `home_te.png` | te (Telugu) | Home page | Real glyphs |
| `home_th.png` | th (Thai) | Home page | Real glyphs |
| `home_uk.png` | uk (Cyrillic) | Home page | Real glyphs |
| `home_ur.png` | ur (Urdu/Arabic) | Home page | Real glyphs |
| `home_zh_Hans.png` | zh_Hans (CJK) | Home page | Real glyphs |
| `home_zh_Hant.png` | zh_Hant (CJK) | Home page | Real glyphs |

## Notes
- RTL locales (ar, fa, he, ps, ur) render with correct RTL layout and real glyphs.
- Latin-script locales (de, es, fr, etc.) already rendered correctly and are unchanged.
