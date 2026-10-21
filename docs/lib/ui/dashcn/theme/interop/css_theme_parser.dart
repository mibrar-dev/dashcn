// Web CSS theme parser (pure Dart, no Flutter import): `:root` + `.dark`
// (plus `[data-theme]` variants), v3 HSL triplets and v4/modern colour
// notations, `--radius`, `--font-*`, `--shadow-*`, `--chart-*`,
// `--sidebar-*`, `--spacing`, `--letter-spacing`/`--tracking-*`, and
// Tailwind v4 `@theme { --color-* }` aliases. Never throws: garbage becomes
// report entries, and the returned theme is always [WebTheme.completed].

import 'internal/css_mapping.dart';
import 'internal/css_syntax.dart';
import 'theme_model.dart';
import 'web_color_parser.dart';

/// Which web CSS colour era the source uses.
enum CssVariant {
  /// Bare `H S% L%` triplets (v3-style variables).
  v3,

  /// Modern notations (`oklch()`, `oklab()`, hex, `rgb()`, …).
  v4,

  /// Both triplet and modern syntax in one file.
  mixed,
}

/// A parsed CSS theme: the completed [WebTheme], its [ImportReport], and the
/// detected [CssVariant].
final class CssThemeResult {
  /// Creates the result.
  const CssThemeResult({
    required this.theme,
    required this.report,
    required this.variant,
  });

  /// Imported theme with fallbacks filled.
  final WebTheme theme;

  /// Mapped/defaulted/ignored variables.
  final ImportReport report;

  /// Detected colour era.
  final CssVariant variant;
}

/// Parses [source] CSS into a [CssThemeResult]. Never throws.
CssThemeResult parseCssTheme(String source) {
  final ImportReport report = ImportReport();
  try {
    return _parse(source, report);
  } catch (error) {
    report.ignored.add(IgnoredEntry('(source)', 'recovered: $error'));
    return CssThemeResult(
      theme: const WebTheme().completed(report),
      report: report,
      variant: CssVariant.v4,
    );
  }
}

CssThemeResult _parse(String source, ImportReport report) {
  final _Collector collector = _Collector();
  _walk(stripCssComments(source), collector);
  final _ThemeBuilder builder = _ThemeBuilder(report);
  builder.absorb(collector.light, false);
  builder.absorb(collector.dark, true);
  builder.absorbThemeBlock(collector.themeVars, collector);
  if (builder.sawTriplet) {
    collector.sawTriplet = true;
  }
  if (builder.sawModern) {
    collector.sawModern = true;
  }
  final WebTheme theme = builder.build();
  for (final String statement in collector.atRules) {
    report.ignored.add(IgnoredEntry(statement, _atRuleReason(statement)));
  }
  return CssThemeResult(
    theme: theme,
    report: report,
    variant: collector.variant,
  );
}

/// Why an at-rule statement is skipped: directives are build-time helpers,
// never theme tokens, and each line says so.
String _atRuleReason(String statement) {
  if (statement.startsWith('@apply')) {
    return 'build-time utility inlining; not a theme token';
  }
  if (statement.startsWith('@custom-variant')) {
    return 'dark-variant helper; the .dark block already carries dark mode';
  }
  if (statement.startsWith('@layer')) {
    return 'wrapper only; inner declarations still parsed';
  }
  if (statement.startsWith('@media')) {
    return 'conditional wrapper; inner declarations still parsed';
  }
  if (statement.startsWith('@import')) {
    return 'stylesheet import; not a theme token';
  }
  return 'not a theme token';
}

/// Raw per-mode variable maps plus era signals, filled by [_walk].
class _Collector {
  /// `:root` (and other non-dark) variables in source order.
  final Map<String, String> light = <String, String>{};

  /// `.dark` / `[data-theme*=dark]` variables in source order.
  final Map<String, String> dark = <String, String>{};

  /// Tailwind v4 `@theme` variables.
  final Map<String, String> themeVars = <String, String>{};

  /// At-rule statements met while walking (`@import`, `@layer`, `@apply`,
  /// …), in source order, deduplicated: variables are never dropped
  /// silently, and neither are the directives around them.
  final List<String> atRules = <String>[];

  /// Records an at-rule statement once.
  void noteAtRule(String statement) {
    final String text = statement.trim();
    if (text.isNotEmpty && !atRules.contains(text)) {
      atRules.add(text);
    }
  }

  /// Whether bare `H S% L%` triplets were seen.
  bool sawTriplet = false;

  /// Whether `oklch(`/`oklab(` was seen.
  bool sawModern = false;

  /// Detected era.
  CssVariant get variant {
    if (sawTriplet && sawModern) {
      return CssVariant.mixed;
    }
    return sawTriplet ? CssVariant.v3 : CssVariant.v4;
  }
}

