// Unexported web-variable to kit-token mapping (pure Dart).
//
// Canonical home of the one table behind every import: each row maps a CSS
// custom property (kebab-case, `--` stripped) to the kit token it fills.
// Colour rows cover all 32 kit colour tokens; scalar rows cover radius,
// fonts, spacing, tracking and the base shadow atoms. Anything without a row
// is either derived at build time (radius steps, the eight shadow sizes,
// `@theme` aliases) and skipped with a reason, or unknown and reported as
// such. Not exported by `interop.dart` (or any barrel): import it directly
// from `src/` when working inside the interop layer.
//
// | Web variable(s)                              | Kit token(s)              |
// |----------------------------------------------|-----------------------------|
// | `--background`, `--card-foreground`, …       | same name, camelCased     |
// | `--chart-1` … `--chart-5`                    | `chart1` … `chart5`         |
// | `--sidebar-*` (7 + primary/accent pairs)     | `sidebar*`                  |
// | `--radius` (rem)                             | `radius`                    |
// | `--font-sans` / `-serif` / `-mono`           | `fonts` slots               |
// | `--spacing` (rem)                            | `spacing`                   |
// | `--letter-spacing`, `--tracking-*` (em)      | `tracking` steps            |
// | `--shadow-color/opacity/blur/spread/offset-*`| shadow atoms per mode     |

/// CSS colour variable (no `--`) to kit colour token. All 32 kit tokens have
/// exactly one row; the reverse map is derived below.
const Map<String, String> kCssColorToKit = <String, String>{
  'background': 'background',
  'foreground': 'foreground',
  'card': 'card',
  'card-foreground': 'cardForeground',
  'popover': 'popover',
  'popover-foreground': 'popoverForeground',
  'primary': 'primary',
  'primary-foreground': 'primaryForeground',
  'secondary': 'secondary',
  'secondary-foreground': 'secondaryForeground',
  'muted': 'muted',
  'muted-foreground': 'mutedForeground',
  'accent': 'accent',
  'accent-foreground': 'accentForeground',
  'destructive': 'destructive',
  'destructive-foreground': 'destructiveForeground',
  'border': 'border',
  'input': 'input',
  'ring': 'ring',
  'chart-1': 'chart1',
  'chart-2': 'chart2',
  'chart-3': 'chart3',
  'chart-4': 'chart4',
  'chart-5': 'chart5',
  'sidebar': 'sidebar',
  // v3-era name for the same token; the reverse map keeps `--sidebar`.
  'sidebar-background': 'sidebar',
  'sidebar-foreground': 'sidebarForeground',
  'sidebar-primary': 'sidebarPrimary',
  'sidebar-primary-foreground': 'sidebarPrimaryForeground',
  'sidebar-accent': 'sidebarAccent',
  'sidebar-accent-foreground': 'sidebarAccentForeground',
  'sidebar-border': 'sidebarBorder',
  'sidebar-ring': 'sidebarRing',
};

/// Kit colour token to CSS variable (with `--`), derived from [kCssColorToKit].
/// Aliased tokens keep the first row's variable (`--sidebar`, not the v3
/// `--sidebar-background`).
final Map<String, String> kKitToCssColor = _reverse(kCssColorToKit);

Map<String, String> _reverse(Map<String, String> map) {
  final Map<String, String> out = <String, String>{};
  for (final MapEntry<String, String> entry in map.entries) {
    out.putIfAbsent(entry.value, () => '--${entry.key}');
  }
  return out;
}

/// Radius variable.
const String kCssRadiusVar = 'radius';

/// Font-slot variables to `fonts` slots.
const Map<String, String> kCssFontToSlot = <String, String>{
  'font-sans': 'sans',
  'font-serif': 'serif',
  'font-mono': 'mono',
};

/// Spacing variable (rem number).
const String kCssSpacingVar = 'spacing';

/// Tracking variables (em numbers) to `tracking` steps.
const Map<String, String> kCssTrackingToStep = <String, String>{
  'letter-spacing': 'normal',
  'tracking-normal': 'normal',
  'tracking-tight': 'tight',
  'tracking-wide': 'wide',
};

