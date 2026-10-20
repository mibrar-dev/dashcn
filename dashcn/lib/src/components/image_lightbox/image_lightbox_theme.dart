// User-owned overrides for the `image_lightbox` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `imageLightboxDefaults` and
// the global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise):
//
//   const ImageLightboxTheme imageLightboxThemeOverrides = ImageLightboxTheme(
//     barrierColor: ThemedColor.value(Color(0xCC000000)),
//     maxScale: 5,
//     thumbnailHeight: 64,
//   );

import 'image_lightbox_style.dart';

/// Image lightbox overrides applied app-wide through `ComponentThemes`.
const ImageLightboxTheme imageLightboxThemeOverrides = ImageLightboxTheme();
