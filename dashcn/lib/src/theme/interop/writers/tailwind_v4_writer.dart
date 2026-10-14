// Tailwind v4 `@theme` writer (pure Dart): the `:root`/`.dark` variable
// definitions plus an `@theme inline` block aliasing every colour as
// `--color-<name>: var(--<name>)` (the utility surface), fonts, and the
// radius steps derived from `--radius`.

import '../internal/css_mapping.dart';
import '../internal/token_inventory.dart';
import '../theme_model.dart';
import 'web_css_writer.dart';

/// Writes [theme] as v4 CSS with an `@theme inline` alias block.
String writeTailwindV4Theme(WebTheme theme) {
  final WebTheme complete = theme.completed();
  final StringBuffer out = StringBuffer(writeWebCss(complete));
  out.writeln();
  out.writeln('@theme inline {');
  for (final String token in kKitColorTokens) {
    final String variable = kitTokenToCssVar(token)!;
    final String name = variable.substring(2);
    out.writeln('  --color-$name: var($variable);');
  }
  for (final String slot in complete.fonts.keys) {
    out.writeln('  --font-$slot: var(--font-$slot);');
  }
  out.writeln('  --radius-lg: var(--radius);');
  out.writeln('  --radius-md: calc(var(--radius) - 2px);');
  out.writeln('  --radius-sm: calc(var(--radius) - 4px);');
  out.writeln('}');
  return out.toString();
}
