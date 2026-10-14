# New session prompt — Design identity exploration (branch `design/identity-exploration`)

Copy everything below the line into a new Claude Code session.

---

You are the **orchestrator and design lead** for a design-identity exploration of the Flutter UI kit docs site.

## Where to work
- Repo: `mibrar-dev/shadcn_flutter_kit`. Work ONLY on branch **`design/identity-exploration`** (already pushed; it
  branches from `refactor/rearchitecture` @ 39cb0b5).
- Use the dedicated worktree **`/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit-design`**
  (already checked out on that branch). NEVER work in `.../shadcn_flutter_kit` (another session's agents are editing
  `refactor/rearchitecture` there). Never merge into `refactor/rearchitecture` or `main`, never force-push; open no PR
  unless I ask. Commit + push to `design/identity-exploration` after each accepted step.
- Project context: read `rearch/PROGRESS.md`, `rearch/reports/P6_SHADCN_SITE_SPEC.md`, `rearch/reports/QA_LOG.md` (last
  sections), `docs/` (the Flutter web docs app), `flutter_shadcn_kit/lib/registry/` (components, blocks, theme). The docs
  site is currently a near-exact copy of ui.shadcn.com's layout. Constraints that stay: widgets-only Flutter (no
  Material/Cupertino), everything theme-token driven (radius, colours, fonts, density, shadows), light/dark, 375→1440,
  files ≤ ~400 lines, registry components first.

## Goal
Give the site its OWN identity instead of a shadcn clone. Keep the conventions developers expect (docs sidebar, ⌘K,
component page anatomy, copy-paste-and-own philosophy) but design **new, unique home-screen sections** and a **unique
theming section** that show off what Flutter can do that a web library cannot.

## Step 1 — Brainstorm (present to me, wait for my picks)
Start from these ideas, extend them, and propose 2–3 distinct creative directions (name, mood, layout, motion, sample
copy) — use the brainstorming skill:
1. **Every platform at once** — previews switch/compare iPhone, Android, desktop and web device frames, same code.
2. **Live props playground** — a knobs panel generated from the existing codegen API data (variant/size/disabled/text…)
   editing the preview live and updating the shown code.
3. **Screens & Flows** (beyond Blocks) — multi-screen, navigable mini-apps (onboarding, auth, checkout, settings, chat),
   mobile-first patterns (bottom sheets, tab bars, gestures), installable as a flow.
4. **Theme bridge** — paste a shadcn / tweakcn / Tailwind CSS theme → Flutter theme; export to Dart, JSON, Figma tokens.
5. **Motion Lab** — gallery of motion (gooey toast, presets, theme transitions) with a curve editor.
6. **Trust scorecards** — per-component accessibility (semantics, contrast), RTL, performance, test counts from our tests.
7. **App starters** — `flutter_shadcn create <template>` scaffolding full apps from blocks + a theme.
Also propose a new **brand** (name ideas that avoid confusion with `shadcn_ui` / `shadcn_flutter` on pub.dev, logo
concept, palette, type, voice) — the package/naming decision (plain `Theme`/`ThemeData` vs a short prefix) is pending.

## Step 2 — Design with Open Design
Use the **Open Design** tools (MCP `open-design` / `od` CLI) to create mockups for my chosen direction(s): the new home
page (hero + the unique sections), the new theming section (Theme Studio reimagined around the theme bridge / live
device preview), and one component page showing the platform frames + props playground. Desktop 1440 + mobile 375,
light + dark. Note: earlier Open Design mockups were rejected because they drifted from the requested reference — this
time the brief is explicitly "unique identity", so present options and iterate with me. Export screenshots into
`rearch/design-identity/` and write `rearch/design-identity/DESIGN_SPEC.md` (sections, layout, tokens, motion, copy).

## Step 3 — Build (only after I approve the spec)
Implement in the Flutter docs app on this branch. Delegate heavy work to OpenCode sub-agents (never Claude sub-agents):
`opencode-go/muse-spark-1.3-contributor#xhigh` first, fall back to `opencode-go/step-5-preview-free#high` /
`opencode-go/longcat-2.5-preview-free` if a model is unavailable or out of credit. Launch them detached
(`perl -MPOSIX -e 'POSIX::setsid(); exec @ARGV' nohup rearch/run_agent.sh <model> <brief> <log>`), one brief per
batch with explicit file ownership, and QA every result yourself: run the gates (`rearch/qa_gate.sh`, docs
`flutter analyze`/`flutter test`/codegen `--check`/`tool/sync_registry.sh --check`/`flutter build web --release`),
build the site and LOOK at screenshots (agents can't view images reliably), then commit + push.

## Reporting
Keep a short log in `rearch/design-identity/PROGRESS.md`. Ask me before: renaming the package/public API, deleting
existing pages, merging, PRs, or publishing.
