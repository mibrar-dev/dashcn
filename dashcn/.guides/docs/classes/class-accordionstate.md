---
title: "Class: AccordionState"
description: "State of [Accordion]: owns the currently expanded item."
---

```dart
/// State of [Accordion]: owns the currently expanded item.
class AccordionState extends State<Accordion> {
  /// Whether [item] is the expanded one.
  bool isExpanded(Object item);
  /// Opens [item] or closes it when it was already open.
  void toggle(Object item);
  void dispose();
  Widget build(BuildContext context);
}
```
