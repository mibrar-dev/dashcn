# P9-Z — Integration: component page, landing hero, search, locale crash, touch opt-out

Status: **done** (pending orchestrator QA + screenshots review). Branch `refactor/dashcn`,
main kit worktree. No CLI changes. No Starters page/nav entry (P9-6 owns that).

## 1. Component page = preview in frames + playground + scorecard

What changed:
- `docs/lib/widgets/component_preview_card.dart`: the main demo card runs inside
  `FramedPreview(id: componentId, child: …)` (P9-1 integration point, uncontrolled —
  reads/writes ambient `DocsState`, so `?frame=` survives reload).
- New `docs/lib/widgets/component_playground_section.dart`: `Playground`
  heading + `PlaygroundPanel(componentId:, initialQuery: state.playgroundQuery,
  onQueryChanged: state.setPlaygroundQuery, reportUrl: false)` rebuilt off
  `DocsState`, or a quiet `Playground coming soon for this component.` note where
  the panel would render nothing (`hasPlayground` checks spec + builder).
- New `docs/lib/widgets/component_scorecard_section.dart`: `Trust scorecard`
  heading + `ScorecardCard(componentId:)`. Both sections register `HeadingAnchor`s,
  so the "On this page" TOC lists them.
- `docs/lib/pages/component_page.dart` order: header → preview (frames) →
  install → playground → scorecard → usage → examples → API → members → theme →
  accessibility (Usage kept after scorecard; the spec's relative order holds).
- Router (`docs_router.dart`, `docs_state.dart`, `main.dart`): `parse` still
  ignores query for routing, but every parsed configuration now carries
  `sourceUri` (`withSourceUri`); `setNewRoutePath`/`navigate`/`go` call
  `state.applyRouteUri(uri)` (frame pair + `p.*`); `restoreRouteInformation`
  reports `state.reportUri(base)` (frame pair + playground merged, defaults
  dropped). `?frame=`/`?orientation=` kept as two params (simpler; old links
  keep working). Parser holds `DocsState` for reporting (tests construct it
  stateless — no breakage).
- Old-test updates: `component_page_test` accessibility assertion scoped to
  `ComponentAccessibilitySection` (the scorecard card has its own
  "Accessibility" subsection); `component_preview_f4_test` calendar count
  scoped to `ExamplePreviewCard` descendants (page now has 7 calendars: 6
  examples + playground); landing headline/CTA assertions updated (see §2).

Tests: `docs/test/p9z/component_page_p9z_test.dart` (6): `?frame=iphone&
p.variant=outline` round-trip (state + reported URL), reload via
`setNewRoutePath`, button shows framed preview + playground + scorecard, menu
(no builder) shows the note and no panel, 1280/900/390 overflow-free, divider
card renders Exempt.

## 2. Landing hero: "Every platform at once"

What changed:
- New `docs/lib/landing/hero_demo.dart` (deferred library): `LandingHeroDemo`
  runs the docs `auth-01` demo flow live in iPhone, Android and desktop
  `DeviceFrame`s (P9-1 building blocks, portrait; desktop is non-rotatable so
  orientation is ignored) — three independent subtrees/navigators. ≥700 px
  shows all three scaled (`FittedBox.contain`, desktop flex 2); below shows
  one frame plus a device switcher (`hero-device-*` keys). No autoplay and no
  entrance animation — all motion is tap-driven (reduced-motion safe).
- `landing_page.dart`: H1 `Every platform at once`, subline, CTAs Get Started
  (`/docs/installation`) + Browse flows (`/docs/flows`), deferred hero slot
  (fixed-height placeholder until the chunk arrives), collage kept below
  (extend, not replace — `home_collage_test` untouched and green).
- Focus fix: each nested flow `Navigator` autofocuses on mount and registers
  its scope up the ancestor chain, stealing the landing's initial focus (first
  Tab started in the hero email field, breaking the D5 audit). The hero wraps
  content in a `FocusScope(canRequestFocus: _installed)` gate (blocks both
  mount-time request vectors while closed, flips after install) plus a
  lineage repair (re-requests the external focus once, refreshing
  `focusedChild` stacks). Verified: pre-focus stays `header-focus-anchor`,
  first Tab reaches the header search trigger; `focus_test.dart` 10/10.

