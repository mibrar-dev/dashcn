# Docs shell fixes: REPORT

Branch: `feat/docs-shell-fixes`. Worktree: `dashcn-w-docsshell`. Port: 8881.
Cherry-picked `b626d6804` (mobile drawer) then fixed close animation to mirror
open (scrim fades, panel slides out, then unmounts; no jump, no lingering
off-screen widgets for finders/focus).

## Fix list (all verified at 1280x800 + 375x812, light + dark)

1. **Sidebar stays fixed** — `docs/lib/widgets/docs_sidebar.dart`: removed
   auto-centre on route change, preserved scroll via static offset. Only
   content changes, selected item highlights.
2. **Playground right-side panel** — `docs/lib/pages/component_page.dart`:
   "Playground" button at top toggles 380px docked panel (desktop) /
   full overlay (phone) with Close; sidebar stays put (DocsLayout).
3. **Trust scorecards dialog/sheet** — same file: "Trust scorecards" button at
   top opens centred dialog (≥640px) or bottom sheet (<640px) with
   `ScorecardCard`; removed inline bottom list.
4. **Charts tab bar** — `docs/lib/pages/charts_gallery.dart`,
   `charts_hub_page.dart`: hub shows tab bar, first family selected default,
   only selected renders. `/charts/bar` shows switching.
5. **Usage redesign** — `docs/lib/widgets/component_sections.dart`: install
   line, minimal example in compact syntax-coloured snippet with copy,
   key params (first 5 API params), snippet count. No wall of code.
6. **Theme 200ms cross-fade** — `theme_switch_transition.dart`
   (`_SnapshotFade` 1→0), `motion/ease.dart` (`kDurationThemeSwitch` 250→200),
   `kThemeSwitchFade` 250→200. No jump-then-back.
7. **Toast one frame** — `dashcn/lib/src/components/toast/toast.dart`
   (mirrored): `ToastLayer` Stack always mounted, first toast never moves
   `child` (no relayout lag).
8. **Drawer + menubar** — `docs_shell.dart` mount/open/unmount dance;
   `docs_header.dart` drawer solid + right rule; `menu.dart` trailing-edge
   anchoring (`topEnd`/`bottomEnd` when trigger in trailing half) + rows use
   `resolveDensityTokens().rowMinHeight` (not hardcoded 32).
9. **Header surface** — `docs_header.dart` uses `surfaceColor` +
   `GlassSurface` (matches `feat/surface-tokens-audit`), opaque default identical.
10. **Double borders** — `preview_stage.dart` (`PreviewFrame` Card borderless +
    single overlay; `showBorder:false` for popup-like), `example_preview_card.dart`
    (`_popupLikeComponents` outer borderless). Popup + docs cards single border.

Supporting: `docs/lib/main.dart` deep-link initial route from `Uri.base` on
http(s) (file:// tests keep `/`), so direct URLs land on pages (screenshots).

## Captures

40 files in `scratchpad/ui/docsshell/captures/` + `CAPTURES.md`:
- `*-button.png` (1,6,9,10 docs cards), `*-button-playground-open.png` (2),
  `*-button-scorecards-open.png` (3, dialog/sheet), `*-charts.png` +
  `*-charts-bar.png` (4, hub first + Bar switching), `*-button-usage-top.png` (5),
  `*-toast-toast-open.png` (7), `*-button-drawer-open.png` + `*-menubar.png` (8),
  `*-popup.png` (10 popup). All at 1280x800 + 375x812 light/dark via
  agent-browser on :8881 (release + deep-link fix; open states via temporary
  `?playground=open` etc. hooks, reverted — final code opens via taps,
  verified via widget tests).

## Gates

- `dart format` (changed files): clean.
- `dart analyze` (docs): No issues. (dashcn toast/menu): No issues.
- `flutter test` (docs): 915 pass. Touched registry: `toast_test` 14 pass,
  `menu_test` 30 pass, `menubar_test` 13 pass. Updated: `charts_pages_test`
  (hub first only), `motion_test` (drawer 200ms, theme 200ms),
  `ts1_transition_test` (200–400ms), `p9z/component_page_p9z_test` (panel/dialog),
  `toast_test` (always Stack).
- `gen_docs_data --check`: up to date. `sync_registry --check`: up to date.
- `flutter build web --release --base-href /`: built `build/web`.
- Browser rule: no audio played; `agent-browser close --all` after captures.

## PR

- URL: https://github.com/mibrar-dev/dashcn/pull/54
- Base `main`, repo `mibrar-dev/dashcn`, branch `feat/docs-shell-fixes`. Do NOT merge.
