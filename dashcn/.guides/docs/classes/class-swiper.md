---
title: "Class: Swiper"
description: "Wraps [child] and reveals a [SwiperVariant."
---

```dart
/// Wraps [child] and reveals a [SwiperVariant.drawer] or [SwiperVariant.sheet]
/// panel when the user swipes towards the panel's edge. The panel is painted
/// in-tree so the gesture can scrub it. Provide a non-swipe trigger for
/// keyboard and assistive-technology users.
class Swiper extends StatefulWidget {
  /// Creates a swiper.
  const Swiper({super.key, required this.position, required this.builder, required this.child, this.variant = SwiperVariant.drawer, this.enabled = true, this.controller, this.theme});
  /// Edge the panel slides in from; `start`/`end` follow the text direction.
  final OverlayPosition position;
  /// Builds the panel content.
  final WidgetBuilder builder;
  /// The widget that responds to the swipe gesture.
  final Widget child;
  /// Which panel to reveal.
  final SwiperVariant variant;
  /// Whether the swipe gesture is active.
  final bool enabled;
  /// Optional programmatic control; the swiper never disposes it.
  final SwiperController? controller;
  /// Widget-leg theme override; other legs resolve from the tree and the app.
  final SwiperTheme? theme;
  State<Swiper> createState();
}
```
