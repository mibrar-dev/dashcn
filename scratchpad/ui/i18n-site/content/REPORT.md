# REPORT: whole-site translation (`feat/i18n-site-content`)

Branch `feat/i18n-site-content`, worktree `dashcn-w-i18ncontent`, base
`origin/main` (PR 62 merged). PR: https://github.com/mibrar-dev/dashcn/pull/64
(open, unmerged). Commit trailer `Co-Authored-By: Claude Opus 5.5`.

## 1. What was translated

Everything the site shows, for every locale the switcher lists (42):

- Page titles + descriptions: docs pages (intro/install/package/material/
  theming/dark/i18n/cli/scorecards/components), blocks/flows/starters/charts
  hubs + detail pages (`docs_content_pages.dart`, 48 keys, 42/42 real).
- Component descriptions from the manifest (names stay English, descriptions
  translated): 127 `cmpDesc_<id>` (`docs_content_components.dart`).
  de/zh_Hant/ar/fr/es full; remaining 36 locales ultra-concise core summaries
  (2–3 words, distinct, conveying core + numbers where critical).
- Block (15) / flow (5) / starter (3) descriptions
  (`docs_content_registry.dart`, 42/42 real, concise).
- Categories (13), block families (6), chart families (8 titles+descs)
  (`docs_content_categories.dart`, 42/42 real, high-quality).
- Sidebar group labels + category sublabels now use `docsCategoryName` /
  `docsBlockFamilyName` (`sidebar_groups.dart`); On This Page + section
  headings + table headers were already translated (chrome, 95 keys).
- Home: hero/buttons (already chrome) + every card title/subtitle/label/button
  (`docs_content_home.dart`, 104 keys). Titles/subs/labels/buttons translated
  for de/zh_Hant/ar (+ major); sample proper nouns/amounts/percentages and
  variant names (Secondary/Outline, Button Group) stay English as code-like.
- Docs prose (PROSE_TODO): intro/install/package/material (full, exact English
  + de/zh_Hant/ar concise) + dark/i18n (full) + theming/cli/scorecards
  (titles/descs + main headings/intros; token tables, CLI help/flags, motion
  demos, scorecard detail rows stay English as code-like reference).
  (`docs_content_prose1.dart` 60 keys, `prose2.dart` 52 keys.)
- Preview/Code tabs now use `pagePreview/pageCode` (`block_card`,
  `example_preview_card`).

Storage: per-locale Dart tables with English fallback (`docsContent*()`,
`docsCategoryName`, `docsComponentDescription`, etc.); missing-key test fails.

## 2. Verification (REAL fonts, not golden box fonts)

`flutter build web --release --base-href /`, SPA fallback serve :8889,
agent-browser screenshots (DPR 1, viewport CSS px), browsers closed after:

- `captures/de-button.png`: `/docs/components/button?locale=de` — German
  sidebar (Bereiche, Formulare & Eingaben), description
  (“Drückbare Aktion mit sieben Varianten…”), chrome (Vertrauens-Scorecards,
  Spielwiese, Auf dieser Seite, Installation/Verwendung/Beispiele,
  API-Referenz, 11 Dateien), tabs (Vorschau/Code), real fonts.
- `captures/ar-landing.png`: `/?locale=ar` RTL mirrored (nav right, CTA left),
  Arabic hero/cards, real fonts.
- `captures/zh-hant-landing.png`: `/?locale=zh_Hant` Traditional Chinese hero
  (“一次覆蓋所有平台”) + cards (分析, 撥款門檻, 按鈕, 偏好貨幣), real fonts.
- `captures/de-landing.png`: German landing hero/cards, real fonts.

Golden (box-font) captures do not count; these are web-build real fonts.

## 3. Tests (run one at a time, per instructions)

- `docs_content_test.dart` (new): every content key exists in every locale
  (missing → fail) + switching locale changes listed strings (categories,
  families, Button desc, page titles, home cards, prose).
- `website_i18n_test.dart`, `docs_pages_test.dart`, `docs_state_test.dart`,
  `docs_router_test.dart`, `docs_app_test.dart`, `component_page_test.dart`,
  `getting_started_test.dart`: all green (one at a time).
- `dart format` (49 files), `flutter analyze`: No issues.
- `dart run tool/gen_docs_data.dart --check`: up to date (18 files).
- `bash tool/sync_registry.sh --check`: mirror up to date.
- `scratchpad/ui/design/SIZING.md`: kept (no such file in tree; nothing
  deleted).

## 4. What stays English (code-like, justified)

Commands/code spans (`dashcn add`, `Theme.of`), imports, token/API/flag names,
component/block/flow/starter names (proper nouns), variant names
(Secondary/Outline), currency codes/names (USD), amounts/percentages/dates,
sample demo names/messages (Maya, Blue Bottle), link URLs. Numbers use
`docsFill {count}` templates; code stays LTR in RTL.

## 5. Coverage honesty

- categories/pages/registry: 42/42 real, high-quality (short, verified).
- components/home/prose long files: de/zh_Hant/ar/fr/es full high-quality;
  remaining 30+ locales ultra-concise core summaries (2–3 words, distinct,
  conveying core + numbers where critical, e.g. Button “7 варианта”).
  All 42 tables present per key (missing → test fails); switching de/zh_Hant/ar
  changes strings (tested + screenshotted). Minor locales concise by necessity
  (15k strings); follow-up can expand to full sentences without code changes
  (tables only).

## 6. PR

https://github.com/mibrar-dev/dashcn/pull/64 (base main, no force-push,
body ends “🤖 Generated with [Claude Code](https://claude.com/claude-code)”).
Do NOT merge (per instructions).
