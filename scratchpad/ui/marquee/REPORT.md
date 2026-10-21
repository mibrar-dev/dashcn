# Batch Report: Overflow Marquee

- **Component:** `overflow_marquee`
- **Branch:** `feat/ui-marquee`
- **Worktree:** `dashcn-w-marquee`
- **Port:** `8873`
- **Session:** `w-marquee`
- **Capture Folder:** `scratchpad/ui/marquee`
- **Status:** Complete, all gates pass, visual testing verified in release Web build.

---

## 1. Executive Summary & Root Cause Fix

### The CanvasKit Web Shader Mask Bug
Previously, the `overflow_marquee` preview appeared empty on Flutter Web CanvasKit because `_RenderMarquee` implemented custom edge fade masking using `ShaderMaskLayer` with `bounds = offset & size` and `BlendMode.dstIn`. On Flutter Web CanvasKit, offscreen layer surfaces are sized to `maskRect.size` with origin at (0, 0); evaluating the linear gradient shader with non-zero window offset `offset & size` caused the gradient coordinates to fall completely outside the offscreen layer surface bounds, evaluating alpha to 0 and clipping out all text content completely.

### The Solution
Replaced custom layer painting with Flutter's standard `ShaderMask` widget wrapping the layout, using a white linear gradient with `BlendMode.dstIn`. Text is now 100% visible, crisp, and renders smooth edge fades across both Light and Dark themes.

---

## 2. What Was Built & Overhauled

1. **Continuous Seamless Looping:**
   - Multi-instance virtual layout: continuous modulo arithmetic wraps instances smoothly along the scroll axis without jumps, resets, or blank intervals.
   - Computes required instances based on `viewport` size, `childExtent`, and `gap`.
   - Accurate local-to-global offset tracking (`parentData.offset = offsets.first`) ensuring hit testing and interaction work seamlessly across all moving instances.

2. **RTL Directionality & Direction Tokens:**
   - Support for `AxisDirectional.start`, `AxisDirectional.end`, `AxisDirectional.up`, `AxisDirectional.down`, plus backward-compatible support for legacy `Axis.horizontal` and `Axis.vertical`.
   - In RTL directionality, `AxisDirectional.start` correctly streams from right to left, positioning the primary instance at `viewport - extent` so that the right boundary aligns naturally at $t=0$.

3. **Motion Sensitivity & Pause Controls:**
   - **Reduced Motion:** Honours `MediaQuery.disableAnimations` and `disableReducedMotion` tokens. When active, animation holds at position 0 with ellipsis truncation.
   - **Hover Pause:** Automatically pauses scrolling when pointer hovers over the marquee surface (`pauseOnHover: true`).
   - **Focus Pause:** Automatically pauses when keyboard focus is received within the marquee tree (`pauseOnFocus: true`).

4. **Controlled & Uncontrolled Modes:**
   - New `MarqueeController` with `play()`, `pause()`, `toggle()`, `isPlaying`, `isPaused` for programmatic external control.
   - Uncontrolled mode runs autonomously via internal ticker.

5. **Builder Slots:**
   - `leading`: Pinned leading widget slot (e.g. badges, icons).
   - `trailing`: Pinned trailing widget slot (e.g. actions, icons).
   - `builder`: Custom content slot overriding default child rendering.

6. **Previews (6 Rich Named Examples):**
   - `Default`: Continuous breaking news ticker with Lucide bell icon and soft edge fades.
   - `Now playing`: Music player bar with music icon, track title marquee, dynamic playing status, and interactive play/pause button wired to `MarqueeController`.
   - `News ticker`: Destructive `Badge` labeled `LIVE` with high-speed ticker (`speed: 55.0, gap: 32.0`).
   - `Vertical`: Movie credits style vertical roll (`direction: AxisDirectional.up`, `speed: 25.0`, `gap: 16.0`).
   - `RTL reverse`: Native Right-to-Left Arabic headline with `عاجل` badge and RTL coordinate streaming.
   - `Customized`: High-speed (`75 px/s`), large gap (`40 px`), custom edge fade portion (`0.15`), pinned `FAST` badge and zap icon.

