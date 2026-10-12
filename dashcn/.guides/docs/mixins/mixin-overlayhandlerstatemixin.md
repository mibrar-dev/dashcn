---
title: "Mixin: OverlayHandlerStateMixin"
description: "State-level contract implemented by every overlay widget."
---

```dart
/// State-level contract implemented by every overlay widget.
///
/// The setters allow a `PopoverController` to update a live overlay; the
/// default no-op implementations let simple overlays ignore them.
mixin OverlayHandlerStateMixin<T extends StatefulWidget> on State<T> {
  /// Closes the overlay.
  Future<void> close([bool immediate = false]);
  /// Schedules overlay closure for the next frame.
  void closeLater();
  /// Closes the overlay with a result value.
  Future<void> closeWithResult<X>([X? value]);
  /// Updates the anchor context for positioning.
  set anchorContext(BuildContext value);
  /// Updates the overlay alignment.
  set alignment(AlignmentGeometry value);
  /// Updates the anchor alignment.
  set anchorAlignment(AlignmentGeometry value);
  /// Updates the width constraint.
  set widthConstraint(PopoverConstraint value);
  /// Updates the height constraint.
  set heightConstraint(PopoverConstraint value);
  /// Updates the margin.
  set margin(EdgeInsets value);
  /// Updates whether the overlay follows the anchor.
  set follow(bool value);
  /// Updates the position offset.
  set offset(Offset? value);
  /// Updates horizontal inversion permission.
  set allowInvertHorizontal(bool value);
  /// Updates vertical inversion permission.
  set allowInvertVertical(bool value);
}
```
