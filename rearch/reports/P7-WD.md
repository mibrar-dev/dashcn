# P7-WD — theme-switch freeze + switch animation — report

## Scope

Brief `rearch/briefs/fixes/P7-WD-theme-switch.md`. Files created/modified (nothing
else touched):

- `flutter_shadcn_kit/lib/registry/theme/theme.dart` — cheap `ShadcnThemeData.lerp`
- `flutter_shadcn_kit/test/registry/theme/theme_lerp_animated_test.dart` — fast-path tests
- `docs/lib/widgets/theme_switch_transition.dart` — NEW: snapshot cross-fade
- `docs/lib/main.dart` — shell wiring (one `theme` read, new transition)
- `docs/lib/state/site_theme_model.dart` — per-document theme cache
- `docs/lib/state/docs_state.dart` — notify-before-persist in `setBrightness`
- `docs/lib/motion/ease.dart` — new `kDurationThemeSwitch` (250 ms)
- `docs/test/theme_switch_test.dart` — NEW: 8 tests
- `docs/test/docs_app_test.dart`, `docs/test/motion_test.dart` — shell expectations
- Mirror re-sync (`docs/tool/sync_registry.sh`, no flags): `theme.dart` verified
  in sync afterwards. No manifest/codegen regen (see §6).

## 1. Diagnosis (measured, before)

Temporary probe tests (run, recorded, deleted) on the pre-fix tree:

| Probe | Before |
|---|---|
| `ThemeDocument.theme()` fresh resolve | 67.2 µs avg (200 iters, debug VM) |
| `ShadcnThemeData.lerp` light↔dark toggle, t=0.5 | 43.2 µs avg (200 iters) |
| Document JSON encode, 2,601 chars (persistence payload) | 112.9 µs avg (50 iters) |
| Notifications per commit (toggle / preset / no-op) | 1 / 1 / 0 — already correct |
| `AnimatedShadcnTheme` switch, isolated dependent | **19 frames, 20 dependent rebuilds**, 9 ms wall on a trivial subtree |

Root cause: the shell wrapped the whole app in `AnimatedShadcnTheme`, so every
switch re-lerped the full `ShadcnThemeData` and rebuilt **every theme dependent
on every animation tick** (~19 full-tree rebuilds: header, sidebar, landing
collage, masonry walls, deferred previews, block pages). Persistence
(≤2.6 KB localStorage) and theme resolution (~67 µs) are two orders of magnitude
too small to be the freeze and were left synchronous (reordered, not reworked —
see §3). Hover-preview rebuilds are P7-U3's brief, not this one.

## 2. Fix

1. **Snapshot cross-fade replaces the shell tween** (`theme_switch_transition.dart`,
   wired in `main.dart`). One swap per commit; a 1× raster snapshot of the old
   frame (single `RepaintBoundary.toImage`, capture source is the content
   boundary only) fades over the new tree in ~250 ms (`kDurationThemeSwitch`,
   `kEaseOutExpo`). Fade frames repaint only the overlay layer. The overlay slot
   is always present so content never remounts (scroll/text/focus state
   survives — tested). Mid-fade commits swap the base instantly with no second
   capture. Reduced motion (or `Duration.zero`) swaps instantly, no snapshot.
   Overlay is `IgnorePointer` + `ExcludeSemantics`; stack uses non-directional
   alignment (no `Directionality` dependency).
2. **Cheap lerp in the registry** (`theme.dart`, API unchanged): `t<=0`/`t>=1`
   endpoints, `a==b` early-out, per-leg identity reuse — a light/dark toggle now
   lerps 31 colours only instead of 36 text styles + 8 shadow lists + the rest.
   `AnimatedShadcnTheme` keeps its behavior, so the Studio canvas, the themes
   preview, the theming docs and registry consumers are untouched but faster.
3. **Theme cache** (`site_theme_model.dart`): `themeFor` memoizes per
   `(document, brightness)`, cleared in `_assign`. Repeated reads in one commit
   return the identical instance (inherited-theme no-op rebuilds stay skipped).
4. **Notify-before-persist** (`docs_state.dart`): `setBrightness` notifies first,
   then writes — same order as `SiteThemeModel._assign`. One commit stays one
   notification (existing `docs_state_test` no-op/persistence tests still pass
   unchanged).
5. `main.dart` reads `state.theme` once per shell build into a local.

Deliberately NOT touched: `studio_canvas.dart` / `live_preview.dart` /
`docs_samples.dart` tweens (TH1-adjacent widget files — still correct, now
cheaper), `ShadcnApp.enableThemeAnimation` path (registry consumers),
`theming_page.dart` prose (still accurate: `AnimatedShadcnTheme` animates over
the duration/curve you pass), any rail/overlay/popup/menu/select files
(P7-U1/U2/U3), generated files, manifests.

## 3. After numbers

