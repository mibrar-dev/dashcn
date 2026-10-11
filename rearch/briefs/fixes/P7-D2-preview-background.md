# Brief P7-D2 — preview canvas background: keep the dotted pattern but blur/soften it so previews read clearly

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, DOCS=$KIT/docs.
Do NOT open PNG images yourself (model crashes on images) — verify with widget tests and numeric pixel checks.

User (2026-10-11): the preview background pattern should stay, but blurred — right now previews blend into the dotted
background so components are hard to read/see.

## Do (docs only: the dotted canvas painter used by component example cards (`example_preview_card.dart` /
`preview_stage.dart` / wherever the dot grid is painted), plus the blocks viewport if it uses the same canvas)
1. Keep the dot-grid pattern but render it soft: blur it (ImageFilter.blur on the pattern layer only — never on the
   preview content), lower the dot alpha (≈ 6–10% of foreground in light, ≈ 8–12% in dark), and add a radial fade so
   the centre where the component sits is calmer than the edges.
2. Give previews separation from the canvas: the canvas uses the `muted`/`background` token difference so component
   surfaces (cards, inputs, popovers, toasts) have visible edges in light AND dark for every preset; no component
   should be the same colour as its backdrop.
3. Performance: paint the pattern once (RepaintBoundary / cached picture), blur cost bounded; no jank while scrolling
   long component pages.
4. Tests: content layer is not blurred (ImageFiltered only wraps the pattern); dot alpha within the target range;
   measured contrast between canvas and card/popover surface ≥ a threshold in light/dark for neutral + claude.
Gates: docs format/analyze/test/codegen --check/sync --check/`flutter build web --release`. Captures via agent-browser
(button, card, select, toast pages at 1440 dark + light) → `rearch/design/ours/screens/p7d2-*.png`.
Report `rearch/reports/P7-D2.md`, `## RESULT`. No git ops. Another agent (P7-G1) is fixing the gooey toast — don't edit
toast files.
