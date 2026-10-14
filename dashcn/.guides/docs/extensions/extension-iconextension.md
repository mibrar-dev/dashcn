---
title: "Extension: IconExtension"
description: "Icon modifiers that apply the ambient icon theme slots to any [Widget]."
---

```dart
/// Icon modifiers that apply the ambient icon theme slots to any [Widget].
///
/// ```dart
/// const Icon(LucideIcons.chevronRight).iconSmall();
/// const Icon(LucideIcons.x).iconSmall().iconMutedForeground();
/// ```
extension IconExtension on Widget {
  /// Applies the `x3Small` (8px) icon slot.
  Widget iconX3Small();
  /// Applies the `xSmall` (12px) icon slot.
  Widget iconXSmall();
  /// Applies the `small` (16px) icon slot.
  Widget iconSmall();
  /// Applies the `medium` (20px) icon slot.
  Widget iconMedium();
  /// Applies the `large` (24px) icon slot.
  Widget iconLarge();
  /// Applies the `mutedForeground` token as the icon colour.
  ///
  /// The resolved colour wins over an ambient icon colour (the old helper
  /// merged the other way around, so an ancestor `IconTheme` colour silently
  /// swallowed the muted colour).
  Widget iconMutedForeground();
}
```
