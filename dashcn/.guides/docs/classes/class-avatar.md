---
title: "Class: Avatar"
description: "An image or initials tile for a person or entity."
---

```dart
/// An image or initials tile for a person or entity.
///
/// ```dart
/// const Avatar(initials: 'IB');
/// Avatar(initials: 'IB', image: NetworkImage(url), badge: AvatarBadge());
/// ```
class Avatar extends StatelessWidget {
  /// Creates an avatar.
  ///
  /// [initials] is the fallback shown while [image] is absent or cannot be
  /// decoded. [badge] is usually an [AvatarBadge].
  const Avatar({super.key, required this.initials, this.image, this.size, this.borderRadius, this.backgroundColor, this.foregroundColor, this.textStyle, this.fit = BoxFit.cover, this.badge, this.badgeAlignment, this.badgeGap, this.theme});
  /// Fallback label; also the accessible label of the tile.
  final String initials;
  /// Optional photo. When it fails to decode, [initials] are shown.
  final ImageProvider? image;
  /// Diameter override; null uses [AvatarTheme.size] then `32 * scaling`
  /// (upstream `size-8`).
  final double? size;
  /// Corner radius override; null uses [AvatarTheme.borderRadius] then a
  /// full circle.
  final BorderRadiusGeometry? borderRadius;
  /// Initials fill override.
  final Color? backgroundColor;
  /// Initials colour override.
  final Color? foregroundColor;
  /// Initials style override.
  final TextStyle? textStyle;
  /// How the image fills the tile.
  final BoxFit fit;
  /// Optional badge overlaid on the tile.
  final Widget? badge;
  /// Where [badge] sits; null uses [AvatarTheme.badgeAlignment] then the
  /// bottom end corner.
  final AlignmentGeometry? badgeAlignment;
  /// Inset of [badge] from the tile edge.
  final double? badgeGap;
  /// Widget-leg theme override, merged on top of the other legs.
  final AvatarTheme? theme;
  /// Two-letter fallback for [name] (`'Ibrar Ahmed'` -> `'IA'`).
  ///
  /// Returns the first two characters for a single word, or the first
  /// character of the first two words, uppercased. Empty input returns `''`.
  static String getInitials(String name);
  Widget build(BuildContext context);
}
```
