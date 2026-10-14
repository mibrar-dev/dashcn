# P7-WB — navigation bar, refresh trigger, overflow marquee, card image, pinned sheet, dot indicator

**Brief:** `rearch/briefs/fixes/P7-WB-components.md`
**Owner (this sub-agent):** `navigation_bar`, `refresh_trigger`, `overflow_marquee`,
`card_image`, `pinned_sheet`, `dot_indicator`
**Scope excluded (other agents live there):** `button`, `navigation_menu`, `table`,
`keyboard_shortcut`, `primitives/form_core`, `drawer`/`drawer_container` chrome, docs theming
(TH1). All gate failures traced to those files are recorded in §6, not fixed.

## 1. What changed, per component

### 1.1 `navigation_bar` — beautiful, working previews
`preview.dart` rewritten: three static/no-signal examples became five interactive scenes, each
with its own selection state and a status echo:

| Example | What it shows |
|---|---|
| Bottom bar | mobile tab bar, 4 items, count badge + status dot, `labelType: all` |
| Sidebar rail | 120×300 rail, icon-over-label, vertical stack |
| Top bar | icon + label side-by-side (`labelPosition: end`), active pill marks the tab |
| Icon only | compact bar, labels collapsed to zero height, hover tooltips (`labelType: tooltip`) |
| Sidebar groups | 260×320 sidebar: `NavigationLabel`, 4 items (incl. disabled), `NavigationDivider`, `NavigationGroup` + expanded `NavigationCollapsible` with nested items |

**Widget source unchanged** (the bar already worked; it was the previews that were static).
Badge overlays are built with `Stack(clipBehavior: none)` + `Positioned(top: -6, right: -10)`
so the count sits on the item's top-right corner without changing the item's layout.

### 1.2 `refresh_trigger` — pull-to-refresh fixed at the root
**Root cause (verified):** the trigger only listened to `ScrollNotification`. On desktop web a
pull is delivered two ways that never produce one:
1. **Wheel/trackpad** → `PointerScrollEvent`, which bypasses the gesture arena entirely. At the
   list's leading edge the inner scrollable expresses *no* interest in the event, so it bubbles
   to the outer page scrollable and the page scrolls instead ("opens all the way up").
2. **Mouse drag** → `Scrollable.dragDevices` defaults to touch-like devices only, so a mouse
   drag is never claimed by the child and no notification is ever emitted.

A pure-`ScrollNotification` listener therefore cannot ever arm on desktop web.

**Fix (3 files by responsibility):**
- `refresh_trigger_input.dart` (**new**) — `RefreshPullInput`: one transition table
  (`accumulate` / `resolve` / per-path resolvers) shared by all three input paths, so the arming
  threshold, the settle timer and the fire/snap-back decision exist exactly once.
- `refresh_trigger.dart` — mechanics + lifecycle: `Listener(onPointerSignal:)` accumulates wheel
  ticks; `Listener(onPointerDown/Move/Up/Cancel:)` tracks mouse drags via raw pointers (gated on
  `PointerDeviceKind.mouse` + `kPrimaryButton`, so touch/stylus/trackpad drags are untouched and
  keep flowing through the notification path); `_outwardForUpdate` centralises the reverse/axis
  sign algebra.
- `refresh_trigger_indicator.dart` (**new**) — the default pill (arrow/spinner/check + localized
  labels), extracted for the ~400-line rule.

Preview is now a live inbox: pull → "Refreshing…" → a freshly-fetched row is prepended and the
time stamped → done pill → snap back. Works by touch drag, mouse drag, and wheel/trackpad.

> **Attempted and reverted:** a `ScrollConfiguration(NeverScrollableScrollPhysics)` child lock
> while pulling. Swapping a scrollable's `_configuration` *during* a drag recreates its
> `ScrollPosition` mid-gesture (`ScrollableState._updatePosition` disposes the old position), which
> cancelled the touch drag mid-flight and killed the pull. Removed rather than worked around.

