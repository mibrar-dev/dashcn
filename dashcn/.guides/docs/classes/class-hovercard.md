---
title: "Class: HoverCard"
description: "A rich preview card shown while the pointer rests on [child]."
---

```dart
/// A rich preview card shown while the pointer rests on [child].
///
/// [hoverBuilder] returns the bare content; the widget wraps it in the themed
/// popover surface itself, so return content (not a surface).
class HoverCard extends StatefulWidget {
  /// Creates a hover card.
  const HoverCard({super.key, required this.child, required this.hoverBuilder, this.debounce, this.wait, this.popoverAlignment, this.anchorAlignment, this.popoverOffset, this.behavior, this.controller, this.theme});
  /// The anchor the card points at.
  final Widget child;
  /// Builds the card content.
  final WidgetBuilder hoverBuilder;
  /// Hide delay after the pointer leaves; null resolves the theme default.
  final Duration? debounce;
  /// Show delay after the pointer enters; null resolves the theme default.
  final Duration? wait;
  /// Card placement; null resolves the theme default.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor edge; null resolves the theme default.
  final AlignmentGeometry? anchorAlignment;
  /// Gap between anchor and card; null resolves the theme default.
  final Offset? popoverOffset;
  /// Hit-test behaviour of the anchor; null resolves the theme default.
  final HitTestBehavior? behavior;
  /// External popover controller; owned internally when null.
  final PopoverController? controller;
  /// Widget-leg theme override.
  final HoverCardTheme? theme;
  State<HoverCard> createState();
}
```
