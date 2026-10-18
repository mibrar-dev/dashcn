// User-owned overrides for the `qr_code` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `qrCodeDefaults` and the
// global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to pin print-safe inks):
//
//   const QrCodeTheme qrCodeThemeOverrides = QrCodeTheme(
//     foreground: ThemedColor.value(Color(0xFF000000)),
//     background: ThemedColor.value(Color(0xFFFFFFFF)),
//   );

import 'qr_code_style.dart';

/// QR code overrides applied app-wide through `ComponentThemes`.
const QrCodeTheme qrCodeThemeOverrides = QrCodeTheme();
