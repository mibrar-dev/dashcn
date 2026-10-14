---
title: "Class: ItemPickerTheme"
description: "Theme of the item picker grid/list body."
---

```dart
/// Theme of the item picker grid/list body.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget). Surfaces
/// come from the dialog/popover presentation, so this theme only sizes the
/// item body.
class ItemPickerTheme extends ComponentThemeData implements Mergeable<ItemPickerTheme> {
  /// Creates an item picker theme.
  const ItemPickerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.constraints, this.padding, this.spacing});
  /// Bounds of the item body. Default: at most 320x320.
  final BoxConstraints? constraints;
  /// Padding around the items. Default: 8 on every side, density-scaled
  /// (see [itemPickerDefaultPadding]).
  final EdgeInsetsGeometry? padding;
  /// Gap between grid cells. Default: 4.
  final double? spacing;
  /// Returns a copy with the given fields replaced.
  ItemPickerTheme copyWith({ValueGetter<BoxConstraints?>? constraints, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? spacing});
  /// Receiver wins per field; [fallback] only fills null cells.
  ItemPickerTheme merge(ItemPickerTheme? fallback);
  /// Geometry interpolates; the rest steps at `t = 0.5`.
  static ItemPickerTheme lerp(ItemPickerTheme a, ItemPickerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