### 1.3 `overflow_marquee` — preview showed nothing
**Root cause:** *not* a render bug — `_RenderMarquee` paints correctly (proved by three new tests
in the existing suite: a long unwrapped `Text` in a width-bounded box paints non-zero; it also
paints under stage-like unbounded height; a fitting text paints at its natural size). The docs
preview itself was the thin part: no explicit width on the ticker band and a lorem placeholder,
so it read as an empty stage against the dotted canvas.

**Fix:** three realistic, bounded scenes — a now-playing row (48px token thumb, play/pause
toggle, scrolling track title), a live news ticker (`LIVE` badge + scrolling headlines), and a
long filename inside a 240px file card (icon + `quarterly-report-final-v2-ACTUAL-final.pdf` +
size). All sit in explicit `SizedBox(width:)` bands.

### 1.4 `card_image` — tall thin bar
**Root cause:** the content was wrapped in `IntrinsicWidth` on the vertical axis. A bare
`IntrinsicWidth` gives its child a *max* width of zero — literally "a few 0.0-size things" — so
the card collapsed to the title's intrinsic width. An image child with a height but no width
(`SizedBox(height: 120)`) passes a `TightW` of 0 to `IntrinsicWidth`, i.e. **no card at all**;
with `Flex` children of unambiguous width the child width is only the smallest child (`Text`
"Sunset"), so the card rendered as a tall thin bar with an over-wide image.

**Fix:** removed `IntrinsicWidth`/`IntrinsicHeight`; the vertical image surface now uses
`AspectRatio(aspectRatio: 16/9)` (new theme field `aspectRatio`, default
`cardImageDefaultAspectRatio = 16/9`) so the surface fills the card width and the card follows a
bounded parent. Horizontal keeps `IntrinsicHeight` (found necessary, see below).

**Horizontal crash found and fixed:** the very first `previews_test.dart` run threw
`BoxConstraints forces an infinite height` from `RenderGap`, because a bare `Row` under a
loose-height parent hand `Gap` an infinite height. Restored `IntrinsicHeight` for the horizontal
direction only (the vertical path never needs it, since `AspectRatio` sizes the media directly).

Preview is a live 2-card grid (one row) — sized to two 200px cards so the 720×420 stage never
overflows (a 4-card grid overflowed by 108px in `previews_test.dart`; see §5).

### 1.5 `pinned_sheet` — handle always at the top
**Root cause:** the handle is drawn inside `DrawerRawContainer.build`, which hard-codes a
`Column` with the handle at the top and a `Center(child:)` for it, for every side.

**Constraint:** `drawer_container` belongs to another batch (P7-WA overlays), so the chrome
container could not be edited.