/// Walks rule blocks; at-rules other than `@theme` recurse so `@layer` and
/// `@media` wrappers stay transparent. Later blocks win per mode.
void _walk(String css, _Collector collector) {
  int i = 0;
  while (i < css.length) {
    while (i < css.length &&
        (css[i].trim().isEmpty || css[i] == ';' || css[i] == '}')) {
      i++;
    }
    if (i >= css.length) {
      break;
    }
    final int open = css.indexOf('{', i);
    if (open < 0) {
      break;
    }
    final int semi = css.indexOf(';', i);
    if (semi >= 0 && semi < open) {
      // Block-less at-rule (`@import "…";`, `@charset …;`,
      // `@custom-variant …;`): skip it instead of swallowing the next
      // block as its selector, and report it so it is never silent.
      collector.noteAtRule(css.substring(i, semi).trim());
      i = semi + 1;
      continue;
    }
    final String selector = css.substring(i, open).trim();
    int depth = 0;
    int close = open;
    for (; close < css.length; close++) {
      if (css[close] == '{') {
        depth++;
      } else if (css[close] == '}') {
        depth--;
        if (depth == 0) {
          break;
        }
      }
    }
    final String inner = css.substring(
      open + 1,
      close >= css.length ? css.length : close,
    );
    i = close >= css.length ? css.length : close + 1;
    if (selector.startsWith('@theme')) {
      collector.themeVars.addAll(splitCssDeclarations(inner));
    } else if (selector.startsWith('@')) {
      // Transparent wrapper (`@layer`, `@media`, …): the inner declarations
      // still parse, and the wrapper itself gets a report line.
      collector.noteAtRule(selector);
      _walk(inner, collector);
    } else if (selector.isNotEmpty) {
      final List<String> skippedAtRules = <String>[];
      (isDarkSelector(selector) ? collector.dark : collector.light).addAll(
        splitCssDeclarations(inner, skippedAtRules),
      );
      for (final String statement in skippedAtRules) {
        collector.noteAtRule(statement);
      }
    }
  }
}

/// Accumulates one theme from raw variable maps.
class _ThemeBuilder {
  /// Creates the builder recording into [report].
  _ThemeBuilder(this.report);

  /// Import entries.
  final ImportReport report;

  final Map<String, int> light = <String, int>{};
  final Map<String, int> dark = <String, int>{};
  double? radius;
  final Map<String, String> fonts = <String, String>{};
  double? spacing;
  final Map<String, double> tracking = <String, double>{};
  double? surfaceOpacity;
  double? surfaceBlur;

  /// Shadow atoms per mode, by field name.
  final Map<String, Map<String, Object>> atoms = <String, Map<String, Object>>{
    'light': <String, Object>{},
    'dark': <String, Object>{},
  };

  /// Era signals found while absorbing.
  bool sawTriplet = false;
  bool sawModern = false;

  Map<String, int> _colors(bool isDark) => isDark ? dark : light;

  /// Absorbs one mode's variables; `var()` refs resolve within the mode.
  void absorb(Map<String, String> vars, bool isDark) {
    for (final MapEntry<String, String> entry in vars.entries) {
      final String name = entry.key;
      final String raw = entry.value;
      if (cssVarToKitToken(name) case final String kitToken) {
        _absorbColor(name, raw, kitToken, isDark, vars);
      } else if (name == kCssRadiusVar) {
        radius = _absorbScalar(name, raw, parseRemLength, 'radius');
      } else if (kCssFontToSlot[name] case final String slot) {
        fonts[slot] = raw.trim();
        report.mapped.add(MappedEntry('--$name', 'fonts.$slot'));
      } else if (name == kCssSpacingVar) {
        spacing = _absorbScalar(name, raw, parseRemLength, 'spacing');
      } else if (kCssTrackingToStep[name] case final String step) {
        final double? value = _absorbScalar(
          name,
          raw,
          parseEmLength,
          'tracking.$step',
        );
        if (value != null) {
          tracking[step] = value;
        }
      } else if (kCssShadowToAtom[name] case final String field) {
        _absorbAtom(name, raw, field, isDark ? 'dark' : 'light');
      } else if (name == kCssSurfaceOpacityVar) {
        final double? value = _absorbScalar(
          name,
          raw,
          parsePxLength,
          'surfaceOpacity',
        );
        if (value != null) {
          if (value < 0 || value > 1) {
            report.ignored.add(IgnoredEntry('--$name', 'not in 0..1: $raw'));
          } else {
            surfaceOpacity = value;
          }
        }
      } else if (name == kCssSurfaceBlurVar) {
        final double? value = _absorbScalar(
          name,
          raw,
          parsePxLength,
          'surfaceBlur',
        );
        if (value != null) {
          if (value < 0) {
            report.ignored.add(IgnoredEntry('--$name', 'not >= 0: $raw'));
          } else {
            surfaceBlur = value;
          }
        }
      } else {
        report.ignored.add(
          IgnoredEntry('--$name', ignoredReason(name) ?? 'unknown variable'),
        );
      }
    }
  }

  double? _absorbScalar(
    String name,
    String raw,
    double? Function(String) parse,
    String token,
  ) {
    final double? value = parse(raw);
    if (value == null) {
      report.ignored.add(IgnoredEntry('--$name', 'not a length: $raw'));
    } else {
      report.mapped.add(MappedEntry('--$name', token));
    }
    return value;
  }

