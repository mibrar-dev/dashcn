# CAPTURES — skeleton shimmer on real content (feat/ui-skeleton)

Docs served from `docs/build/web` on http://localhost:8874 (python http.server,
background). Browser: agent-browser, HEADLESS, session `w-skeleton`.
Page: `#/docs/components/skeleton`. Viewports 1280x800 and 375x812, `set media
light|dark` + reload for themes (the app follows `prefers-color-scheme`).

Scroll method: the docs app is a Flutter canvas build, so DOM scroll/click
refs are unavailable (snapshot shows only "Enable accessibility"). Scrolling
was done by dispatching synthetic `WheelEvent`s on `flutter-view` via
`agent-browser eval`; `mouse wheel` was unusable (CDP dispatch hangs).
No element could be clicked for the same reason — see "not covered" below.

## Files

| File | Shows |
|---|---|
| skeleton-1280-light-top.png | 1280 light, page top: Default example (toggle + card, shimmer over real text box) |
| skeleton-1280-light-card.png | 1280 light, Card example: avatar disc + two bars |
| skeleton-1280-light-list.png | 1280 light, List example: 3 avatar + text rows with dividers |
| skeleton-1280-light-loading-card.png | 1280 light, Loading card example: frosted card with header lines, content lines, footer bar |
| skeleton-1280-light-table.png | 1280 light, Table example: header blocks + 4x3 body grid |
| skeleton-1280-dark-top.png | 1280 dark, page top (title + device chips; Default content directly below fold) |
| skeleton-1280-dark-default.png | 1280 dark, Default example: toggle + card render correctly on dark tokens |
| skeleton-1280-dark-card.png | 1280 dark, Card example: disc + bars clearly visible on dark |
| skeleton-1280-dark-list.png | 1280 dark, List example: 3 rows + dividers, no overflow |
| skeleton-1280-dark-loading-card.png | 1280 dark, Loading card + Table top in one frame, both complete |
| skeleton-1280-dark-table.png | 1280 dark, Table example complete + API Reference start |
| skeleton-375-light-top.png | 375 light, responsive page top (hamburger menu, wrapped device chips) |
| skeleton-375-light-default.png | 375 light, Default example: toggle + card fit 375px, no overflow |
| skeleton-375-light-card-list.png | 375 light, Card complete + List complete, no overflow |
| skeleton-375-light-loading-card.png | 375 light, Loading card complete + Table header |
| skeleton-375-light-table.png | 375 light, Table grid complete + API Reference start |
| skeleton-375-dark-top.png | 375 dark, page top incl. Default example content, no overflow |
| skeleton-375-dark-card-list.png | 375 dark, Card complete + List complete (3 rows), no overflow |
| skeleton-375-dark-loading-card.png | 375 dark, List tail + Loading card complete + Table header |
| skeleton-375-dark-table.png | 375 dark, Table grid complete, no overflow |
| skeleton-interaction.webm | 1280 light: open page, scroll through Installation/Playground/Usage/Examples, stop |

## What looks right

- Every named example (Default, Card, List, Loading card, Table) renders in
  both themes and at both widths with no RenderFlex overflow (matches the
  375px widget tests).
- Dark shimmer (muted → accent) reads clearly; light shimmer is subtle in
  stills (the sweep animation carries it; see video).
- Touch density applies on phone widths (larger avatar/rows) via
  `resolveDensityTokens`; 375px shots show the roomier shapes.
- Docs Trust scorecard for skeleton (visible during the phone walk): text
  contrast Pass, labeled/Android/iOS tap targets Pass, RTL renders + Mirrored,
  41 tests Pass.

## What looks wrong / observations (plainly)

1. API Reference + Theme tables clip the Description column at the right edge
   at 1280px (both themes; e.g. "The real con…"), and code blocks clip
   horizontally at 375px. This is docs-chrome table/code rendering, not the
   skeleton component — the README source is complete and other components
   share the same renderer. Flagging for a docs follow-up, not fixed here.
2. First dark-top screenshot caught the preview mid-paint (empty card); a
   retake 3s later rendered correctly. No component issue.
3. `agent-browser reload` once dropped the session to `about:blank`; reopened
   the URL and continued. No component issue.

## Not covered (and why)

- No per-example "open/active overlay" shots: skeleton has no overlay, so
  there is no open state. The closest analog (Default toggle loading/loaded)
  cannot be clicked — the canvas build exposes no DOM refs and coordinate
  click is unsupported. Both toggle states are covered by widget tests instead
  (`skeleton_qa_test.dart`: "toggle flips between shimmer and loaded content").
- No isolated 375x812 dark-Default shot: the 375 dark top frame already shows
  the Default content; a duplicate was removed.