**Fix (inside `pinned_sheet`):** the sheet now passes `showDragHandle: false` into
`DrawerContainerData` (so the chrome's top handle can never double up) and draws its **own**
`_SheetHandle` — a `Stack(fit: passthrough)` sibling positioned per resolved side:

| Sheet opens from | Handle |
|---|---|
| bottom | top, horizontal pill |
| top | bottom, horizontal pill |
| left | **right** edge, **vertical** pill (axes swapped) |
| right | **left** edge, **vertical** pill |

The handle is positioned inside the chrome's `Stack` rather than outside it because an
outside-positioned handle clips when the sheet is fully open. It floats 8px inside the edge
(the drawer's own `gapBeforeDragger` default) so it never clips, and stays visible at every snap
stage (peek included). Same rule as the chrome handle it replaces: shown while `draggable`,
hidden when `draggable: false` or `showDragHandle: false`.

### 1.6 `dot_indicator` — no gaps between dots
**Root cause:** the dot *fill* lived on the `Clickable` decoration while the gap was faked with
`Clickable` **padding**. Padding is applied inside the decoration, so the fill painted over the
padding and neighbouring dots touched — visually one merged pill, with **zero** gap. (The
spacer path only ran for read-only runs, which do have gaps.)

**Fix:** the fill now lives on the inner dot (`_StateDot`), reading `WidgetStatesData` from the
enclosing `Clickable`'s provider so hover/press/focus tints still reach it. The padding stays a
transparent tap target of half the gap per side, so tap targets still meet mid-gap — the visual
gap is exactly the theme gap in both interactive and read-only runs.

**Also:** the default gap is now the theme token (`spacing.sm`, shadcn `gap-2`, density-aware and
scaled) instead of the hard-coded `8 * scaling`; active dot diameter 12, inactive 8 — distinct
rows driven by the token defaults.

## 2. Files written

**Registry (owned):**
- `flutter_shadcn_kit/lib/registry/components/navigation_bar/preview.dart`
- `flutter_shadcn_kit/lib/registry/components/refresh_trigger/{preview.dart, refresh_trigger.dart, refresh_trigger_indicator.dart (new), refresh_trigger_input.dart (new), meta.json}`
- `flutter_shadcn_kit/lib/registry/components/overflow_marquee/preview.dart`
- `flutter_shadcn_kit/lib/registry/components/card_image/{preview.dart, card_image.dart, card_image_style.dart, card_image_theme.dart (no change), meta.json, README.md}`
- `flutter_shadcn_kit/lib/registry/components/pinned_sheet/{pinned_sheet.dart, meta.json}`
- `flutter_shadcn_kit/lib/registry/components/dot_indicator/{dot_indicator.dart, dot_indicator_style.dart, dot_indicator_theme.dart (no change), preview.dart, meta.json}`

**Tests (owned):**
- `test/registry/components/{navigation_bar,refresh_trigger,overflow_marquee,card_image,pinned_sheet,dot_indicator}_test.dart`

**Generated (owned by the generators, re-run):** `lib/registry/manifests/registry.json`,
`docs/lib/ui/shadcn/**` (mirror), `docs/lib/generated/*`, `docs/lib/previews/*`.

## 3. Commands run → outcome

| Command | Outcome |
|---|---|
| `dart run tool/registry/gen_registry_manifest.dart` | generated |
| `dart run tool/registry/gen_registry_manifest.dart --check` | up to date |
| `dart run tool/registry/gen_previews_test.dart` | generated (83 components) |
| `dart run tool/registry/gen_previews_test.dart --check` | up to date |
| `docs/tool/sync_registry.sh` | mirrored 713 Dart files |
| `docs/tool/sync_registry.sh --check` | up to date |
| `dart run tool/gen_docs_data.dart` | written |
| `dart run tool/gen_docs_data.dart --check` | up to date (13 files) |
| `dart analyze lib/registry` | **No issues found!** |
| `dart analyze test/registry` | No issues found! |
| `flutter test test/registry` | 4963 tests, 24 failures — **all** in `form`/`form_core`/`phone_input` (other agents) |
| `flutter test <my 6 suites>` | **134 tests, all passed** |
| `flutter test test/registry/previews_test.dart` | 502 tests, all passed (after the grid fix in §5) |
| `rearch/qa_gate.sh` | format clean; analyze clean; layers 0 errors; owner/theme/banned clean; remaining items = other agents |
| `flutter build web --release` (docs) | ✓ Built build/web (22.7s) |

## 4. Captures

`rearch/screenshots/p7wb-{navigation_bar,refresh_trigger,overflow_marquee,card_image,pinned_sheet,dot_indicator}-{light,dark}.png`
(12 files). Rendered from a local release build served over HTTP; dark captured by emulating the
platform colour scheme, which the docs site follows when no explicit mode is chosen. Files were
not visually inspected (no image reading) — `flutter analyze`, the widget suites and the release
build are the functional proof; sizes are all 28–76 KB, i.e. non-blank renders.

## 5. Regression caught by the shared suite

`previews_test.dart` failed with `card_image claude/dark` and `card_image neutral/*`:
**`A RenderFlex overflowed by 108 pixels on the bottom`** — the 4-card grid at 200px wrapped to
3+1 across the 720px stage and overflowed its 420px height. Fixed by constraining the grid to
424px (two 200px cards + the `spacing.lg` gap) → one row of two. `previews_test.dart` now fully
green (502 tests).

## 6. Gate failures recorded (other agents' in-flight files — NOT fixed, per instructions)

1. `dart analyze lib/registry` reported `primitives/form_core/form_entry.dart:123,126 - Undefined
   name '_validityRequest'` (+3 unused-field warnings). Now **resolved** by the owning agent
   during my run (analyze is clean at final measurement).
2. `flutter test test/registry` — 24 failures, all downstream of those same files:
   `form_test.dart` (3), `phone_input_test.dart` (1), plus 20 more in the same area.
3. `test/registry/qa/interactive_previews_test.dart` **fails to load**:
   `components/keyboard_shortcut/keyboard_shortcut.dart:170:37: Error: Not a constant expression`
   (`const ThemedColor.value(Colors.transparent)`). That suite is the one carrying the
   interactive assertions for MY components, so it could not be executed — my equivalent
   interactions are proven in each component's own suite instead (§3).
4. `test/registry/qa/previews_centered_test.dart` **fails to load**, same cause via
   `table/preview.dart` syntax errors. It is generated and regenerates cleanly on my side.
5. `rearch/qa_gate.sh`'s `stray:` line is long because other agents have ~250 modified files in
   the tree; every one of my own files is either on the list above or a generator output.

## 7. Open questions

- **Refresh trigger on the docs page:** my widget tests prove the wheel/mouse/touch paths inside a
  `SizedBox` stage (the shape `previews_test.dart` uses). The live docs interaction (a real
  trackpad gesture on the deployed page) could not be captured here — the Flutter canvas does not
  expose an accessibility tree to `agent-browser`, so click-by-coordinate was not feasible
  either. **UNVERIFIED at the browser level**, verified at the widget level.
- **`drawer_container` handle ownership:** the sheet now draws its own handle and suppresses the
  chrome's. If P7-WA moves the handle into the chrome with per-side geometry, the sheet's
  local handle becomes redundant and should be dropped in favour of the container's.
- **`file-too-long` warnings** (48 across the registry, pre-existing baseline) — my largest new
  file is 339 lines (`refresh_trigger.dart`), inside the ~400 rule.

## 8. Continuation session (2026-10-12) — reconciliation with the committed QA contract

The tree had moved since the first session: commits `102fb81`/`216a804`
(P7 batch + P7-Q2 QA) established a **committed QA contract** that two of my
uncommitted preview rewrites violated. The full `test/registry` run
(5001 passed, 15 failed) showed 6 failures in my area, all preview-content
mismatches against committed tests — never widget bugs:

| Failure | Root cause |
|---|---|
| `navigation_bar_qa` (4) | My 5-scene rewrite replaced the committed `Default` / `With labels` / `Sidebar` examples the QA tests index by position (`previews[0..2]`) and pin by label (`Home`/`Search`/`Settings`/`Disabled`, `Account`/`Profile`, `navigationCollapsibleChildrenKey`). E.g. `With labels` became `Sidebar rail` → `find.text('Home')` found 0 widgets. |
| `refresh_trigger_qa` (1) | My inbox preview has no `Row 1` text. The drag itself threw nothing (line 87 passed) — content-only mismatch. |
| `interactive_previews` refresh (1) | Looks up the `Default` example by name and expects `Refreshed 0→1 time(s)` + `Fresh row 1`; my inbox scene has neither name nor strings. |

**Resolution (preview files are mine to own; QA files are read-only):**
- `navigation_bar/preview.dart` and `refresh_trigger/preview.dart` restored
  byte-identical to HEAD (`git show HEAD:…` → file; `git status` clean for
  both). The committed previews are already interactive and realistic
  (P7 batch + P7-C2: bounded pull box that prepends `Fresh row N` and stamps
  the count), so the restore keeps every brief goal except the extra scenes,
  which contradicted the pinned contract.
- Kept my `refresh_trigger.dart` implementation (wheel accumulation +
  raw-pointer mouse tracking + shared transition table): the restored
  `Default` example now pulls → `Refreshed 1 time(s)` + `Fresh row 1` in the
  interactive suite, proving the implementation fires, not just renders.
- Rewrote my `navigation_bar_test.dart` scene group (old scene names no
  longer exist) to drive the pinned examples: icon-tap selection + disabled
  tap keeps selection, all-labels visibility + tap select, sidebar select +
  collapsible toggle (with `scrollUntilVisible`, mirroring the QA suite —
  the header sits below the fold of the 320px box).
- `refresh_trigger_test.dart` is preview-agnostic (generic pump loop) — no
  change needed. `overflow_marquee`, `card_image`, `pinned_sheet`,
  `dot_indicator` had zero QA failures — untouched this session.
- Regenerated `docs` data (preview names feed `docs_previews` /
  `docs_example_sources`); all `--check` gates green. The one `dart format`
  complaint tree-wide is `button/button_status_content.dart` (another
  batch — not touched). `check_single_owner`'s one finding is
  `switcher/preview.dart:76` (another batch — not touched).

**Post-reconciliation measurements:** my 6 suites + `previews_test` = 634
passed; `navigation_bar_qa` + `refresh_trigger_qa` + the interactive
`refresh_trigger` case all pass. Remaining full-suite failures (9: toast 3,
alert_dialog 2, dialog 1, navigation_menu 1, gooey_toast 1, +1 more in that
area) are other batches' files — recorded, not fixed.

## RESULT
status: done
files_written:
  - flutter_shadcn_kit/lib/registry/components/refresh_trigger/refresh_trigger.dart
  - flutter_shadcn_kit/lib/registry/components/refresh_trigger/refresh_trigger_indicator.dart (new)
  - flutter_shadcn_kit/lib/registry/components/refresh_trigger/refresh_trigger_input.dart (new)
  - flutter_shadcn_kit/lib/registry/components/refresh_trigger/meta.json
  - flutter_shadcn_kit/lib/registry/components/overflow_marquee/preview.dart
  - flutter_shadcn_kit/lib/registry/components/card_image/{preview.dart, card_image.dart, card_image_style.dart, card_image_theme.dart, meta.json, README.md}
  - flutter_shadcn_kit/lib/registry/components/pinned_sheet/{pinned_sheet.dart, meta.json}
  - flutter_shadcn_kit/lib/registry/components/dot_indicator/{dot_indicator.dart, dot_indicator_style.dart, dot_indicator_theme.dart, preview.dart, meta.json}
  - flutter_shadcn_kit/test/registry/components/navigation_bar_test.dart
  - flutter_shadcn_kit/test/registry/components/refresh_trigger_test.dart
  - flutter_shadcn_kit/test/registry/components/overflow_marquee_test.dart
  - flutter_shadcn_kit/test/registry/components/card_image_test.dart
  - flutter_shadcn_kit/test/registry/components/pinned_sheet_test.dart
  - flutter_shadcn_kit/test/registry/components/dot_indicator_test.dart
  - rearch/screenshots/p7wb-*.png (12 captures, first session)
  - rearch/reports/P7-WB.md (this file; §8 added in the continuation session)
  - NOTE (continuation): navigation_bar/preview.dart and
    refresh_trigger/preview.dart were deliberately restored byte-identical to
    HEAD (§8) and no longer carry a diff; the refresh_trigger preview
    restore is covered by the regenerated docs data + mirror (generator
    outputs, no diff of their own beyond other batches' in-flight content).
commands_run:
  - (first session — see §3) manifest/previews/docs generators + --check, docs
  - mirror sync + --check, dart/flutter analyze, 6 owned suites (134 passed),
  - previews_test (502 passed), qa_gate.sh, docs web release build
  - CONTINUATION (this session, current tree):
  - dart format (owned files) -> clean after formatting navigation_bar_test
  - dart analyze lib/registry -> No issues found!
  - dart analyze test/registry -> No issues found!
  - 6 owned suites + previews_test -> 634 passed
  - navigation_bar_qa + refresh_trigger_qa -> all pass (were 5 failing)
  - interactive_previews refresh_trigger case -> passes (pull really fires)
  - flutter test test/registry (full) -> 5001 passed, 15 failed; 6 mine (all
  - fixed by the §8 reconciliation), 9 others' (toast/alert_dialog/dialog/
  - navigation_menu/gooey_toast — recorded, not fixed)
  - flutter test test/registry/qa -> 705 passed, same 15 failed (subset)
  - gen_registry_manifest/gen_previews_test/docs-mirror --check -> up to date
  - dart run tool/gen_docs_data.dart -> regenerated (preview-name change),
  - --check -> up to date (13 files)
  - rearch/qa_gate.sh -> format 1 changed (button/button_status_content,
  - other batch); analyze clean; rearch +42 pass; layers warnings only
  - (file-too-long 48, unused-dependency 3); owner 1 finding
  - (switcher/preview, other batch); theme 0; banned empty
key_findings:
  - refresh_trigger: ScrollNotification-only listening can never arm on desktop web — wheel/trackpad are PointerScrollEvent (bypass the gesture arena) and mouse drags are not in Scrollable.dragDevices. Fixed with one shared transition table (refresh_trigger_input.dart) + wheel accumulation + raw-pointer mouse tracking; touch/stylus/trackpad paths untouched. The restored QA-contract preview now proves end-to-end firing (`Refreshed 1 time(s)` + `Fresh row 1` in the interactive suite).
  - Reverted a child ScrollConfiguration lock: swapping scroll configuration mid-drag recreates the ScrollPosition and kills the in-flight gesture.
  - overflow_marquee: the render object was fine (3 new visibility tests prove it); the preview was thin/unbounded and read as blank. Replaced with three realistic bounded scenes.
  - card_image: IntrinsicWidth on the vertical axis gives the child max-width 0, collapsing the card to the smallest child's width. Replaced with AspectRatio(16/9) + new theme field; IntrinsicHeight kept only for horizontal (a bare Row under loose height hands Gap an infinite height and throws).
  - pinned_sheet: handle geometry is hard-coded in drawer_container (another batch's file), so the sheet passes showDragHandle: false and draws its own side-aware handle (bottom→top, top→bottom, left→right edge vertical pill, right→left edge vertical pill), inside the chrome Stack so it never clips when open.
  - dot_indicator: the fill lived on the Clickable decoration and painted over the gap padding, so dots merged into one pill. Fill moved to the inner dot (states read from the enclosing provider); default gap is now the theme spacing.sm token.
  - CONTINUATION: uncommitted preview rewrites can silently contradict a committed QA contract from a sibling batch. The committed navigation_bar/refresh_trigger previews (P7 batch + P7-C2) already satisfy the brief's interactivity goals and are pinned by name/position/label in P7-Q2 tests — restoring them (and re-pointing my own scene tests) fixed 6/6 failures with zero widget changes. Preview scene names are a cross-batch API: they feed committed QA tests and generated docs.
open_questions:
  - Browser-level verification of the docs pull gesture was not possible (Flutter canvas exposes no a11y tree to agent-browser); widget-level proof only. UNVERIFIED at the browser level.
  - If P7-WA gives drawer_container per-side handle geometry, the pinned_sheet local handle becomes redundant and should be removed in favour of the container's.
  - The shared QA suites now load and run (the keyboard_shortcut const issue was fixed by its owner). Remaining full-suite failures (9) belong to toast/alert_dialog/dialog/navigation_menu/gooey_toast batches.
  - Captures p7wb-*.png (12) show the first-session scenes; the navigation_bar/refresh_trigger scenes have since been restored to the committed contract. Re-capture on the release build UNVERIFIED this session (no image reading per brief); recommend the orchestrator re-run captures if pixel proof is required.
