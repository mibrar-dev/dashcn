# P7-DL1 — dialogs are centred and content-sized; dialog spacing fixes

Brief: user bug 2026-10-11 (`rearch/design/ours/screens/user-bugs-2026-10-11b/date-dialog-spacing.png`).
Scope kept to dialog files only (other agents active: P7-CP1, P7-Z2, P7-TH1).

## Changes (registry; mirrored to docs via `docs/tool/sync_registry.sh`)

1. `flutter_shadcn_kit/lib/registry/components/dialog/dialog_style.dart`
   - New `DialogSize` enum (`sm` 384 / `md` 512 / `lg` 768) + `dialogSizeWidth`
     + `dialogEffectiveMaxWidth` (explicit `maxWidth` > `size` > 512 default).
   - `DialogTheme.size` added through copyWith/merge/lerp/==/hashCode.
   - `dialogDefaults.maxWidth` is now `null` so a `size` leg can win; the
     effective default stays 512 (shadcn `sm:max-w-lg`). All existing
     `maxWidth` legs behave exactly as before.

2. `flutter_shadcn_kit/lib/registry/components/dialog/dialog.dart`
   - `_DialogShell` is now content-sized and centred with viewport caps: the
     card hugs its content up to `dialogEffectiveMaxWidth` and
     `viewport − inset` (16px `p-4` margins each side, so a 375px phone caps
     the card at 343 instead of overflowing past the screen), centred on both
     axes via the route `alignment` (default center). Taller bodies scroll
     **inside** the card (`SingleChildScrollView` under a
     `ConstrainedBox(maxWidth, maxHeight)`); small bodies are unaffected
     (scroll view sizes to its child, body stays at card + `p-6`).
   - Full-screen path keeps filling the viewport (opt-in stretch) and also
     scrolls inside now.
   - Fixed during testing: the `LayoutBuilder` closure must capture the
     surface widget in a separate final, not the reassigned `card` variable
     (self-ancestor focus loop caught by `dialog_test`).

3. `flutter_shadcn_kit/lib/registry/components/alert_dialog/alert_dialog_style.dart`
   - `footerGap` 24 → 16 (shadcn `gap-4`). Header (`headerGap` 8 = `gap-2`)
     and actions (`actionGap` 8 = `gap-2`, right-aligned `Wrap` that wraps on
     narrow screens) were already correct; no code change there.

