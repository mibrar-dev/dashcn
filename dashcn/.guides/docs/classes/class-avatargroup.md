---
title: "Class: AvatarGroup"
description: "Overlaps several [Avatar]s with a background-coloured ring between them."
---

```dart
/// Overlaps several [Avatar]s with a background-coloured ring between them.
///
/// ```dart
/// const AvatarGroup(
///   children: <Widget>[Avatar(initials: 'IB'), Avatar(initials: 'AC')],
/// );
/// ```
class AvatarGroup extends StatelessWidget {
  /// Creates an avatar group.
  const AvatarGroup({super.key, required this.children, this.size, this.overlap, this.ringWidth = 2, this.clipBehavior = Clip.none, this.borderRadius});
  /// Tiles to overlap, first in front; usually [Avatar]s.
  final List<Widget> children;
  /// Tile diameter; null resolves `32 * scaling` (upstream `size-8`).
  /// Children are laid out at this size; an inner [Avatar.size] has no
  /// effect.
  final double? size;
  /// How far each tile overlaps its predecessor; null resolves
  /// `size * 0.3`.
  final double? overlap;
  /// Width of the background ring around each tile.
  final double ringWidth;
  /// Clip behavior of the group's stack.
  final Clip clipBehavior;
  /// Shape of the background ring; null is a full circle, matching the
  /// default circular tile. Pass the tile radius when grouping
  /// rounded-square tiles so the ring does not peek out.
  final BorderRadiusGeometry? borderRadius;
  Widget build(BuildContext context);
}
```
