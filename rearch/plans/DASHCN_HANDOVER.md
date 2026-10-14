# dashcn handover: continue on another machine

Snapshot: 2026-10-13 06:45 UTC. The cloud session (claude.ai/code session_01CGPJni4UYgnbtcRVz2B8CN) ran the work up to
here. Use this file to pick it up in a local Claude Code session on the Mac, or in a fresh cloud session.
`DASHCN_PROGRESS.md` holds the detailed log of every accepted phase, `DASHCN_FEATURES_PLAN.md` the P9 plan, and
`DASHCN_PACKAGE_PLAN.md` the P8 plan.

## 1. Where things are

**Release candidate ready.** Every planned phase is accepted and pushed, and P7 (`refactor/rearchitecture`, now
frozen) is merged in (`0f7a80d`). Nothing is in flight.

| Repo | Branch | CI |
|---|---|---|
| `mibrar-dev/shadcn_flutter_kit` (kit + docs) | `refactor/dashcn` | green |
| `mibrar-dev/flutter_shadcn_cli` (CLI) | `refactor/dashcn` | green |

Accepted and pushed:

| Phase | What |
|---|---|
| Brand | Original dashcn bird logo (`brand/`), every format; docs site rebranded |
| P8-1, P8-2 | Package `dashcn` 1.0.0, plain public names (`DashcnApp`), `check_names` gate = 0 |
| P8-3 | CLI `dashcn_cli` 1.0.0, `dashcn` executable, package mode, eject |
| P8-4 | Docs content: install tabs, package-or-own and Material pages, CLI reference, README |
| P8-5 | CI, tag-triggered pub.dev publish workflows, CHANGELOGs, `RELEASING.md` (not published) |
| KIT-FIX-1 | Accessibility (contrast-safe `onMuted`, labels, touch hit areas) + no form errors at mount |
| P9-1 | Device frames: every platform at once |
| P9-2a, P9-2b | Live props playground |
| P9-3a, P9-3b | Screens & Flows (five flows, `swipe_actions`), flow pages on the site, `dashcn add flow:<id>` |
| P9-4a, P9-4b | Web theme import/export (shadcn CSS, tweakcn, Tailwind, Figma tokens): kit, Theme Studio, CLI |
| P9-5a, P9-5b | Trust scorecards (generator and `/docs/scorecards`, with documented exemptions) |
| P9-6, P9-Z2 | App starters `dashcn create saas|chat|shop` + `/docs/starters` |
| P9-Z | Component page (frames + playground + scorecard), landing hero, search, locale fix, touch opt-out |
| P8-6 | Final QA: fresh-app journeys, dry-runs 0 warnings, pana, docs release check; one CLI bug fixed |

## 2. In flight

Nothing. The `wip/autosave-*` branches hold only old snapshots and can be deleted. Worktree B (`dashcn-kit-b`) and
`dashcn-cli-b` sit on `wip/p8-6-rc` (merged).

## 3. What's left

Releasing is **Ibrar's call** (never by an agent): follow "Ready to release" in `rearch/reports/P8-6.md` and
`RELEASING.md`:
1. pub.dev automated-publishing entries and `pub.dev` environments (both repos).
2. Stamp the CHANGELOG dates.
3. Merge `refactor/dashcn` into `main` in both repos (Ibrar decides; the rule "never merge into main" binds agents).
4. Tag the kit `v1.0.0` first, then the CLI.
5. Decide whether to rename the repos; the checklist is in the P8-6 report.

Optional polish, not blocking (write a brief per item if wanted):
- Visual screenshot pass of the deployed docs on GPU hardware (headless captures here were black under SwiftShader).
- Hash vs path URLs for GitHub Pages (path URLs need a `404.html`).
- `dashcn eject` for flows and blocks (now refused with a message).
- Flow pages: nested navigators take initial focus (the landing hero has a docs-side fix); consider a kit-level opt-out.
- Fold `?orientation=` into `?frame=`.
- Starter template links on the site point at `blob/main` (correct only after the release merge or rename).
- Measure `refresh_trigger` text properly, then remove its scorecard exemption.
- The header shows Starters only from 1600px wide; check it with the real font in a browser.

## 4. Rules (from the user; still binding)

- **Where to work.** Only in the dashcn worktrees. Never touch the `shadcn_flutter_kit` / `shadcn_flutter_cli`
  checkouts' own working trees; another session works there.
- **Branches.**
  - Never merge into `refactor/rearchitecture` or `main`.
  - No PRs, no pub.dev publishing, no repo renames unless the user asks.
- **Delegation.** Heavy work goes to OpenCode agents only, never Claude sub-agents. Model order:
  1. `opencode-go/muse-spark-1.3-contributor#xhigh`
  2. `opencode-go/step-5-preview-free#high`
  3. `opencode-go/longcat-2.5-preview-free`

  The Zen muse-spark variant is a fallback.
- **QA.** The orchestrator runs every gate itself, then commits explicit paths only and pushes.
  - Use `git commit --only <paths>` while agents are active (`git add` new files first).
  - Restore the test-regenerated PNGs under `rearch/screenshots/pilot` and `rearch/design/ours/screens` first.
- **Autonomy.** The user granted full autonomy: no questions needed, choose what is best.
- **Process hygiene.** Kill processes BY PID only. `pkill -f` matches OpenCode's command line (which contains the
  brief) and your own shell.

## 5. Mac setup: step by step

