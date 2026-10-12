---
title: "Class: NavigationItemStyle"
description: "One navigation item state's styling slice."
---

```dart
/// One navigation item state's styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class NavigationItemStyle implements Mergeable<NavigationItemStyle> {
  /// Creates a navigation item style.
  const NavigationItemStyle({this.background, this.foreground, this.borderColor, this.borderWidth, this.padding, this.minHeight, this.textStyle});
  /// Per-state fill.
  final StateValue<ThemedColor>? background;
  /// Per-state content/label colour.
  final StateValue<ThemedColor>? foreground;
  /// Per-state border; null draws none.
  final StateValue<ThemedColor>? borderColor;
  /// Border width used when [borderColor] resolves non-null.
  final double? borderWidth;
  /// Row padding; null falls back to the row default.
  final EdgeInsetsGeometry? padding;
  /// Content box minimum height; null falls back to 20 (h-9 with the default
  /// padding). Keeps rows 36 high even while the label is collapsed.
  final double? minHeight;
  /// Label style; its colour is ignored (taken from [foreground]).
  final TextStyle? textStyle;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  NavigationItemStyle merge(NavigationItemStyle? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
