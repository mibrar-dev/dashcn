# Changelog

All notable changes to the `dashcn` package are documented here, following
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.1.0] - 2026-10-14

First release of `dashcn`: a widgets-only Flutter design system with
themed components, blocks and presets. No Material or Cupertino dependency.

### Added
- `DashcnApp` root widget (localizations, overlay and theme wiring).
- `Theme` / `ThemeData` with design tokens, density, typography and
  syntax colors; 43 built-in theme presets with light and dark modes.
- Foundation, theme and primitives layers, 118 components and 16 blocks.
- Generated entry points: the `dashcn.dart` barrel, per-layer libraries
  (`foundation.dart`, `theme.dart`, `primitives.dart`), one library per
  component (`components/<id>.dart`) and per block (`blocks/<id_with_underscores>.dart`, e.g. `blocks/login_01.dart`).
- Web-theme bridge (`theme_interop.dart`, pure Dart): import web CSS themes
  (v3 triplets, v4/tweakcn variables) and Tailwind v3/v4 themes, with an
  import report that lists mapped, defaulted and ignored variables; export
  to web CSS, Tailwind v4 `@theme`, W3C DTCG tokens, dashcn theme JSON and
  Dart.
- Runnable `example/` app.
