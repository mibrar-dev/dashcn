# P9-2b — Live props playground: the Controls panel

Prerequisite: P9-2a accepted (`docs/lib/generated/docs_controls.dart`, `docs/lib/playground/**` — values, emitCode,
28 builders, `kPlaygroundBuilders`). Read `$KIT/rearch/reports/P9-2a.md` (incl. its open questions) and the
playground code. Spec: `DASHCN_FEATURES_PLAN.md` §P9-2. You work in the MAIN worktree; another agent (flows) works in
`dashcn-kit-b`. Do NOT edit `component_page.dart` (P9-Z wires everything) — deliver a self-contained widget.

## Deliverable: `PlaygroundPanel(componentId:)` in `docs/lib/playground/ui/`
- Layout: preview on top (wrap it in P9-1's `FramedPreview` so frames work there too), controls beside it at ≥ 1100 px
  wide, below it under that, and in a bottom sheet (kit `drawer`/`pinned_sheet`) under 600 px. Live code block underneath
  (existing syntax-highlighted, selectable, copyable code widget) showing `emitCode` output, updating on every change.
- One control widget per `ControlSpec` kind using kit components only: Switch (bool), Select (enum), Input (String),
  Slider + number readout (num), theme-token swatch picker (colour), Input (child text), Switch ("enabled").
  Nullable booleans get a tri-state control (Unset / On / Off) — values.dart already round-trips null.
- Dependent ranges (from the P9-2a report): a slider `value` control tracks the live `min`/`max` values; pagination
  `page` clamps to `totalPages`. Implement generically (a spec may declare `boundedBy`), not per component.
- Reset button restores defaults; values are reflected in the URL (`?p.variant=outline`) via the docs router state so
  a configured playground is shareable and survives reload/back.
- Components without a builder: render nothing (the integration step shows "Playground coming soon").
- Light/dark, theme-dependent spacing, keyboard accessible, every control labelled (semantics).

## Tests (`docs/test/playground/ui/`)
Per layout breakpoint (1280, 900, 390): panel renders without overflow; changing a control updates preview and code;
reset; URL round-trip through the router; tri-state; dependent range clamps. Screenshot captures for button, select,
slider, dialog at 1280 + 390, light + dark → `../rearch/screenshots/p9-2b/` (relative to the docs package; wrap like a
real app — the docs `DashcnApp`/site theme — so text has the right colours; do not open the PNGs).

## Gates
Docs: `dart format --set-exit-if-changed lib test tool`, `flutter analyze`, `flutter test test tool`,
`gen_docs_data --check`, `sync_registry --check`, `flutter build web --release`.

## Report
`$KIT/rearch/reports/P9-2b.md`
