---
title: "Class: ContextMenu"
description: "Wraps [child] so a secondary-click (and a long-press on touch platforms)  opens [items] as a menu at the pointer."
---

```dart
/// Wraps [child] so a secondary-click (and a long-press on touch platforms)
/// opens [items] as a menu at the pointer.
///
/// The menu is non-modal: tapping outside closes it, and the rows use the
/// menu's traversal engine (arrows, Enter/Space, Escape, typeahead). A
/// secondary click on a disabled menu does nothing.
class ContextMenu extends StatelessWidget {
  /// Creates a context menu.
  const ContextMenu({super.key, required this.child, required this.items, this.behavior = HitTestBehavior.translucent, this.direction = Axis.vertical, this.enabled = true, this.theme = const MenuTheme(), this.popupTheme});
  /// The widget that triggers the menu.
  final Widget child;
  /// The menu rows.
  final List<Widget> items;
  /// Hit-test behavior of the trigger area.
  final HitTestBehavior behavior;
  /// Row layout of the menu.
  final Axis direction;
  /// Whether the menu can open.
  final bool enabled;
  /// Widget-leg row theme override, applied inside the popup.
  final MenuTheme theme;
  /// Widget-leg surface override, merged over the popup theme legs.
  final MenuPopupTheme? popupTheme;
  Widget build(BuildContext context);
}
```
