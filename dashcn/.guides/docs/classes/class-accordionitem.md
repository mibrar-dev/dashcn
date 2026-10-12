---
title: "Class: AccordionItem"
description: "One collapsible entry inside an [Accordion]."
---

```dart
/// One collapsible entry inside an [Accordion].
class AccordionItem extends StatefulWidget {
  /// Creates an accordion entry.
  const AccordionItem({super.key, required this.trigger, required this.content, this.expanded = false, this.theme});
  /// Widget that toggles this item.
  final Widget trigger;
  /// Content revealed while the item is expanded.
  final Widget content;
  /// Whether the item starts expanded when no other item is.
  final bool expanded;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final AccordionTheme? theme;
  State<AccordionItem> createState();
}
```
