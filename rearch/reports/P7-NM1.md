# P7-NM1 — navigation menu dropdown like shadcn

## Root cause

Two defects combined into the full-width strip from the bug report:

1. **Centered placement.** `NavigationMenuState._show` anchored the panel with
   `Alignment.topCenter` (implicit anchor `bottomCenter`) and
   `allowInvertHorizontal: false`, so the panel centered under the trigger
   instead of starting at the trigger/menu start.
2. **Unbounded width.** The overlay's `flexible` width constraint hands the
   child the full viewport width, and `_MenuPopover` wrapped content in
   `ConstrainedBox(maxWidth: double.infinity)` with `NavigationMenuTheme`
   defaulting `maxWidth` to unconstrained. `NavigationMenuContentList` rows of
   `Expanded` then stretched across the whole window (measured 800px on an
   800px window, items pinned to opposite edges), pushing the panel
   border/shadow off-screen so no panel was visible.

No shared-primitive behavior was wrong: `flexible` + `PopoverLayoutRender`
are correct for menus that hug via their own surface. The fix adds the
missing hug primitive (`PopoverHugWidth` in `primitives/popover_layout.dart`)
and anchors/sizes the panel in `navigation_menu`.

## Fix

`flutter_shadcn_kit/lib/registry/components/navigation_menu/`
(`navigation_menu.dart`, `navigation_menu_style.dart`, `preview.dart`,
`meta.json`, `README.md`) plus `flutter_shadcn_kit/test/registry/components/
navigation_menu_test.dart` and shared `primitives/popover_layout.dart`:

- Placement: `alignment: topStart` / `anchorAlignment: bottomStart`
  (directional, RTL mirrors), `allowInvertHorizontal: true` so end-of-bar
  triggers flip inside the viewport; `dismissBackdropFocus: false` so
  hover-open never steals focus. Moving between open triggers still retargets
  `anchorContext`.
- Sizing: new public `PopoverHugWidth`/`RenderPopoverHugWidth` caps the child
  at `min(maxWidth, viewport - overlay-margin-gutter)` with a plain loose
  layout (no intrinsic query, so `LayoutBuilder` descendants stay safe):
  grids take the cap, small content hugs. `maxWidth` default is now 480
  (was: unconstrained); narrow viewports fit via the gutter inset.
- Panel surface: explicit popover tokens on the `OutlinedContainer`
  (popover fill, border token, `borderRadiusMd`, `shadowMd`).
- Behavior: hover opens after 80ms (`_openDelay`), hover exit closes after
  150ms grace, plain entries close on hover, press toggles, chevron rotates
  and the active trigger keeps its accent fill.
- Keyboard on each entry's focus node (ahead of the button bindings):
  Left/Right walk triggers with RTL mirroring and the panel follows,
  Down opens and moves focus into the panel (post-frame, once mounted),
  Escape closes and returns focus to the trigger (also from inside the
  panel via the existing `DismissIntent`); Escape bubbles when closed.
  Exposed for tests/programmatic use as
  `NavigationMenuItemState.focusNode`.
- Content: plain-text descriptions clamp to 2 lines with ellipsis
  (`line-clamp-2`); titles stay text-sm medium, descriptions muted.
- Previews: `Default` (Getting-started featured tile + 3 links, Components
  2-col grid of 6, Docs link), `Content list`, `With icons`.

## Verification

- New tests fail on old code, pass on new: panel 800px -> <=480px and
  start-aligned (±16px with the bar, below it), small content hugs,
  375px viewport fits with no exception, open delay, press toggle,
  arrows/Down/Escape/focus-return, 2-line clamp.
- `flutter test test/registry/components/navigation_menu_test.dart`: 22/22.
- `previews_test.dart --plain-name navigation_menu`: all presets pass;
  `qa/previews_centered_test.dart`: passes.
- `dart format`: clean. `dart analyze` on component + primitive + test:
  no issues. Banned-pattern grep: clean.
- `check_layers`: no findings in touched files (2 `undeclared-dependency`
  errors are `dot_indicator`, another agent's file). `check_single_owner`:
  public 0. `check_user_theme --strict`: 0 findings.
- Generators: `gen_registry_manifest` regenerated (own entries verified
  current by hash); `registry_barrel_generate` no diff; `gen_previews_test`
  + `--check` pass; `gen_blocks_test --check` passes.
- Docs: own 5 files mirrored; `gen_docs_data` regenerated, `--check` passes.
- `docs` web build: BLOCKED by `docs/lib/widgets/rail_picker_rows.dart`
  (`RailSeedSwatch.theme` getter error, TH1 agent's in-flight file).

## Measurements (800x600 window, before -> after)

- Grid panel width: 800.0 -> <=480 (hug cap).
- Panel left vs bar left: 252px off -> within ±16px.
- Single-content panel: 324 (unchanged, natural hug).
- 375px viewport: 383 (overflow) -> fits, no exception.

## Open issues for QA

- `navigation_menu.dart` is ~580 lines, over the ~400 budget. Splitting
  would force ~10 private state members public across the bar/panel/entries
  (one coupled state machine) or leave the main file still over budget, so
  I kept a single file; `menu.dart` (458) is the closest precedent. QA call.
- Manifest `--check` and docs `sync --check` cannot be green while other
  agents edit concurrently (`gooey_toast`, `table`, `keyboard_shortcut`,
  `carousel`, `markdown`, `resizable`, `stepper` churned during this task);
  own entries verified current; regen once more at commit time.
- Docs-page captures (`/components/navigation_menu` open state) blocked on
  the TH1 build breakage above; test-harness captures attached instead
  (`rearch/design/ours/screens/p7nm1-panel-open.png`,
  `p7nm1-panel-narrow.png`).
- References: `git show origin/main:` has no navigation-menu sources
  (path does not exist there); shadcn + base-ui docs verified via webfetch
  (delay 50 / closeDelay 50, bottom-side positioner, viewport moves between
  triggers, fade/zoom). Deployed-site click-through skipped (build blocked).
