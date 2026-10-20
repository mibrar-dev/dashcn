// User-owned overrides for the `segmented_control` component theme.
//
// Values only: CLI updates never overwrite this file and Studio rewrites it
// deterministically. Unset fields fall through to `segmentedControlDefaults`
// and the global tokens, so an empty override keeps the exact token look.
//
// Sparse example (uncomment and complete to customise the thumb):
//
//   const SegmentedControlTheme segmentedControlThemeOverrides =
//       SegmentedControlTheme(
//     control: SegmentedControlStyle(
//       thumbBackground: ThemedColor.ref(ColorRef.card),
//     ),
//   );

import 'segmented_control_style.dart';

/// App-wide overrides for the segmented control.
const SegmentedControlTheme segmentedControlThemeOverrides =
    SegmentedControlTheme();
