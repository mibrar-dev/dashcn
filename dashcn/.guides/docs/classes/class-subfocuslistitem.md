---
title: "Class: SubFocusListItem"
description: "One selectable row inside a [SubFocus] list."
---

```dart
/// One selectable row inside a [SubFocus] list.
///
/// Hovering requests sub-focus; the row paints the highlight colour while
/// focused. A row without [onTap] (or with `enabled: false`) is rendered
/// read-only: no tap target, no hover, dimmed at half opacity.
class SubFocusListItem extends StatelessWidget {
  /// Creates a focusable list row.
  const SubFocusListItem({super.key, this.leading, required this.title, this.trailing, this.onTap, this.enabled, this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6), this.borderRadius, this.highlightColor, this.highlightedForeground, this.foreground});
  /// Widget shown before [title].
  final Widget? leading;
  /// Primary row content.
  final Widget title;
  /// Widget shown after [title].
  final Widget? trailing;
  /// Called when the row is activated; null renders it read-only.
  final VoidCallback? onTap;
  /// Overrides the enabled state; null means `onTap != null`.
  final bool? enabled;
  /// Padding around the row.
  final EdgeInsetsGeometry padding;
  /// Highlight corner radius; null falls back to `theme.borderRadiusSm`.
  final BorderRadius? borderRadius;
  /// Background while focused; null falls back to the `accent` token.
  final Color? highlightColor;
  /// Text/icon colour while focused; null falls back to `accentForeground`.
  final Color? highlightedForeground;
  /// Text/icon colour while not focused; null falls back to `foreground`.
  final Color? foreground;
  Widget build(BuildContext context);
}
```
