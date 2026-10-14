---
title: "Class: ResizableTheme"
description: "Handle styling for the resizable component."
---

```dart
/// Handle styling for the resizable component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ResizableTheme extends ComponentThemeData implements Mergeable<ResizableTheme> {
  /// Creates a resizable theme.
  const ResizableTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.handleColor, this.handleThickness, this.hitThickness, this.gripColor, this.gripSize});
  /// Per-state divider colour. Default: `border`, `ring` on hover/press.
  final StateValue<ThemedColor>? handleColor;
  /// Divider line thickness. Default: `1`.
  final double? handleThickness;
  /// Gesture hit-area thickness. Default: `10`.
  final double? hitThickness;
  /// Grip colour. Default: `border`.
  final ThemedColor? gripColor;
  /// Grip size for a horizontal group. Default: `Size(4, 16)`.
  final Size? gripSize;
  /// Returns a copy with the given fields replaced.
  ResizableTheme copyWith({ValueGetter<StateValue<ThemedColor>?>? handleColor, ValueGetter<double?>? handleThickness, ValueGetter<double?>? hitThickness, ValueGetter<ThemedColor?>? gripColor, ValueGetter<Size?>? gripSize});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ResizableTheme merge(ResizableTheme? fallback);
  /// State scales step at `t < 0.5`; dimensions are lerped.
  static ResizableTheme lerp(ResizableTheme a, ResizableTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
