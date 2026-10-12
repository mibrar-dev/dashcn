---
title: "Class: CardImage"
description: "An interactive card with an image and an optional text block."
---

```dart
/// An interactive card with an image and an optional text block.
///
/// ```dart
/// CardImage(
///   image: Image.network(url),
///   title: const Text('Sunset'),
///   subtitle: const Text('18:42'),
///   onPressed: open,
/// );
/// ```
class CardImage extends StatefulWidget {
  /// Creates a card image.
  const CardImage({super.key, required this.image, this.title, this.subtitle, this.trailing, this.leading, this.onPressed, this.enabled, this.focusNode, this.autofocus = false, this.theme});
  /// The image (or any widget) shown in the image surface.
  final Widget image;
  /// Title passed to the [Basic] text block.
  final Widget? title;
  /// Subtitle passed to the [Basic] text block.
  final Widget? subtitle;
  /// Trailing widget passed to the [Basic] text block.
  final Widget? trailing;
  /// Leading widget passed to the [Basic] text block.
  final Widget? leading;
  /// Called on tap. When null the card is disabled unless [enabled] is true.
  final VoidCallback? onPressed;
  /// Overrides the enabled state; null means `onPressed != null`.
  final bool? enabled;
  /// Focus node of the card. The card creates and owns one when this is null.
  final FocusNode? focusNode;
  /// Whether the card requests focus when first built.
  final bool autofocus;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final CardImageTheme? theme;
  State<CardImage> createState();
}
```
