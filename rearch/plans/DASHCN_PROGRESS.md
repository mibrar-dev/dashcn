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

## Next
1. (done) P8-3 CLI (opencode-go/muse-spark-1.3-contributor#xhigh) ∥ P9 Wave A (P9-1 frames, P9-4a theme bridge, P9-5a scorecards).
2. Then B → C → D → Z per features plan; P8-4 docs, P8-5 release eng, P8-6 final QA.