  void _absorbColor(
    String name,
    String raw,
    String kitToken,
    bool isDark,
    Map<String, String> vars,
  ) {
    final String variable = '--$name';
    final String? resolved = resolveCssRefs(raw, vars);
    if (resolved == null) {
      report.ignored.add(
        IgnoredEntry(variable, 'unresolvable reference: $raw'),
      );
      return;
    }
    final int? argb = tryParseWebColor(resolved);
    if (argb == null) {
      report.ignored.add(IgnoredEntry(variable, 'unparsable colour: $raw'));
      return;
    }
    if (looksLikeTriplet(resolved)) {
      sawTriplet = true;
    }
    final String lower = resolved.toLowerCase();
    if (lower.contains('oklch(') || lower.contains('oklab(')) {
      sawModern = true;
    }
    _colors(isDark)[kitToken] = argb;
    report.mapped.add(
      MappedEntry(
        variable,
        '${isDark ? 'dark' : 'light'}.$kitToken',
        resolved == raw ? '' : 'resolved $raw',
      ),
    );
  }

  void _absorbAtom(String name, String raw, String field, String mode) {
    final String variable = '--$name';
    if (field == 'color') {
      final int? argb = tryParseWebColor(raw);
      if (argb == null) {
        report.ignored.add(IgnoredEntry(variable, 'unparsable colour: $raw'));
        return;
      }
      atoms[mode]![field] = argb;
    } else {
      final double? value = parsePxLength(raw);
      if (value == null) {
        report.ignored.add(IgnoredEntry(variable, 'not a number: $raw'));
        return;
      }
      atoms[mode]![field] = value;
    }
    report.mapped.add(MappedEntry(variable, 'shadow.$mode.$field'));
  }

  /// Absorbs Tailwind v4 `@theme` variables (mode-independent).
  void absorbThemeBlock(Map<String, String> vars, _Collector collector) {
    for (final MapEntry<String, String> entry in vars.entries) {
      final String name = entry.key;
      if (!name.startsWith('color-')) {
        // Scalars are mode-independent; aliases resolve against the mode
        // maps first, so `--font-sans: var(--font-sans)` keeps its value.
        final String resolved =
            resolveCssRefs(entry.value, collector.light) ??
            resolveCssRefs(entry.value, collector.dark) ??
            entry.value;
        absorb(<String, String>{name: resolved}, false);
        if (kCssShadowToAtom[name] case final String field) {
          if (atoms['light']!.containsKey(field) &&
              !atoms['dark']!.containsKey(field)) {
            atoms['dark']![field] = atoms['light']![field]!;
            report.mapped.add(MappedEntry('--$name', 'shadow.dark.$field'));
          }
        }
        continue;
      }
      final String? kitToken = kCssColorToKit[name.substring('color-'.length)];
      if (kitToken == null) {
        report.ignored.add(
          IgnoredEntry('--$name', ignoredReason(name) ?? 'unknown variable'),
        );
        continue;
      }
      // Aliases (`var(--background)`) resolve per mode; raw colours fill
      // both modes with the same value.
      bool filled = false;
      for (final bool isDark in const <bool>[false, true]) {
        final String? resolved = resolveCssRefs(
          entry.value,
          isDark ? collector.dark : collector.light,
        );
        final int? argb = resolved == null ? null : tryParseWebColor(resolved);
        if (argb != null) {
          _colors(isDark)[kitToken] = argb;
          filled = true;
        }
      }
      if (filled) {
        report.mapped.add(MappedEntry('--$name', kitToken, 'via @theme'));
      } else {
        report.ignored.add(
          IgnoredEntry('--$name', 'unresolvable reference: ${entry.value}'),
        );
      }
    }
  }

  /// Builds the completed theme.
  WebTheme build() {
    WebShadowAtoms? buildAtoms(String mode) {
      final Map<String, Object> fields = atoms[mode]!;
      if (fields.isEmpty) {
        return null;
      }
      const WebShadowAtoms fallback = WebShadowAtoms.fallback;
      Object field(String name, Object fallbackValue) {
        if (!fields.containsKey(name)) {
          report.defaulted.add(
            DefaultedEntry('shadow.$mode.$name', 'missing; fallback atom used'),
          );
        }
        return fields[name] ?? fallbackValue;
      }

      return WebShadowAtoms(
        color: field('color', fallback.color) as int,
        opacity: field('opacity', fallback.opacity) as double,
        blur: field('blur', fallback.blur) as double,
        spread: field('spread', fallback.spread) as double,
        offsetX: field('offsetX', fallback.offsetX) as double,
        offsetY: field('offsetY', fallback.offsetY) as double,
      );
    }

    return WebTheme(
      light: Map<String, int>.unmodifiable(light),
      dark: Map<String, int>.unmodifiable(dark),
      radius: radius,
      fonts: Map<String, String>.unmodifiable(fonts),
      spacing: spacing,
      tracking: Map<String, double>.unmodifiable(tracking),
      lightShadow: buildAtoms('light'),
      darkShadow: buildAtoms('dark'),
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
    ).completed(report);
  }
}
