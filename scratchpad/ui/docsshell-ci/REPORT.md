# Docs-shell CI fix: RTL menu anchoring — REPORT

Branch: `feat/docs-shell-fixes`. Worktree: `dashcn-w-docsshell`.
PR: https://github.com/mibrar-dev/dashcn/pull/54 (base `main`, no merge).
Failure: `dashcn test/registry/components/p7u1_overlay_test.dart`
"menu anchoring RTL opens below the trigger end edge" expected x = 300 (±1),
got 384.

## 1. Diff found (branch vs origin/main)

Only anchoring-relevant change was in menu (popover primitives untouched):

- `dashcn/lib/src/components/menu/menu.dart`
- `docs/lib/ui/dashcn/components/menu/menu.dart` (mirror)

The docs-shell batch had replaced the bar-root anchoring:

```dart
alignment: AlignmentDirectional.topStart,
anchorAlignment: below ? AlignmentDirectional.bottomStart : AlignmentDirectional.topEnd,
offset: rtl ? Offset(-raw.dx, raw.dy) : raw,   // raw fallback (-4, 8) below
```

with trailing-half logic (`alignEnd` from `RenderBox.centerX` vs
`MediaQuery.sizeOf/2`, `topEnd`/`bottomEnd` + `(4, 8)` fallback when in the
trailing half). In the RTL test the trigger at x=100 (centerX < 400 = trailing
in RTL) flipped to `bottomEnd`/`topEnd` (physical left edges), so
`popup.right` became 384 instead of the expected 300.

## 2. Fix

Restored the original directional start-edge anchoring in both copies,
unchanged test expectation:

- `alignment: AlignmentDirectional.topStart` always
- `anchorAlignment: below ? bottomStart : topEnd`
- `fallback: below ? Offset(-4, 8) : Offset(8, -4)`, mirrored physical
  offset in RTL (`Offset(-raw.dx, raw.dy)`)

Kept the unrelated docs-shell improvement in the same file (still
`sync_registry.sh --check` clean):
`minHeight: group?.rowMinHeight ?? resolveDensityTokens(context).rowMinHeight`
(compact = 32, same as the old hardcoded 32; menubar bar still passes 48).
No popover/overlay change was needed.

Resulting diff vs `origin/main` is now only the `density_tokens` import (+
blank line) and the `minHeight` legs.

## 3. Tests (run one at a time, dashcn/)

- `flutter test test/registry/components/p7u1_overlay_test.dart` — all 26 pass
  (was 1 failure on RTL end edge, now `popup.right = trigger.right + 4`,
  `popup.top = trigger.bottom + 8`).
- `flutter test test/registry/components/menu_test.dart` — 30 pass.
- `flutter test test/registry/components/dropdown_menu_test.dart` — 10 pass.
- `flutter test test/registry/components/menubar_test.dart` — 13 pass.
- `flutter test test/registry/components/popup_test.dart` — 8 pass.

## 4. Viewport checks (RTL, widget rects + docs browser)

Widget rects (single-trigger menubar, `Padding(left:100, top:50)`):

- 1280x800 RTL: trigger `(104, 54, 96x48)`, popup
  `Rect(24, 110, 204, 184)`. `right = 104+96+4 = 204`,
  `top = 54+48+8 = 110`. Anchored below the trigger's directional
  start edge (physical right edge in RTL), mirrored from LTR
  (`Rect(100, 110, 280, 184)`, `left = trigger.left - 4`).
- 800x600 RTL (CI test viewport): same anchoring, `popup.right = 300`
  for the two-button `_bar()` (`trigger.right + 4`), `top = bottom + 8`.
- 375x812 RTL and LTR: `auto` popups below 768 px become bottom sheets
  (`popupUsesSheet`, `kPopupAdaptiveBreakpoint = 768`), so the menu is
  `Rect(12, 694, 363, 800)` (812 h) / `Rect(12, 549, 363, 655)` (667 h)
  in both directions — on-screen with 12 px gutters, symmetric LTR/RTL.
  This is the existing responsive rule, not the anchoring regression;
  the dedicated `375px viewport keeps the popup on screen` test still passes.

Docs browser: served `docs/` on `:8891`, opened `/docs/components/menubar`,
set viewports 1280x800 and 375x812 via agent-browser and screenshotted
both (Flutter canvas exposes no actionable AX tree, so exact RTL anchoring
is proven by the widget rects above; docs copy is byte-identical per
`sync_registry.sh --check`). No audio played; `agent-browser close --all`
run; dev server killed.

## 5. Gates

- `dart format` (2 changed files): 0 changed.
- `dart analyze` (both menu files): No issues.
- `dart run tool/check_names.dart` (from `dashcn/`): 0 hits.
- `dart run tool/gen_docs_data.dart --check` (from `docs/`): up to date
  (18 files checked). `bash tool/sync_registry.sh --check`: mirror up to date.
  No regeneration needed (anchoring restore matches `main`; remaining delta
  does not affect generated API/preview/scorecard data).

## 6. Commit / push

Commit on `feat/docs-shell-fixes`, no force-push, trailer:
`Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>`. Do NOT merge.
