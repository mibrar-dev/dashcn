# dashcn progress log (branch `refactor/dashcn`)

## Setup (2026-10-12)
- Everything runs in the cloud session (claude.ai/code): OpenCode 1.19 agents (opencode.ai allowed, key in OpenCode's
  auth store), Flutter 3.47.7 at /opt/flutter, watchdog Monitor + hourly routine. The Mac Remote Control route was
  dropped (its usage limit blocked it); Ibrar closed it.
- Kit branch `refactor/dashcn` created from `origin/refactor/rearchitecture` @ `fa22ef2`.
- CLI branch `refactor/dashcn` from `origin/refactor/rearchitecture` @ `609faa9`. Ibrar checked: his local branch has no
  commits beyond origin.

## Decisions (Ibrar, 2026-10-12)
- Version **1.0.0** for everything (published from scratch).
- Root widget **`DashcnApp`** (Ibrar delegated; rationale in DASHCN_FEATURES_PLAN.md §0).
- Website brand **dashcn**. Logo: original Dash-spirited bird (not Google's Dash asset; trademark). Kit in `brand/`.
- Six signature features approved → `DASHCN_FEATURES_PLAN.md` (P9).
- Autonomy: orchestrator decides everything without asking (incl. approving the P8-2 map and pushing the CLI branch).
  Still never: merge into refactor/rearchitecture or main, PRs, pub.dev publish, repo renames.

## Done
- P8-0 brand: `brand/` kit (SVG/PNG/ICO + generator). Docs app icons (web/iOS/Android/macOS/Windows), web title,
  meta, OG card and manifest rebranded. QA: every variant inspected visually (16 px favicon legible, maskable within
  safe zone, mono glyph complete, iOS icons opaque RGB).
- Plans + agent infra: `DASHCN_FEATURES_PLAN.md`, `rearch/briefs/dashcn/_common.md`, `rearch/run_dashcn_agent.sh`,
  briefs P8-1, P8-2.

## Baseline gate (cloud, Flutter 3.47.7 / Dart 3.13.5, tree @ 98032a1 before P8-1)
format 0 changed · analyze 0 issues (lib + tests) · registry tests +4518 pass · rearch +42 pass · layers clean ·
theme 0 · banned none · **owner: 1 pre-existing finding `components/switcher/preview.dart:76 [switcher]`** (not P8 work).

## P8-1 package skeleton — ACCEPTED
Agent: muse-spark-1.3-contributor (free, then opencode-go paid on resume). `flutter_shadcn_kit/` → `dashcn/`,
`lib/registry` → `lib/src`, app shells → `dashcn/example/`, `tool/gen_exports.dart` (138 public libraries:
`dashcn.dart`, `foundation|theme|primitives.dart`, `components/<id>.dart`, `blocks/<id_with_underscores>.dart`).
Report: rearch/reports/P8-1.md. Orchestrator gates (independent): kit format/analyze clean, +4518/+42, exports +
manifest + blocks + previews --check up to date, example analyze clean, docs format/analyze clean, +232, gen --check,
sync --check (real rsync), build web OK, publish dry-run 0 errors. Visual: docs home renders.
Rulings on open questions: block stems with underscores (lint-correct) — accepted; delete
`tool/registry/registry_barrel*.dart` in P8-2; barrel keeps helper components (0 collisions; revisit at API review);
`example/` platform shells branding → P8-2 codemod; rearch PNG drift = test captures, restored, never committed.
Found: docs app crashes at startup when the browser reports no locale (`RangeError: Incorrect locale information
provided`) — pre-existing; fix queued for P9-Z.
Infra fixes: launchers auto-continue until the report has `## RESULT`; unique `__AGENT_EXIT__` sentinel.

## P8-2 plain-name rename — ACCEPTED
Map approved by the orchestrator (33 proposed entries; comments citing the upstream design → "upstream"; locals
`shadcn` → `themeData`). Codemod `tool/rename_api*.dart` (token-exact, unresolved AST, 16 tests) + guardrail
`tool/check_names.dart` (wired into qa_gate) + inventory `rearch/plans/api_inventory.json`. Mirrors renamed to
`ui/dashcn` and regenerated, not codemodded.
Incidents: (1) `maskAllow` kept the matched text → infinite loop on the first allow-listed file (looked like
"slowness" for ~3 h); found by the orchestrator. (2) first apply renamed half of each pair and was hand-patched
(`this.theme`) — tree reset to HEAD, valuable tools kept, fresh agent redid it cleanly. (3) OpenCode hung 18 min
compacting a huge context — killed, session resumed.
Orchestrator QA fixes: string rule had turned the real repo name `shadcn_flutter_kit` into `dashcn_kit` (Pages base
path → broken routing on the live site; skills install URLs → non-existent repo; `pub add dashcn_kit` on every
component page) — restored/fixed, repo name allow-listed until the repo is renamed; "matches dashcn/ui" →
"the upstream web kit"; CI workflow paths (`flutter_shadcn_kit`, `lib/registry`) fixed — CI had been broken since P8-1;
docs analyzer exclude → `ui/dashcn`.
Gates (orchestrator): kit +4518/+42, tool +16, rename --check none pending, check_names 0, generators --check, docs
+232, gen/sync --check, build web; site title "dashcn", renders.
Open for later: pub dry-run warns "13 checked-in files ignored by .gitignore" (git itself finds none) → P8-6;
docs config/README/pubspec still say flutter_shadcn_kit → P8-4; `flutter_cli_verification_example/.shadcn/` CLI cache
→ P8-3.

## P9-4a theme bridge core — ACCEPTED
Pure-Dart `lib/src/theme/interop/` (12 files, no `package:` imports → CLI can vendor): colour spaces (oklch/oklab/
hsl/bare v3 triplets/rgb/hex, gamut mapping, CIEDE2000 checked vs Sharma ref), web CSS v3/v4 + tweakcn parser,
Tailwind v3 literal parser, writers (web CSS v4, Tailwind v4, DTCG, dashcn preset), ImportReport. 223 tests; all 43
presets round-trip with ΔE 0. Orchestrator gates: kit +4741/+42, exports/manifest --check, check_names 0; docs mirror
was not synced by the agent → synced, docs analyze clean.
Ruling for P9-4b: interop leaked generic helpers into `package:dashcn/dashcn.dart` → move to a dedicated
`lib/theme_interop.dart` with a narrow `show` surface (brief P9-4b §1).
Found during P8-3: its eject tests hang; two orphaned `dart test` runs (15 + 9 min at 100% CPU) killed.

## P8-3 CLI — ACCEPTED, CLI branch pushed (mibrar-dev/flutter_shadcn_cli refactor/dashcn @ 3e0af5f)
`dashcn_cli` 1.0.0, executable `dashcn`, `.dashcn/config.json` (agent verified `dashcn.yaml` never existed as a config
— accepted), `dashcn.lock`, `lib/ui/dashcn/`, `DASHCN_*` env; `init --mode package|copy`, `add --package`, `eject`
(dry-run + conflict guard), analyzer codemod `tool/rename_cli.dart`. Rejected in review: an on-load migration of old
`.shadcn`/`shadcn.lock` files (clean-break decision) → removed. Remaining "shadcn": 9 real-repo URLs only.
Orchestrator gates with DASHCN_KIT_ROOT set (e2e really ran): format, analyze, 538 unit, e2e acceptance + package mode,
rename --check. Release prerequisite: the CLI's default registry pins `mibrar-dev/shadcn_flutter_kit@v<version>` →
the kit must be tagged `v1.0.0` (with the `dashcn/` layout) before a published CLI works with defaults.
P9-1 incident: agent killed itself with `pkill -f` (OpenCode cmdline = brief text) → _common rule "kill by PID only".

## P9-1 device frames — ACCEPTED
`docs/lib/widgets/device_frame/`: iPhone (Dynamic Island), Android (punch-hole), desktop window, browser chrome via
CustomPainter; MediaQuery size/insets/dpr + platform override (kit already routes reads via `Theme.of(context).platform`
— no kit change); FrameBar (None/iPhone/Android/Desktop/Web/All, rotate for phones only, light/dark); "All" = four live
frames side by side; choice persisted + `?frame=`/`?orientation=`. 45 tests incl. an overflow matrix (6 previews × 6
modes × 2 orientations × 2 brightness). Not yet wired into the component page — P9-Z (`FramedPreview`).
Review: desktop/browser rotated into a portrait window → fixed (`DeviceSpec.rotatable`). Agent earlier killed itself
with `pkill -f`; widget-test hangs diagnosed (deferred-library loads must pump; captures in runAsync).
Orchestrator gates: docs format/analyze clean, frames +45, docs +277, gen/sync --check, build web; screenshots reviewed.

## P9-4b theme bridge UI + CLI — ACCEPTED (kit + CLI)
API trim: interop moved out of `dashcn.dart`/`theme.dart` into `package:dashcn/theme_interop.dart` (`show` list;
helpers in unexported `internal/`). Theme Studio: Import dialog (paste/file, live light+dark preview, ImportReport,
Apply) + Export tabs (web CSS v4, Tailwind v4, DTCG, preset JSON, Dart; scrollable tab strip — six tabs overflowed by
328 px, the real cause of the failing widget test). CLI: vendored interop (`tool/sync_interop.sh` + `--check`),
`dashcn theme import <file|url> [--apply]`, `dashcn theme export --format …`, e2e round trip.
Agent incidents: provider "backend temporarily unavailable" ×3 on one session (context too large) → fresh session with
handoff brief. Orchestrator QA fixes (CLI): vendored copy failed the repo-wide format gate (kit 3.12 vs CLI 3.3
formatter styles) → sync/--check now format with the CLI language version; `DASHCN_KIT_ROOT` accepts the repo root
(was silently skipping); drift check verified to fail on drift; README format reference protected in rename_cli.
Gates (orchestrator): kit +4741/+42, exports/manifest --check, check_names 0, barrels export no interop; docs +294,
gen/sync --check, build web; CLI format/analyze clean, 553 unit, e2e acceptance + package + theme_interop, rename
--check, sync_interop --check.

## P8-5 release engineering — ACCEPTED (kit 0ffdb3e, CLI 6cb13fe)
CI on PR + push (main, refactor/**), tag-triggered pub.dev publishing via OIDC (configured, never run), changelogs,
RELEASING.md (semver, one-time pub.dev setup by Ibrar, release order kit→CLI, repo-rename checklist).
QA: the kit publish job used dart-lang's reusable workflow (Dart SDK only — cannot publish a Flutter package) →
replaced with setup-dart (OIDC) + flutter-action + `flutter pub publish`; changelog facts corrected.
First GitHub CI runs failed → fixed: capture tests hard-coded `/home/user/...`; one unformatted tool file; CLI CI
analyzed/rename-checked the kit checkout under `dashcn-kit/`. Kit CI green at 8ae6fd9.

## P9-5a trust scorecards generator — ACCEPTED
`tool/gen_scorecards.dart` + generated harness (83 components) → `lib/src/manifests/scorecards.json`
(generatedAt/commit/flutter; per component a11y guidelines, RTL, frames "test environment (relative)", test count).
Findings (measured, nothing invented): 22/83 pass all a11y checks; 47 text-contrast failures — root cause verified by
the orchestrator: muted-foreground #737373 on muted #F5F5F5 = 4.35:1 (< WCAG AA 4.5; passes on white at 4.74);
11 unlabeled tappables; 22 below 44/48 px mobile tap targets (32–36 px desktop sizing); 5 missing semantics; RTL 83/83.
CI now runs test/scorecards + `gen_scorecards --check`. Follow-up queued: A11Y-1 token/semantics fix batch.

## P9-5b scorecards on the docs site — ACCEPTED
`docs_scorecards.dart` generated from scorecards.json; `ScorecardCard(componentId:)` (pass/fail/not-measured badges,
expandable guideline messages, measured-on footer) — placement on the component page in P9-Z; "How we measure" page
(`/docs/scorecards`) with metrics, method, limits and an all-components table. Orchestrator gates: docs format/analyze
clean, +304, gen/sync --check, build web; real-site screenshots (en-US) reviewed — honest labels as briefed.

## P9-2a live props playground — data, code emission, builders — ACCEPTED
`docs_controls.dart` generated from the API extraction (bool/enum/String/num/colour/child/callback controls; enum
values resolved from kit enums; optional `meta.json` `playground` overrides — none needed), `PlaygroundValues` with URL
round-trip (`p.<name>=`), `emitCode` (non-default args only, qualified enums, const when possible, valid Dart — parsed
in tests), builders for 28/30 requested components (`toggle_group` and `label` do not exist). 220 playground tests.
Found during QA: the P8-2 comment rule had written "a upstream app/dialog/theme" where "shadcn" meant this kit → fixed
(separate commit); docs `tool/` generator tests were never run by CI → added.
Orchestrator gates: kit qa_gate +4741/+42, all generators --check, check_names 0, package format clean; docs
format/analyze clean, `flutter test test tool` +556, gen/sync --check, build web.

## P9-2b playground panel — ACCEPTED
`PlaygroundPanel(componentId:)`: preview inside FramedPreview, controls rail ≥1100 px / stacked 600–1100 / bottom
sheet < 600; live syntax-highlighted code; kit controls only (Switch, Select, Input, Slider, tri-state, token picker);
dependent ranges as data (`boundedBy`); Reset; values in the URL. Review: playgrounds opened EMPTY (text controls had
no default, builders fell back to '') → generator now gives text controls meaningful defaults and the code shows them.
Orchestrator gates: docs format/analyze clean, `flutter test test tool` +593, gen/sync --check, build web.

## P9-3a Screens & Flows — ACCEPTED (worktree B, branch wip/p9-3a-flows, merged)
`lib/src/flows/` layer (manifest type `flow`, public `lib/flows/<id>.dart`, not in the barrel; check_layers rule:
flows → components/blocks only): onboarding-01, auth-01, checkout-01, settings-01, chat-01 — data + callbacks in, no
fake backends; new component `swipe_actions`. Four review rounds: (1) REAL bug — exposed swipe actions never fired
(close-tap detector's un-translated hit box won the arena) → fixed, tests assert real callbacks in scrollables;
(2) flow forms showed errors before typing → `showErrors: {submitted}`; KIT BUG found: `FormValidationMode.changed`
fires at mount (also hits the login-01 block) → queued; (3) capture harness lacked the app text style (white text in
light mode) → wraps like DashcnApp; (4) swipe_actions lacked preview.dart (docs generator) → added + scorecard example.
Merged refactor/dashcn into the branch: regenerated docs controls/scorecards (84 components); scorecards page test
hard-coded 83 → derives the count. Orchestrator gates on the merged tree: kit +4830/+42, all generators --check,
check_names 0, scorecard+tool tests +111, package format clean; docs format/analyze clean, `test tool` +593,
gen/sync --check, build web.
Deferred polish → P9-3b: "No account yet?Create one" spacing; settings home vertically centred instead of top;
cramped toggle rows.

## P8-4 docs content — ACCEPTED
Brand leftovers (docs pubspec/README/.gitignore/Makefile, root README rewritten as the dashcn README with the brand
lockup); Package | Own-the-code install tabs from one source of truth (`docs/lib/widgets/install_commands.dart`) on
component pages and Getting Started; new pages `/docs/package-or-own` and `/docs/material` (every Dart sample parsed
by a test); CLI reference regenerated from the real `dashcn` 1.0.0 help (readme_scan accepts `--dir <path>` and
aliases); landing collage card ellipsizes long labels. Interrupted once by a container restart → resumed the same
OpenCode session. Orchestrator fix: the capture harness's RepaintBoundary sat inside the background (dark captures
transparent) → boundary now wraps the background. Merged with refactor/dashcn; gates on the merged tree: docs
gen/sync --check, format, analyze clean, `test tool` +597, build web; check_names 0.

## KIT-FIX-1 accessibility + form validation — ACCEPTED (worktree B, branch wip/kit-fix-1, merged)
Scorecards (84): textContrast 36→82, labeled tap targets 72→84, touch tap targets 61→70, semantics 78→83.
`ThemeColors.onMuted` (derived, 4.5:1 guaranteed via new `theme/contrast.dart`; preset JSONs untouched); labels and
semantics on shared primitives (chip button, stepper, tree, navigation item, …); `TouchHitArea` adds transparent
padding on phones only (Button, collapsible); `FormValidationMode.changed` no longer fires at mount (pristine/dirty —
every FormValueSupplier publishes once at mount, so the first report is `initial`). Scorecard harness now measures on
the app background with the app text style (a large share of the old failures were harness artefacts). Remaining:
menu (disabled row), refresh_trigger (sampling artefact), divider (decorative), 14 dense tap targets → P9-Z
decisions + a TouchHitArea opt-out. Merged refactor/dashcn (P8-4) in; gates on the merged tree: qa_gate exit 0
(+4844/+42), all generators --check, check_names 0, package format clean; docs gen/sync --check, format, analyze,
`test tool` +598, build web.

## P9-3b flows on the docs site + `dashcn add flow:<id>` — ACCEPTED (kit + CLI)
Docs: "Flows" nav section (header item from 1440 px), `/docs/flows` index (cards with phone-frame thumbnails) and
`/docs/flows/<id>` (live flow in the P9-1 iPhone frame, screen map that jumps the live flow via the new kit
`initialScreen` parameter, Package | Own install tabs, dependencies, per-screen generated code, prev/next); demo
data/callbacks live in docs only; generators `flow_scan` + `render_flows` with `--check`. CLI: `dashcn add flow:<id>`
(copy mode installs flow + component/block closure, lock `flows`; package mode prints the import), list/search/info/
remove/update/doctor cover flows; `eject flow:` refused with a message (follow-up). Kit polish: auth link-row gaps,
settings home top-aligned, toggle-row padding. Merge finding (KIT-FIX-1 × P9-3b): touch-sized buttons made the
onboarding permission card overflow 16 px in the phone frame → the card now scrolls when taller than the screen
(orchestrator fix). Gates on the merged tree: kit `flutter test` +5000, qa_gate exit 0, all generators --check,
check_names 0, format; docs gen/sync --check, format, analyze, `test tool` +613, build web; CLI analyze, format,
sync_interop --check, `DASHCN_KIT_ROOT` tests +570 (e2e flows incl. `flutter analyze` of a fresh app).
Follow-ups → P9-Z: flows in the docs search index; eject for flows/blocks; TouchHitArea opt-out (now a must-have).

## P9-6 app starters (`dashcn create`) — ACCEPTED (worktree B + dashcn-cli-b, branches wip/p9-6-starters, merged)
Kit: `lib/src/starters/{saas,chat,shop}/` — `starter.json` (flows, blocks, components, routes, files, theme preset,
platforms) + `.tmpl` templates (main, app/router, shell, app-owned in-memory repository marked "replace with your
backend", smoke test; shop's product grid is built from components, no new block) + README; manifest `starters`
section with validation; not exported, excluded from generators by construction; `flutter pub publish --dry-run`
0 warnings. CLI: `dashcn create <starter> <name> [--theme preset|file.css] [--mode package|copy] [--platforms]
[--org] [--force] [--dry-run]`, `create --list`; copy mode installs through the installer (flows recorded in
`dashcn.lock`, after the orchestrator merged P9-3b in and sent a follow-up). Merge conflict (validator allowed keys)
resolved by keeping `flows` + `starters`. Gates on the merged trees: kit qa_gate exit 0 (+4846/+42), all generators
--check, check_names 0, format, publish dry-run 0 warnings; docs gen/sync --check, format, analyze, `test tool` +613,
build web; CLI analyze, format, sync_interop --check, unit +579, e2e `create` 6/6 (saas/chat/shop × package/copy:
create → `flutter analyze` 0 issues → generated smoke test) + flows e2e.
Follow-up → after P9-Z: Starters docs page + nav (document the package/copy theme-file split).

## P9-Z integration — ACCEPTED
Component page: preview in P9-1 frames, Playground section (P9-2b panel; "coming soon" note without a builder),
Trust scorecard section, both in the TOC; `?frame=`/`p.*` survive reload/back via DocsState + router (`sourceUri`).
Landing hero "Every platform at once": auth-01 live in iPhone/Android/desktop frames (deferred; one frame + switcher on
narrow; no autoplay), with a focus-steal fix for nested navigators. Search indexes flows + new prose pages; sidebar
Themes group with "Import a web theme" (`/themes?panel=import`). Locale crash: Flutter web engine builds a Locale from
`navigator.language` ('C' in headless Chromium) and throws before the first frame → docs `web/index.html` shim
normalizes unusable locales to en-US (Playwright before/after evidence in the report); kit locale resolution verified
safe with new tests. Kit: `ThemeData.touchTargets` (`padded` default | `shrinkWrap`) honoured by TouchHitArea, documented;
scorecard exemptions with reasons (divider semantics, menu disabled row, refresh_trigger sampling) shown as "Exempt".
Test harness: deferred-chunk warm-up per isolate (documented in the report). Merged refactor/dashcn (P9-6) in; gates on
the merged tree: qa_gate exit 0 (+4853/+42), all generators --check, check_names 0, format; docs gen/sync --check,
format, analyze, `test tool` +632, build web.
Follow-ups: flow pages' nested-navigator focus steal (kit-level opt-out?), fold `?orientation=` into `?frame=`.

## P9-Z2 starters on the docs site — ACCEPTED
Generator `starter_scan` + `render_starters` → `docs_starters.dart` (3 starters; template targets only, never `.tmpl`
text; `--check` now 18 files). `/docs/starters` grid (3/2/1 columns) with phone-framed thumbnails composed from the
starters' flows with docs demo data; `/docs/starters/<id>`: routes table linking flow/block pages, `dashcn create`
Package | Own tabs, theme-file split, flags, generated file tree, next steps, prev/next. Nav (header from 1600 px,
sidebar, palette), search ("saas" finds the saas starter), Getting Started "Start from a template". One review round:
the first index was full-width rows with a tiny thumb → grid of compact cards. Gates: all generators --check,
check_names 0; docs gen/sync --check, format, analyze, `test tool` +653, build web.
Follow-up: GitHub template links point at `blob/main` (update after the release branch/repo-rename decisions).

## Next (as of 2026-10-12 21:00 UTC — see DASHCN_HANDOVER.md for how to continue on another machine)
In flight: P8-4 docs content (main worktree, `refactor/dashcn`), KIT-FIX-1 a11y/forms (worktree B, `wip/kit-fix-1`).
Queue: P9-3b flows on the site + `dashcn add flow:<id>` + polish → P9-6 `dashcn create` starters → P9-Z integration
(component page = frames + playground + scorecard; nav; landing hero; headless-locale crash) → P8-6 final QA.
