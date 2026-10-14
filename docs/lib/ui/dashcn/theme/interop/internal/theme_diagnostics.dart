// Unexported import diagnostics for web-theme interop (pure Dart).
//
// Canonical home of [missingTokens]: the kit tokens a parsed theme does not
// name. Not exported by `interop.dart` (or any barrel): import it directly
// from `src/` when working inside the interop layer.

import '../theme_model.dart';
import 'token_inventory.dart';

/// Kit tokens [theme] does not name, as `mode.token` / scalar paths.
/// Optional tokens (`fonts` slots, `tight`/`wide` steps) carry an
/// ` (optional)` suffix: absent is valid for them, and [WebTheme.completed]
/// leaves them absent. Everything else is schema-required and completed
/// fills it from fallbacks.
List<String> missingTokens(WebTheme theme) {
  final List<String> missing = <String>[];
  for (final String token in kKitColorTokens) {
    if (!theme.light.containsKey(token)) {
      missing.add('light.$token');
    }
    if (!theme.dark.containsKey(token)) {
      missing.add('dark.$token');
    }
  }
  if (theme.radius == null) {
    missing.add('radius');
  }
  if (theme.spacing == null) {
    missing.add('spacing');
  }
  for (final String slot in const <String>['sans', 'serif', 'mono']) {
    if (!theme.fonts.containsKey(slot)) {
      missing.add('fonts.$slot (optional)');
    }
  }
  if (!theme.tracking.containsKey('normal')) {
    missing.add('tracking.normal');
  }
  for (final String step in const <String>['tight', 'wide']) {
    if (!theme.tracking.containsKey(step)) {
      missing.add('tracking.$step (optional)');
    }
  }
  _missingAtoms(theme.lightShadow, 'shadow.light', missing);
  _missingAtoms(theme.darkShadow, 'shadow.dark', missing);
  return missing;
}

void _missingAtoms(WebShadowAtoms? atoms, String prefix, List<String> missing) {
  if (atoms != null) {
    return;
  }
  for (final String atom in const <String>[
    'color',
    'opacity',
    'blur',
    'spread',
    'offsetX',
    'offsetY',
  ]) {
    missing.add('$prefix.$atom');
  }
}
