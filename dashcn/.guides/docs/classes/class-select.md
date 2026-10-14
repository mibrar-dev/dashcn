---
title: "Class: Select"
description: "A single-selection dropdown picker: the trigger shows [itemBuilder]'s  rendering of [value] (or [placeholder] while [value] is null)."
---

```dart
/// A single-selection dropdown picker: the trigger shows [itemBuilder]'s
/// rendering of [value] (or [placeholder] while [value] is null). Tapping
/// opens a popover of [items] (or the asynchronous [builder], which enables
/// a search field); picking a row reports through [onChanged], and forms see
/// the value through `FormValueSupplier`.
class Select<T> extends StatefulWidget {
  /// Creates a dropdown picker.
  const Select({super.key, required this.itemBuilder, this.value, this.onChanged, this.enabled, this.placeholder, this.items, this.builder, this.searchPlaceholder, this.focusNode, this.expandIcon = const Icon(LucideIcons.chevronsUpDown), this.canUnselect = false, this.autoClose = true, this.popupConstraints, this.valueSelectionHandler, this.valueSelectionPredicate, this.theme});
  /// Builds the trigger content of the selected value.
  final SelectValueBuilder<T> itemBuilder;
  /// The selected value; null shows [placeholder].
  final T? value;
  /// Called with the next selection; null disables the select.
  final ValueChanged<T?>? onChanged;
  /// Overrides the enabled state; null means `onChanged != null`.
  final bool? enabled;
  /// Shown in the trigger while [value] is null.
  final Widget? placeholder;
  /// The popup rows; ignored when [builder] is set.
  final FutureOr<List<Widget>>? items;
  /// Builds the popup rows for a search query; enables the search field.
  final SelectItemsBuilder? builder;
  /// Placeholder of the search field (shown when [builder] is set).
  final Widget? searchPlaceholder;
  /// Trigger focus node.
  final FocusNode? focusNode;
  /// Trigger trailing icon; null hides it.
  final Widget? expandIcon;
  /// Whether picking the selected value clears the selection.
  final bool canUnselect;
  /// Whether picking a value closes the popup. Default: true (single
  /// selection); `multi_select` passes false so the popup stays open.
  final bool autoClose;
  /// Popup size constraints; null resolves `SelectTheme.constraints`, then
  /// 192-320 wide and 240 high. The popup is always trigger-wide.
  final BoxConstraints? popupConstraints;
  /// Custom selection mapping; null is single selection.
  final SelectValueSelectionHandler<T>? valueSelectionHandler;
  /// Custom selection test; null is `value == test`.
  final SelectValueSelectionPredicate<T>? valueSelectionPredicate;
  /// Widget-leg theme override, merged over the component/app/defaults legs.
  final SelectTheme? theme;
  State<Select<T>> createState();
}
```
