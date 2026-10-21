# Surface tokens audit: solid surface paints without the surface primitive

Reference path: `dashcn/lib/src/components/navigation_bar/navigation_bar.dart`
(`_surface`: `surfaceColor(base, ambient.surfaceOpacity)` +
`GlassSurface(surfaceBlur: ambient.surfaceBlur)`).
Primitive: `dashcn/lib/src/primitives/surface.dart`
(`surfaceColor`, `resolveSurfaceOpacity`/`resolveSurfaceBlur`, `GlassSurface`).
Rule: a `Container`/`ColoredBox`/`BoxDecoration` fill from
`colors.background` / `colors.card` / `colors.popover` must go through the
primitive so the ambient `surfaceOpacity` / `surfaceBlur` apply. At the opaque
default (`null`/`1.0`, `null`/`0`) `surfaceColor` returns the base unchanged
and `GlassSurface` returns its child unchanged, so defaults render identical.

Method: `grep -rn "colors.(background|card|popover)"` over
`dashcn/lib/src/components`, `blocks`, `flows`, `starters` (excluding
`preview.dart`), then read each paint site for `surfaceColor`/`GlassSurface`
use, paint-vs-data distinction, and floating-surface vs inline/page role.
`DESIGN.md` (`scratchpad/ui/design/DESIGN.md`) does not exist in this
worktree; the audit proceeds from the rule text and the `navigation_bar`
reference instead.

## Fixed (7): direct solid surface paint now through the primitive

| # | file | token painted directly | fix (same path as `navigation_bar`) |
|---|------|------------------------|--------------------------------------|
| 1 | `dashcn/lib/src/components/chart/chart_tooltip.dart` (`ChartTooltipCard.build`) | `surface.tooltipFill`, defaults to `colors.popover` (`chart_style.dart:555`) | `surfaceColor(surface.tooltipFill, ambient.surfaceOpacity)` + `GlassSurface(surfaceBlur: ambient.surfaceBlur, borderRadius: 6)` around the `Container`. Ambient legs (no component surface knobs on the tooltip config). Defaults identical. |
| 2 | `dashcn/lib/src/components/code_snippet/code_snippet.dart` (`_CodeSnippetState.build`) | `style.background`, default `card` (`code_snippet_style.dart:38-39`) | `surfaceColor(rawFill, ambient.surfaceOpacity)` + `GlassSurface(surfaceBlur: ambient.surfaceBlur)` around the block `Container`. Ambient legs. Defaults identical. |
| 3 | `dashcn/lib/src/components/error_system/error_system.dart` (`AppErrorGate.build`) | `colors.background` (full-section `ColoredBox` overlay) | `surfaceColor(colors.background, ambient.surfaceOpacity)` + `GlassSurface(surfaceBlur: ambient.surfaceBlur)` around the `ColoredBox`. Ambient legs. Defaults identical. |
| 4 | `dashcn/lib/src/components/feature_carousel/feature_carousel.dart` (`_FeatureCarouselState.build` backdrop) | `colors.background` (`Positioned.fill ColoredBox`) | `surfaceColor(colors.background, ambient.surfaceOpacity)` + `GlassSurface(surfaceBlur: ambient.surfaceBlur)` around the backdrop `ColoredBox`. Ambient legs. Defaults identical. Import added plus paint wrapped (this change completes the earlier import-only edit). |
| 5 | `dashcn/lib/src/components/search_bar/search_bar.dart` (`_SearchBarState.build` surface) | `resolved.background`, defaults to `colors.popover` (`search_bar_style.dart:312`) | `surfaceColor(background, theme.surfaceOpacity)` + `GlassSurface(surfaceBlur: theme.surfaceBlur)` around the `DecoratedBox`. Ambient legs (`SearchBarTheme` carries no component surface knobs). Defaults identical. |
| 6 | `dashcn/lib/src/components/toolbar/toolbar_surface.dart` (`buildToolbarSurface`) | `style.background` (container fill) | `surfaceColor(rawFill, resolveSurfaceOpacity(context, component: style.surfaceOpacity))` + `GlassSurface(surfaceBlur: resolveSurfaceBlur(context, component: style.surfaceBlur))`. Component leg wins over ambient (matches `navigation_bar` leg order). Defaults identical. |
| 7 | `docs/lib/widgets/docs_header.dart` (`DocsHeader.build` bar) | `theme.colors.background` (`Container color:`) | `surfaceColor(theme.colors.background, theme.surfaceOpacity)` + `GlassSurface(surfaceBlur: theme.surfaceBlur)` around the bar `Container`. Layout, heights, padding, nav, search trigger, buttons, and the `_HeaderFocusAnchor` focus path unchanged. Defaults identical. |

## Reviewed, no fix: delegates to the primitive or not a box-surface paint

Component files whose `colors.background/card/popover` hit is **not** a direct
box-surface violation (each keeps its current rendering):

- `autocomplete/autocomplete.dart:188` — `colors.popover` passed as `fill:` to
  `MenuPopupSurface`, which already applies `surfaceColor` + blur internally.
  Delegates; no direct paint.
