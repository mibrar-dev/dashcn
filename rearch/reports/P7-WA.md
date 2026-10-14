# P7-WA — overlays over the WHOLE app + dialog/alert/toast previews + sheet/drawer scale

## 1. What changed (root fixes + previews + hosting)

### `alert_dialog/alert_dialog.dart` — layout bug at the root
Evidence `user-bugs-2026-10-11b/alert-dialog-layout.png`: icon offset at the
top-left outside the title row, actions LEFT-aligned flush to the border.
Root causes, all in this file:
- Outer `Column(crossAxisAlignment: start)` + `Wrap` sized to its content:
  `WrapAlignment.end` aligned buttons to the content's own end (reads as
  LEFT-aligned). → outer column is now `stretch`, so the row spans the card
  and the actions truly sit at its end.
- Header `Row(crossAxisAlignment: start, mainAxisSize: min)` put the 20px
  icon at the top of the title/description block (the offset). → row is now
  `max` + `center`, icon vertically centred on the title line.
- Removed the `Flexible` around the header (a flex child inside the dialog
  shell's `SingleChildScrollView` is both unnecessary and illegal in
  unbounded height).
- shadcn footer responsiveness (`flex-col-reverse sm:flex-row sm:justify-end
  gap-2`): `LayoutBuilder` stacks actions full-width below 360px and keeps
  the right-aligned row above; narrow headers centre the icon above the
  title. Unbounded width falls back to the row.
Card stays shadcn: `p-6`/`p-4`/`sm:max-w-lg`/1px border/`shadow-lg` from
`DialogTheme`, title `text-lg semibold` foreground, description `text-sm`
muted, `gap-2`/`gap-4` spacings, destructive action variant in previews.

### Previews (all working, centred, theme-token driven, light/dark)
- `alert_dialog/preview.dart`: Delete account (destructive), Discard changes
  (destructive), Session expiring (live 90s countdown, Stay signed in resets,
  Sign out — explicit way out), Success confirmation, Live push (real
  `showAlertDialog` route over the whole app). Framed cards mimic the dialog
  surface (`background`, `radiusLg`, `border`, `shadowLg`, max 420, p-24).
- `dialog/preview.dart`: Edit profile (form, Save/Cancel), Share link
  (Clipboard copy → Copied!), Invite members (working email list), Terms
  (scrollable, Accept/Decline), Picker (filter + selection pop), Barrier
  locked (see §2). Every trigger pushes a root-navigator route.
- `toast/preview.dart`: rewritten from local 360×220 `ToastLayer` boxes
  (clipped to the stage) to bare centred triggers calling `showToast` — the
  toasts open over the app through the app-level host at the configured
  position. Destructive is content-tinted (layer theme is app-wide by design).
  New Positions example covers all six `ToastPlacement`s.
