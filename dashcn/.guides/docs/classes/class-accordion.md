---
title: "Class: Accordion"
description: "A container of expandable sections; at most one panel is open."
---

```dart
/// A container of expandable sections; at most one panel is open.
///
/// ```dart
/// Accordion(
///   items: <Widget>[
///     AccordionItem(
///       trigger: const AccordionTrigger(child: Text('Is it accessible?')),
///       content: const Text('Yes.'),
///     ),
///   ],
/// );
/// ```
class Accordion extends StatefulWidget {
  /// Creates an accordion from [items].
  const Accordion({super.key, required this.items, this.theme});
  /// Usually [AccordionItem] widgets; dividers are inserted between them.
  final List<Widget> items;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final AccordionTheme? theme;
  State<Accordion> createState();
}
```
