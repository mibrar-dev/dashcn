---
title: "Class: AccordionTrigger"
description: "The tappable header of an [AccordionItem]."
---

```dart
/// The tappable header of an [AccordionItem].
class AccordionTrigger extends StatelessWidget {
  /// Creates a trigger with [child] as its label.
  const AccordionTrigger({super.key, required this.child, this.theme});
  /// Content shown next to the indicator.
  final Widget child;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final AccordionTheme? theme;
  Widget build(BuildContext context);
}
```
