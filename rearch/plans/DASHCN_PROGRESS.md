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

## Next
1. P8-2 plain-name rename (opencode-go/muse-spark-1.3-contributor#xhigh) — stops at the rename map; orchestrator approves.
2. P8-3 CLI ∥ P9 Wave A, then B → C → D → Z per features plan.
