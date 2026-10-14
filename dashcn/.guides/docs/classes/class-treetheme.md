---
title: "Class: TreeTheme"
description: "Visual contract of a tree."
---

```dart
/// Visual contract of a tree. Every field is nullable: an override leg sets
/// only what it changes and [merge] keeps the lower leg's remaining fields.
class TreeTheme extends ComponentThemeData implements Mergeable<TreeTheme> {
  /// Creates a tree theme.
  const TreeTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.branchLine, this.branchLineColor, this.padding, this.indentWidth, this.itemPadding, this.itemGap, this.selectedBackground, this.selectedFocusedBackground, this.selectedRadius});
  /// Guide style. Default: [TreeBranchLine.path].
  final TreeBranchLine? branchLine;
  /// Guide colour. Default: the `border` token.
  final ThemedColor? branchLineColor;
  /// Padding around the whole tree. Default: 8 (scaled).
  final EdgeInsetsGeometry? padding;
  /// Horizontal space per level. Default: 16 (scaled).
  final double? indentWidth;
  /// Padding inside one row. Default: 8 horizontal, 4 vertical, resolved
  /// against density.
  final EdgeInsetsGeometry? itemPadding;
  /// Gap between the adornments and the row content. Default: 8 (scaled).
  final double? itemGap;
  /// Selected row fill. Default: `primary` at 5%.
  final ThemedColor? selectedBackground;
  /// Selected **and** focused fill. Default: `primary` at 10%.
  final ThemedColor? selectedFocusedBackground;
  /// Selected row corner radius. Default: `theme.borderRadiusMd`.
  final BorderRadiusGeometry? selectedRadius;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  TreeTheme merge(TreeTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
