---
title: "Class: EditableTextHost"
description: "Owns the controller/focus/state objects and gesture wiring for one  EditableText wrapper."
---

```dart
/// Owns the controller/focus/state objects and gesture wiring for one
/// EditableText wrapper.
///
/// External [controller]/[focusNode]/[statesController] are used as-is;
/// otherwise the host creates and disposes its own. Call [update] on every
/// `didUpdateWidget` to apply new widget values.
class EditableTextHost implements TextSelectionGestureDetectorBuilderDelegate {
  /// Creates a host.
  ///
  /// [initialValue] seeds the internally created controller only.
  EditableTextHost({TextEditingController? controller, String? initialValue, FocusNode? focusNode, WidgetStatesController? statesController, bool enabled = true, this.onControllerChanged, this.onStatesChanged});
  /// Called after the effective controller changes (user edits or swaps).
  final VoidCallback? onControllerChanged;
  /// Called after the widget-state set changes (hover/focus/disabled).
  final VoidCallback? onStatesChanged;
  /// Gesture builder wired to this host; call `buildGestureDetector` from the
  /// field's build.
  final TextSelectionGestureDetectorBuilder gestureBuilder;
  /// The effective text controller.
  TextEditingController get controller;
  /// The effective focus node.
  FocusNode get focusNode;
  /// The effective widget-state controller.
  WidgetStatesController get states;
  GlobalKey<EditableTextState> get editableTextKey;
  bool get forcePressEnabled;
  bool get selectionEnabled;
  /// Applies the current widget values, swapping owned/external objects and
  /// updating the disabled state.
  void update({required TextEditingController? controller, required FocusNode? focusNode, required WidgetStatesController? statesController, required bool enabled});
  /// Releases listeners and any objects this host owns.
  void dispose();
  /// Input formatters including the effective `maxLength` limiter.
  List<TextInputFormatter> formatters({List<TextInputFormatter>? inputFormatters, int? maxLength, MaxLengthEnforcement? maxLengthEnforcement});
  /// Appends [value] at the end and moves the caret after it.
  void appendText(String value);
  /// Selects everything and copies it to the clipboard.
  void selectAllAndCopy();
  /// Clears the field text.
  void clear();
}
```