/// Shadow-atom variables to `WebShadowAtoms` fields.
///
/// `--shadow-offset-x/-y` are the canonical names the writers emit;
/// `--shadow-x/-y` are the Tailwind v4 shorthand aliases for the same atoms.
const Map<String, String> kCssShadowToAtom = <String, String>{
  'shadow-color': 'color',
  'shadow-opacity': 'opacity',
  'shadow-blur': 'blur',
  'shadow-spread': 'spread',
  'shadow-offset-x': 'offsetX',
  'shadow-offset-y': 'offsetY',
  'shadow-x': 'offsetX',
  'shadow-y': 'offsetY',
};

/// Glass surface variables (mode-independent, unitless / px).
const String kCssSurfaceOpacityVar = 'surface-opacity';
const String kCssSurfaceBlurVar = 'surface-blur';

/// Kit colour token for a CSS variable (`--` prefix optional), or null.
String? cssVarToKitToken(String variable) {
  final String name = _stripPrefix(variable).toLowerCase();
  return kCssColorToKit[name];
}

/// CSS variable (with `--`) for a kit colour token, or null.
String? kitTokenToCssVar(String token) => kKitToCssColor[token];

String _stripPrefix(String variable) =>
    variable.startsWith('--') ? variable.substring(2) : variable;

/// Reason a variable with no table row is skipped, or null when it has one.
///
/// Derived values (radius steps, full shadow definitions, `@theme` aliases,
/// animation and easing knobs) are skipped because the kit recomputes them;
/// palette and layout variables have no kit counterpart.
String? ignoredReason(String variable) {
  final String name = _stripPrefix(variable).toLowerCase();
  if (kCssColorToKit.containsKey(name) ||
      kCssFontToSlot.containsKey(name) ||
      kCssTrackingToStep.containsKey(name) ||
      kCssShadowToAtom.containsKey(name) ||
      name == kCssRadiusVar ||
      name == kCssSpacingVar ||
      name == kCssSurfaceOpacityVar ||
      name == kCssSurfaceBlurVar) {
    return null;
  }
  if (name.startsWith('radius-') || name == 'radius') {
    return 'derived radius step; recomputed from --radius at build';
  }
  if (name == 'shadow' || name.startsWith('shadow-')) {
    return 'derived shadow size; recomputed from shadow atoms at build';
  }
  if (name.startsWith('color-')) {
    return 'utility alias or palette ramp; no kit token counterpart';
  }
  if (name.startsWith('animate-') ||
      name.startsWith('ease-') ||
      name.startsWith('font-') ||
      name == 'color-scheme') {
    return 'no kit token counterpart';
  }
  if (name.startsWith('sidebar-')) {
    return 'no kit token counterpart';
  }
  if (name.startsWith('chart-')) {
    return 'not a chart1..5 series token';
  }
  if (name.startsWith('spacing-') ||
      name.startsWith('tracking-') ||
      name.startsWith('text-') ||
      name.startsWith('breakpoint-') ||
      name.startsWith('container-')) {
    return 'layout scale; no kit token counterpart';
  }
  return 'unknown variable';
}

/// Dotted v3 path to kit token (`primary.DEFAULT` → `primary`,
/// `primary.foreground` → `primaryForeground`, `chart.1` → `chart1`).
String? v3PathToKitToken(List<String> path) {
  final List<String> parts = path
      .map((String p) => p.trim())
      .where((String p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) {
    return null;
  }
  if (parts.length == 1) {
    return kCssColorToKit[parts[0].toLowerCase()];
  }
  final String head = parts[0].toLowerCase();
  final String tail = parts.sublist(1).join('-').toLowerCase();
  if (tail == 'default') {
    return kCssColorToKit[head];
  }
  if (head == 'chart' && RegExp(r'^[1-5]$').hasMatch(tail)) {
    return 'chart$tail';
  }
  return kCssColorToKit['$head-$tail'];
}
