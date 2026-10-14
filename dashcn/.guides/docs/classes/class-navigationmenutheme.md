---
title: "Class: NavigationMenuTheme"
description: "Theme of the navigation menu bar and its popover."
---

```dart
/// Theme of the navigation menu bar and its popover.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget).
class NavigationMenuTheme extends ComponentThemeData implements Mergeable<NavigationMenuTheme> {
  /// Creates a navigation menu theme.
  const NavigationMenuTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.surfaceOpacity, this.surfaceBlur, this.margin, this.offset, this.padding, this.maxWidth});
  /// Opacity of the popover surface. Default: ambient surface opacity (or 1).
  final double? surfaceOpacity;
  /// Blur under the popover surface. Default: ambient surface blur (or 0).
  final double? surfaceBlur;
  /// Margin around the popover. Default: one density gap step all around.
  final EdgeInsetsGeometry? margin;
  /// Offset of the popover from its trigger. Default: 4px below.
  final Offset? offset;
  /// Padding inside the popover. Default: 0.75 density steps all around.
  final EdgeInsetsGeometry? padding;
  /// Maximum popover width before wrapping. Default: unconstrained.
  final double? maxWidth;
  /// Returns a copy with the given fields replaced.
  NavigationMenuTheme copyWith({ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur, ValueGetter<EdgeInsetsGeometry?>? margin, ValueGetter<Offset?>? offset, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? maxWidth});
  /// Receiver wins per field; [fallback] only fills null cells.
  NavigationMenuTheme merge(NavigationMenuTheme? fallback);
  /// Geometry interpolates; the rest steps at `t = 0.5`.
  static NavigationMenuTheme lerp(NavigationMenuTheme a, NavigationMenuTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
