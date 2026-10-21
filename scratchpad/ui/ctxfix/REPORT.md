# REPORT — context_menu hit-test-only target (`feat/ui-context-target`)

Branch: `feat/ui-context-target`. Worktree: `dashcn-w-ctx`.
Scope: keep layout unchanged; 48px touch floor and 160–320 menu clamp stay;
centring test expectation unchanged (±2px at 210).

## Root cause

`ContextMenu.build` wrapped the trigger as
`Padding(targetPadding 8) → ConstrainedBox(min 48 on touch) → GestureDetector`.
Both wrappers enlarge layout:

- Desktop (macOS in `previews_centered_test`): `Padding` adds 8px top inset.
  The painted union runs from card-top (`ColumnTop + 8`) to status-bottom
  (`ColumnTop + total`), so its centre is `stageCentre + 4` → 214px vs
  expected 210px (Default, With submenu, Compact menu).
- Touch: `ConstrainedBox` floors layout to 48px, same shift plus extra size.

The audit measures painted leaves only, ignoring transparent wrappers, but
the 8px top offset shifts the painted card down, moving the union centre.

## Change

`dashcn/lib/src/components/context_menu/context_menu.dart`:

- New private `_ContextMenuTrigger` (`MultiChildRenderObjectWidget`) +
  `_RenderContextMenuTrigger` (`ContainerRenderObjectMixin`,
  `RenderBoxContainerDefaultsMixin`):
  - `size = constraints.constrain(visible.size)` — layout stays the visible
    child's size (24px icon stays 24px; 280px card stays 280px).
  - Hit rect = visible inflated by resolved `targetPadding`, then floored to
    `minSize` (symmetric extra split left/right, top/bottom). Stored as
    `_hitRect`; `hitTest` checks `_hitRect`, not `size`.
  - `hitTestChildren` delegates to `defaultHitTestChildren` (hit child on
    top first). `computeDryLayout` constrains the visible dry size.
- Hit child (paints nothing, ignored by the centred audit):
  `GestureDetector(behavior) → Listener(opaque) → SizedBox.expand()`.
  The inner opaque `Listener` guarantees a hit return without painting;
  the outer keeps the caller's `behavior`, `onSecondaryTapDown`, and
  touch-only `onLongPressStart`. No `ColoredBox`/`DecoratedBox` (those would
  count as painted content and shift the union).
- `targetPadding` resolved via `Directionality`; `minTargetSize` floor only
  on iOS/Android/Fuchsia (desktop keeps child + padding hit area).
  160–320 menu clamp untouched (`showContextMenu`).

`dashcn/test/registry/components/context_menu_test.dart` (enlarged-target
group):

- Touch floor: layout 24×24 (was 48×48) + secondary tap at (28,12)
  (4px outside visible, inside 48px floor) opens; far tap does not.
- New: touch floor with zero padding still hits 4px outside.
- Desktop: layout 24×24 (was 40×40).
- Null floor: layout 24×24 (was 40×40).
- Padding test unchanged (tap 4px outside visible inside 8px padding opens).

Meta/README unchanged (already describe a hit area, not layout).

## Test results

- `dart format` changed files: clean (0 changed on re-run).
- `dart analyze` (dashcn + docs): No issues found.
- `flutter test test/registry/components/context_menu_test.dart`: 24 passed.
- `flutter test test/registry/qa/previews_centered_test.dart --name context_menu`:
  Default, With submenu, Touch target, Expanded target, Compact menu — 5 passed
  (was 214px, now 210px ±2).
- `flutter test test/registry/qa/previews_centered_test.dart` (full): 384 passed.
- `flutter test test/registry/surface`: 36 passed.
- `dart run tool/check_names.dart`: 0 hits.
- Regen: `gen_registry_manifest`, `gen_scorecards` (dashcn) + `sync_registry.sh`,
  `gen_docs_data.dart` (docs) re-ran; all `--check` pass. Changed outputs:
  `registry.json` (hash), `scorecards.json`, `docs_api.dart`,
  `docs_scorecards.dart`, mirrored `context_menu.dart`.

## Files

- `dashcn/lib/src/components/context_menu/context_menu.dart`
- `dashcn/test/registry/components/context_menu_test.dart`
- `dashcn/lib/src/manifests/registry.json`, `scorecards.json`
- `docs/lib/ui/dashcn/components/context_menu/context_menu.dart` (mirror)
- `docs/lib/generated/docs_api.dart`, `docs_scorecards.dart`

Commit trailer: `Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>`
No merge; PR 47 CI to verify.
