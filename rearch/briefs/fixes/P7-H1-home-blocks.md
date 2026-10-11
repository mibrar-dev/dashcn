# Brief P7-H1 — home cards + blocks fixes; working chat (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself. Evidence (described): `rearch/design/ours/screens/user-bugs-2026-10-11b/*`.
1. Home hero announcement pill "118 components ready to install →" is ~600px wide; it must hug its text + arrow
   (shadcn hero badge: inline-flex, px-3, h-7, text-sm). Also the count should be the LISTED count (not 118 incl. hidden
   building blocks) — use the generated listed count.
2. Home "Support" chat card: the message input is a tall multi-line box by default. Use the design-system input height
   (h-9 single line) that AUTO-GROWS with content up to ~4 lines (TextArea minLines 1). Make it a WORKING chat: typing +
   Enter or Send appends the user's bubble, then after ~800ms shows a typing indicator and a dummy agent reply (cycle
   through a few canned answers), auto-scrolls to the newest message, the counter badge updates, Send disabled when
   empty. Same behaviour for the registry `chat` component's preview examples if they are static.
3. Block calendar-01 ("date-range picker card with a two-month calendar"): only ONE month renders and the right half
   of the card is empty. Show two months side by side (one on mobile), range selection across both (start, in-range
   fill, end), Clear/Apply wired, footer shows the selected range.
4. Block dashboard transactions table: the status chips (Paid/Pending/Refunded) stretch to the full column width and are
   too tall. Use the registry Badge/Chip at intrinsic size (shadcn badge: h-5/px-2/text-xs), left-aligned in the cell;
   table rows at the shadcn row height.
5. Sweep home cards + all 16 blocks for any other stretched chips/badges/buttons or oversized inputs and fix.
Tests: pill width == content; chat send → user bubble + reply after delay (fake async); calendar-01 renders 2 months at
≥768 and selects a range across months; badge width < 120px in the table.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
format/analyze/test, build web --release. Captures → `rearch/design/ours/screens/p7h1-*.png`. Report
`rearch/reports/P7-H1.md`, `## RESULT`. No git ops. Don't edit date/time trigger internals (P7-I1) or Button (P7-S1).
