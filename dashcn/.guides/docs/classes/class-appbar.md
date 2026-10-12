---
title: "Class: AppBar"
description: "Title bar for scaffold headers and footers."
---

```dart
/// Title bar for scaffold headers and footers.
///
/// Showing [header]/[title]/[subtitle] styles them (muted small over large
/// medium over muted small) through the text primitive.
class AppBar extends StatelessWidget {
  /// Creates an app bar.
  const AppBar({super.key, this.leading = const <Widget>[], this.trailing = const <Widget>[], this.title, this.header, this.subtitle, this.child, this.trailingExpanded = false, this.alignment = Alignment.center, this.padding, this.backgroundColor, this.leadingGap, this.trailingGap, this.height, this.surfaceBlur, this.surfaceOpacity, this.useSafeArea = true, this.theme});
  final List<Widget> leading;
  final List<Widget> trailing;
  final Widget? title;
  final Widget? header;
  final Widget? subtitle;
  /// Custom center content; overrides [title]/[header]/[subtitle].
  final Widget? child;
  /// Whether the trailing area expands instead of the center.
  final bool trailingExpanded;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;
  final ThemedColor? backgroundColor;
  final double? leadingGap;
  final double? trailingGap;
  final double? height;
  /// Backdrop blur override; null falls back to the theme.
  final double? surfaceBlur;
  /// Opacity multiplied onto the background; null falls back to the theme.
  final double? surfaceOpacity;
  /// Whether to respect the device safe area.
  final bool useSafeArea;
  /// Widget-leg theme override, merged over the other legs.
  final AppBarTheme? theme;
  Widget build(BuildContext context);
}
```