- `avatar/avatar.dart:356` — `colors.background` ring behind stacked avatars
  (`DecoratedBox`). Separator ring, not a floating/raised surface; no blur
  layer by design. Allow-list.
- `chart/chart.dart:606` — `colors.background` as `backgroundColor:` into the
  cartesian painter (canvas paint, not a `Container`/`ColoredBox`/
  `BoxDecoration` box surface). Allow-list (canvas, cf. registry `chart`
  reason).
- `chart/chart.dart:1262` — `colors.background` as chart `strokeColor`
  (canvas gap stroke). Allow-list (canvas).
- `chart/chart_style.dart:555` — `colors.popover` as `tooltipFill` **data**;
  the paint lives in `chart_tooltip.dart` (fixed above). No direct paint.
- `eye_dropper/eye_dropper.dart:465` — `colors.background` as
  `PixelGridPainter.backgroundColor` (sampling-grid canvas). Stays opaque so
  sampled colours stay accurate. Allow-list (canvas).
- `file_diff_viewer/file_diff_viewer.dart:428` — `colors.background` as a
  contrast fallback for marker ink (`_contrastingOn`), not a fill. No paint.
- `file_diff_viewer/file_diff_viewer_style.dart:364` —
  `resolved.background ?? colors.card` as `FileDiffSurface.background` data;
  the container paint at `file_diff_viewer.dart:78-80` is an inline diff-text
  layout fill, not a floating surface (cf. registry `file_diff_viewer`
  reason). Allow-list.
- `gooey_toast/gooey_toast_options.dart:53` — `colors.popover` as contrast
  reference for `ensureToneContrast`, not a paint. The toast paint is
  `GooeySurface` (already frosted). No paint.
- `markdown/markdown_style.dart:381-382` — `colors.card`/`cardForeground` as
  markdown renderer data (`surface:`/`onSurface:`), not a box paint here.
  Allow-list (text rendering).
- `number_ticker/number_ticker.dart:322` — `colors.background` as
  `ShaderMask` fade colours (edge-fade shader, not a box fill). Allow-list.
- `overflow_marquee/overflow_marquee_style.dart:318` — `colors.background`
  as `fadeColor` (edge-fade shader). Allow-list.
- `scrollable/scrollable.dart:76` — `colors.background` as
  `resolveFadeSurface` (fade-mask helper, also exposed for custom masks).
  Allow-list (fade mask, not a box surface).
- `slider/slider.dart:275` — `colors.background` as slider thumb fill
  (control, not a surface). Allow-list (control stays opaque).
- `skeleton/skeleton_compose.dart:109` — `colors.card` already wrapped:
  `surfaceColor(base, ...)` (USES). No fix needed.
- `command/command.dart:164`, `drawer_container:199`,
  `filter_bar_menu:64`, `filter_bar_sheet:54`, `hover_card:155`,
  `scaffold:294`, `search_bar:326` (post-fix), `segmented_control_thumb:119`,
  `navigation_bar:292,302`, `audio_player:211` — already route through
  `surfaceColor`/`GlassSurface`/`MenuPopupSurface` (USES). No fix needed.
- `card/card.dart:327` (`cardForeground`), `hover_card:163,166`
  (`popoverForeground`), `chart_style:558` (`popoverForeground`) — foreground
  text/icon tokens, never surface fills. No paint.

## Blocks / flows / starters

- `blocks/*` (20 files, e.g. `login-01`, `login-02/panel`, `login-03`,
  `signup-01/02`, `account-01/02`, `calendar-01/02`, `dashboard-01/shell/table`,
  `dashboard-02`, `sidebar-01/content`, `sidebar-02`, `sidebar-03`,
  `pricing-01`, `otp-01`): `ColoredBox`/`BoxDecoration color:
  theme.colors.background/card` page and panel fills. These are full-screen
  app backgrounds (the scaffold body role), which stay opaque by design — cf.
  the `scaffold` group in `surface_everywhere_test.dart` ("the full-screen
  body background stays opaque by design"). Allow-list with that reason; no
  fix.
- `flows/*` (11 files: `auth-01/scaffold`, `chat-01/conversation+thread_list`,
  `checkout-01/cart+payment+success`, `onboarding-01/pages+permission`,
  `settings-01/detail+home`): same page-background role
  (`color: appTheme.colors.background`). Allow-list (app background stays
  opaque). No fix.
- `starters/*` (`chat`/`saas`/`shop` templates incl. `.tmpl`): no
  `colors.background/card/popover` hits. Clean; no fix.

## Counts

- Component files with direct `colors.background/card/popover` box-surface
  paints fixed: 6 (+ docs header = 7 total fixed).
- Component hits reviewed as delegates / non-box paints / controls / canvas /
  shaders / already-frosted: 17 sites above, no change.
- Blocks page-background fills allow-listed: 20 files. Flows page-background
  fills allow-listed: 11 files. Starters: clean.
