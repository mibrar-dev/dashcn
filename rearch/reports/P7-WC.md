# P7-WC — table padding + resizable columns/rows; keyboard shortcut preview; ⌘K hint in docs search

Brief: `rearch/briefs/P7-WC.md`.
Components owned: `table` (+ `primitives/table_layout`), `keyboard_shortcut`,
docs header search trigger. No PNG opened by the agent (delegated to the
orchestrator's visual check); captures are structural.

## 0. Concurrent "P7-WC2" overlay (read this first — supersedes parts of §2)

While this batch was in flight another agent labelled **P7-WC2** rewrote
`keyboard_shortcut.dart`, `keyboard_shortcut_style.dart`, `keyboard_shortcut_theme.dart`,
`keyboard_shortcut/README.md`, `meta.json` **and** `preview.dart`, plus my test
file, on top of my §2 work. Their change is deliberate and defensible, so I kept
it and only repaired the compile errors it left behind:

* `KbdVariant { subtle, ghost }` — a fill variant per cap (`subtle` = the
  `muted` token, `ghost` = no fill) settable on the cap, on the chord, and in
  the theme leg; `keyboardShortcutDefaults` carries `variant: KbdVariant.subtle`
  so both legs agree.
* the default cap radius is now a **fixed 4 px** (`keyboardShortcutDefaultKeyRadius`)
  rather than the ambient `radiusSm`, so a kbd reads as a key on `radius: 0` and
  `radius: 1` presets; the default cap padding is `px-1.5 py-0.5`
  (`pxSymmetric(horizontal: 6, vertical: 2)`), which with the `text-xs` 16 px
  line (`height: 4/3`) measures exactly shadcn's `h-5` (20 px, pinned by test);
  chord `spacing` 2 → 4 (`gap-1`); `preview.dart` gains a 7th `Ghost` example,
  `README.md` a Variants section and `meta.json` the `KbdVariant` enum, the
  `variant` field and the new constant.
* repairs I made to keep the tree compiling (4 sites, all their code):
  `const ThemedColor.value(Colors.transparent)` → `const
  ThemedColor.value(Color(0x00000000))` (`Colors` is `material.dart`, banned, and
  not a const expression) in `keyboard_shortcut.dart` and in three of their new
  tests, plus the missing `import '.../theme/tokens.dart';` in
  `keyboard_shortcut_test.dart`.
* the same agent also replaced my `_SearchHint` in `docs_header.dart` with the
  real registry `KeyboardShortcut` widget (the correct fix for the stale
  comment in `docs/lib/widgets/palette.dart`), its row centred
  (`CrossAxisAlignment.center`) inside the 32 px trigger; I added the missing
  `import 'package:flutter/services.dart';` it needed for `LogicalKeyboardKey`.

**Net effect on §2:** the cap is themed, mono, bordered and centred as I
describe; radius/padding defaults and the extra ghost variant are theirs.
Previews and all tests pass on the merged result.

## 1. Table — cell padding, alignment, row/column resizing

### 1.1 Spec alignment (shadcn head `h-10 px-2 text-left font-medium`,
cell `p-2 align-middle`, row `border-b`, hover `muted/50`)

* `table_style.dart`: **header foreground `foreground` → `mutedForeground`**
  (shadcn v4 `TableHead` is `text-muted-foreground`; the old default was a
  copy of the body colour). Body/header `p-2` / `px-2`, `h-10` min height,
  `muted/50` hover and `border-b` already matched and are pinned by tests.
* Added `selected: muted` to `tableCellDefaults.background` (shadcn
  `data-[state=selected]:bg-muted`) so the new selection checkboxes show the
  shadcn selected fill.
* `table_cell_view.dart`: cells now wrap their content in
  `Align(alignment: AlignmentDirectional.centerStart)` — shadcn's
  `align-middle`. Previously a 40 px header or a taller-than-content row
  painted text at the **top** of the cell. Verified as the root cause of the
  "padding still wrong" report (the header `px-2`/`h-10` values were already
  correct; the vertical alignment was not).

### 1.2 Resizable columns and rows

