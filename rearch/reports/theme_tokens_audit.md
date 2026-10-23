# Theme-tokens audit: every component reads the theme (branch `fix/theme-tokens-everywhere`)

Scope: all 133 dirs in `dashcn/lib/src/components`, surface-drawing files in
`lib/src/primitives`, `lib/src/blocks`, `lib/src/flows`. Preview files,
README/meta and full-line comments excluded. Default theme for
pixel-identity below is the kit `const ThemeData()` (`radius` 0.5:
Xs 2 / Sm 4 / Md 6 / Lg 8 / Xl 12 / Xxl 12; compact density).

## What was already token-driven (no change)

The large majority of components already resolve radius, density, shadows,
surface opacity/blur, fonts and tracking from the ambient theme, e.g. button
(`buttonMetricsForTokens` + `buttonIconSize`), input, select trigger (now
fully), card (`shadowSm`, surface legs), dialog, popup, menu, sidebar,
swipe_actions, accordion chevron (iconTheme rungs), alert, autocomplete,
badge, calendar, checkbox, chip, collapsible, color_field, color_input,
command (`tracking.wide`), date/time pickers, divider, dropzone, form,
hover_card, list_tile, markdown, menubar, navigation, outlined_container,
progress track (h/2 pill), radio_group, resizable, scaffold, scrollbar,
skeleton, slider track (`trackHeight/2`), switch/switcher capsules, table
(resizer now `colors.primary`), tabs, text_area, toast, toggle, toolbar,
tooltip, tracker, tree, video scrub/buttons (geometric), wheel_picker,
window, and the `surface` primitive (`GlassSurface` + `resolveSurfaceOpacity/
Blur`). Surface blur sigmas outside `surface.dart` belong to animation
effects (gooey/streaming), not surfaces.

## Fixes (this branch)

| Component / file | Was hard-coded | Now reads | Identity at default |
|---|---|---|---|
| action_sheet.dart ×2 | `BorderRadius.circular(12 * scaling)` | `ambient.radiusXl * scaling` | 12 exact |
| border_loading defaults + fallback | const `Radius.circular(12)` | null + `Theme.of(context).radiusXl` | 12 exact |
| segmented control track | const `Radius.circular(8)` + `borderRadiusMd` fallback | null + `borderRadiusLg` fallback | 8 exact |
| empty_state icon badge | const `Radius.circular(14)` | null + `theme.radiusXl + 2` fallback | 14 exact |
| file_upload_row thumb + row | `6 * scaling`, const `8` | `ambient.radiusMd/scaling`, null + `radiusLg` fallback | 6/8 exact |
| markdown blocks/table/code | `6`, `10` | `radiusMd`, `radiusLg + 2` | 6 exact; 10 exact (2 above Lg) |
| markdown image preview | `16` | `radiusXl + 4` | 16 exact (sheet/dialog rule) |
| resizable grip | `2` | `radiusXs` | 2 exact |
| menu_rows shortcut | `letterSpacing: 1.2` | `tracking.wide ?? 1.2` | exact |
| feature_carousel card/arrows | const `radius: 12` | null + `radiusXl` fallback | 12 exact |
| chart tooltip | const `Radius.circular(6)` | `radiusMd` | 6 exact |
| video_player stage/header/menu/controls/frame | `4/8/10/14/18` | `radiusSm` (4), `radiusLg` (8), `radiusLg + 2` (10), `radiusXl + 2` (14), `radiusXl + 6` (18) | all exact via media-chrome offsets |
| video overlay title/subtitle | `fontSize: 14/12` | `densityTokens.bodyTextSize`, `typography.xSmall` | exact |
| audio artwork | `14/20` | `radiusXl + 2` / `radiusXxl + 8` | 14/20 exact (media-chrome offsets) |
| audio compact progress hairline | `1` | `trackHeight / 2` pill geometry | same rendering (2px bar) |
| audio equalizer bars | `1.5` | `_waveBarWidth / 2` pill geometry | same pill rendering |
| audio compact_parts icon, transport buttons, expanded icon | `iconSize ?? 16`, `controlSize ?? 32` | `densityTokens.iconSize/controlHeight` | exact |
| audio transport speed popup | `8` | `radiusLg` | 8 exact |
| audio artist tracking | `letterSpacing: 1.2` | `tracking.wide ?? 1.2` | exact |
| dashboard-02 legend swatch | `circular(5)` on 10px box | `swatch / 2` circle geometry | exact |
| hsv/hsl thumb default | `Radius.circular(0)` | `Radius.zero` | exact |
| select trigger text/icon/height | `14`, `16`, `?? 36` | `bodyTextSize`, `iconSize`, `rowMaxHeight` | exact (36 = compact row max) |
| search_bar leading icon | const `16` default | null + `densityTokens.iconSize` | exact |
| badge icon + dot | `?? 12`, `badgeDotSize 10` | `iconTheme.xSmall`, `iconTheme.x2Small` | exact |
| breadcrumb gap + separator | `?? 6`, `12` | `density.baseGap - 2`, `iconTheme.xSmall` | 6 exact (8−2); separator exact |
| collapsible/accordion icon gap | `?? 16` | `spacing.lg` | 16 exact |
| pagination gap + icon | `?? 4`, `12` | `spacing.xs`, `iconTheme.xSmall` | exact |
| navigation_bar gap | `?? 8` | `spacing.sm` | 8 exact |
| history/item_picker gaps | `?? 4` | `spacing.xs` | exact |
| history tile | `?? 32` | `densityTokens.rowMinHeight` | exact |
| drawer_container gaps | `?? 8/4` | `spacing.sm/xs` | exact |
| phone_input field/country gaps | `?? 8/16` | `spacing.sm/lg` | exact |
| spinner diameter | `?? 24` | `iconTheme.large` | exact |
| star_rating size | const `24` default | null + `iconTheme.large` | exact |
| progress track height | `?? 8` | `spacing.sm` | exact |
| spell_check toolbar offset | `Offset(8, -8)` | `spacing.sm` pair | exact |
| table resizer color | dead `Color(0xFF000000)` init | `late`, always assigned `colors.primary` | exact |

