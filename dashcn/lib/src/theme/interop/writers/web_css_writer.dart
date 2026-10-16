// v4-style web CSS writer (pure Dart): a completed [WebTheme] as `:root` +
// `.dark` with `oklch()` colours, the inverse of [parseCssTheme] for the
// round-trip gate (`parse(write(t))` within ΔE2000 < 0.5, exact radius/fonts).

import '../internal/color_format.dart';
import '../internal/css_mapping.dart';
import '../internal/css_syntax.dart';
import '../internal/token_inventory.dart';
import '../theme_model.dart';

/// Writes [theme] as `:root` + `.dark` CSS (calls `completed()` first, so
/// missing tokens fall back to the neutral values, documented there).
String writeWebCss(
  WebTheme theme, {
  String lightSelector = ':root',
  String darkSelector = '.dark',
}) {
  final WebTheme complete = theme.completed();
  final StringBuffer out = StringBuffer();
  _writeBlock(out, lightSelector, complete, false);
  _writeBlock(out, darkSelector, complete, true);
  return out.toString();
}

void _writeBlock(
  StringBuffer out,
  String selector,
  WebTheme theme,
  bool isDark,
) {
  final Map<String, int> colors = isDark ? theme.dark : theme.light;
  out.writeln('$selector {');
  for (final String token in kKitColorTokens) {
    out.writeln('  ${kitTokenToCssVar(token)}: ${oklchOf(colors[token]!)};');
  }
  out.writeln('  --radius: ${formatCssNumber(theme.radius!)}rem;');
  for (final MapEntry<String, String> font in theme.fonts.entries) {
    out.writeln('  --font-${font.key}: ${font.value};');
  }
  out.writeln('  --spacing: ${formatCssNumber(theme.spacing!)}rem;');
  for (final MapEntry<String, double> step in theme.tracking.entries) {
    out.writeln('  --tracking-${step.key}: ${formatCssNumber(step.value)}em;');
  }
  final WebShadowAtoms atoms = (isDark ? theme.darkShadow : theme.lightShadow)!;
  out.writeln('  --shadow-color: ${oklchOf(atoms.color)};');
  out.writeln('  --shadow-opacity: ${formatCssNumber(atoms.opacity)};');
  out.writeln('  --shadow-blur: ${formatCssNumber(atoms.blur)}px;');
  out.writeln('  --shadow-spread: ${formatCssNumber(atoms.spread)}px;');
  out.writeln('  --shadow-offset-x: ${formatCssNumber(atoms.offsetX)}px;');
  out.writeln('  --shadow-offset-y: ${formatCssNumber(atoms.offsetY)}px;');
  if (theme.surfaceOpacity != null) {
    out.writeln(
      '  --surface-opacity: ${formatCssNumber(theme.surfaceOpacity!)};',
    );
  }
  if (theme.surfaceBlur != null) {
    out.writeln('  --surface-blur: ${formatCssNumber(theme.surfaceBlur!)}px;');
  }
  out.writeln('}');
}
