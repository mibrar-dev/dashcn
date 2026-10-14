# P7-BF1 — form validation shows only after the user types (or on submit)

Brief: `rearch/briefs/fixes/P7-BF1-form-validation.md` · User report 2026-10-11 ("login-01
opens with *This field cannot be empty.* under Email and Password").

## Root cause (verified, not guessed)

Two effects combined, both in the `form_core` primitive:

1. `FormController.attach` derived the validation lifecycle from **"has this key been
   registered before"**: `previous == null ? initial : changed`.
2. Every field is written to twice on mount. `FormEntry.didChangeDependencies` attaches
   first (unregistered → `initial`), then the value supplier's own
   `FormValueSupplier.didChangeDependencies` reports its starting value through
   `handle.reportNewFormValue` → `controller.attach` again. On that second call
   `previous != null`, so the field validated under **`changed`** and produced an
   `InvalidResult(state: changed)`.
3. `FormEntryErrorBuilder` with `modes == null` showed a result of *any* mode, so that
   `changed` result rendered on the first frame — for an untouched, empty field.

`FormValidationMode.initial` was therefore never what a surviving result carried: every
field's stored result was `changed` before the user did anything.

## Fix

Per-field **dirty** (value changed by the user) plus a form-wide **submitted** flag, and
a display rule that keeps an untouched field silent.

- `primitives/form_core/form_entry.dart`
  - `_acceptsEdits`: a post-frame latch. The first report of a field's life — the
    supplier registering itself, and a value the parent seeds in `build` — is **not** an
    edit, so the field stays in the controller's silent `initial` mode. Only a later
    report whose value actually differs from the last reported one marks it dirty.
  - `reportNewFormValue` passes that to `attach(dirty: ...)`; `_pullValidity` now mirrors
    the controller's display decision (the per-field future bookkeeping collapsed away).
- `primitives/form_core/form_controller.dart`
  - `_FieldRegistration.dirty` — survives a re-attach, so swapping a validator cannot
    silence a field that is already showing its error.
  - `attach` lifecycle is now `dirty ? changed : initial` instead of `previous != null`.
  - `getDisplayError(key)`: an `initial` result is never shown; a `changed` result is
    shown only while the field is dirty; a `submitted` result always shows; a pending
    check reads as `WaitingResult` under the same rules.
  - `submit()` sets the submitted flag; new `reset()` clears the submitted flag, every
    field's dirty flag and every result while **keeping values**, plus an `isSubmitted`
    getter.
- `primitives/form_core/form_core.dart`: new `defaultShowErrors` (`changed` + `submitted`).
- `primitives/form_core/form_builders.dart`: `FormEntryErrorBuilder` with `modes == null`
  now uses `defaultShowErrors` instead of "show everything".
- `components/form/form.dart`: `showErrors` documented as null = `defaultShowErrors`.
- `components/form/preview.dart`: the "Validating" example's hint states that the message
  shows only once you type (it previously implied the error showed immediately).
- `components/phone_input/preview.dart`: the "Invalid" example opts in explicitly with
  `showErrors: {initial, changed, submitted}` and a comment — its purpose is to document
  the error *state*, and a real form keeps the default.
- `blocks/account-02/account_02.dart`: `_reset()` now also calls `_controller.reset()`,
  so the preferences a reset restores are not treated as user edits.
- `blocks/` ×16: no edits needed. Every block's validation now behaves correctly from
  the primitive; the explicit `showErrors: {changed, submitted}` they pass is what the
  default now means.

## Docs home / studio form cards

Verified with a grep over `docs/lib/widgets` for `ShadcnForm|FormController|validator|
autovalidateMode`: **no matches**. The home and Theme Studio cards (`studio_forms.dart`,
`collage_home_forms.dart`, `collage_home_auth.dart`, `collage_cards_forms.dart`,
`studio_canvas` …) compose plain `Input` / `TextArea` / `Select` with no validators and
no `ShadcnForm`, so they never rendered validation text and need no change.

## Tests

- **New** `test/registry/components/form_validation_display_test.dart` (8 cases):
  fresh form silent · a field seeded with an invalid value silent · editing one field
  shows only that field · submit shows every invalid field · fixing clears and stays live ·
  `reset()` clears dirty + submitted (values kept, an edit re-arms, a submit re-arms) ·
  an untouched field stays silent while another is edited.
- **New** `test/registry/blocks/blocks_forms_silent_test.dart` (9 cases): a fresh render of
  every form block (login-01/02/03, otp-01, signup-01/02, account-01, account-02,
  pricing-01) renders no `FormFieldMessages` with a non-null message — asserted
  structurally, so it holds for any validator, localized or custom.
- **Updated** three `form_test.dart` cases that encoded the old eager behaviour:
  - "a field error renders, clears and dims under both token sets" — now asserts a fresh
    field is silent, then clears it live.
  - "FormInline and FormTableLayout render labels and errors" — a fresh form is silent;
    a submit shows both.
  - "Validated works without a ShadcnForm scope" — `Text` child swapped for `Input`, typed
    into first.
- **Updated** `phone_input_test.dart` "form field validates and updates its value": a fresh
  field is silent; typing a valid number shows nothing; clearing it reports live.

## Gates

| Gate | Result |
|---|---|
| `rearch/qa_gate.sh` | analyze clean (lib + test/registry) · `test/rearch` +42 pass · layers 2 pre-existing warnings (`file-too-long: 48`, `unused-dependency: 3`) · owner 1 pre-existing finding (`switcher/preview.dart:76`, file unmodified) · theme 0 · banned empty |
| `dart format` (lib/registry, test/registry) | clean for every file this brief touched |
| `flutter test test/registry` | 1094 pass / 15 fail; **all 15 failures are in `test/registry/qa/` and are not caused by this change** — see below |
| `dart run tool/registry/gen_registry_manifest.dart --check` | up to date |
| `dart run tool/registry/gen_blocks_test.dart --check` | up to date (16 blocks) |
| `docs/tool/sync_registry.sh --check` | up to date (813 files) |
| `docs: dart run tool/gen_docs_data.dart --check` | up to date (13 files) |
| `dart analyze` (kit + docs lib) | kit: no issues · docs lib: no issues |
| `flutter build web --release` (docs) | ✓ built |
| Form/block test files (run as a set) | 296/296 pass |

### The 15 pre-existing `test/registry/qa` failures

Latest run (after the other agents fixed the `keyboard_shortcut.dart` compile break
mid-session, which had been cascading into several files): 9 named failures across 6
files — `interactive_previews_test` (4: alert_dialog, dialog, navigation_menu, toast),
`toast_qa_test` (3), `alert_dialog_qa_test` (1), `gooey_toast_qa_test` (1) — plus the
grouped remainder. Every one fails because it cannot find its **own** widget
(`Found 0 widgets with text "Show alert dialog"`), i.e. tests written against previews
that other agents are actively rewriting in the same tree. Attribution from `git status`:
`alert_dialog/**`, `gooey_toast/preview.dart`, `navigation_bar/preview.dart`,
`navigation_menu/**`, `refresh_trigger/**` and `toast/preview.dart` all carry uncommitted
changes from other briefs. None of these files import `form_core`, and a grep for
form-validation strings in the failure log (`cannot be empty`, `FormFieldMessages`,
`FormController`, `FormEntry`, `ShadcnForm`) returns **0 hits** over the whole log.
Still noted from other agents' in-flight work: 1 file unformatted
(`button/button_status_content.dart`) at the time of the gate run; the `switcher`
single-owner finding and the 2 layer warnings are pre-existing baselines (the offending
files are unmodified).

## Open questions

- `FormFieldHandle.revalidate()` still has no in-tree caller. It revalidates under
  `submitted`, so it shows regardless of dirty; left as is.
- `FormController.errors` / `getSyncError` remain unfiltered by dirtiness (they answer
  "is the form valid", not "what is on screen"). Only the display path
  (`getDisplayError`) is gated. `SubmissionResult.errors` is unaffected because submit
  overwrites every field with `submitted` mode.
