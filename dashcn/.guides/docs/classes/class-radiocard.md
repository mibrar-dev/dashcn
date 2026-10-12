---
title: "Class: RadioCard"
description: "A card-shaped option of a [RadioSet]: the indicator and a whole  block of content."
---

```dart
/// A card-shaped option of a [RadioSet]: the indicator and a whole
/// block of content.
///
/// The border *colour* reacts to selection; its width never changes, so
/// selecting a card cannot shift its content.
class RadioCard<T> extends StatefulWidget {
  /// Creates a radio card.
  const RadioCard({super.key, required this.value, required this.child, this.trailing, this.enabled = true, this.focusNode, this.autofocus = false, this.theme, this.cardTheme});
  /// The value this card stands for.
  final T value;
  /// The card content, shown next to the indicator.
  final Widget child;
  /// Widget shown after the content.
  final Widget? trailing;
  /// Whether this card accepts input.
  final bool enabled;
  /// Focus node; created internally when [autofocus] is true and this is null.
  final FocusNode? focusNode;
  /// Whether the card takes focus when first built.
  final bool autofocus;
  /// Widget-leg override for the indicator slice.
  final SelectableRadioTheme? theme;
  /// Widget-leg override for the card surface.
  final SelectableCardTheme? cardTheme;
  State<RadioCard<T>> createState();
}
```