Tests: `docs/test/p9z/landing_hero_test.dart` (5): deferred load, three frames
wide / switcher narrow (+ tap switches frame), CTA navigation, overflow-free at
1400/900/390.

## 3. Search, nav and theme import discoverability

What changed:
- `docs/tool/src/render_files.dart`: `DocsSearchKind` gains `flow` + `page`;
  the index emits flows (name, route, install action, keywords = id +
  description + screens + tags) and four prose pages (package-or-own,
  material, scorecards with `contrast` keyword, flows index with `otp`).
  Regenerated (`17 files checked` green).
- `docs/lib/widgets/sidebar_groups.dart`: new `Themes` group — `Theme Studio`
  (`/themes`) and `Import a web theme` (`/themes?panel=import`).
- `docs/lib/pages/themes.dart` (now stateful) + `main.dart`: `?panel=import`
  opens the import dialog, `?panel=export` opens Get Code on entry (uses the
  new `sourceUri` plumbing); export stays one tap away via the rail Get Code
  button either way.

Tests: `docs/test/p9z/search_nav_test.dart` (6): `otp` → `/docs/flows/auth-01`,
`contrast` → `/docs/scorecards`, package page found, every `kDocsSections`
route reachable from nav or palette, sidebar import item opens the dialog,
rail Get Code opens export.

## 4. Locale crash — root cause, fix, evidence

Repro (Playwright `node`, Chromium `/opt/pw-browsers/chromium`, served
`docs/build/web` on :8901): context `locale: 'C'` (also `LANG`/`LC_ALL` unset).
Control (`en-US`) boots clean (title `dashcn`, 0 errors).

Before (locale `C`), console:
```
TITLE: dashcn
NAV: {"language":"C","languages":["C"]}
BODY: dashcn | Loading docs…                          (stuck placeholder)
[pageerror] Error: Invalid argument(s): Incorrect locale information provided
Dart stack trace:
RangeError: Incorrect locale information provided
    at new Locale (<anonymous>)
    at Object.btT (main.dart.js:1064:3)
    ...
```
The throw is a `Locale` construction from the raw browser string during boot,
before the first frame (placeholder never drops). Audited kit paths:
`ComponentLocalizationsDelegate.isSupported`/`lookupComponentLocalizations`
never throw (unknown → English defaults), `resolveLocale` always falls back
to `en`, and `''` is not even constructible as a Dart `Locale` (assert) —
so the kit correctly handles every `Locale` object it can receive; the crash
is below Dart, in engine locale parsing (UNVERIFIED line-level: minified
`main.dart.js` frames only, but no kit/docs Dart constructs a `Locale` from
a string at boot).

