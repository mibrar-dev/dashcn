# Brief P7-S1 — stateful buttons: idle → loading → success / failed (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself. User: every button should support a state machine — idle, loading, failed, success — and
anywhere else it makes sense.
## Design (registry `button`, widgets-only, theme tokens, density, reduced motion, RTL, a11y)
- `enum ButtonStatus { idle, loading, success, failure }`.
- Controlled: `status:` param. Uncontrolled/async: `onPressedAsync: Future<void> Function()?` — on press → loading
  (spinner replaces/precedes the leading icon, label kept, width stays stable — no layout jump, button disabled while
  loading) → success (check icon, optional `successLabel`) or failure (x/alert icon, destructive tint for non-
  destructive variants, optional `failureLabel`, error from the thrown exception available via callback) → auto-reset
  to idle after `statusResetDuration` (default ~1.5s; null = stay). `onStatusChanged` callback.
- Animated transitions (cross-fade icon + label, 150–200ms), semantics announce status changes (liveRegion).
- Apply the same to icon buttons / button group items where they share the Button core; consider `Toggle` N/A.
## Do
1. Implement in `components/button/**` (split files ≤ ~400 lines; theme fields for status icons/colours in the
   user-owned theme). README + meta api.
2. Previews: new examples "Async (success)", "Async (failure)", "Controlled status", "Loading" (replace the fake
   disabled+glyph Loading example), each interactive.
3. Use it where it improves real flows: block/home form submit buttons that currently fake loading (login/signup/
   account/otp/pricing submit) — switch to `onPressedAsync` with the existing validation; keep their tests green.
Tests: state transitions with fake async (success, failure, reset timing, null reset), width stable across states,
disabled while loading, semantics, reduced motion, controlled mode.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
analyze/test, build web. Report `rearch/reports/P7-S1.md`, `## RESULT`. No git ops. Other agents: P7-I1 (pickers),
P7-H1 (home/blocks — coordinate: you only change submit buttons' onPressed wiring in blocks), P7-C2 (preview sweep).