Drag + keyboard + min/max + RTL all work; the resize controller was already
present and was kept:

* **New file `primitives/table_layout/table_resize_keyboard.dart`** — keyboard
  resizing extracted out of `table_resize.dart` (that file was 472 lines,
  over the 400 LOC rule; now 443 + 90). Arrows step a divider by
  `resizableHandleStep` (10 px, the same constant `primitives/resizable_handle`
  uses — no second copy), Home/End jump the leading cell to its min/max
  bound, column steps flip under RTL exactly like pointer deltas, and every
  step goes through the controller so the per-index `ConstrainedTableSize`
  clamps apply.
* `table_resize.dart`:
  * every divider now owns a real `FocusNode` (keyed per axis/cell, disposed
    in `dispose`, cleared in `didUpdateWidget` when the grid shape changes),
    so a divider is tab-reachable and a pointer press takes focus (same as
    `ResizableHandleView`), letting arrows resize right after a click;
  * **both** edges of a divider paint a handle (restored from the state before
    my refactor, see §4 — the trailing edge owns the focus node, the leading
    one mirrors it for pointers).

### 1.3 Previews

`preview.dart` rewritten (two examples, first is the default):

* **Data table** — live and realistic: sortable headers (`Name`/`Role` toggle
  direction with the shadcn arrow indicator, `chevronsUpDown` when unsorted),
  row-selection checkboxes incl. a tri-state select-all, status badges
  (`primary`/`secondary`/`outline` per status), pagination over 6 rows
  (4 per page with Prev/Next and "n of 6 selected"), and **resizable columns
  with min/max bounds** (`ConstrainedTableSize` per column). Badges are wrapped
  in `Align(centerStart)` so they don't stretch to the column width. The grid
  is height-bounded (`(_pageSize + 1) * 44`) because `ScrollableClient` has no
  shrink-wrap axis, and width-bounded to 400 so the stage centres it.
* **Invoices** — the small static grid (three rows + `Total` footer).

## 2. keyboard_shortcut — centred, themed previews

* `keyboard_shortcut_style.dart`: the cap now follows shadcn's **kbd**
  (`bg-muted border text-muted-foreground rounded-sm`). New `keyBorderColor`
  /`keyBorderWidth` fields; defaults are the `muted`, `border` and
  `mutedForeground` tokens (the old fill was `background` at 70 % alpha — not
  shadcn). `keyBorderRadius` stays null and resolves at build time (see §0:
  P7-WC2 pinned it to a fixed 4 px).
  Docs field table + `meta.json` updated.
* `keyboard_shortcut.dart`: the cap passes border colour/width to `Card`
  explicitly so an ambient `CardTheme` leg can never leak into a key cap, and
  the label renders in the ambient **mono** face (shadcn kbd) unless the user's
  `keyTextStyle` names a family.
* `preview.dart` rewritten — six centred examples: Default (⌘K from an
  activator), Modifiers (Ctrl Shift P), **Sequence** (G *then* H, not a chord),
  **In menu item** (the chord trailing a card row, like a `command` menu),
  Scoped labels and Live chord (a real `Shortcuts` binding).

## 3. Docs header — ⌘K hint in the search field

`docs/lib/widgets/docs_header.dart`: `_SearchTrigger` now renders the palette
shortcut as a **kbd at the right of the field** (`⌘K` on macOS/iOS, `Ctrl K`
elsewhere, from `defaultTargetPlatform`). Tapping it opens the palette through
the trigger's existing `onPressed`; the global `⌘K`/`Ctrl+K` bindings in
`docs/lib/main.dart` were verified unchanged. The hint was first hand-rolled
(styled like the palette footer caps) and is now the real registry
`KeyboardShortcut` widget — see §0.

## 4. Findings (worth a decision)

* **`KeyboardShortcut` private field formals are usable from other libraries.**
  `const KeyboardShortcut({required List<LogicalKeyboardKey> this._keys})`
  makes the *parameter* name `keys`; a caller outside the component library
  writes `KeyboardShortcut(keys: [...])` and the compiler accepts it (proved
  with a two-file scratch package). `docs/lib/widgets/palette.dart` documents
  the opposite ("cannot be passed from another library") — that comment is
  stale and the header now uses the real component instead of a local cap.
