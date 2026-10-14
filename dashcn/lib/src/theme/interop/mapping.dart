// Compatibility shim: the mapping tables now live in
// `internal/css_mapping.dart`, the token inventory in
// `internal/token_inventory.dart` and the diagnostics in
// `internal/theme_diagnostics.dart` (all unexported surface). Import those
// files directly from `src/`; this shim stays so existing `src/` imports keep
// resolving.

export 'internal/css_mapping.dart';
export 'internal/theme_diagnostics.dart';
export 'internal/token_inventory.dart';
