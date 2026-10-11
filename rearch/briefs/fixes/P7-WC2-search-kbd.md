# Brief P7-WC2 — docs search ⌘K hint polish (user 2026-10-11)
Evidence `rearch/design/ours/screens/user-bugs-2026-10-11b/search-kbd-crammed.png`: the ⌘K kbd at the right of the
header search field is a tiny round bubble, too small and crammed against the edge. Make it shadcn's Kbd group: two
separate keys "⌘" "K" (or "Ctrl" "K"), h-5, px-1.5, gap-1, text-xs mono-ish, muted bg + border, radius from theme sm,
right padding = field padding, vertically centred; same Kbd styling as the registry keyboard_shortcut component (use it).
Do NOT open PNGs. Gates: docs analyze/test/build web. Report appended to `rearch/reports/P7-WC.md` (## WC2 section). No git.

## User preference (2026-10-11, overrides the radius-from-theme line above)
Either no background (transparent, blends with the field) or a subtle background with a FIXED default radius that looks
good on every theme (e.g. 4px) — hard-coded as the Kbd's DEFAULT but overridable via the keyboard_shortcut/Kbd theme
(`radius`, `background` fields; `KbdVariant.ghost` = no background). Use the subtle-background variant with the fixed
radius in the docs search field; expose `ghost` too. Same defaults in the registry keyboard_shortcut component.
