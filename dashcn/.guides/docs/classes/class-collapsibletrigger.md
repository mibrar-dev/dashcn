---
title: "Class: CollapsibleTrigger"
description: "The tappable header of a [Collapsible]."
---

```dart
/// The tappable header of a [Collapsible].
class CollapsibleTrigger extends StatelessWidget {
  /// Creates a trigger with [child] as its label.
  const CollapsibleTrigger({super.key, required this.child, this.theme});
  /// Content shown next to the expand/collapse icon.
  final Widget child;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final CollapsibleTheme? theme;
  Widget build(BuildContext context);
}
```
