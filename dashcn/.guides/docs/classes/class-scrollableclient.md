---
title: "Class: ScrollableClient"
description: "A scrollable surface that scrolls on both axes."
---

```dart
/// A scrollable surface that scrolls on both axes.
///
/// The [builder] receives the current offset and the viewport size, so
/// content can translate, zoom or virtualise itself. When [overscroll] is
/// true the offset may leave the content bounds; otherwise it is clamped.
class ScrollableClient extends StatelessWidget {
  /// Creates a two-dimensional scrollable client.
  const ScrollableClient({super.key, this.primary, this.mainAxis = Axis.vertical, this.verticalDetails = const ScrollableDetails.vertical(), this.horizontalDetails = const ScrollableDetails.horizontal(), required this.builder, this.child, this.diagonalDragBehavior, this.dragStartBehavior, this.keyboardDismissBehavior, this.clipBehavior, this.hitTestBehavior, this.overscroll, this.theme});
  /// Whether this is the primary scrollable of the [mainAxis].
  final bool? primary;
  /// Axis that inherits the primary controller and the keyboard dismissal.
  final Axis mainAxis;
  /// Controller, physics and axis direction of the vertical axis.
  final ScrollableDetails verticalDetails;
  /// Controller, physics and axis direction of the horizontal axis.
  final ScrollableDetails horizontalDetails;
  /// Builds the content for the current offset and viewport size.
  final ScrollableBuilder builder;
  /// Optional child handed through to [builder].
  final Widget? child;
  /// How diagonal drags pick an axis.
  final DiagonalDragBehavior? diagonalDragBehavior;
  /// When drag gestures start.
  final DragStartBehavior? dragStartBehavior;
  /// Keyboard dismissal on drag.
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  /// Viewport clipping.
  final Clip? clipBehavior;
  /// Hit-test behaviour of the scrollable.
  final HitTestBehavior? hitTestBehavior;
  /// Whether offsets may move past the content edges.
  final bool? overscroll;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final ScrollableClientTheme? theme;
  Widget build(BuildContext context);
}
```
