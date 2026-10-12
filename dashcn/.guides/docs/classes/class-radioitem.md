---
title: "Class: RadioItem"
description: "One option of a single-select group."
---

```dart
/// One option of a single-select group.
///
/// The group owns the selection; an item only reads it.
class RadioItem<T> extends StatefulWidget {
  /// Creates a row item.
  const RadioItem({super.key, required this.value, this.label, this.trailing, this.enabled = true, this.focusNode, this.autofocus = false, this.theme});
  /// The value this item stands for.
  final T value;
  /// Label shown after the indicator.
  final Widget? label;
  /// Widget shown after the label.
  final Widget? trailing;
  /// Whether this item accepts input.
  final bool enabled;
  /// Focus node; created internally when [autofocus] is true and this is null.
  final FocusNode? focusNode;
  /// Whether the item takes focus when first built.
  final bool autofocus;
  /// Widget-leg style override.
  final SelectableRadioTheme? theme;
  State<RadioItem<T>> createState();
}
```
