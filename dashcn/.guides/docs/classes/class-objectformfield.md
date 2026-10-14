---
title: "Class: ObjectFormField"
description: "A form field whose value is edited through a dialog or popover."
---

```dart
/// A form field whose value is edited through a dialog or popover.
class ObjectFormField<T> extends StatefulWidget {
  /// Creates an object form field.
  const ObjectFormField({super.key, required this.value, this.onChanged, required this.placeholder, required this.builder, this.leading, this.trailing, this.mode = PromptMode.dialog, required this.editorBuilder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.expand = false, this.triggerMinWidth = 0, this.dialogTitle, this.dialogActions, this.dialogPadding, this.dialogFooterPadding, this.enabled, this.decorate = true, this.immediateValueChange});
  /// The current value.
  final T? value;
  /// Called with the next value.
  final ValueChanged<T?>? onChanged;
  /// Shown while [value] is null.
  final Widget placeholder;
  /// Builds the trigger content from a non-null value.
  final Widget Function(BuildContext context, T value) builder;
  /// Optional widget before the trigger content.
  final Widget? leading;
  /// Optional widget after the trigger content.
  final Widget? trailing;
  /// Dialog or popover presentation.
  final PromptMode mode;
  /// Builds the editor; the handler reads/updates the working value.
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler) editorBuilder;
  /// Popover alignment relative to the trigger.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor alignment for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover surface.
  final EdgeInsetsGeometry? popoverPadding;
  /// Full-width trigger when true; otherwise hugs (at least [triggerMinWidth]).
  /// A tight parent fills either way.
  final bool expand;
  /// Minimum trigger width in upstream px (240 date, 140 time pickers).
  final double triggerMinWidth;
  /// Title of the dialog prompt.
  final Widget? dialogTitle;
  /// Padding between the dialog card border and the editor (`EdgeInsets.zero`
  /// paints no card padding for editors with their own shell, like pickers).
  /// Null resolves [objectFormDialogPadding].
  final EdgeInsetsGeometry? dialogPadding;
  /// Padding of the dialog footer row (with a hairline top border); null keeps
  /// the footer inside the card padding.
  final EdgeInsetsGeometry? dialogFooterPadding;
  /// Extra dialog actions before Cancel/Save.
  final List<Widget> Function(BuildContext context, ObjectFormHandler<T> handler)? dialogActions;
  /// Overrides the enabled state; null means `onChanged != null`.
  final bool? enabled;
  /// Whether prompt mode paints its own surface around the editor.
  final bool decorate;
  /// Whether edits are reported live (popover default true, dialog false).
  final bool? immediateValueChange;
  State<ObjectFormField<T>> createState();
}
```
