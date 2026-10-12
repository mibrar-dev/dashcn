---
title: "Class: GooeyToastController"
description: "Owns the gooey toasts of a layer and renders them into the root overlay."
---

```dart
/// Owns the gooey toasts of a layer and renders them into the root overlay.
class GooeyToastController extends ChangeNotifier {
  /// Creates a controller.
  GooeyToastController();
  /// Active toasts, newest first.
  List<GooeyToastDetails> get activeToasts;
  /// Whether a toast with [id] is active.
  bool containsToast(String id);
  /// Dismisses the toast with [id], if present.
  void dismiss(String id);
  /// Pauses or resumes the countdown of the toast [id].
  ///
  /// Pausing keeps the remaining lifetime, so a toast hovered for half its
  /// duration still shows for the other half once the pointer leaves.
  void setInteracting(String id, bool value);
  /// Shows a gooey toast and returns its id.
  ///
  /// [behavior] decides what happens when the slot is already occupied;
  /// `transition` reuses the live record so the pill morphs between states
  /// instead of being torn down (the promise and multi-state flows).
  String showGooeyToast(BuildContext context, GooeyToastOptions options, {String? id, GooeyToastNewToastBehavior? behavior, Duration? duration, bool autoDismiss = true, VoidCallback? onDismissed});
  void dispose();
}
```
