# P9-Z — Integration: component page, landing hero, search, locale crash, touch opt-out

Spec: `DASHCN_FEATURES_PLAN.md` §P9-Z (binding) and the integration notes at the end of the P9-1, P9-2b and P9-5b
reports in `$KIT/rearch/reports/`. You work in the MAIN kit worktree (`$KIT`, branch `refactor/dashcn`); no CLI
changes. Another agent (P9-6 starters) works in a secondary worktree on `lib/src/starters/**` + the CLI `create`
command: do not add a Starters page/nav entry (that follows after P9-6 merges) and do not touch `lib/src/starters/`.
You are the named batch allowed to edit `docs/lib/pages/component_page.dart`, `docs_nav.dart` and the landing page.

## 1. Component page = preview in frames + playground + scorecard
- Preview card stage → `FramedPreview(id: componentId, child: …)` (P9-1). Router: `state.applyFrameUri(uri)` on
  load and `state.frameUri(uri)` on report, so `?frame=` survives reload/back. Fold `?orientation=` into the frame
  param only if it is simpler; keep old links working.
- New "Playground" section: `PlaygroundPanel(componentId:, initialQuery:, onQueryChanged:)` wired through the router
  so `p.*` params survive reload/back (P9-2b note). Components without a builder show a quiet "Playground coming
  soon" note, not an empty box.
- `ScorecardCard(componentId:)` below the playground, above the API reference. Add both sections to the page's
  "On this page" TOC.
- Order on the page: header → preview (frames) → install → playground → scorecard → examples → API.
- Tests: router round-trip with `?frame=iphone&p.variant=outline`; page shows all three parts for `button`; a
  component without a builder shows the note; 390/900/1280 widths overflow-free.

## 2. Landing hero: "Every platform at once"
Replace/extend the landing hero with a live demo: the same flow (`auth-01`, docs demo data) running at once in the
iPhone, Android and desktop frames (reuse P9-1 "All" layout, scaled), with a short headline and two CTAs (Get
started, Browse flows). Narrow screens show one frame plus a device switcher. Respect reduced motion. Keep the
landing fast: frames are deferred-loaded like other heavy pages (check `main.dart` deferred patterns). Tests +
captures.

## 3. Search, nav and theme import discoverability
- Docs full-text search index (`docs_search.dart` generator) includes flows (title, summary, screens) and the new
  pages (package-or-own, material, scorecards, flows). Generator `--check` stays green; test that searching "otp"
  finds auth-01 and "contrast" finds the scorecards page.
- Nav: Theme Studio's import/export reachable from the Themes nav entry ("Import a web theme" item/link to the import
  panel). Verify every route in `kDocsSections` is reachable from nav or palette.

## 4. Locale crash
In a browser that reports no/odd locale (headless Chromium without `LANG`), the built site crashed with
`RangeError: Incorrect locale information provided`. Reproduce with the pre-installed Chromium (Playwright,
`executablePath: '/opt/pw-browsers/chromium'`; serve `docs/build/web` locally; launch with env `LANG` unset and
`--lang=` empty, and also `locale: 'C'`), find the call that throws (likely `Intl`/`DateFormat`/`NumberFormat`/
`Localizations` resolution with an unsupported or empty locale), and fix it so the app falls back to `en` — in the
kit if the kit resolves locales (localizations delegates), else in docs. Add a test (unit test of the locale
resolution with '', 'C', 'xx_YY', null) and record the before/after console output in the report.

## 5. Kit: touch-target opt-out + scorecard exemptions
- `TouchHitArea` (KIT-FIX-1) grows layout on phones; apps need an opt-out, like Material's `shrinkWrap`. Add a theme
  setting (e.g. `ThemeData.touchTargets` enum `padded` (default) | `shrinkWrap`, with copyWith/lerp/==/hashCode
  consistent with neighbouring fields) honoured by `TouchHitArea`; tests for both values on iOS/Android/macOS;
  document it on the Button README and the Material interop / theming docs page.
- Scorecards: let the harness record a documented exemption per check (`exempt: "<reason>"`) for `divider`
  (decorative, excluded from semantics), `menu` (disabled row — WCAG exempts disabled controls) and
  `refresh_trigger` (sampling artefact; or fix the measurement if you can make it measure the text). Exempt checks
  render as "Exempt" with the reason on the scorecard card/page, and do not count as failures. Regenerate.

## 6. Captures
`docs/test/p9z/capture_test.dart` → `rearch/screenshots/p9-z/`: component page (button, select) at 1280×900 and
390×844 light/dark, landing hero both widths light/dark, search results for "otp". `RepaintBoundary` must wrap the
background (see `test/p8_4/capture_test.dart`).

## Gates
Kit (`$APP`): `bash ../rearch/qa_gate.sh`, every generator `--check`, `dart run tool/check_names.dart` (0),
`dart format --set-exit-if-changed .`. Docs (`$DOCS`): `bash tool/sync_registry.sh && dart run
tool/gen_docs_data.dart`, both `--check`, `flutter analyze`, `flutter test test tool`, `dart format
--set-exit-if-changed .`, `flutter build web`. Do not commit; the orchestrator commits.

## Report
`$KIT/rearch/reports/P9-Z.md` (per section: what changed, tests, screenshots, the locale root cause with evidence,
open follow-ups) ending with `## RESULT` and `status: done` or `status: blocked`.
