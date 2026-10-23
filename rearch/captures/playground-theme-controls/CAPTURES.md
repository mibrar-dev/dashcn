# Playground Theme Controls Visual Captures

All captures taken using `agent-browser` running against the production web release build served on port 8089 (`http://localhost:8089/`).

## Captures Index

| File | Resolution / Mode | Description | Status |
|------|-------------------|-------------|--------|
| `swipe_actions_1280_light.png` | 1280x800 (Light) | Swipe Actions component page with Playground panel open in right rail. Demonstrates that components without props controls still render the Theme section and Reset button. | Clean, passes visual review |
| `swipe_actions_1280_dark.png` | 1280x800 (Dark) | Swipe Actions component page with Playground panel open in dark mode. | Clean, passes visual review |
| `swipe_actions_375_light.png` | 375x812 (Light) | Mobile view with playground panel presented as a responsive bottom sheet overlay. | Clean, passes visual review |
| `swipe_actions_375_dark.png` | 375x812 (Dark) | Mobile view in dark mode with playground panel as a responsive bottom sheet. | Clean, passes visual review |
| `button_radius0_1280_light.png` | 1280x800 (Light) | Button component page with theme radius override set to 0 px (square corners). Both live preview and all example buttons reflect the 0 px radius token. | Clean, passes visual review |
| `button_radius0_1280_dark.png` | 1280x800 (Dark) | Button component page in dark mode with theme radius override set to 0 px. | Clean, passes visual review |
| `button_radius0_375_light.png` | 375x812 (Light) | Mobile view of button page with radius 0 px. | Clean, passes visual review |
| `button_radius0_375_dark.png` | 375x812 (Dark) | Mobile view in dark mode of button page with radius 0 px. | Clean, passes visual review |
| `button_radius20_1280_light.png` | 1280x800 (Light) | Button component page with theme radius override set to 20 px (pill/rounded corners). Preview and all examples show 20 px radius. | Clean, passes visual review |
| `button_radius20_1280_dark.png` | 1280x800 (Dark) | Button component page in dark mode with theme radius override set to 20 px. | Clean, passes visual review |
| `button_radius20_375_light.png` | 375x812 (Light) | Mobile view of button page with radius 20 px. | Clean, passes visual review |
| `button_radius20_375_dark.png` | 375x812 (Dark) | Mobile view in dark mode of button page with radius 20 px. | Clean, passes visual review |
| `select_density_touch_1280_light.png` | 1280x800 (Light) | Select component page with density override set to `touch` (spacious density). Triggers scale up to touch targets (44-48px). | Clean, passes visual review |
| `select_density_touch_1280_dark.png` | 1280x800 (Dark) | Select component page in dark mode with density override set to `touch`. | Clean, passes visual review |
| `select_density_touch_375_light.png` | 375x812 (Light) | Mobile view of select component page with density override set to `touch`. | Clean, passes visual review |
| `select_density_touch_375_dark.png` | 375x812 (Dark) | Mobile view in dark mode of select component page with density override set to `touch`. | Clean, passes visual review |

## Visual Review & Verification

1. **Universal Playground Availability**:
   - Every component page now displays the "Playground" button, even pages without props builders or specs (e.g. `swipe_actions`).
   - Clicking "Playground" (or navigating to a URL with `t.*` parameters) docks the panel on the right (at >= 1024px) or opens a bottom sheet (at < 1024px).
   - When a component has no props builder, the panel still displays the full Theme section, allowing the user to configure theme tokens live for that component's preview and all its examples.

2. **Full Theme Token Controls (Figma-Style)**:
   - **Radius**: Slider (0-24) + discrete preset buttons (0, 4, 8, 12, 16, 20, 24) + numeric input.
   - **Density**: Segmented control (`compact`, `comfortable`, `touch`).
   - **Spacing base**: Slider + numeric input (1-16px, default 4px).
   - **Tracking**: Slider + numeric input (-2.0 to 4.0).
   - **Shadow**: Segmented presets (`none`, `sm`, `md`, `lg`).
   - **Surface Opacity**: Slider + numeric input (0.0 to 1.0).
   - **Surface Blur**: Slider + numeric input (0 to 30px).
   - **Font**: Segmented control (`sans`, `serif`, `mono`).
   - **Mode**: Segmented control (`light`, `dark`).
   - Collapsible with "Hide" / "Show" toggle.

3. **Scoped Theme Overrides**:
   - Overrides wrap only the component preview and all examples via `PlaygroundScope` and `Theme(data: themeOverride)`.
   - The site chrome (header, navigation sidebar, command palette, panel controls) remains unaffected by the component's theme override.
   - Changes update every example on the page live without requiring a scroll or reload.

4. **URL Query Serialization & Reset**:
   - Token overrides serialize into the URL query as `t.<name>` (e.g. `?t.radius=20&t.density=touch`).
   - `PlaygroundThemeValues.fromQuery` restores overrides on reload or deep-link navigation.
   - "Reset" button restores default tokens and clears non-default query parameters.

5. **Internationalization**:
   - All panel chrome strings (`pgTheme`, `pgShow`, `pgHide`, `pgControls`, `pgReset`, `pgCopyCode`, `pgDone`, `pgEdit`) use the docs i18n system (`docsChrome`).
   - Token and class names remain in standard English across all locales.

## Notes for Agent A (Concurrent kit token work)
- Kit components tested: `Button`, `Select`, `SwipeActions`.
- `Button` reacts immediately to `radius` (border radius changes dynamically from 0 to 20px) and `mode`.
- `Select` adapts trigger padding and height under `density: touch`.
- `SwipeActions` list item cards currently use hardcoded corner radiuses in some internal styles; noted for Agent A's `fix/theme-tokens-everywhere` branch to ensure all internal sub-widgets derive their border radius from `theme.tokens.radius` or `theme.tokens.radiusMd`.
