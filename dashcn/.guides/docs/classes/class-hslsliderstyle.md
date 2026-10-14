---
title: "Class: HSLSliderStyle"
description: "Cursor styling of the HSL colour slider."
---

```dart
/// Cursor styling of the HSL colour slider.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class HSLSliderStyle implements Mergeable<HSLSliderStyle> {
  /// Creates an HSL slider style slice.
  const HSLSliderStyle({this.cursorColor, this.cursorSize, this.cursorWidth});
  /// Ring colour of the drag cursor. Default: white.
  final ThemedColor? cursorColor;
  /// Diameter of the 2D cursor circle / bar thickness. Default: `16`.
  final double? cursorSize;
  /// Width of the cursor ring. Default: `2`.
  final double? cursorWidth;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  HSLSliderStyle merge(HSLSliderStyle? fallback);
}
```