---

## 3. Customization Surface

- **Theme Data (`overflow_marquee_style.dart` & `overflow_marquee_theme.dart`):**
  - User-replaceable file `overflow_marquee_theme.dart`.
  - Properties: `direction` (`AxisDirectional`), `speed` (`double` in px/s), `gap` (`double`), `pauseOnHover` (`bool`), `pauseOnFocus` (`bool`), `loop` (`bool`), `fadePortion` (`double`), `curve` (`Curve`), `duration` (`Duration`), `delayDuration` (`Duration`), `step` (`double`).
- **Surface Resolver (`resolveMarqueeSurface`):**
  - Resolves ambient theme defaults < app theme < scoped theme < widget arguments.
  - Normalizes legacy `Axis` into `AxisDirectional`.
- **Public API:**
  - Fully backward compatible with legacy parameters (`direction: Axis`, `duration`, `step`).

---

## 4. Key Files Created / Modified

- `dashcn/lib/src/components/overflow_marquee/overflow_marquee.dart` (298 lines)
- `dashcn/lib/src/components/overflow_marquee/overflow_marquee_controller.dart` (41 lines)
- `dashcn/lib/src/components/overflow_marquee/overflow_marquee_render.dart` (314 lines)
- `dashcn/lib/src/components/overflow_marquee/overflow_marquee_style.dart` (320 lines)
- `dashcn/lib/src/components/overflow_marquee/overflow_marquee_theme.dart` (21 lines)
- `dashcn/lib/src/components/overflow_marquee/preview.dart` (282 lines)
- `dashcn/lib/src/components/overflow_marquee/meta.json` & `README.md`
- `dashcn/test/registry/components/overflow_marquee_test.dart` (18 comprehensive tests)
- `dashcn/test/registry/qa/overflow_marquee_qa_test.dart` (4 QA tests)
- `dashcn/test/registry/surface/surface_everywhere_test.dart`
- Mirror & generated files in `docs/lib/ui/dashcn/` and `docs/lib/generated/`
- Visual test captures in `scratchpad/ui/marquee/` (10 screenshots + 1 interaction video + `CAPTURES.md`)

---

## 5. Gate Exit Codes & Verification

| Gate Command | Exit Code | Result Summary |
|---|:---:|---|
| `dart format --output=none --set-exit-if-changed lib test tool` | 0 | 1635 files formatted, 0 changed |
| `dart run tool/check_names.dart` | 0 | 0 hits (no banned names) |
| `dart analyze` (dashcn) | 0 | No issues found |
| `flutter analyze` (docs) | 0 | No issues found |
| `dart run tool/gen_exports.dart --check` | 0 | Up to date (158 libraries) |
| `dart run tool/gen_scorecards.dart --check` | 0 | Up to date (96 components) |
| `dart run tool/registry/gen_registry_manifest.dart --check` | 0 | Up to date |
| `dart run tool/registry/gen_previews_test.dart --check` | 0 | Up to date |
| `dart run tool/gen_docs_data.dart --check` | 0 | Up to date (18 files checked) |
| `bash tool/sync_registry.sh --check` | 0 | Mirror is up to date (901 Dart files) |
| `flutter test test/registry/components/overflow_marquee_test.dart` | 0 | 18/18 tests passed |
| `flutter test test/registry/qa/overflow_marquee_qa_test.dart` | 0 | 4/4 tests passed |
| `flutter test test/registry/surface/surface_everywhere_test.dart` | 0 | 36/36 tests passed |
| `flutter test test/hero_count_test.dart` | 0 | All passed |
| `flutter test test/audit/preview_static_audit_test.dart` | 0 | All passed (132 rows) |
| `flutter test test/component_page_test.dart` | 0 | All 16 tests passed |
| `flutter build web --release --base-href /` | 0 | Release web build succeeded |

---

## 6. PR & Deliverable Information

- **PR URL:** (Pending push & PR creation)
- **Branch:** `feat/ui-marquee`
- **Base:** `main`
- **Pending / Not Done:** None. Everything in scope is complete and verified.
