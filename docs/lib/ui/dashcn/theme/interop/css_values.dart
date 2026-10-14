// Compatibility shim: the CSS syntax helpers now live in
// `internal/css_syntax.dart` (unexported surface). Import that file directly
// from `src/`; this shim stays so existing `src/` imports keep resolving.

export 'internal/css_syntax.dart';
