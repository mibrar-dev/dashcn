---
title: "Class: Collapsible"
description: "An expandable section."
---

```dart
/// An expandable section.
///
/// ```dart
/// Collapsible(
///   children: <Widget>[
///     const CollapsibleTrigger(child: Text('Recent activity')),
///     CollapsibleContent(child: activityList),
///   ],
/// );
/// ```
class Collapsible extends StatefulWidget {
  /// Creates a collapsible section.
  const Collapsible({super.key, required this.children, this.isExpanded, this.onExpansionChanged, this.theme});
  /// Usually one [CollapsibleTrigger] followed by [CollapsibleContent]s.
  final List<Widget> children;
  /// Expanded state. Non-null makes the widget controlled; null lets it keep
  /// its own state.
  final bool? isExpanded;
  /// Called with the **new** expansion state when the trigger is tapped.
  final ValueChanged<bool>? onExpansionChanged;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final CollapsibleTheme? theme;
  State<Collapsible> createState();
}
```
