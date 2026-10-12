# P9-3a — Screens & Flows (kit): five navigable, mobile-first mini-apps

Spec: `DASHCN_FEATURES_PLAN.md` §P9-3 (binding). You work in a SECONDARY kit worktree ($KIT, branch
`wip/p9-3a-flows`); another agent works in the main worktree at the same time. Read the blocks layer
(`$APP/lib/src/blocks/*` — the closest existing pattern: README.md, meta.json, entry file, tests), the manifest
generator (`$APP/tool/registry/gen_registry_manifest.dart`), `tool/gen_exports.dart`, `tool/rearch/check_layers.dart`.

## Existing primitives to USE (verify APIs first; do not duplicate)
`drawer` / `pinned_sheet` (bottom sheets), `navigation_bar` (bottom tab bar), `refresh_trigger` (pull-to-refresh),
`swiper` + `dot_indicator` (onboarding pages), `chat`, `stepper`/`steps`, `tabs`, `page_route` (`AppPageRoute`),
`input`, `input_otp`, `form`, `button`, `card`, `avatar`, `switch`, `item_picker`, `toast`, `empty_state`.
Gap to fill as a normal component (README + meta.json + tests, like every other): `swipe_actions` (swipe a row to
reveal trailing actions; dismiss-to-delete; RTL-aware; keyboard/semantics alternative). Add any other primitive only
if a flow genuinely cannot be built otherwise — justify it in the report.

## New layer: `lib/src/flows/<id>/`
Each flow: `flow.dart` (entry widget `<Name>Flow` owning a nested `Navigator` with `AppPageRoute`s),
`screens/*.dart`, `README.md`, `meta.json` (type `flow`, `screens`, `dependencies` on components/blocks, `entry`).
Flows depend on components/blocks, never the reverse — extend `check_layers` with the `flows` layer and that rule.
Flows take data + callbacks in; NO fake backends inside the kit (demo data lives in tests / docs previews only).
1. `onboarding-01`: 3 swipeable pages (swiper + dot indicator), Skip, Next/Get started, a permission-ask screen.
2. `auth-01`: sign in, sign up, OTP (input_otp), forgot password; social buttons; validation via `form`.
3. `checkout-01`: cart (swipe_actions to delete rows) → address bottom sheet → payment → success.
4. `settings-01`: grouped list, nested pages, toggles, account sheet, sign-out confirm (alert dialog).
5. `chat-01`: thread list (swipe actions + pull-to-refresh) → conversation (chat bubbles + composer) → attachments
   sheet.
Mobile-first (375–430 wide), but must not break at 1280; theme-dependent spacing/density only (existing rule);
light/dark; RTL.

## Wiring
- Manifest: the generator must emit `flows` entries (type `flow`); `gen_registry_manifest --check` clean.
- Exports: `lib/flows/<id_with_underscores>.dart` per flow; NOT in `dashcn.dart` (like blocks).
- Docs mirror: make `docs/tool/sync_registry.sh` mirror `flows/` too (docs pages come in P9-3b).

## Tests (`$APP/test/registry/flows/<id>_flow_test.dart`)
Per flow an end-to-end widget test that walks EVERY screen with taps/drags (incl. a sheet drag and a swipe action),
in light + dark and RTL, asserting callbacks fire with the right data; `swipe_actions` unit tests. No `pumpAndSettle`
on endless animations. Screenshot test writing every screen at 390×844 to `$KIT/rearch/screenshots/p9-3a/` (path
relative to the package, never absolute; do not open the PNGs).

## Gates
`rearch/qa_gate.sh` (incl. layers with the new rule, names), `gen_registry_manifest --check`, `gen_exports --check`,
`gen_previews_test`/`gen_blocks_test --check` if they apply, `dart format --set-exit-if-changed .` in `$APP`; docs
`sync_registry.sh --check` + `flutter analyze`.

## Report
`$KIT/rearch/reports/P9-3a.md`
