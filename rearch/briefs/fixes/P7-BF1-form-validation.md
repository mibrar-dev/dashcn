# Brief P7-BF1 — form validation shows only after the user types (or on submit), never by default (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself. User: in the blocks, forms show validation errors by default (e.g. login-01 opens with "This
field cannot be empty." under Email and Password). Validation must appear only when the user has typed in that field
(changed / touched) or presses submit — never on first render, and not for untouched fields after typing elsewhere.
## Do (root: registry `form` + `primitives/form_core/**`; then blocks + previews + docs home/studio forms)
1. Find why errors show initially (e.g. the first value report counted as `changed`, `FormValidationMode.initial`
   included by default, the docs/captures calling validate, or blocks passing showErrors {changed} which fires on
   attach). Fix the primitive: per-field "dirty" (value changed by the user) and "submitted" flags; default showErrors =
   {changed (only when dirty), submitted}; initial attach never shows errors; a field's error clears when fixed and
   updates live after it is dirty.
2. Apply across all 16 blocks, the docs home/studio form cards, and form-related previews; remove any eager validate calls.
3. Tests: fresh render of every form block shows NO errors; typing invalid text in one field shows only that field's
   error; submit shows all invalid fields; fixing clears; reset clears dirty state.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
analyze/test, build web. Report `rearch/reports/P7-BF1.md`, `## RESULT`. No git ops. Other agents active: TH1 (theme
tokens in docs/blocks — don't revert its token replacements), TS1 (Theme Studio), WB, WC — touch only form/validation.
