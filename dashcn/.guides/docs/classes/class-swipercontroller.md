---
title: "Class: SwiperController"
description: "Programmatic control of a [Swiper]'s panel: [open] / [close] animate it and  [isOpen] / [progress] report its state."
---

```dart
/// Programmatic control of a [Swiper]'s panel: [open] / [close] animate it and
/// [isOpen] / [progress] report its state.
class SwiperController extends ChangeNotifier {
  /// Whether this controller is attached to a mounted [Swiper].
  bool get isAttached;
  /// Whether the panel is currently open (or opening).
  bool get isOpen;
  /// Current open progress, 0 (closed) to 1 (fully open).
  double get progress;
  /// Opens the panel with its transition.
  void open();
  /// Closes the panel with its transition.
  void close();
}
```
