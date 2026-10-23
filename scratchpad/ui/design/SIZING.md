# dashcn sizing principle (one scale for the whole library and the docs)
Source: shadcn/ui new-york-v4 registry (button.tsx, menubar.tsx, sidebar.tsx), checked 2026-10-22. Same sizes on desktop and mobile; touch comfort comes from an invisible hit area, never from larger visuals.

## Text and icons
- Body text 14 px, line height 20 px. Small/meta text 12 px. Labels 12 px medium.
- Icons 16 px everywhere in controls and rows.

## Heights (the core rule: things that sit side by side are the same height)
- Field and button height (button, input, select trigger, search field, date field, segmented/toggle group, combobox): 36 px default; 32 px small; 40 px large. A button next to an input is the same height.
- Row height (menu item, dropdown item, context menu item, menubar menu item, sidebar item, navigation item, list tile single-line, command item, tab trigger inside a 36 px tab list): 32 px. Two-line rows: 48 px.
- Bars (menubar root, tab list, segmented control track, toolbar): 36 px with 4 px inner padding, so the items inside are 28 px.
- Sidebar: item 32 px, group label 32 px, sub-item 28 px, header and footer padding 8 px, width 256 px (64 px icon-only rail).

## Padding and gaps (4 px scale only: 4, 8, 12, 16, 24)
- Button: 16 px horizontal (12 px when it has an icon); small 12 px.
- Field: 12 px horizontal.
- Rows: 8 px horizontal, 6 px vertical (menu items), 8 px for sidebar items.
- Floating surfaces (menus, popovers, dropdowns): 4 px inner padding; 8 px for popups with free content; 16 px for sheets, dialogs and cards.
- Gaps: 4 px inside compound controls, 8 px between controls, 16 px between groups, 24 px between sections.
- Separators: 1 px with 4 px vertical margin inside menus.

## Radius
- Controls 6 px; rows 4 px inside a surface; surfaces (menus, cards, sheets) 8 to 12 px.

## Forbidden
- Different heights for controls that sit in one row.
- Content touching a surface edge (minimum inner padding is the surface rule above).
- Directional chevrons on horizontal menubar triggers (shadcn shows none).
