# dashcn handover: continue on another machine

Snapshot: 2026-10-12 21:00 UTC. The cloud session (claude.ai/code session_01CGPJni4UYgnbtcRVz2B8CN) ran the work up to
here. Use this file to pick it up in a local Claude Code session on the Mac, or in a fresh cloud session.
`DASHCN_PROGRESS.md` holds the detailed log of every accepted phase, `DASHCN_FEATURES_PLAN.md` the P9 plan, and
`DASHCN_PACKAGE_PLAN.md` the P8 plan.

## 1. Where things are

| Repo | Branch | Head | CI |
|---|---|---|---|
| `mibrar-dev/shadcn_flutter_kit` (kit + docs) | `refactor/dashcn` | `29d7ef5` or newer | green |
| `mibrar-dev/flutter_shadcn_cli` (CLI) | `refactor/dashcn` | `da167f6` | green |

Accepted and pushed:

| Phase | What |
|---|---|
| Brand | Original dashcn bird logo (`brand/`), every format; docs site rebranded |
| P8-1, P8-2 | Package `dashcn` 1.0.0, plain public names (`DashcnApp`), `check_names` gate = 0 |
| P8-3 | CLI `dashcn_cli` 1.0.0, `dashcn` executable, package mode, eject |
| P8-5 | CI, tag-triggered pub.dev publish workflows, CHANGELOGs, `RELEASING.md` (not published) |
| P9-1 | Device frames: every platform at once |
| P9-2a, P9-2b | Live props playground |
| P9-3a | Screens & Flows: five flows and `swipe_actions` |
| P9-4a, P9-4b | Web theme import/export (shadcn CSS, tweakcn, Tailwind, Figma tokens): kit, Theme Studio, CLI |
| P9-5a, P9-5b | Trust scorecards (generator and `/docs/scorecards`) |

## 2. In flight at handover time (OpenCode agents in the cloud container)

| Agent | Worktree, branch | Brief | Report |
|---|---|---|---|
| P9-3b flows docs + CLI | main (`dashcn-kit`) + `dashcn-cli`, both `refactor/dashcn` | `rearch/briefs/dashcn/P9-3b-flows-docs-cli.md` | `rearch/reports/P9-3b.md` |
| P9-6 starters (`dashcn create`) | B (`dashcn-kit-b`) + `dashcn-cli-b`, both `wip/p9-6-starters` | `rearch/briefs/dashcn/P9-6-starters.md` | `rearch/reports/P9-6.md` |

P8-4 was accepted at 21:40 UTC and KIT-FIX-1 at 23:10 UTC. P9-3b's agent works in the main kit worktree, which is
based on P8-4, and in the CLI. Merge `refactor/dashcn` in before accepting it. OpenCode sessions live in the cloud
container's `~/.local/share/opencode`, so they can't be resumed on the Mac; use the snapshots there.

Their uncommitted work is snapshotted every hour to `wip/autosave-main` and `wip/autosave-kit-b` on the kit repo (and
`wip/autosave-cli` / `wip/autosave-cli-b` on the CLI repo when they have changes) by `rearch/autosave_wip.sh`. Each snapshot is ONE commit on
top of the worktree's HEAD; its message says which HEAD and when. **These snapshots are unreviewed work in progress.**

If the cloud is gone, recover them like this:
- **Option A: resume.** Check out the snapshot, read the report, and relaunch the agent on the same brief with
  "continue from the existing changes" (step 5).
- **Option B: restart.** Relaunch the brief from a clean `refactor/dashcn`.

If the cloud session is still alive, let it finish. Don't run the same phase in two places.

## 3. Queue (in order)

Briefs that don't exist yet must be written first, using the existing briefs as the pattern.

1. **QA and accept P9-3b** (P8-4 and KIT-FIX-1 done). Run all gates yourself (section 6) and review the diff and screenshots.
   - P8-4: commit with explicit paths in main, then merge it into `refactor/dashcn`.
   - KIT-FIX-1: merge `refactor/dashcn` into `wip/kit-fix-1`, regenerate, re-run the gates, then fast-forward push
     `HEAD:refactor/dashcn`.
2. **P9-3b** (brief to write). Flows on the docs site, `dashcn add flow:<id>` in the CLI, and polish:
   - "No account yet?Create one" is missing a space;
   - settings home should be top-aligned;
   - toggle rows are cramped.
3. **P9-6** (running, see section 2). `dashcn create <starter>` app starters, e.g. `dashcn create saas`, built from blocks and flows.
4. **P9-Z** (brief to write). Integration:
   - the component page becomes frames + playground + scorecard;
   - navigation;
   - landing hero;
   - fix the docs crash in a browser with no locale (`RangeError: Incorrect locale information provided`);
   - KIT-FIX-1 follow-ups:
     - an opt-out for `TouchHitArea`'s layout growth on phones (like Material's `shrinkWrap` tap-target size), e.g.
       a theme flag, documented on the Button page;
     - a decision on the scorecard for `divider` (decorative by design), `menu` (disabled row) and
       `refresh_trigger` (a measurement artefact): exempt them in the harness, with the reason shown.
5. **P8-6 final QA.**
   - fresh-app tests for package mode and eject;
   - `dart pub publish --dry-run` / `flutter pub publish --dry-run` for both packages;
   - the pub warning "13 checked-in files ignored".

   Release order when the user asks: tag the kit `v1.0.0` first, because the CLI's default registry pins
   `…/shadcn_flutter_kit@v<cli version>/dashcn/lib/src`.

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

# 3. (Only if continuing in-flight work from the cloud) inspect the snapshots
cd ../dashcn-kit
git fetch origin wip/autosave-main wip/autosave-kit-b
git log -1 --stat origin/wip/autosave-main | head -40
# P8-4 continues in the main worktree:
git merge --ff-only origin/wip/autosave-main  # or: git checkout -b wip/p8-4 origin/wip/autosave-main
# KIT-FIX-1 gets its own worktree:
git worktree add ../dashcn-kit-b -b wip/kit-fix-1 origin/wip/autosave-kit-b

# 4. Pub get
(cd dashcn && flutter pub get) && (cd docs && flutter pub get) && (cd ../dashcn-cli && dart pub get)
```

If `merge --ff-only` refuses, the snapshot sits on an older HEAD. Use `git checkout -b wip/p8-4
origin/wip/autosave-main`, then merge `refactor/dashcn` into it.

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
> 1. Verify the setup (section 5). Check whether the cloud agents' work exists on `wip/autosave-main` /
>    `wip/autosave-kit-b` and recover it (Option A).
> 2. Run the watchdog under Monitor.
> 3. Work through the queue in section 3: write the missing briefs, launch OpenCode agents with
>    `rearch/run_dashcn_agent.sh`, QA every phase with all gates, commit explicit paths, and push `refactor/dashcn`
>    on both repos.
> 4. After each accepted phase, append it to `DASHCN_PROGRESS.md` and update this handover's sections 2–3.
