# MOBILE_QA — M1 mobile (375px) QA + fix, identity mockups

Method: probe page (`_probe.html`, deleted after use) loading each of the 16 pages in an
`<iframe>` exactly 375px wide / 812px tall over a local server
(`python3 -m http.server 8765`), results read via headless Chrome
`--virtual-time-budget=8000 --dump-dom`. Pass criterion: `scrollWidth <= 375`.
Desktop check: same probe with iframe width 1440 must stay 1440 (layout unchanged).
Wide elements that remain are all children of intentional inner scrollers
(`overflow-x:auto`: preset strips, flow scrollers, `pre.code`), which the brief
sanctions for code/table wrappers — none of them push the page (`scrollWidth = 375`).

| dir | page | before scrollWidth | after scrollWidth | what you changed |
|-----|------|-------------------:|------------------:|------------------|
| A | home.html | 375 | 375 | `flow4`/`spec-grid` grids `1fr`→`minmax(0,1fr)`; grid children `min-width:0` (no layout change when content fits) |
| A | theming.html | 579 | 375 | `bench` grid →`minmax(0,…)` + children `min-width:0`; `exptabs` wraps; `table.spec` fixed layout with breaking cells so token rows wrap instead of forcing the grid wide |
| A | component.html | 418 | 375 | `docs` grid →`minmax(0,1fr)` + children `min-width:0`; `score5` →`minmax` pair; API `table.spec` fixed layout |
| A | index.html | 375 | 375 | shared `tokens.css` mobile safety only (grids `minmax`, frames/code `max-width:100%`) |
| B | home.html | 375 | 375 | `bridge`/`lab-grid`/`recipes`/`plat`/`tiles` grids →`minmax`; children `min-width:0` |
| B | theming.html | 375 | 375 | shared `tokens.css` mobile safety only; preset `strip` keeps its intentional inner scroll |
| B | component.html | 467 | 375 | `docs`/`score` →`minmax`; `preview-box` padding 28→16 on mobile, `knobs`/`frame-slot` `min-width:0`/`max-width:100%`; `table.api` fixed layout |
| B | index.html | 375 | 375 | shared `tokens.css` mobile safety only |
| C | home.html | 434 | 375 | stiffness/damping inline grid →`minmax(0,1fr)` pair; `curve-box`/`curve-panel`/`canvas` `min-width:0`; `.cmd` wraps and `card .mono` breaks instead of forcing Motion-Lab `grid2` wide |
| C | theming.html | 375 | 375 | `spec` grid →`minmax(0,1fr)` + children `min-width:0` |
| C | component.html | 580 | 375 | via shared `tokens.css`: `docs` →`minmax(0,1fr)` + children `min-width:0`; `table.api` fixed layout with breaking cells; `devices`/`platform-bar` capped at `max-width:100%` |
| C | index.html | 375 | 375 | shared `tokens.css` mobile safety only |
| D | home.html | 375 | 375 | `hero`/`screens4`/`knobs`/`motion`/`specs`/`create-grid` grids →`minmax`; `stage-head`/`stats` wrap; `frame-iphone` capped via `min()` |
| D | theming.html | 375 | 375 | `bench` middle track →`minmax(0,1fr)` (+2-col/1-col mobile variants) + children `min-width:0` |
| D | component.html | 443 | 375 | `docs`/`play`/`score` →`minmax`; `preview` padding 36→16 on mobile; `knob`/`c-code` `min-width:0` + breaking; `table.api` fixed layout |
| D | index.html | 375 | 375 | shared `tokens.css` mobile safety only |

Shared per-dir `tokens.css` additions (all inside `@media (max-width: 560/640px)`, desktop untouched):
colours, radii and fonts untouched (still CSS variables); grids use `minmax(0,1fr)` so
tracks can shrink; grid/flex children get `min-width:0`; tables use `table-layout:fixed`
with `overflow-wrap:anywhere`; `pre.code`/`.code`/`.terminal` keep `overflow-x:auto`
inside their own wrappers; device frames capped at `max-width:100%`.

Desktop re-check (iframe width 1440): all 16 pages report `scrollWidth = 1440`,
identical to the pre-fix baseline (same top-wide elements) — desktop layout unchanged.
All HTML files re-validated (doctype + balanced tags).

Probe files (`_probe.html`, `_probe2.html`) deleted; no server/temp files remain in the worktree.

## RESULT: PASS
