# Captures — Batch 2B: filter_bar rewrite on theme & density principles (w-filter, port 8872)

Component page: `#/docs/components/filter_bar`
Built from `feat/ui-filter-bar` (`docs/build/web`), served at `http://127.0.0.1:8872` via `python3 -m http.server 8872`.
Browser shots taken via `agent-browser --session w-filter` in headless mode.

## Browser shots (real fonts, docs web release build)

- `filter_bar_1280_light.png` — 1280×800, light mode. Top article hero card with Default example. Search field with 16 px search icon and clear button, Newest sort dropdown, 42 results count, and Clear all button. Spacing on 8 px scale, control heights compact default.
- `filter_bar_1280_dark.png` — 1280×800, dark mode. Same layout under dark theme tokens. Surface blur and card border colors adapt cleanly.
- `filter_bar_1280_light_open.png` — 1280×800, light mode. Shows the Examples section with "With chips", "Overflow menu", and "Overflow menu open" examples. The "Overflow menu open" card demonstrates the compact anchored menu popup open with `Filters (2)` title, `Newest` sort dropdown, `7 results` count, and `Clear all` button on a 160..320 px bounded card.
- `filter_bar_1280_dark_open.png` — 1280×800, dark mode. Same view showing the open compact overflow menu on dark background with frosted glass surface.
- `filter_bar_375_light.png` — 375×812 phone viewport, light mode. Responsive wrapping of the filter bar on phone width. Controls wrap cleanly without any RenderFlex overflow.
- `filter_bar_375_dark.png` — 375×812 phone viewport, dark mode. Same phone view under dark theme. No horizontal scroll or overflow.
- `filter_bar_375_light_open.png` — 375×812 phone viewport, light mode with overflow menu open. Shows the "Overflow menu open" example on mobile with the compact popup card open below the trigger, displaying active filter count, sort dropdown, and Clear all action.
- `filter_bar_375_dark_open.png` — 375×812 phone viewport, dark mode with overflow menu open. Exact dark theme counterpart of the mobile overflow menu open view.
- `filter_bar_interaction.webm` — Interaction recording on the filter bar component page demonstrating navigation, opening the overflow trigger, inspecting the compact menu card and controls, and smooth scrolling.

## Visual and Ergonomic Verification

- **Density scaling**: All controls default to compact density tokens (36 px search height, 16 px icons, 8 px gaps). Sizing overrides via `FilterBarStyle` and `FilterBarTheme` allow users to customize `controlHeight`, `controlWidth`, `iconSize`, `padding`, and `borderRadius`.
- **Touch target minimum**: Touch interactions and standalone sort control adhere to 48 px minimum height.
- **Narrow width overflow**: Automatically transitions to a compact menu trigger (`FilterBarPresentation.autoMenu` by default at `< 720` or narrow screens) or modal bottom sheet (`FilterBarPresentation.autoSheet`).
- **Surface**: The overflow menu and sheet scaffold utilize `GlassSurface` and `surfaceColor` with ambient card fill, border, and elevation tokens.
- **Overflow check**: 375 px width renders without horizontal overflow or exceptions across all named examples.
- **No visual regressions observed.**
