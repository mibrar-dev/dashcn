# Menus and bars sizing, popup fixes

Branch `fix/sizing-menus-bars` (worktree `dashcn-w-menus`, notes `scratchpad/ui/round2/menus`).
Scale: `scratchpad/ui/design/SIZING.md` (4 px scale; 14/20 body, 16 icons;
field 36, row 32, bars 36+4/28; rows 8h/6v; surfaces 4, free-content popups 8,
panels 16; same sizes desktop+mobile, invisible hit area only).

## Measured sizes (after; widget-test px == PNG px at dpr 1)

| Element | Before | After | Proof |
|---|---|---|---|
| Menubar root | 56 (bar borders y358-413 in PNG) | **36** (borders y368-403) | `menubar_test` bar 36 |
| Menubar triggers | 48, chevrons on | **28**, px 8, no chevrons | `menubar_test` 28 + 8/4 padding, `showChevron isFalse` |
| Open menu rows | 32 | **32**, 8h/6v, surface 4, anchored under trigger | `menu_test` row 32; `menubar_test` submenu below bar |
| Menu/dropdown/context rows | 32 | **32**, one border | `menu_test`, `popup_single_surface_test` 8/8 |
| Command rows | 48 | **32** | preview `minHeight: 32`; scorecards pass |
| Command list inset | padding inside ListView | padding outside ListView (full-bleed rows, pixel-identical) | `command_test` 11/11 |
| Menubar bar layout | plain Row (clips on overflow) | horizontal scroller, full-bleed triggers | `menubar_test` 15/15 |
| Nav-menu panel padding | 12 | **16** | `navigation_menu_test` panel padding |
| Nav-menu title-desc / item gaps | crammed (0-2 px in preview columns) | **4 / 8** | `titles sit 4 px`, `content list spaces rows 8 px` |
| Navigation rows (bar/rail/sidebar) | 12h/8v, labels stacked below icon | **8h/6v, 32 px**, row layout on vertical | `navigation_bar_test` item 32, rail row layout |
| Group labels | unmeasured | **32 px** | `navigation_bar_test`, `sidebar_test` label 32 |
| NavigationBar sidebar width | 200 | **256** | `navigation_bar_test` 256 |
| Sidebar rail | 240 / 56 | **256 / 64** | `sidebar_test` constants |
| Sidebar rows / sub-rows | 40 (padding stacked on 32) | **32 / 28** border-box | `sidebar_test` 32/28 |
| Tabs strip / pills | 36 (30 + 3) | **36 (28 + 4)** | `tabs_test` 28 + padding 4 |
| Segmented track / segments | 32 outer, 26 painted | **36 painted, 28 segments** | `segmented_control_test` 36/28; desktop PNG 382-417 = 36 |
| Segmented touch | box 48, segments stretch 48 | same (kept): 28 visuals, 48 invisible hit | touch test 48/48 |
| Popup surface padding | 4 | **8** | `popup_test` 8 px |
| Popup borders | 1 | **1** (single-surface test) | `popup_single_surface_test` |
| Popup Customized (dark) | near-white fill, invisible text | secondary/secondaryForeground tokens, readable | captures dark+light |
| Command Customized | near-white fill | muted token, readable | preview + captures |
| MenuPopupSurface text | replacing DefaultTextStyle (drops theme font) | **merge** (keeps family/size) | captures render crisp (was tofu) |

Touch: no visual enlarges on mobile (phone captures show the same 36/32/28;
menubar popup and dropdown open as bottom sheets via the existing adaptive
path with the same row sizes).

## Popup "Show popup" investigation (item 6: confirm and fix)

The anchored trigger opens in every programmatic condition: the existing
interactive test (tap shows `Ibrar Ali`), plus new tests for 8 px padding,
single surface, and the bottom-edge flip case (popup lands on screen above
the trigger, `popup.bottom <= button.top + 4`). A docs-conditions repro
(scrolled content + real OverlayManager + tap) also passes.

The live-click failure does not reproduce: taps demonstrably register live
(theme toggle, density toggle, TOC all respond), menus open live, and the
coordinate-click method used by the live test proved unreliable in this
session (missed TOC links, phantom scrolls from down/up pairs landing
seconds apart). Verdict: no component bug in the open path; the padding
(4->8), border (single, verified), dark-mode colours (fixed), and the new
on-screen regression test are the fix. The golden `popup_open` captures
prove the open + anchored state in pixels.

## Captures (`scratchpad/ui/round2/menus/captures/`, dpr 1)

Golden harness (temporary `test/registry/visual/menus_captures_test.dart`,
run with `CAPTURE_PREFIX=after|before`, deleted after the run; permanent
coverage lives in the component tests): every preview closed plus every
OPEN state (open menubars, menus, dropdowns, context menus, command inline
+ dialog, nav-menu panel, popups) at 1280x800 light+dark and
menubar/popup/sidebar open at 375x812 light+dark — 44 files per prefix.
Browser shots supplement the docs integration: `before_menubar*`,
`before_popup*` (closed + anchored button), `before_command*`,
`before_popup_1280x800_light`.

## Gates

- `dart format` (34 touched kit files): clean.
- `dart analyze` (kit + docs): No issues found.
- `dart run tool/check_names.dart`: 0 hits.
- `flutter test` (one at a time): menu 31, menubar 15, dropdown 10,
  context 24, command 11, popup 10, popup_single_surface 8, navigation_menu
  25, navigation_bar 24, sidebar 10, tabs 14, segmented 21,
  layout_audit_density 10, rearch manifest 4, previews 586, scorecards
  harness 97, interactive_previews 36 — all pass.
- Regen `--check`: scorecards, registry manifest, exports (159 libs),
  previews test, blocks tests — all up to date.
- Docs: `sync_registry.sh --check` up to date; `gen_docs_data --check` up
  to date; format 1266 files clean; analyze clean; `flutter test test/`
  938 pass; `flutter build web --release --base-href /dashcn/` builds.
- Scorecards: 0 failing components (command + menubar tap-target failures
  introduced mid-task by the 32/28 rows were resolved via the full-bleed
  scrollable precedent, then the segmented touch-hit fix; harness re-run).

## PR

PR: https://github.com/mibrar-dev/dashcn/pull/63
