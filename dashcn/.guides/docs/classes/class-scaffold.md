---
title: "Class: Scaffold"
description: "App screen shell; fixed bars take layout space, floating bars overlay."
---

```dart
/// App screen shell; fixed bars take layout space, floating bars overlay.
class Scaffold extends StatelessWidget {
  /// Creates a scaffold shell.
  const Scaffold({super.key, required this.child, this.headers = const <Widget>[], this.footers = const <Widget>[], this.loadingProgress, this.loadingProgressIndeterminate = false, this.floatingHeader = false, this.floatingFooter = false, this.backgroundColor, this.headerBackgroundColor, this.footerBackgroundColor, this.showLoadingSparks, this.resizeToAvoidBottomInset, this.theme});
  final Widget child;
  final List<Widget> headers;
  final List<Widget> footers;
  /// Loading fraction 0..1; null hides the bar unless indeterminate.
  final double? loadingProgress;
  /// Whether the loading bar animates without a value.
  final bool loadingProgressIndeterminate;
  /// Whether headers overlay the body instead of pushing it down.
  final bool floatingHeader;
  /// Whether footers overlay the body instead of pushing it up.
  final bool floatingFooter;
  final ThemedColor? backgroundColor;
  final ThemedColor? headerBackgroundColor;
  final ThemedColor? footerBackgroundColor;
  final bool? showLoadingSparks;
  /// Whether the body pads for the keyboard; null falls back to the theme.
  final bool? resizeToAvoidBottomInset;
  /// Widget-leg theme override, merged over the other legs.
  final ScaffoldTheme? theme;
  Widget build(BuildContext context);
}
```
