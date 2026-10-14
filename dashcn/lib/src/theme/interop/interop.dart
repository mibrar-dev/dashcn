// Web-theme interop barrel (pure Dart, no Flutter import): import this file
// to parse web CSS / Tailwind themes into [WebTheme] and write them back as
// CSS, Tailwind v4, W3C Design Tokens or kit preset JSON.
//
// Deliberately small (published APIs are permanent): every export below uses `show`,
// so the parsing tables, length helpers, fallback inventory, formatters and
// diagnostics in `internal/` stay out of the public surface. Reach for those
// files directly from `src/` only when working inside the interop layer or
// its tests. `package:dashcn/theme_interop.dart` is the publish entry point.

export 'color_space.dart'
    show WebColorException, Oklch, oklchFromArgb, argbFromOklch;
export 'css_theme_parser.dart' show CssVariant, CssThemeResult, parseCssTheme;
export 'tailwind_v3_parser.dart' show TailwindV3Result, parseTailwindV3Theme;
export 'theme_model.dart'
    show
        WebTheme,
        WebShadowAtoms,
        ImportReport,
        MappedEntry,
        DefaultedEntry,
        IgnoredEntry;
export 'web_color_parser.dart' show parseWebColor, tryParseWebColor;
export 'writers/dashcn_theme_writer.dart'
    show
        WebThemeException,
        webThemeFromPresetJson,
        presetJsonFromWebTheme,
        presetJsonStringFromWebTheme;
export 'writers/dtcg_writer.dart' show writeDtcgTokens;
export 'writers/tailwind_v4_writer.dart' show writeTailwindV4Theme;
export 'writers/web_css_writer.dart' show writeWebCss;
