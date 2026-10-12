# dashcn — signature features plan (P9)

Status: **approved scope (Ibrar, 2026-10-12)**, design by orchestrator. Branch `refactor/dashcn` only.
Companion to `DASHCN_PACKAGE_PLAN.md` (P8 = package + plain names). Read both.

## 0. Decisions (2026-10-12, Ibrar)
- **Version 1.0.0 everywhere** (kit package `dashcn`, `dashcn_cli`, docs app, manifest `version`, CHANGELOG first entry
  `## [1.0.0]`). Published from scratch, so no 0.x line. Consequence: from the first publish any public-API break needs
  2.0.0. P8-2's rename and the P9 APIs below must therefore land *before* the first publish, and P8-6 includes an API
  review gate.
- **`ShadcnApp` → `DashcnApp`** (Ibrar delegated the choice). Reason: `App` is the most common user-written root widget
  name (`class App extends StatelessWidget`) and would force `as`/`hide` in most apps; `DashcnApp` matches
  `MaterialApp`/`CupertinoApp`, and "dashcn" does not contain "shadcn" so `check_names` stays strict. Every other plain
  name in the P8 table is unchanged.
- **Brand**: website/title `dashcn`; logo kit under `brand/` (see `brand/README.md`).
- Agents: OpenCode only (`muse-spark-1.3-contributor#xhigh` → `step-5-preview-free#high` → `longcat-2.5-preview-free`),
  launched from Ibrar's Mac via the Remote Control session; this cloud session orchestrates + QAs.

## 1. Ordering
P8-1 skeleton → P8-2 rename (codemod) **first**: every P9 file is then written with final names, no second codemod.
P8-3 (CLI rename) runs in parallel with Wave A because the file sets don't overlap.

| Wave | Batches (parallel inside a wave) | Depends on |
|---|---|---|
| A | P9-1 Device frames · P9-4a Theme bridge core · P9-5a Scorecard generator | P8-2 |
| B | P9-2a Playground data + P9-2b Playground UI · P9-4b Theme bridge UI + CLI · P9-5b Scorecard UI | A |
| C | P9-3a Flow primitives + flows · P9-3b Flows in docs + CLI | B (uses frames) |
| D | P9-6 App starters (`dashcn create`) | C (uses flows) |
| E | P9-Z integration: component page layout, nav, landing hero, screenshots, final gates | all |

**Shared-file rule:** `docs/lib/pages/component_page.dart` and `docs/lib/routing/docs_nav.dart` are touched only by the
P9-Z integrator (or by one named batch per wave); feature batches deliver self-contained widgets + one integration
point documented in their report.

---

## P9-1 Every platform at once (device frames)
**Goal:** any preview can be shown inside an iPhone, Android, desktop window or browser frame — or all four side by side
— running the *same* widget instance tree per frame, with real platform behaviour (safe areas, text scale, platform
scroll physics, keyboard affordances).

Design
- `docs/lib/widgets/device_frame/` (new): `DeviceSpec` (name, logical size, safe-area insets, corner radius,
  devicePixelRatio, `TargetPlatform`, chrome painter), specs `iphone16`, `pixel9`, `macosWindow`, `browser`.
  `DeviceFrame(spec, child)` paints chrome with `CustomPainter` (no images), clips, and wraps the child in
  `MediaQuery(size, padding, viewPadding, devicePixelRatio)` + a platform override.
- Platform override: verify how the kit reads platform (`defaultTargetPlatform` / `Theme.platform`?). If components read
  `defaultTargetPlatform`, add `ThemeData.platform` (nullable; falls back to `defaultTargetPlatform`) and route the reads
  through `Theme.of(context).platform` — kit change, own sub-task with tests. Mark findings UNVERIFIED until read.
- `PreviewFrameBar` toolbar: `None · iPhone · Android · Desktop · Web · All`, plus rotate (portrait/landscape) and
  light/dark. "All" = a `Wrap` of four frames scaled with `FittedBox`, each its own subtree. Choice persists in
  `docs_state` and the URL (`?frame=iphone`).
- Mobile site width: frames scale down; "All" becomes a horizontal snap scroller.

Acceptance: every component and block preview renders in all 5 modes without overflow/exceptions in light+dark; widget
tests per spec (insets visible to child via `MediaQuery.paddingOf`, platform visible via `Theme.of(context).platform`);
golden-free screenshot captures for 6 representative components → `rearch/screenshots/p9-1/`.
Owns: `docs/lib/widgets/device_frame/**`, `docs/test/device_frame/**`, kit platform plumbing (if needed) +
its tests.

## P9-2 Live props playground
**Goal:** a Controls panel next to the preview edits props live and rewrites the code sample underneath.