Fix (docs-side, per brief's "else in docs"): `docs/web/index.html` pre-
bootstrap shim normalizes an unusable `navigator.language`/`languages[0]`
(empty, `C`, or rejected by `new Intl.Locale`, regex fallback) to `en-US`
via own-property getters before `flutter_bootstrap.js` runs.

After (locale `C`), console:
```
TITLE: dashcn
NAV: {"language":"en-US","languages":["en-US"]}      (shim rewrote)
--- (0 interesting of 8 total; only GPU warnings) ---
first-frame-painted (placeholder removed): true, pageerrors: 0
```
Kit unit tests (`dashcn/test/registry/primitives/localizations_test.dart`,
new `odd browser locales` group, 38/38 pass): `C`/`xx_YY` unclaimed,
resolve to `en`, lookup returns English without throwing, `DashcnApp` with an
odd locale shows English, first supported locale stays `en` (the null path).

## 5. Kit: touch-target opt-out + scorecard exemptions

Touch opt-out:
- `dashcn/lib/src/theme/theme.dart`: `enum TouchTargets { padded,
  shrinkWrap }`, `ThemeData.touchTargets` (default `padded`), wired through
  `copyWith`/`lerp`/`==`/`hashCode` like the neighbouring discrete fields.
- `dashcn/lib/src/primitives/touch_hit_area.dart`: returns `child`
  unchanged when `shrinkWrap` (documented, with the dense-row guidance).
- Tests for both values on iOS/Android/macOS + copyWith/lerp/== round-trip;
  documented in the Button README and the Material interop page
  (`Touch targets` section).

Scorecard exemptions:
- `dashcn/test/scorecards/scorecard_model.dart`: `scorecardExemptions`
  (`divider/semantics` decorative; `menu/textContrast` disabled row, WCAG;
  `refresh_trigger/textContrast` pull-affordance sampling artefact) applied
  in `buildScorecards` as `exempt: "<reason>"` alongside measured values;
  regenerated `scorecards.json` (84 components) — `--check` green.
- Docs: scan/render carry `exempt`, generated `DocsScorecardCheck/Semantics`
  gain `exempt` + `exemptCount` (excluded from `failureCount`); rows render an
  `Exempt` badge with the reason; overview rows show `0 failures · 1 exempt`;
  "How we measure" documents exemptions.
- Incidental 390 px fix: `ScorecardCard` footer `Column` measured unbounded
  inside `CardFooter`'s `Row` (102 px overflow) — wrapped in `Expanded`.

## 6. Captures

`docs/test/p9z/capture_test.dart` (single test, 13 PNGs, `RepaintBoundary`
around the background `ColoredBox`, captures in `tester.runAsync`):
`rearch/screenshots/p9-z/`: `component-{button,select}-{1280,390}-{light,
dark}.png` (8), `landing-hero-{1280,390}-{light,dark}.png` (4),
`search-otp.png` (1). Pixel dims verified (`file`: 1280×900 / 390×844).
Screenshots not opened per instructions.

## 7. Test-harness notes (for future batches)

Widget-test isolates hang a fresh chunk `loadLibrary` issued after an
earlier test zone did its own chunk loads (the engine delivers completions
across real time; loads orphaned in dead `FakeAsync` zones never land; a
`Future` completed in one zone does not notify subscribers in later zones —
verified with a minimal cross-test probe). Consequences handled centrally
in `docs/test/support/app_harness.dart` (all green, full suite +632):
- First `pumpDocsApp` per isolate navigates button → flows → blocks (same-
  zone sequential loads resolve), building each so chunks install (fetched
  ≠ installed), then pops back; programmatic configs keep state/storage
  untouched; focus restored; wide viewport + error-queue drain for the warm.
- `drainLandingHero` waits for the hero key only on landing.
Also fixed along the way: tabs playground wraps in a horizontal scroll when
not expanded (matches the component's own example; `expand: true` keeps the
bounded strip — the scroll broke its flex).

## Gates

Kit (`dashcn/`): `qa_gate.sh` → format 0 changed, exports up to date (145),
analyze 0/0, registry tests +4853 pass, layers/owner/theme ok, banned empty;
`gen_scorecards --check` up to date (84); `check_names` 0; `dart format .`
0 changed (1461).
Docs: `sync_registry.sh` + `gen_docs_data` (+ both `--check`) up to date
(17 files); `dart format .` 0 changed (1028); `flutter analyze` no issues;
`flutter test test tool` +632 ~1, all passed (pre-existing skip);
`flutter build web` exit 0. No commits (orchestrator commits).

## Files

Kit (8): `dashcn/lib/src/theme/theme.dart`,
`dashcn/lib/src/primitives/touch_hit_area.dart`,
`dashcn/lib/src/components/button/README.md`,
`dashcn/lib/src/manifests/scorecards.json`,
`dashcn/test/registry/primitives/touch_hit_area_test.dart`,
`dashcn/test/registry/primitives/localizations_test.dart`,
`dashcn/test/scorecards/scorecard_model.dart`,
`dashcn/test/scorecards/gen_scorecards_test.dart`.
Docs lib (17 + mirror): `docs/lib/state/docs_state.dart`,
`docs/lib/routing/docs_router.dart`, `docs/lib/main.dart`,
`docs/lib/pages/component_page.dart`, `docs/lib/pages/landing_page.dart`,
`docs/lib/pages/themes.dart`, `docs/lib/pages/material_interop_page.dart`,
`docs/lib/pages/scorecards_page.dart`, `docs/lib/landing/hero_demo.dart`
(new), `docs/lib/widgets/component_preview_card.dart`,
`docs/lib/widgets/component_playground_section.dart` (new),
`docs/lib/widgets/component_scorecard_section.dart` (new),
`docs/lib/widgets/scorecard/{scorecard_badge,scorecard_sections,
scorecard_card}.dart`, `docs/lib/widgets/sidebar_groups.dart`,
`docs/lib/playground/builders/tabs.dart`,
`docs/lib/generated/docs_scorecards.dart`,
`docs/lib/generated/docs_search.dart`, `docs/web/index.html`
(+ `docs/lib/ui/dashcn/**` mirror sync).
Docs tool (3): `docs/tool/src/{render_files,render_scorecards,
scorecard_scan}.dart`.
Docs tests (8): `docs/test/p9z/` (4 new files),
`docs/test/support/app_harness.dart`,
`docs/test/{component_page_test,component_preview_f4_test,docs_app_test,
docs_pages_test}.dart`, `docs/test/scorecard/scorecards_page_test.dart`.
Screenshots (13): `rearch/screenshots/p9-z/*.png`.
Scratch (uncommitted, allowed dir): `rearch/logs/p9z_*.log`,
`rearch/logs/repro_locale.js`.

## Open follow-ups

- Flow pages share the nested-Navigator initial-focus steal (hero fixed
  docs-locally); consider a kit-level `requestFocus` opt-out if flow pages
  need first-tab guarantees.
- `refresh_trigger` contrast is exempted as a sampling artefact; a harness
  change to sample body text instead would remove the exemption.
- `?orientation=` kept as a separate param (old links work); folding into
  `?frame=` left for a future simplification pass.
- Usage section kept between scorecard and examples (spec order holds for
  all named items).
- Test-run PNG churn under `rearch/screenshots/` + `rearch/design/` is from
  the gates, not this batch (per brief).

## RESULT
status: done
files_written: [/home/user/dashcn-kit/dashcn/lib/src/theme/theme.dart, /home/user/dashcn-kit/dashcn/lib/src/primitives/touch_hit_area.dart, /home/user/dashcn-kit/dashcn/lib/src/components/button/README.md, /home/user/dashcn-kit/dashcn/lib/src/manifests/scorecards.json, /home/user/dashcn-kit/dashcn/test/registry/primitives/touch_hit_area_test.dart, /home/user/dashcn-kit/dashcn/test/registry/primitives/localizations_test.dart, /home/user/dashcn-kit/dashcn/test/scorecards/scorecard_model.dart, /home/user/dashcn-kit/dashcn/test/scorecards/gen_scorecards_test.dart, /home/user/dashcn-kit/docs/lib/state/docs_state.dart, /home/user/dashcn-kit/docs/lib/routing/docs_router.dart, /home/user/dashcn-kit/docs/lib/main.dart, /home/user/dashcn-kit/docs/lib/pages/component_page.dart, /home/user/dashcn-kit/docs/lib/pages/landing_page.dart, /home/user/dashcn-kit/docs/lib/pages/themes.dart, /home/user/dashcn-kit/docs/lib/pages/material_interop_page.dart, /home/user/dashcn-kit/docs/lib/pages/scorecards_page.dart, /home/user/dashcn-kit/docs/lib/landing/hero_demo.dart, /home/user/dashcn-kit/docs/lib/widgets/component_preview_card.dart, /home/user/dashcn-kit/docs/lib/widgets/component_playground_section.dart, /home/user/dashcn-kit/docs/lib/widgets/component_scorecard_section.dart, /home/user/dashcn-kit/docs/lib/widgets/scorecard/scorecard_badge.dart, /home/user/dashcn-kit/docs/lib/widgets/scorecard/scorecard_sections.dart, /home/user/dashcn-kit/docs/lib/widgets/scorecard/scorecard_card.dart, /home/user/dashcn-kit/docs/lib/widgets/sidebar_groups.dart, /home/user/dashcn-kit/docs/lib/playground/builders/tabs.dart, /home/user/dashcn-kit/docs/lib/generated/docs_scorecards.dart, /home/user/dashcn-kit/docs/lib/generated/docs_search.dart, /home/user/dashcn-kit/docs/web/index.html, /home/user/dashcn-kit/docs/tool/src/render_files.dart, /home/user/dashcn-kit/docs/tool/src/render_scorecards.dart, /home/user/dashcn-kit/docs/tool/src/scorecard_scan.dart, /home/user/dashcn-kit/docs/test/p9z/component_page_p9z_test.dart, /home/user/dashcn-kit/docs/test/p9z/search_nav_test.dart, /home/user/dashcn-kit/docs/test/p9z/landing_hero_test.dart, /home/user/dashcn-kit/docs/test/p9z/capture_test.dart, /home/user/dashcn-kit/docs/test/support/app_harness.dart, /home/user/dashcn-kit/docs/test/component_page_test.dart, /home/user/dashcn-kit/docs/test/component_preview_f4_test.dart, /home/user/dashcn-kit/docs/test/docs_app_test.dart, /home/user/dashcn-kit/docs/test/docs_pages_test.dart, /home/user/dashcn-kit/docs/test/scorecard/scorecards_page_test.dart, /home/user/dashcn-kit/rearch/screenshots/p9-z/component-button-1280-light.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/component-button-1280-dark.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/component-button-390-light.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/component-button-390-dark.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/component-select-1280-light.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/component-select-1280-dark.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/component-select-390-light.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/component-select-390-dark.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/landing-hero-1280-light.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/landing-hero-1280-dark.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/landing-hero-390-light.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/landing-hero-390-dark.png, /home/user/dashcn-kit/rearch/screenshots/p9-z/search-otp.png, /home/user/dashcn-kit/rearch/reports/P9-Z.md]
commands_run: [bash ../rearch/qa_gate.sh -> format 0 changed / exports up to date (145) / analyze No issues / registry tests +4853 passed / layers-owner-theme ok / banned empty; dart run tool/gen_scorecards.dart --check -> up to date (84 components); dart run tool/check_names.dart -> 0 hits; dart format --set-exit-if-changed . (dashcn) -> 0 changed (1461); bash tool/sync_registry.sh && dart run tool/gen_docs_data.dart + both --check -> up to date (17 files); dart format --set-exit-if-changed . (docs) -> 0 changed (1028); flutter analyze (docs) -> No issues found; flutter test test tool (docs) -> +632 ~1 All tests passed; flutter build web (docs) -> Built build/web EXIT 0; locale repro (Playwright, locale C) before -> pageerror RangeError Incorrect locale information provided, placeholder stuck; after shim -> navigator en-US, 0 pageerrors, first frame painted; flutter test touch_hit_area -> 4 passed; flutter test localizations -> 38 passed]
key_findings: [Component page order preview-frames/install/playground/scorecard/examples/API with TOC headings; ?frame=/p.* survive reload/back via DocsState+router; landing hero runs auth-01 live in 3 P9-1 frames (deferred) with narrow switcher, no autoplay, focus-steal gate+repair keeping first-Tab in header; search index covers flows+pages (otp->auth-01, contrast->scorecards); locale crash is engine Locale parsing of raw navigator strings (kit delegates already fall back) fixed by index.html shim verified before/after; TouchTargets.padded/shrinkWrap honored by TouchHitArea; 3 documented scorecard exemptions render Exempt and excluded from failures; widget-test deferred-loader quirk diagnosed (cross-zone fresh loads hang; fetched installs on first build) and fixed centrally in app_harness warm-builds]
open_questions: [Browser-frame content platform Windows semantic (from P9-1, unchanged); ?orientation= folding left for later; flow-page first-tab steal as kit follow-up; refresh_trigger proper text measurement as follow-up]