| Measure | Before | After |
|---|---|---|
| Content rebuilds per switch (isolated, stable child) | 20 (19 tween + 1) | **1** |
| `lerp` toggle t=0.5 | 43.2 µs | 28.6 µs (~−34%) |
| `themeFor` repeated read | 67.2 µs resolve | 0.3 µs cache hit (~200×) |
| Reduced-motion / zero-duration switch | 150 ms capped tween | instant, no snapshot, 1 rebuild |
| Mid-fade second commit | n/a (tween retarget) | base swaps, 2 builds total, completes |
| Unchanged commit | full `==` + tween check | 0 rebuilds, no snapshot |
| State across switch | n/a | preserved (counter/scroll-safe structure) |

Caveats: debug-VM widget-test proxies, not release raster/timeline data
(UNVERIFIED on release frames; the rebuild-count elimination is structural, not
timing-dependent). Full-app pump before/after was impossible: every shell-level
test currently fails to compile on TH1's in-flight `rail_picker_rows.dart:162`
(see §6). Web localStorage write time UNVERIFIED on device; payloads are ~4 B
(brightness) and ~2.6 KB (document).

## 4. Tests

- `docs/test/theme_switch_test.dart` (NEW, 8/8 pass, isolated from the app
  shell so unrelated breakage cannot block it): one-notification-per-commit,
  cache identity/invalidation, once + fade + complete, reduced-motion instant,
  zero-duration instant, mid-fade commit, unchanged no-op, state survival.
- `test/registry/theme/theme_lerp_animated_test.dart` (+2, 5/5 pass with the
  file; `test/registry/theme` + `test/registry/themes` 63/63 pass).
- `docs_state_test.dart` 11/11 pass unchanged.
- `docs_app_test.dart` / `motion_test.dart` shell assertions updated to the new
  contract (`ThemeSwitchTransition`, 250 ms; `Duration.zero` under reduced
  motion). **UNVERIFIED by execution**: both files fail to load until TH1 fixes
  `rail_picker_rows.dart` (analyze-clean, reviewed by hand).

## 5. Animation

~250 ms snapshot cross-fade on preset and light/dark switches (brief's
snapshot option; circular reveal rejected as clip/shader jank-prone). Same
`kEaseOutExpo` curve as the old tween for visual continuity. First frame after
commit is the new theme under the fading old frame — no flash, no layout shift
(snapshot is pixel-identical to the pre-switch frame).

## 6. Gates (2026-10-11, other agents active in the tree)

- Registry `dart format`: my files clean; 10 files need formatting, all
  P7-WB/WC (`button_status_content`, `card_image`, `keyboard_shortcut` ×2,
  table previews/resize, shortcut/table tests) — not mine.
- Registry `dart analyze lib`: my file clean; 1 syntax error in
  `primitives/table_layout/table_resize.dart:441` (P7-WC in-flight).
  `analyze test`: 3 warnings in `dot_indicator_test.dart` (in-flight).
- `check_layers`: `undeclared-dependency: 2` both in
  `components/dot_indicator/dot_indicator.dart` (in-flight). `owner`:
  pre-existing `switcher/preview.dart` (also noted in P7-Z). `user_theme`: 0.
  `banned`: empty.
- `test/rearch/registry_manifest_test`: fails on blocks drift
  (`ageDefaultHoverScale` vs `ageDefaultAspectRati…`) — other agents' component
  work; my change adds no files/imports so it cannot affect the manifest.
- Docs `dart format` (my 8 files): clean. `flutter analyze`: exactly 1 issue,
  `rail_picker_rows.dart:162:27` undefined `theme` (TH1 in-flight; U3's file,
  committed as 959aa86 then edited by TH1's uncommitted `P7-TH1` hunk).
- Docs `flutter test`: 57 pass; 22 load-failures, all with the single
  `rail_picker_rows.dart:162` root cause (verified: every `Error:` line
  identical). `gen_docs_data --check`: 2 files out of date from other agents'
  component work (my change touches no generator inputs — generator reads
  component entries + `color_tokens`/`tokens.dart`, never `theme.dart`'s lerp).
  `sync_registry.sh --check`: behind on `resizable`/`stepper`/`table` previews
  (in-flight; re-syncing now would mirror `table_resize.dart`'s syntax error
  into the docs tree, so the mirror was synced once for my file and left).
- `flutter build web --release`: fails only on `rail_picker_rows.dart:162`.
- `theme.dart` grew 472 → 506 lines (+34 for the per-leg fast path; file was
  already on P7-Z's over-length exemption list — a split would churn
  `AnimatedShadcnTheme`/tween/`ComponentTheme` ownership and manifests).

## Open questions

- TH1's `rail_picker_rows.dart:162` blocks all shell-level verification
  (`docs_app_test`, `motion_test` app tests, full-app before/after
  frame timings, release build). Re-run those three commands after TH1 lands.
- Residual: the Studio canvas (`studio_canvas.dart`) still runs a per-frame
  tween over its masonry wall per rail edit — cheaper via §2.2 now, but a
  second snapshot boundary there is a possible follow-up (not this brief).
- Release raster/timeline numbers (≤16 ms frames claim) need a profiled
  release build once the tree compiles again.
