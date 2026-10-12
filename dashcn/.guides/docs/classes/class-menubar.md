---
title: "Class: Menubar"
description: "Bar contract (upstream menubar: `rounded-md border bg-background p-1`,  radius md) resolved through widget > tree > app > defaults."
---

```dart
/// Bar contract (upstream menubar: `rounded-md border bg-background p-1`,
/// radius md) resolved through widget > tree > app > defaults.
///
/// Every row inside the bar resolves the menu's `MenuTheme`, so menus opened
/// from the bar match that component.
class Menubar extends StatelessWidget {
  /// Creates a menubar.
  const Menubar({super.key, required this.children, this.border, this.popoverOffset, this.theme});
  /// Top-level menu triggers, usually [MenuButton]s with a `subMenu`.
  ///
  /// Any widget works: non-[MenuItem] content (labels, separators) renders
  /// without taking part in traversal, like a [MenuGroup].
  final List<Widget> children;
  /// Whether the bar draws its border, background and padding; null resolves
  /// `MenubarTheme.border` (true).
  final bool? border;
  /// Submenu offset; null resolves `MenubarTheme.subMenuOffset`
  /// (`Offset(-4, 8)`), matching upstream's submenu placement below the bar.
  final Offset? popoverOffset;
  /// Widget-leg theme override, merged over the component/app/defaults legs.
  final MenubarTheme? theme;
  Widget build(BuildContext context);
}
```
