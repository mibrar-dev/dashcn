# Captures: website i18n header (surface opacity 0.6, blur 12)

Page: `/docs/components/button` scrolled ~900 px so article content sits
behind the floating header. Theme document patched via localStorage
(`surfaceOpacity: 0.6`, `surfaceBlur: 12`); locale via `?locale=`; brightness
via `docs.theme.brightness`. Release web build served with SPA fallback on
:8887, screenshots via agent-browser (viewport CSS px, DPR 1).

| File | Locale (dir) | Theme | Viewport | Notes |
| --- | --- | --- | --- | --- |
| `de-light-1280.png` | de (LTR, long text) | light | 1280x800 | Header (Start/Docs/Komponenten/Diagramme/Themes, Suche, globe, Los geht's) over install block; frosted smudge visible top-center; sidebar (Bereiche…) + TOC (Auf dieser Seite…) translated. |
| `de-dark-1280.png` | de (LTR) | dark | 1280x800 | Same page dark; header readable over dark article; eject note + Verwendung + Wichtige Parameter translated. |
| `de-light-375.png` | de (LTR) | light | 375x812 | Hamburger (Menü), icon-only actions, Paket/Code besitzen tabs, Verwendung translated. |
| `de-dark-375.png` | de (LTR) | dark | 375x812 | Same as above, dark. |
| `ar-light-1280.png` | ar (RTL) | light | 1280x800 | Mirrored: nav right (الرئيسية…), sidebar right (الأقسام), TOC left (في هذه الصفحة), CTA ابدأ left; install/usage/key-params translated. |
| `ar-dark-1280.png` | ar (RTL) | dark | 1280x800 | Same page dark; header readable over dark article. |
| `ar-light-375.png` | ar (RTL) | light | 375x812 | Hamburger القائمة right, mirrored icons, التثبيت tabs, الاستخدام translated. |
| `ar-dark-375.png` | ar (RTL) | dark | 375x812 | Same as above, dark. |

Show-through reads: on light captures the blur smudge + ghost text is
visible behind the bar (top edge, strongest over dark/colored cards); on
dark captures the bar stays readable (foreground tokens, contrast holds).
Code snippets stay LTR (`DashcnLtr`-style runs) inside RTL pages.
