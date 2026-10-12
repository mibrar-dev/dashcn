# Brief P7-Z2 — stabilise after P7-I1/H1/S1/B2/C2 (make everything green, fix cross-agent breakage)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Read the reports P7-I1, P7-H1, P7-S1, P7-B2, P7-C2 (rearch/reports). Do NOT open PNGs yourself.
Known cross-agent breakages:
1. P7-I1's content-sized picker triggers (object_form_field IntrinsicWidth hug) overflow ~218px inside narrow docs
   landing/studio cards → fix so a trigger never overflows a narrower parent: hug content when there is room, shrink to
   the parent's max width when not (label may then wrap to a 2nd line rather than ellipsize or overflow); keep P7-I1's
   tests (icon centred, no ellipsis, content width when roomy).
2. login/account block tests (blocks_meta / interactive) red after P7-S1's button state machine → update blocks/tests
   coherently (blocks use `onPressedAsync`), meta deps = imports.
3. Anything else red in: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; check_layers/owner/user-theme;
   docs format/analyze/test, codegen --check, sync --check, `flutter build web --release`.
4. Remove scratch/probe/zz_ files; no stray files at repo root.
5. Mobile captures of blocks: P7-B2's *-390 captures show the docs page header instead of the block — capture the
   block itself at mobile size via the block page's mobile viewport toggle / open-in-new-tab route →
   `rearch/design/ours/screens/p7z2-*-390.png` (login-02, sidebar-02, dashboard-01).
Fix at the root; don't weaken tests. Report `rearch/reports/P7-Z2.md` with every gate output + `## RESULT`. No git ops.

## Orchestrator note (mid-run, don't revert)
User feedback applied by the orchestrator while you run: chat replies now start-aligned with a muted incoming bubble
theme (`_incomingBubble`) in docs collage_home_media / studio_media and registry chat/preview; block page backgrounds
switched from `muted` (grey, user dislikes) to `background` (login-01/03, otp-01, signup-01) and brand panels to `card`
(login-02, signup-02). Keep these.
