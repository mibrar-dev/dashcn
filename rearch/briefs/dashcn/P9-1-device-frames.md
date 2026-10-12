# P9-1 — Every platform at once (device frames)

Prerequisite: P8-2 accepted. Spec: `DASHCN_FEATURES_PLAN.md` §P9-1 (binding). Read `$DOCS/lib/pages/component_page.dart`,
`$DOCS/lib/previews/**`, `$DOCS/lib/state/docs_state.dart`, `$DOCS/lib/routing/docs_router.dart`.

## Tasks
1. **Verify platform reads first.** Grep `$APP/lib/src` for `defaultTargetPlatform`, `TargetPlatform`, `Platform.`,
   `kIsWeb`. Report each site. If components branch on platform, add nullable `platform` to the kit `ThemeData` (falls
   back to `defaultTargetPlatform`) + `Theme.of(context).platform` accessor and route those reads through it, with
   tests in `$APP/test/registry/theme/platform_override_test.dart`. If none branch, skip the kit change and say so.
2. `$DOCS/lib/widgets/device_frame/`: `device_spec.dart` (iphone, android, desktop window, browser; portrait and
   landscape), `device_frame.dart` (chrome via CustomPainter, no images; clip; MediaQuery override of size, padding,
   viewPadding, viewInsets, devicePixelRatio; platform override), `frame_bar.dart` (None · iPhone · Android ·
   Desktop · Web · All, rotate, light/dark), `all_frames.dart` ("All" = Wrap of 4 frames in FittedBox; snap
   scroller below 700 px).
3. State and URL: `frame`/`orientation` in docs state, persisted, and synced with the `?frame=` query param. The
   docs-state edits are limited to adding the two fields and their (de)serialisation.
4. Integration point: expose `FramedPreview({required Widget child, String? id})` and DO NOT edit
   `component_page.dart`. Document the one-line integration in the report (P9-Z wires it).
5. Tests in `$DOCS/test/device_frame/`: each spec exposes the right insets and size to the child, the platform
   override is visible, there is no overflow in all 5 modes × light/dark for 6 representative previews (button,
   card, dialog, select, calendar, sidebar-01 block), and the frame choice persists and round-trips through the URL.
6. Screenshot test `$DOCS/test/device_frame/frames_capture_test.dart` writes PNGs to
   `$KIT/rearch/screenshots/p9-1/` (do not open them).

## Owns
`$DOCS/lib/widgets/device_frame/**`, `$DOCS/test/device_frame/**`, `$DOCS/lib/state/docs_state.dart` (two
fields only), kit platform plumbing and tests if step 1 needs them.

## Gates
Docs: format, `flutter analyze`, `flutter test`, `gen_docs_data --check`, `sync_registry --check`,
`flutter build web --release`. Kit (if touched): `rearch/qa_gate.sh`.

## Report
`$KIT/rearch/reports/P9-1.md`
