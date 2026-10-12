---
title: "Class: ObjectFormPromptDialog"
description: "Reference for ObjectFormPromptDialog"
---

```dart
class ObjectFormPromptDialog<T> extends StatefulWidget {
  /// Creates the dialog page.
  const ObjectFormPromptDialog({super.key, required this.initialValue, required this.editorBuilder, this.dialogTitle, this.dialogActions, this.padding = objectFormDialogPadding, this.footerPadding, this.decorate = true, required this.onPrompt, required this.onChanged});
  /// Value the editor starts with.
  final T? initialValue;
  /// Builds the editor body.
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler) editorBuilder;
  /// Optional heading above the editor.
  final Widget? dialogTitle;
  /// Padding between the card border and the editor; null means the caller
  /// paints the shell (a `p-0` dialog around a `p-3` calendar, as upstream
  /// does).
  final EdgeInsetsGeometry? padding;
  /// Padding of the footer row when it paints a top border; null means the
  /// footer sits in the card padding with no separator.
  final EdgeInsetsGeometry? footerPadding;
  /// Extra actions before Cancel/Save.
  final List<Widget> Function(BuildContext context, ObjectFormHandler<T> handler)? dialogActions;
  /// Whether to paint the dialog surface.
  final bool decorate;
  /// Re-opens another prompt with a value.
  final ValueChanged<T?> onPrompt;
  /// Reports value changes to the field.
  final ValueChanged<T?> onChanged;
  State<ObjectFormPromptDialog<T>> createState();
}
```
