---
title: "Class: ObjectPromptButton"
description: "Trailing prompt button for segmented object fields: opens [content] in  an anchored popover, or runs [openDialog] for the dialog presentation."
---

```dart
/// Trailing prompt button for segmented object fields: opens [content] in
/// an anchored popover, or runs [openDialog] for the dialog presentation.
///
/// Owns its [PopoverController] (disposed with the button), so callers stay
/// stateless. Popover presentation needs an `OverlayManager` ancestor (the
/// app root provides it); without one, use the dialog presentation.
class ObjectPromptButton extends StatefulWidget {
  /// Creates a prompt button.
  const ObjectPromptButton({super.key, required this.mode, required this.contentBuilder, required this.openDialog, required this.child, this.enabled = true, this.alignment, this.anchorAlignment});
  /// Dialog or popover presentation (resolved by the caller).
  final PromptMode mode;
  /// Popover content.
  final WidgetBuilder contentBuilder;
  /// Opens the dialog presentation.
  final VoidCallback openDialog;
  /// Button content, usually a calendar icon.
  final Widget child;
  /// Whether the prompt opens; disabled dims to 50%.
  final bool enabled;
  /// Popover alignment relative to the field; null = top-left.
  final AlignmentGeometry? alignment;
  /// Popover anchor alignment; null = bottom-left.
  final AlignmentGeometry? anchorAlignment;
  State<ObjectPromptButton> createState();
}
```