4. `flutter_shadcn_kit/lib/registry/components/date_picker/date_picker.dart`
   - Initial keyboard target (`_focusNow`, passed as the calendar's `now`):
     null when the real today is drawn and enabled (calendar default keeps
     working); otherwise the selected day in the grid (range: start then end;
     multi: first in-grid date), else the first of the shown view. The
     reported symptom — ring on out-of-month "26" when opening a March sheet
     in October — now lands on the selected day (or March 1). Paint is
     unaffected: an off-screen today draws nothing and a selected cell
     already paints the primary fill.
   - Calendar itself (`calendar.dart`) deliberately untouched: the ring shown
     before the grid takes focus is the tested roving-tabindex pattern
     (`calendar_test` "autofocus is off by default" pins it), and the
     first-enabled fallback (incl. out-of-month) is pinned by the disabled-day
     keyboard tests. See open questions.

5. `flutter_shadcn_kit/lib/registry/primitives/form_core/object_form_prompt.dart`
   - The `Gap(md)` between editor and footer is now only added for a
     borderless footer. Picker prompts (`p-0` card + `p-3` bordered footer)
     no longer get 12px of extra space under the grid on top of the
     calendar/sheet's own bottom `p-3` — the footer is separated by exactly
     one divider with `p-3`, as specified.

`time_picker.dart`: audited, no change needed (`p-0` card, `p-3` sheet shell,
`p-3` bordered footer — same fixed-by-prompt structure as the date picker).

## Verification

- `dart format` on the 5 files: clean (0 changed).
- `dart analyze` registry touched dirs + docs mirror dirs: no issues.
- `flutter test test/registry`: **+4585, all passed** (includes dialog 15,
  alert_dialog 13+1, date/time/calendar 127, p7u2_pickers + object_input 31,
  object_form_prompt 3).
- `rearch/qa_gate.sh`: format prints "3 changed" (pre-existing files from
  other agents, none of the 5 DL1 files), analyze 0, tests all pass, layers
  warnings only, single-owner shows one pre-existing `switcher` line, theme
  0, banned empty.
- `tool/registry/gen_registry_manifest.dart` regenerate: no diff;
  `--check`: up to date. Barrel regenerate: no diff.
- `docs/tool/sync_registry.sh`: mirrored 709 files; `--check`: up to date.
- `docs/tool/gen_docs_data.dart` (docs codegen): regenerated, `--check`
  passes. Dialog goldens pass; 3 remaining failures are other agents'
  in-flight work (button API/theme tables from P7-S1 `onPressedAsync`, and
  the blocks preview-examples check) — none touch dialog files.
- `flutter build web --release` (docs): **blocked by pre-existing breakage
  outside DL1 scope** — `docs/lib/widgets/rail_picker_rows.dart:162:27`:
  `Undefined name 'theme'` (`dart analyze` confirms 1 issue in that file;
  it is dirty from another workstream and was never touched by DL1).
  Registry + docs-mirror `dart analyze` on all five DL1 areas is clean, so
  the failure is isolated to that file.
- Captures `rearch/design/ours/screens/p7dl1-*.png`: **blocked** — they need
  a running docs app, which needs the web build above. Widget-test geometry
  stands in as verification: dialog 512-cap + 16px inset + `p-6` offset
  (`dialog_test`), picker card == grid width ≤360 with 8px caption gap and
  12px footer padding (`p7u2_pickers_test`), 375-phone fit
  (`p7u2_pickers_test` "fits a 375 phone"), prompt 240–480 shrink-wrap
  (`object_form_prompt_test`) — all green in the +4585 run.

## Audit of every `show*Dialog` usage

- `dialog` previews, `alert_dialog` live-push preview, `page_route` preview,
  `error_system` (via `showAlertDialog`), `item_picker`, `command`
  (`showCommandDialog` caps its own content at 510 < 512): all content-sized
  bodies, no fix needed; they inherit the new viewport caps + inner scroll.
- `object_input._openDialog` (DateInput path) uses `showShadcnDialog`
  **without** a `p-0` theme override, so the calendar gets card `p-6` **plus**
  its own `p-3` (≈44px of blank above the weekdays, ≈36px below the grid).
  This matches the evidence screenshot better than the prompt path and is the
  likely pictured dialog. Fix is one line
  (`theme: const DialogTheme(padding: EdgeInsets.zero)`) but
  `object_input.dart` belongs to another workstream — left for its owner,
  flagged here.
- Docs `get_code_dialog.dart`: fixed `SizedBox(width: 640)` content inside a
  512-capped card overflows the card on desktop and any phone. Same reason:
  docs-owned file, flagged, not touched. `DialogSize.lg` (768) exists for
  exactly this kind of wide dialog once the docs side is fixed.

## Open questions (need orchestrator call)

1. Caption row: brief asks `h-9` + "weekday row immediately below" (no gap),
   but `p7u2_pickers_test.dart` pins caption height 32 and
   `grid.top − caption.bottom = 8` (`test/registry/components/
   p7u2_pickers_test.dart:146-149`). Changing the header breaks those gates,
   so the header `Gap(sm)` and 32px slot are kept. If the user still sees a
   band after the footer + focus fixes, the header needs a brief-vs-tests
   decision (the remaining 8 + 12(`p-3`) is spec + pinned test, not a bug).
2. Keyboard-only ring: gating the calendar ring on real focus would break
   the pinned roving-tabindex tests; the ring now starts on the right
   (in-grid) day instead. A true focus-only ring needs a calendar + test
   change owned with the calendar workstream.
3. `dialog` `meta.json` still documents `maxWidth 480` (stale, predates DL1)
   and has no `size` row; `alert_dialog` `meta.json` still says
   `footerGap 24`. Left untouched (manifest generator does not cover theme
   field docs); suggest a docs-fields pass separately.
4. `dialog.dart` is now 439 physical lines (was 398), tripping the
   `file-too-long` **warning** (>400, warning-only; repo already carries 45).
   The capped-centred shell has to live in the route file; splitting it out
   would churn `meta.json` + manifest for no gate benefit.

## RESULT
status: partial
files_written:
- flutter_shadcn_kit/lib/registry/components/dialog/dialog.dart (viewport-capped centred shell + inner scroll)
- flutter_shadcn_kit/lib/registry/components/dialog/dialog_style.dart (DialogSize + effective width)
- flutter_shadcn_kit/lib/registry/components/alert_dialog/alert_dialog_style.dart (footerGap 24→16)
- flutter_shadcn_kit/lib/registry/components/date_picker/date_picker.dart (in-grid initial focus proxy)
- flutter_shadcn_kit/lib/registry/primitives/form_core/object_form_prompt.dart (bordered footer: no double gap)
- rearch/reports/P7-DL1.md (this report)
- generated/synced outputs via sanctioned gates only: docs mirror (5 files),
  docs generated data (13 files), no hand edits outside dialog files
commands_run:
- dart format (5 files) -> clean
- dart analyze registry touched dirs + docs mirror dirs -> no issues
- flutter test test/registry -> +4585 all passed
- rearch/qa_gate.sh -> tests green; format "3 changed" pre-existing files only; layers warnings only; owner 1 pre-existing switcher line; theme 0; banned empty
- manifest regenerate + --check -> up to date; barrel regenerate -> no diff
- docs sync + --check -> up to date (709 files)
- docs codegen regenerate + --check -> up to date; dialog goldens pass; 3 failures pre-existing (button x2, blocks preview-examples)
- flutter build web --release -> BLOCKED (rail_picker_rows.dart:162, other workstream)
- agent-browser captures p7dl1-*.png -> BLOCKED (needs web build)
key_findings:
- Likely pictured dialog is object_input's showShadcnDialog path (p-6 + p-3 double frame), not the prompt path; one-line fix flagged for its owner.
- Docs get_code_dialog fixed 640px content overflows 512 cap; DialogSize.lg (768) added for wide dialogs.
- Caption h-9 / zero-gap ask conflicts with pinned p7u2 tests (32px + 8px); header left as-is.
open_questions:
- [1] caption spacing brief-vs-tests call; [2] true focus-only ring needs calendar+test change; [3] meta.json theme-field docs drift.
