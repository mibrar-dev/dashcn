---
title: "Class: CollapsibleContent"
description: "The content pane of a [Collapsible]."
---

```dart
/// The content pane of a [Collapsible].
class CollapsibleContent extends StatelessWidget {
  /// Creates a content pane.
  const CollapsibleContent({super.key, this.collapsible = true, required this.child});
  /// Whether this pane follows the section's expansion state.
  final bool collapsible;
  /// The widget shown while expanded.
  final Widget child;
  Widget build(BuildContext context);
}
```
