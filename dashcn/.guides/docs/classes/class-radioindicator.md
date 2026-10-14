---
title: "Class: RadioIndicator"
description: "The circle that shows whether a radio item is selected."
---

```dart
/// The circle that shows whether a radio item is selected.
class RadioIndicator extends StatelessWidget {
  /// Creates an indicator.
  const RadioIndicator({super.key, this.style, this.selected = false});
  /// Widget-leg style override.
  final RadioIndicatorStyle? style;
  /// Whether the dot is drawn.
  final bool selected;
  Widget build(BuildContext context);
}
```