Design
- **Data (P9-2a, generator):** extend `docs/tool/gen_docs_data.dart` to emit `docs/lib/generated/docs_controls.dart`:
  per component a list of `ControlSpec` derived from the existing API extraction — `bool` → switch, enum → select
  (enum values resolved by scanning the kit's `lib/src/**` enum declarations with the analyzer), `String` → text,
  `int/double` → slider (range heuristics + manifest override), `Color` → theme-token picker, `Widget child` with a
  text child → text, `VoidCallback?` → "enabled" switch (null vs noop). Skips anything else (listed as read-only).
  Manifest may add `playground: {exclude: [...], ranges: {...}, defaults: {...}}` per component.
- **Builders:** `docs/lib/playground/builders/<id>.dart` — `PlaygroundBuilder` with `Widget build(PlaygroundValues)`
  and nothing else; the *code string* is generated generically from `ControlSpec` + values (emit only non-default
  args, `const` when possible, `dart format`-like layout). Hand-written builders for the top 30 components first
  (button, badge, input, textarea, checkbox, switch, radio set, select, slider, toggle, toggle group, tabs, card,
  alert, avatar, progress, skeleton, tooltip, dialog trigger, popover, dropdown, accordion, calendar, date picker,
  pagination, breadcrumb, separator, label, kbd, spinner); the rest show "Playground coming soon".
- **UI (P9-2b):** `docs/lib/playground/controls_panel.dart`; right rail ≥ 1100 px, below the preview otherwise, bottom
  sheet on phones. Live code block (existing syntax highlighter, selectable + copy). Values in URL
  (`?p.variant=outline&p.size=sm`) so a configured preview is shareable. "Reset" restores defaults.
Acceptance: unit tests for code emission (defaults omitted, enums qualified, strings escaped) and generator `--check`;
widget test per hand-written builder: changing each control changes the rendered widget and the code; codegen
stays deterministic.
Owns: `docs/tool/gen_docs_data.dart` (controls section only), `docs/lib/generated/docs_controls.dart`,
`docs/lib/playground/**`, `docs/test/playground/**`.

## P9-3 Screens & Flows
**Goal:** installable, navigable mini-apps — mobile-first — next to Blocks.

Flows (v1.0): `onboarding-01` (3 swipeable pages + skip, permission ask), `auth-01` (sign in, sign up, OTP, forgot
password, social buttons), `checkout-01` (cart → address sheet → payment → success; swipe-to-delete cart rows),
`settings-01` (grouped list, nested pages, toggles, account sheet, sign-out confirm), `chat-01` (thread list with
swipe actions, conversation with composer, attachments sheet, pull-to-refresh).

Design
- **Kit (P9-3a):** new registry layer `lib/src/flows/<id>/` with `flow.dart` (entry: `<Name>Flow` widget owning a
  nested `Navigator` + `AppPageRoute`s) and `screens/*.dart`; manifest type `flow` with `screens`, `dependencies`
  (components/blocks), `entry`. Gap-fill primitives the flows need, each a normal component with tests if missing
  (verify first): `bottom_sheet` (drag handle, snap points, swipe-dismiss), `tab_bar` (bottom navigation),
  `swipe_actions`, `pull_to_refresh`, `page_indicator`. Theme-dependent spacing/density only (existing rule).
- Flows take callbacks/data in, never fake backends: `AuthFlow(onSignIn: ..., onSignUp: ...)`; demo data lives only in
  docs previews.
- **Docs + CLI (P9-3b):** "Flows" section (nav + index cards), each flow page runs inside the P9-1 phone frame by default
  with a screen map (thumbnail strip, tap to jump) and code per screen. CLI: `dashcn add flow:auth-01` installs the
  whole flow + deps (copy mode) or adds the import (package mode).
Acceptance: per flow an end-to-end widget test that walks every screen via taps/drags (incl. sheet + swipe gestures)
in light/dark and RTL; layers check passes (flows may use blocks/components, never the reverse); screenshots of every
screen at 390×844.
Owns: `lib/src/flows/**` + new primitives + tests (3a); docs flows pages + CLI flow install (3b).

## P9-4 Bring your web theme
**Goal:** paste a shadcn / tweakcn / Tailwind theme → dashcn theme; export back to CSS, Tailwind and Figma tokens.

Design
- **Core (P9-4a), pure Dart, no Flutter import** so docs and CLI share it: `lib/src/theme/interop/`
  - parsers: shadcn v3 CSS (`--primary: 222.2 47.4% 11.2%` HSL triplets), shadcn v4 / tweakcn CSS (`oklch()`,
    `:root` + `.dark`, `--radius`, `--font-sans/serif/mono`, `--shadow-*`, `--chart-*`, `--sidebar-*`), Tailwind v4
    `@theme { --color-* }`, Tailwind v3 `theme.extend.colors` object literal (restricted literal parser, no JS eval);
    colour spaces oklch/oklab/hsl/rgb/hex with gamut mapping.
  - writers: shadcn v4 CSS, Tailwind v4 `@theme`, **W3C DTCG** `*.tokens.json` (Figma Variables / Tokens Studio), dashcn
    theme JSON (existing ThemeDocument) and Dart (`app_theme.dart`).
  - `ImportReport` lists mapped / defaulted / ignored variables — never silent.
- **UI + CLI (P9-4b):** Theme Studio gains Import (paste or drop a file, live preview, report) and Export (tabs per
  format, copy/download). CLI: `dashcn theme import <file|url> [--name]` and
  `dashcn theme export --format css|tailwind|dtcg|dart`.
Acceptance: fixtures for every preset (42) + 5 real tweakcn exports; round-trip `parse(write(t)) == t` within ΔE2000 <
0.5; parser fuzz test (no throws on garbage, report instead); CLI unit + e2e test.
Owns: `lib/src/theme/interop/**` + tests (4a); Theme Studio import/export widgets, CLI theme commands (4b).

## P9-5 Trust scorecards
**Goal:** each component page shows measured, reproducible quality facts — never hand-typed numbers.

Metrics (per component, from its previews/examples):
- **Accessibility**: `meetsGuideline(textContrastGuideline)`, `labeledTapTargetGuideline`, `androidTapTargetGuideline`,
  `iOSTapTargetGuideline` + semantics present (role/label) — pass/fail each.
- **RTL**: renders under `TextDirection.rtl` with no exceptions/overflow and mirrored layout checks (leading edge
  assertions) — pass/fail.
- **Frame time**: build+layout+paint time over 120 pumped frames of its interaction animation in the test env, p50/p90
  in ms, labelled "test environment, relative" (honest). Optional real-device numbers later via `integration_test`.
- **Tests**: number of test cases tagged to the component (`tags: ['component:<id>']` or path
  `test/**/components/<id>/`), and pass status at generation time.
Design (P9-5a): `tool/gen_scorecards.dart` runs a generated harness test with `--reporter json`, writes
`lib/src/manifests/scorecards.json` (`generatedAt`, `commit`, per-id metrics, `null` = not measured), `--check` mode for
CI. (P9-5b) docs `ScorecardCard` with badges + "How we measure" page; CI job regenerates on main.
Acceptance: generator deterministic except timestamp/commit; missing data shows "not measured", never a fake pass;
tests for the generator parsing; card renders light/dark.
Owns: `tool/gen_scorecards.dart`, `test/scorecards/**`, `lib/src/manifests/scorecards.json` (5a);
`docs/lib/widgets/scorecard/**`, docs "how we measure" page (5b).

## P9-6 App starters — `dashcn create`
**Goal:** `dashcn create saas my_app` scaffolds a full, runnable app from flows, blocks and a theme.

Design
- Starter definitions are data in the kit: `lib/src/starters/<id>/starter.json` (routes → flows/blocks, nav shell,
  theme preset, platforms, optional packages) + small `templates/*.dart.tmpl` for `main.dart`/router/shell.
- v1.0 starters: `saas` (auth-01, onboarding-01, dashboard-01, settings-01, pricing-01, sidebar shell on desktop / tab bar
  on mobile), `chat` (auth-01, chat-01, settings-01), `shop` (auth-01, checkout-01, product grid block, settings-01).
- CLI: `dashcn create <starter> <name> [--theme <preset|file.css>] [--mode package|copy] [--platforms ...] [--org ...]`
  → runs `flutter create --empty`, adds `dashcn` (package) or copies sources (copy), writes app files, `dart format`,
  prints next steps. `--theme file.css` uses P9-4 import. `dashcn create --list`.
Acceptance: e2e test per starter in a temp dir: create → `flutter analyze` (0 issues) → `flutter test` (generated smoke
test walks main routes) for both modes; idempotency/overwrite guard tests.
Owns: `lib/src/starters/**` (kit), CLI `create` command + templates + tests.

## P9-Z Integration + QA
Component page layout (frame bar, playground rail, scorecard card), nav (Flows, Starters, Theme import), landing hero
(“Every platform at once” demo using frames + a flow), docs pages for each feature, regenerate all data, every gate in
both repos, screenshots of every new surface (phone/desktop, light/dark), report `rearch/reports/P9_FINAL_QA.md`.

## Gates (every batch)
Kit `rearch/qa_gate.sh` + generators `--check` + `check_names`; docs format/analyze/test/`gen_docs_data --check`/
`sync_registry --check`/`flutter build web --release`; CLI format/analyze/test/e2e. Orchestrator screenshots every UI
change (agents must not open PNGs).
