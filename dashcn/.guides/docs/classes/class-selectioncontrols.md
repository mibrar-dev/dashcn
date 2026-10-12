---
title: "Class: SelectionControls"
description: "Widgets-only text selection controls."
---

```dart
/// Widgets-only text selection controls.
///
/// Mixes in [TextSelectionHandleControls], which tells [EditableText] to use
/// `contextMenuBuilder` (see [defaultContextMenuBuilder]) instead of the
/// deprecated `buildToolbar`; cut/copy/paste/select-all availability and
/// behaviour stay with `EditableTextState` itself.
class SelectionControls extends TextSelectionControls with TextSelectionHandleControls {
  /// Creates selection controls.
  ///
  /// [color] defaults to the ambient `ring` token; [handleSize] is the handle
  /// diameter.
  SelectionControls({this.color, this.handleSize = kSelectionHandleSize});
  /// Handle color; null uses the ambient `ring` token.
  final Color? color;
  /// Handle diameter in logical pixels.
  final double handleSize;
  /// Value equality: `EditableText` disposes and recreates its selection
  /// overlay whenever `selectionControls !=`, so two default-constructed
  /// controls must compare equal. Without this, every rebuild of a field
  /// (e.g. a popover re-invoking its builder, which creates fresh widgets)
  /// churns the overlay entries — removing and disposing them mid-build and
  /// crashing the overlay with a zombie entry (`_TypeError` in
  /// `_OverlayEntryWidgetState.initState`).
  bool operator ==(Object other);
  int get hashCode;
  Size getHandleSize(double textLineHeight);
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight);
  Widget buildHandle(BuildContext context, TextSelectionHandleType type, double textLineHeight, [VoidCallback? onTap]);
}
```
