---
title: "Class: GooeyToastLayer"
description: "Hosts a [GooeyToastController] and renders its toasts above [child]."
---

```dart
/// Hosts a [GooeyToastController] and renders its toasts above [child].
///
/// Wrap the app (or a demo viewport): the controller inserts into the root
/// overlay, so toasts anchor to the window edge and never cover their own
/// trigger. Disposing the layer's controller clears its toasts.
class GooeyToastLayer extends StatefulWidget {
  /// Creates a gooey toast layer.
  const GooeyToastLayer({super.key, required this.child, this.controller, this.theme});
  /// Content below the toasts.
  final Widget child;
  /// Injected controller; one is owned when null.
  final GooeyToastController? controller;
  /// Widget-leg theme override.
  final GooeyToastTheme? theme;
  State<GooeyToastLayer> createState();
}
```
