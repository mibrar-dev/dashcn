// User-owned overrides for the `signature_pad` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `signaturePadDefaults` and
// the global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise the ink):
//
//   const SignaturePadTheme signaturePadThemeOverrides = SignaturePadTheme(
//     strokeColor: ThemedColor.ref(ColorRef.accent),
//     strokeWidth: 4,
//   );

import 'signature_pad_style.dart';

/// Signature pad overrides applied app-wide through `ComponentThemes`.
const SignaturePadTheme signaturePadThemeOverrides = SignaturePadTheme();
