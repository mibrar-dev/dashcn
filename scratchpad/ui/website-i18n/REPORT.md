# REPORT: website i18n header (`feat/website-i18n-header`)

## 1. Header rebuilt on the kit navigation bar

- `docs/lib/widgets/docs_header.dart`: `DocsHeader` no longer paints with a
  hand-rolled `surfaceColor` + `GlassSurface` + `Container`. It returns a
  fixed-height `SizedBox` wrapping the kit `NavigationBar`
  (`container: bar`, docs bar padding, spacing 0) with a single inert
  `_DocsBarContents implements NavigationBarItem` (`selectable: false`, so the
  bar's roving index ignores it) that keeps the exact Row: focus anchor, nav
  buttons, search trigger (192/160/256), GitHub, theme toggle, locale
  switcher, CTA. `backgroundColor: null` resolves the background token with
  ambient `surfaceOpacity`/`surfaceBlur` — future glass-theme changes arrive
  via the kit.
- `docs/lib/widgets/docs_shell.dart`: the header floats over the navigator
  (`Stack`: `Positioned.fill(navigator)` + top-positioned header) so scrolled
  page content passes behind the frosted bar; pages carry a matching top
  inset (`docs_article` +16/0, sidebar +10, TOC +33, landing/index/blocks/
  flows/starters/charts scrolls, themes column, placeholder, playground
  panel). TOC jump (`_scrollTo`) stops below the bar (scroll-margin-top).
- Bar fits every width in the test font (init 57 px overflow at 1440, then
  29 px, 33 px at 1600, 5 px fixed by: switcher = 32 px icon-only trigger,
  GitHub label ≥1600, code label dropped). `responsive_test` exact article
  geometry (320/112 @1280, 336/112 @1024, 24/80 @375) preserved.
- Readability: text keeps foreground/muted tokens on the background token
  (4.5:1 at opaque); with 0.6 opacity the blur keeps scrolled content from
  breaking legibility (see captures).

## 2. Language switcher in the header

- `DocsLocaleSwitcher` (`docs_header.dart`): globe trigger with tooltip
  `Language: <native>`; popup lists **every**
  `ComponentLocalizations.supportedLocales` entry (42, never hard-coded)
  with `docsLocaleNativeName`.
- `DocsState.setLocale/applyLocaleQuery` (`docs_state.dart`): switches the
  whole site immediately on the same page (navigator pages rebuild via
  `ListenableBuilder` in `buildNavigator`; `const` page widgets
  de-consted so updates aren't skipped), persists to `docs.locale`
  localStorage **and** `?locale=` (reported URL, restored on load/back),
  storage wrapped in try/catch. `DashcnApp(locale: state.locale)` flips
  `Directionality` for RTL (ar/he/fa/ur/ps).
- `docs/lib/state/docs_strings.dart`: `docsLocaleTag/FromTag`,
  `kDocsLocaleNativeNames` (42), 95 chrome keys, `docsChrome` with English
  fallback, `docsFill` for `{count}`/`{command}` templates, `docsFileCount`.

## 3. Translated keys per locale

95 keys × 42 locales = 3990 strings, every key present in every table
(verified by script + `website_i18n_test`): header/nav/sidebar/groups/docs
sections/footer/search/article/component/usage/install/scorecard/
playground/placeholder/table-headers/landing/file-count/customize/back-view
buttons. Coverage: en de ar fr es it pt pt_BR nl ja ko zh zh_Hans zh_Hant
vi ru uk bg pl cs sk ro el hu da sv nb fi tr fa ur he ps id ms hi bn mr ta
te fil th — 95/95 each.

## 4. What stays English

Prose + generated data + demo sample content — full list in
`scratchpad/ui/website-i18n/PROSE_TODO.md` (article paragraphs for all 10
prose pages, registry descriptions/snippets/API docs, sidebar proper nouns,
palette entries, Theme Studio rail/dialogs, scorecard detail rows, landing
collage and marketing subtitles).

## 5. Captures

`scratchpad/ui/website-i18n/captures/` + `CAPTURES.md`: 8 shots,
`/docs/components/button` scrolled ~900 px under a 0.6/12-blur header —
de/ar × light/dark × 1280x800/375x812. RTL mirrors (nav/sidebar right, TOC
left); code stays LTR.

## 6. Gates

- `dart format --output=none --set-exit-if-changed lib test tool` (docs): clean
- `flutter analyze` (docs): No issues found
- `flutter test` (docs, per-file; kit untouched so no registry tests affected):
  website_i18n, docs_state, docs_app, docs_router, docs_pages, focus,
  responsive, palette, component_page, component_examples,
  component_preview_f4, component_members, getting_started, themes_page,
  p7th1 x2, p6_p1, p7h1, hero_count, home_collage, home_dialog_actions,
  initial_route, file_count_label, code_figure, code_teaser, motion,
  media_live, preview_canvas, view_focus, page_title, rail_popups,
  surface_rail, surface_picker_close, theme_rail_ux, theming_page,
  theme_export, theme_dart_source, theme_interop, theme_intensity,
  theme_motion, ts1 x6, studio_canvas, theme_switch, audit, device_frame,
  flows, p8_4, p9z, starters, blocks_pages, charts_pages, scorecard,
  playground, support — all green
- `dart run tool/check_names.dart` (dashcn): 0 hits
- `dart run tool/gen_docs_data.dart --check`: up to date (18 files)
- `bash tool/sync_registry.sh --check`: mirror is up to date
- `flutter build web --release --base-href /`: ✓ Built build/web

## 7. PR

https://github.com/mibrar-dev/dashcn/pull/57 (open, unmerged; branch
`feat/website-i18n-header`, pushed with no force-push).
