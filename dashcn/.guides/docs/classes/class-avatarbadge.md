---
title: "Class: AvatarBadge"
description: "A small circular badge drawn on an [Avatar] corner."
---

```dart
/// A small circular badge drawn on an [Avatar] corner.
///
/// ```dart
/// const Avatar(
///   initials: 'IB',
///   badge: AvatarBadge(child: Icon(LucideIcons.check)),
/// );
/// ```
class AvatarBadge extends StatelessWidget {
  /// Creates a badge.
  const AvatarBadge({super.key, this.child, this.size, this.borderRadius, this.color, this.foregroundColor, this.theme});
  /// Badge content, usually an icon or a short text.
  final Widget? child;
  /// Diameter override; null uses [AvatarTheme.badgeSize] then
  /// `10 * scaling` (upstream `size-2.5` on the default avatar).
  final double? size;
  /// Corner radius override; null is a full circle.
  final BorderRadiusGeometry? borderRadius;
  /// Fill override; null uses [AvatarTheme.badgeColor] then the `primary`
  /// token.
  final Color? color;
  /// Child colour override (text and icons).
  final Color? foregroundColor;
  /// Widget-leg theme override, merged on top of the other legs.
  final AvatarTheme? theme;
  Widget build(BuildContext context);
}
```
