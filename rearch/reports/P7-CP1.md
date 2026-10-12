# P7-CP1 — color picker eye dropper samples the WHOLE app, live

## Status: done (implementation + targeted gates green; two gates blocked by concurrent agents, evidence below)

## What changed (registry only + tests + generated)

**`components/eye_dropper/eye_dropper.dart`** (rewritten session layer, same widget API):
- `EyeDropperLayerScope.promptPickColor([storage, onSample])` — new optional
  live-sample callback; existing one-arg calls compile unchanged.
- `EyeDropperLayerScope.maybeFind` (null when absent) and
  `isCaptureSupported` (backed by `eyeDropperCaptureSupported`).
- Whole-app sampling: a nested layer delegates to the outermost scope
  (`Data.maybeFindRoot`), so inside `ShadcnApp` every session captures the
  app-root boundary and the loupe + crosshair cover the entire window — above
  picker popovers too. No root layer → falls back to the own subtree.
- DPR-correct: capture at `MediaQuery.devicePixelRatioOf`, sampling through
  `ScreenCapture.sampleLogical` (logical × ratio → image pixels).
- Session UX: loupe follows the pointer, new full-window `_CrosshairPainter`,
  tap commits, Escape / right-click (`onSecondaryTapDown`) cancels,
  arrows nudge 1 logical px, Enter commits.
- Stale-free capture: 500 ms throttled recapture while a session is active
  (newly painted content), guarded against overlapping captures.
- Dispose-safe: refresh timer cancelled, completer completed once
  (`isCompleted` guard), `mounted` guards on every async gap; no
  ValueNotifier-after-dispose path (layer owns no notifiers; history writes
  skipped for null commits).
- Preview label wrapped in ambient-or-LTR `Directionality` (the root layer
  sits above the app `Directionality`).

**`primitives/screen_capture.dart`**: `ScreenCapture.pixelRatio` field,
`sampleLogical` (DPR mapping + same-logical-area loupe),
`eyeDropperCaptureSupported` (true everywhere: `toImage` works on web +
desktop; the button hides only when no scope exists).

**`components/app/app.dart` + `meta.json`**: `ShadcnApp` installs an
`EyeDropperLayer` between `ShadcnUI` and the theme (inside the theme so the
loupe follows presets/light/dark, ancestor of the Navigator so it covers the
window). Docs app gets it automatically (uses `ShadcnApp`); dep declared.

**Picker state fixes** (external colour now reaches every control immediately):
- `ColorPicker.didUpdateWidget` clears stale `_changing` on `widget.value`
  change; `_onChanging`/`_onChanged` gain `mounted` guards (dispose-safe).
- `HSVColorSlider` / `HSLColorSlider` `didUpdateWidget` clears stale
  `_lastChanging` on `widget.color` change (the frozen-thumb bug).
- `ColorPickerControls` gains `onChanging`: the pipette streams live samples
  via `onChanging`, commits via `onChanged`, and on cancel-after-live restores
  the pre-session colour (`onChanging` + `onChanged(previous)`).
- Pipette hides when sampling is impossible (no scope and no custom
  `onEyeDropperRequested`); custom actions always show.

**Previews**: `color_picker` gains an interactive 6th example `Eye dropper`
(known red/green/blue scene + alpha picker); `eye_dropper` preview streams
live samples into its swatch/hex while sampling.

**Meta**: `eye_dropper` typedefs += `EyeDropperSampleCallback`; `app` deps +=
`eye_dropper`. Manifest + barrel + previews tests regenerated.

## Tests

New `test/registry/components/eye_dropper_live_test.dart` (9 tests, all pass):
live hue/sat/val/alpha + hex streaming, tap commit, Escape-cancel restore,
right-click cancel, arrows + Enter, DPR-2 mapping, root overlay full-window
size + far-corner sampling, dispose-mid-session (null, no exception),
pipette hidden without scope / shown with scope.
Updated harnesses (pipette needs a scope now): `color_picker_test`
(`EyeDropperLayer` in `_pump` + responsive `pumpAt`),
`qa/color_picker_qa_test` (`_picker` wrapped).

## Gates

- `dart format` on all touched files: clean (22 kit files, 0 changed; 31 docs
  mirror+generated files, 0 changed).
- `dart analyze` full `lib/registry` + new/updated tests: No issues found.
  (The background `qa_gate.sh` run at 23:44 printed `analyze: 5 issues` and
  `format: 3 changed` — transient mid-edits from concurrent agents; re-ran
  clean afterwards. `GATE_EXIT=0`.)
- Targeted suites, all pass: eye_dropper_live (9 new), eye_dropper (19),
  color_picker, app (21), color_input, color_field, color, hsv, hsl, history,
  select, input, gooey_toast, shadcn_app_localizations, qa
  eye_dropper/color_picker, previews (566).
- `check_layers`: 0 errors. `check_single_owner`: public 0 (19 private
  pre-existing, none in touched files). `check_user_theme --strict`: 0.
  Banned-pattern grep: empty.
- Generators: manifest / previews (83) / blocks (16) / barrel regenerated,
  `--check` passes.
- Docs mirror: all touched `.dart` files byte-identical registry↔mirror;
  codegen `--check` passes after regen.
- Docs test/build + `sync --check`: BLOCKED by concurrent agents (see below),
  not by this brief. No git ops performed (orchestrator commits).

## Concurrent-work collisions (not mine, not touched)

- `rearch/qa_gate.sh` full run + docs `sync --check` see drift in
  `navigation_menu/preview.dart`, `alert_dialog/preview.dart`
  (P7-TH1/P7-Z2 mid-edit, both sides uncommitted).
- Docs `analyze`/`test`/`build` fail on `widgets/rail_picker_rows.dart:162`
  (`theme` undefined — another agent's broken mid-edit).
- Kit gate `format (3 changed)` / transient `analyze (5 issues)` likewise
  from other agents' in-flight files; re-ran clean afterwards.
- No git ops performed (orchestrator commits).

## Open questions

- Should `ColorInput._pickScreenColor` (closes prompt, picks, reopens) also go
  live, or keep its close-pick-reopen flow? Left unchanged (out of brief).
- Touch drag has no hover-live (tap commits); acceptable per brief.