* **A divider handle must be painted from both neighbouring cells.** My first
  pass printed only the trailing edge, and the drag test regressed: a divider's
  exact centre lies on the trailing cell's *exclusive* hit-test edge
  (`RawCell`/`Stack` exclusive), so only the neighbour's handle is hittable
  there and vice versa. Dropping the leading handles made ~50 % of each
  divider unhittable. Both edges are therefore drawn; only the trailing one
  holds the focus node, so there is one tab stop per divider.
* `ScrollableClient` has no shrink-wrap: a table with only
  `horizontalController` inside a `Column` throws "Vertical viewport was given
  unbounded height", so the data-table preview sizes the table explicitly
  (row height is deterministic) instead of relying on intrinsic height.
* Table cells that contain a badge/`Align` used to stretch: badges in
  `shadcn_flutter_kit/lib/registry/blocks/dashboard-01/dashboard_01_table.dart`
  already wrapped theirs in `Align` (another agent's file, untouched).

## 5. Gates (final run, this tree)

| Gate | Result |
|---|---|
| `dart format` (my files) | clean |
| `dart analyze lib/registry` / `lib/registry`+tests | 0 issues / 0 issues |
| `flutter test` table + keyboard components/QA/public-API | **79 + 44 all pass** (incl. the P7-WC2 variant tests) |
| centered audit table + keyboard_shortcut | pass |
| `test/rearch` (manifest, layers, single-owner, next-layout) | **42 passed** |
| registry manifest generator + `--check` | green |
| previews barrel + centered generator `--check` | green (83 components) |
| docs `sync_registry.sh` + `--check` | green (713 files) |
| docs codegen + `--check` | green (13 files) |
| docs `dart analyze lib/widgets/docs_header.dart` | 0 issues |
| `flutter build web --release` | **✓ Built** |
| `rearch/qa_gate.sh` | format 1 file (**another agent's** `button_status_content.dart`), analyze 0/0, rearch 42, layers **0 errors** (warnings: 48 file-too-long, 3 unused-dep), owner 1 finding (`components/switcher/preview.dart`, theirs), user-theme 0, banned clean |

Remaining test failures in the tree (all **other agents' in-flight** files,
none in `table` / `keyboard_shortcut` / my test edits):
`alert_dialog`, `dialog`, `toast`, `gooey_toast`, `navigation_bar`,
`navigation_menu`, `refresh_trigger`, `carousel` in the kit suite;
`component_examples` (fails at `button@375`, before `table` is even reached),
`home_collage`, `responsive` article box, `themes_page`, `ts1_*` colour
pickers in the docs suite.

## 6. Captures

`rearch/design/ours/screens/p7wc-{table-data,table-invoices,kbd-chords,kbd-menuitem}_{light,dark}.png`
(8 PNGs, dpr 2, from `flutter_shadcn_kit/test/registry/visual/p7wc_screens_test.dart`).
Light/dark verified to differ, content horizontally centred. **Not inspected
by the agent** (the model crashes on PNGs) — visual pass belongs to the
orchestrator.

* Two host-process interruptions happened mid-run. Both times the tree briefly
  failed to compile from **other agents' in-flight edits** (`docs/lib/main.dart`
  referenced `_switchOrigin`; `studio_blocks/studio_paint.dart` missed a
  `foundation` import; `keyboard_shortcut.dart`/its tests used `Colors.transparent`
  with no `material.dart`; `docs_header.dart` used `LogicalKeyboardKey` with no
  `services.dart` import). No action was taken on files outside my ownership
  except the four compile repairs listed in §0; the numbers in §5 are post-fix.
* `test/rearch/registry_manifest_test` failed twice on a stale file hash from
  another agent's parallel edit; re-running the deterministic generator (no
  hand edits) fixed it both times. Expect this to recur while agents share the
  tree — it is not a defect in this batch.
* Docs suites most relevant to my header change (focus, palette, docs_router)
  pass; the remaining docs failures iterate non-kbd components and fail inside
  `docs_article.dart` / theme-rail code.

