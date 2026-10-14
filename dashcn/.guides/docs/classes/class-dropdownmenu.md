---
title: "Class: DropdownMenu"
description: "A menu surface for a dropdown: the menu's rows inside a [MenuPopup],  dismissing the overlay it is shown in when a row closes the menu."
---

```dart
/// A menu surface for a dropdown: the menu's rows inside a [MenuPopup],
/// dismissing the overlay it is shown in when a row closes the menu.
///
/// Inline surfaces never take focus on mount; overlay helpers pass
/// `autofocus: true` for the opened menu.
class DropdownMenu extends StatelessWidget {
  /// Creates a dropdown menu surface.
  const DropdownMenu({super.key, required this.children, this.theme, this.autofocus = false});
  /// The menu rows.
  final List<Widget> children;
  /// Widget-leg surface override, merged over the popup theme legs.
  final MenuPopupTheme? theme;
  /// Whether the group takes focus on mount; true for opened overlays.
  final bool autofocus;
  Widget build(BuildContext context);
}
```