## Justified exceptions (allow-listed in `theme_tokens_guard_test.dart`)

- **Round by design (pill/circle geometry, no scale step):** chat reaction
  `999`, file_diff stat `999`, gooey chip `999`, thread_list unread `999`,
  popover sheet handle `2` (h/2), fab/avatar/switch/skeleton/drawer-handle/
  progress/video/scrub circles (`size/2`, `h/2` — no literal, need no entry).
- **Intentionally fixed:** keyboard_shortcut `Radius.circular(4)` (P7-WC2:
  a key hint must keep its rounding; per-instance `keyBorderRadius` exists);
  gooey_toast status tones + surface fill (fixed across presets by design,
  contrast-checked); slider tick `Radius.circular(1)` and waveform ring
  (sub-pixel paint geometry, no BuildContext).
- **Media chrome over content (not theme surfaces):** all video_player
  scrims/whites/frame/LIVE red/style defaults, audio disc/gradient/artwork
  colors, speed-popup chrome, image_lightbox barrier, chart-canvas whites.
- **Barriers:** `0x80000000` in dialog/drawer/swiper/overlay/color_input/
  drawer_panel/object_form_field/markdown preview (no barrier token exists).
- **Color science:** alpha checkerboard, hue-gradient stops, color_math
  endpoints, hsv/hsl cursor rings, border_loading modulate white,
  fade/marquee/star ShaderMask whites (alpha-only use).
- **Dead/API-mirroring defaults:** AudioProgressBar const colors (every call
  site already passes theme-resolved `border`/`muted`/`primary`); bullet
  painter black fallback (no BuildContext; callers pass style color).
- **Fixed art-directed geometry (documented, unchanged defaults):**
  audio compact 36/48 pill boxes, phone_input trigger/overlay widths,
  search_bar overlay maxHeight/row, color_picker 96, slider variant
  track/thumb table, star gap 5, video microcopy sizes, feature_carousel
  CTA/arrow sizes, signature_pad/sortable/select/search disabled-opacity
  washes (no disabled-opacity token exists), collapsible TouchHitArea base,
  code_snippet 28/14 (mirrors button-xs metrics; cross-layer import
  forbidden), table `_resizerThickness 4`, history tile internals.

## Pixel identity at the kit default (0.5)

Every fix is pixel-identical at the kit default (`radius` 0.5: Xs 2 / Sm 4 /
Md 6 / Lg 8 / Xl 12 / Xxl 12; compact density; spacing base 4). Where no scale
step equalled the old literal, the code keeps the exact px as a documented
offset above the nearest step (media chrome keeps +2/+4/+6/+8 above the
surface scale so it still reads as chrome when the theme radius moves);
those offsets are noted per row above. Only the token source changes, so
moving the theme radius/density moves every component.