```bash
# 0. Tools: Flutter 3.47.x (Dart 3.13), Node 20+, gh, rsync, perl (macOS has it)
flutter --version
npm i -g opencode-ai@1.19.0
opencode auth login        # choose "opencode", paste YOUR key (stored in ~/.local/share/opencode/auth.json)
opencode models | grep opencode-go/   # the three models above must be listed
gh auth status             # needed for `gh run list`

# 1. Kit worktree from your existing clone (adds a worktree; doesn't change that folder's files)
cd ~/path/to/shadcn_flutter_kit
git fetch origin refactor/dashcn
git worktree add ../dashcn-kit -B refactor/dashcn origin/refactor/dashcn

# 2. CLI worktree
cd ~/path/to/shadcn_flutter_cli
git fetch origin refactor/dashcn
git worktree add ../dashcn-cli -B refactor/dashcn origin/refactor/dashcn

# 3. Pub get
cd ../dashcn-kit
(cd dashcn && flutter pub get) && (cd docs && flutter pub get) && (cd ../dashcn-cli && dart pub get)
```

**Stop the cloud routine.** Disable it at claude.ai, Routines, "dashcn agent watchdog check"
(`trig_01KHe8x21YMUXTvtjMb8Ejhw`), so two orchestrators don't race. Also archive the cloud session.

## 6. Running agents and the watchdog

```bash
cd ../dashcn-kit       # or dashcn-kit-b for the secondary worktree
# launch (detached; survives the terminal). Brief paths are relative to the worktree.
perl -MPOSIX -e 'POSIX::setsid(); exec @ARGV' nohup bash rearch/run_dashcn_agent.sh \
  'opencode-go/muse-spark-1.3-contributor#xhigh' rearch/briefs/dashcn/<BRIEF>.md <NAME> \
  > /dev/null 2>&1 &
#   (3rd arg is a NAME → rearch/logs/<NAME>.log. The launcher watches the FIRST `rearch/reports/<X>.md` path in the
#    brief for `## RESULT`, so a brief must not name another phase's report path before its own.)
# resume an existing OpenCode session with a nudge (loops until the report says status: done|blocked)
#   (4th arg is a NAME: log goes to rearch/logs/<NAME>.log; `opencode session list` shows ids, titled dashcn:<brief>)
perl -MPOSIX -e 'POSIX::setsid(); exec @ARGV' nohup bash rearch/resume_dashcn_agent.sh <session-id> \
  'opencode-go/muse-spark-1.3-contributor#xhigh' <prompt-file> <NAME> rearch/reports/<NAME>.md > /dev/null 2>&1 &
# after a machine/container restart: agents die but edits and OpenCode sessions survive on disk →
# resume each session with a "you were restarted, re-check git status, continue" prompt (done once on 2026-10-12)
# watchdog: prints EVENT DONE|STALL|LONG|DIED|MODEL_ERROR lines (run it under Claude's Monitor tool)
HEARTBEAT_MIN=100000 bash rearch/watch_dashcn_agents.sh 60
# snapshot in-flight work to origin (safe any time)
bash rearch/autosave_wip.sh main . ; bash rearch/autosave_wip.sh cli ../dashcn-cli
```

- The launcher substitutes `{{ROOT}}` / `{{KIT}}` in `rearch/briefs/dashcn/_common.md` (prepended to every brief).
- It auto-continues up to 8 times until the report contains `## RESULT`.
- It registers the agent in `rearch/logs/.agents/` for the watchdog.

Recovery recipes:
- **Stalled agent:** kill its PID, then resume with a nudge.
- **"backend temporarily unavailable"** repeating on one session while new sessions work means the context is too
  big. Start a fresh session with a handoff brief (see `P9-4b-handoff.md`).
- **Model errors:** move to the next model in the order above.

### Gates (orchestrator, on the final or merged tree)

**Kit, in `dashcn/`:**
- `bash ../rearch/qa_gate.sh`
- every generator `--check`: `tool/registry/gen_registry_manifest.dart`, `tool/gen_exports.dart`,
  `tool/registry/gen_previews_test.dart`, `tool/registry/gen_blocks_test.dart`, `tool/gen_scorecards.dart`
- `dart run tool/check_names.dart` (expect 0 hits)
- `dart format --set-exit-if-changed .`

**Docs, in `docs/`:**
- `bash tool/sync_registry.sh && dart run tool/gen_docs_data.dart`, then the `--check` of both
- `flutter analyze`
- `flutter test test tool`
- `dart format --set-exit-if-changed .`
- `flutter build web`
- check screenshots for visual changes

**CLI:**
- `dart analyze`
- `dart test` with `DASHCN_KIT_ROOT=<kit worktree>`, so the end-to-end suites actually run
- `dart format --set-exit-if-changed .`
- `tool/sync_interop.sh --check`

**After pushing:** `gh run list -R mibrar-dev/shadcn_flutter_kit -b refactor/dashcn -L 3` (and the same for
`flutter_shadcn_cli`).

## 7. Start prompt for the local Claude Code session

Open Claude Code in the `dashcn-kit` worktree and paste:

> You are the orchestrator and QA reviewer for the dashcn project. Read `rearch/plans/DASHCN_HANDOVER.md` first,
> then `DASHCN_PROGRESS.md`, `DASHCN_FEATURES_PLAN.md` and `DASHCN_SESSION_PROMPT.md`, all in `rearch/plans/`.
> Follow every rule in section 4 of the handover. I have granted full autonomy: don't ask me questions.
>
> 1. Verify the setup (section 5).
> 2. The release candidate is done. Ask me which optional polish items from section 3 I want. Never publish, tag,
>    merge into `main` or rename repos unless I ask.
> 3. For each item I choose: write a brief, launch an OpenCode agent with `rearch/run_dashcn_agent.sh`, run the
>    watchdog under Monitor, QA with all gates, commit explicit paths, and push `refactor/dashcn`.
> 4. After each accepted phase, append it to `DASHCN_PROGRESS.md` and update this handover's sections 2–3.
