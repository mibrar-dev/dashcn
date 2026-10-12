---
title: "Class: ObjectFormPromptPopup"
description: "The popover presentation of an object editor."
---

```dart
/// The popover presentation of an object editor.
class ObjectFormPromptPopup<T> extends StatefulWidget {
  /// Creates the popover body.
  const ObjectFormPromptPopup({super.key, required this.initialValue, required this.editorBuilder, this.popoverPadding, this.decorate = true, required this.onPrompt, required this.onChanged});
  /// Value the editor starts with.
  final T? initialValue;
  /// Builds the editor body.
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler) editorBuilder;
  /// Padding inside the popover surface.
  final EdgeInsetsGeometry? popoverPadding;
  /// Whether to paint the popover surface.
  final bool decorate;
  /// Re-opens another prompt with a value.
  final ValueChanged<T?> onPrompt;
  /// Reports value changes to the field.
  final ValueChanged<T?> onChanged;
  State<ObjectFormPromptPopup<T>> createState();
}
```
