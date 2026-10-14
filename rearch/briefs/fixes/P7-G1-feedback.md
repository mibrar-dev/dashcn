User feedback on the current gooey toast (screenshot `rearch/design/ours/screens/user-bugs-2026-10-11/gooey-toast-edges-
close.png` — do NOT open it; described here): "not looking good — you can see the edges, and the close button is way off".
1. The pill→body junction shows visible notches/steps and a stroked outline that follows the two shapes separately
   (outline drawn around the pill AND the body, with a stair-step where they meet). The merged silhouette must be ONE
   smooth metaball outline: concave fillets between pill and body, no inner seams, no double borders, antialiased; the
   1px border (if any) is drawn once around the merged path only.
2. The close (×) button floats outside the toast, top-right beyond the body. Place it INSIDE the body at the top-right
   corner with the body's padding (or on the pill, vertically centred, shadcn/Sonner style), hit target ≥ 24px.
3. Icon tint: the status icon is fine, but keep the title in foreground (not tinted).
Add tests: merged silhouette path is a single closed contour (no overlapping subpaths drawn with a stroke); close button
rect is within the body rect with padding. Re-capture and update the report.