- `gooey_toast/preview.dart`: ONE shared `_shared` notifier (shape
  sharp/**soft** — the enum has no `smooth` shape; soft is the smooth
  profile — animation preset, position, fill). The Playground (first example)
  hosts the controls bar; `_toast()` + Promise + Reply all resolve
  shape/animation/position from `_shared` at show time and fill through each
  layer's theme rebuilt by `ValueListenableBuilder`. Removed the divergent
  Positions/Animation-presets/Body-animation/Shapes/Booking/Tabs demos that
  hardcoded their own styles. (Promise loading pill keeps `autopilot: null` —
  behaviour, not style.)
- `drawer/preview.dart`: Default (4 edges, centred wrap), Sheet (draggable
  bottom), **Background scale** (own navigator + observer; scale reads inside
  the stage), Themed. Panel bodies use foreground/muted tokens.

### Drawer/sheet background scale (new registry capability)
- `drawer/drawer_background_scale.dart` (new, exported from `drawer.dart`,
  listed in `drawer/meta.json` + manifest): `DrawerScaleObserver` (a
  `NavigatorObserver` publishing topmost `ShadcnDrawerRoute` progress 0..1,
  following scrubs/reversals; ignores dialogs/pages) + `DrawerBackgroundScale`
  (scales to 0.95, `ClipRRect` corners, black dim — all × progress; reduced
  motion renders untransformed; `enabled: false` opts out).
- `docs/lib/main.dart`: app-level hosting — `ShadcnApp(navigatorObservers:
  [observer], home: GooeyToastLayer > ToastLayer > DrawerBackgroundScale >
  shell)`. Toasts stay outside the scale wrapper (unscaled, window-anchored).

## 2. Barrier-locked way out
Locked dialogs ignore barrier tap + Escape by design (`dialog.dart`,
untouched). The `Barrier locked` preview now carries an explicit
**Cancel** (+ Delete) so the user is never trapped. Test
`p7wa_overlays_test.dart` proves: barrier tap does nothing while locked,
Cancel pops with `false`.

## 3. Tests
`test/registry/components/p7wa_overlays_test.dart` — 17 tests, all pass:
alert header centring/row-max, footer stretch + `WrapAlignment.end`, stacked
below 360px / row above, four required alert names; locked ignores
barrier/escape + Cancel pops, locked preview offers Cancel, five required
dialog names; toast trigger renders a `Positioned` card in the root layer;
gooey Playground owns shape/animation/position/fill chips, chip taps work,
non-Playground demos own no controls; drawer scale progress 0→1 with keyed
`drawer-background-scale` Transform, opt-out/reduced-motion/dialog-never
scale, scale-demo preview listed.
`test/registry/visual/p7wa_screens_test.dart` — 8 captures, all pass:
`rearch/design/ours/screens/p7wa-{alert-delete,dialog-edit,toast,drawer-scale}_{light,dark}.png`.

## 4. Gates
| Gate | Result |
|---|---|
| `dart format` (owned files) | clean (27 registry files + tests) |
| `dart analyze` (owned components + tests + `docs/lib/main.dart`) | 0 issues |
| owned + neighbouring widget tests (alert/dialog/toast/gooey/drawer/p7wa) | 95 pass |
| `p7wa_screens_test` | 8 pass, PNGs written |
| `previews_f3b/f3d`, `api_snapshot` | pass |
| `gen_registry_manifest` (+ `--check` at regen time) | drawer scale file listed |
| `gen_previews_test` (+ `--check`) | regenerated, up to date |
| `gen_blocks_test --check` | up to date (16 blocks) |
| docs `sync_registry.sh` + `--check` | mirror up to date (711 files) |
| docs `gen_docs_data.dart` + `--check` | up to date (13 files) |
| `check_single_owner` | 0 public duplicates (19 private warnings, none ours) |
| `check_user_theme --strict` | 0 findings |

### In-flight failures (NOT ours — recorded, untouched)
- Full-tree `dart format --set-exit-if-changed`: 8 files fail —
  `button_status_content`, `keyboard_shortcut*`, `table/preview`,
  `table_resize` (has a parse error), `keyboard_shortcut_test`,
  `table_qa_test` (P7-WB/WC/TH1/CP1/NM1 work).
- `check_layers undeclared-dependency: 2` — both in
  `components/dot_indicator/dot_indicator.dart` (P7-WB).
- `previews_test`: `card_image` fails (P7-WB). `previews_f3c`: `table` fails
  (P7-WC). `previews_centered`: `card_image`/`carousel` fail (P7-WB + other).
- `registry_manifest_test`: drifts between consecutive runs with no input
  from this batch (verified: two gens 8s apart differ) — concurrent registry
  writes by sibling agents.
- Docs `dart analyze lib`: `widgets/rail_picker_rows.dart:162` (TH1/CP1) +
  mirrored `refresh_trigger.dart:413` (`sourceDevice`, P7-WB) — both break
  `flutter test` (load failures) and `flutter build web --release`.
- Pre-existing working-tree edits I did not touch:
  `alert_dialog_style.dart` (footerGap 24→16), `dialog.dart`/`dialog_style.dart`
  (DialogSize, scrollable shell), `app/*` — left intact; this batch builds on
  top of them.

## 5. Deliberate deviations / notes
- Gooey shape control is sharp/**soft**: `GooeyToastShapeStyle` has
  `defaultShape/soft/sharp/capsule` — no `smooth` (smooth is an animation
  preset). The brief's "sharp/smooth" maps to sharp/soft.
- Toast destructive variant is content-styled, not layer-themed: `showToast`
  has no per-toast theme leg (theme is layer-wide); the preview tints the
  destructive text instead of forking a local layer (which would re-clip).
- `alert_dialog_style.dart`, `dialog.dart`, `dialog_style.dart` were already
  modified in the working tree by sibling work; this batch deliberately does
  not touch them.
