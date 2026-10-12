---
title: "Class: StageContainer"
description: "A responsive container that constrains content to breakpoint widths."
---

```dart
/// A responsive container that constrains content to breakpoint widths.
///
/// The [builder] receives the outer padding to apply; [StageContainer] does
/// not wrap the child itself, so the caller controls the box.
class StageContainer extends StatelessWidget {
  /// Creates a stage container.
  const StageContainer({super.key, required this.builder, this.breakpoint, this.padding, this.theme});
  /// Builds the content; receives the resolved outer padding.
  final StageContainerBuilder builder;
  /// Width strategy; null resolves the theme, then the default breakpoints.
  final StageBreakpoint? breakpoint;
  /// Base padding; null resolves the theme, then the density default.
  final EdgeInsetsGeometry? padding;
  /// Widget-leg theme override.
  final StageContainerTheme? theme;
  Widget build(BuildContext context);
}
```
