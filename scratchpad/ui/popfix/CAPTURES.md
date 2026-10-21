# popfix captures

Docs on `http://127.0.0.1:8879` (flutter run -d web-server). Agent-browser,
one command at a time (sessions time out when batched).

## User report

- `user_popup_double.png`: copy of the attachment (Show popup + Profile/Settings, two nested borders).
- `before_user_big.png`: 3x nearest-neighbor upscale for inspection.

## Before (pre-fix server, 1280x800 dark)

- `before_popup_1280x800_dark.png`: #/docs/components/popup Default (Ibrar Ali card, single inline).
- `before_dropdown_1280x800_dark.png`: #/docs/components/dropdown_menu Default (Profile/Settings/Sign out, single inline).
- `before_command_1280x800_dark.png`: #/docs/components/command Default (palette, single inline; the double was in the opened home dialog, not inline).

## After (post-fix, transparent shells + 40px compact sheet rows)

1280x800 dark: `after_popup_1280x800_dark.png`, `after_dropdown_1280x800_dark.png`, `after_command_1280x800_dark.png`, `after_actionsheet_1280x800_dark.png`, `after_home_1280x800_dark.png`.
1280x800 light: `after_popup_1280x800_light.png`, `after_dropdown_1280x800_light.png`, `after_command_1280x800_light.png`, `after_actionsheet_1280x800_light.png`.
375x812 dark: `after_popup_375x812_dark.png`, `after_dropdown_375x812_dark.png`, `after_command_375x812_dark.png`, `after_actionsheet_375x812_dark.png`.
375x812 light: `after_popup_375x812_light.png`, `after_dropdown_375x812_light.png`, `after_command_375x812_light.png`, `after_actionsheet_375x812_light.png`.
Inline attempts: `after_actionsheet_375x812_light_inline.png`, `..._inline2.png` (agent-browser scroll does not move the Flutter web scrollable; rows below the fold are covered by `action_sheet_test` + the single-surface test, not pixels).

## Notes

- Overlay open pixels (home command dialog, wide sheet dialog, anchored popup) cannot be produced via agent-browser: the Flutter canvas exposes no `@eN` refs to click. The doubles are proven by code (transparent `DialogTheme` + `showCommandDialog`) and by `popup_single_surface_test.dart` (each overlay component paints exactly one visible full border).
- Light mode via `agent-browser set media light` (docs follows system brightness when no explicit choice is stored).
