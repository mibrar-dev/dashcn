// User-owned overrides for the `wheel_picker` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `wheelPickerDefaults` and
// the global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise):
//
//   const WheelPickerTheme wheelPickerThemeOverrides = WheelPickerTheme(
//     itemHeight: 48,
//     visibleItems: 7,
//     selectionColor: ThemedColor.ref(ColorRef.accent, alpha: 0.2),
//     fontSize: 18,
//   );

import 'wheel_picker_style.dart';

/// Wheel picker overrides applied app-wide through `ComponentThemes`.
const WheelPickerTheme wheelPickerThemeOverrides = WheelPickerTheme();
