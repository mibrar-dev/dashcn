---
title: "Class: MultiSelect"
description: "A multi-selection dropdown."
---

```dart
/// A multi-selection dropdown.
///
/// [_itemBuilder] renders one selected value in the trigger (usually a
/// [MultiSelectChip]); the popup rows are [MultiSelectItem]s built from
/// [items] or the asynchronous [builder]. Picking a row toggles it and keeps
/// the popup open; a chip's remove control clears its value.
class MultiSelect<T> extends StatelessWidget {
  /// Creates a multi-selection dropdown.
  const MultiSelect({super.key, required this.itemBuilder, this.value, this.onChanged, this.enabled, this.placeholder, this.items, this.builder, this.searchPlaceholder, this.focusNode, this.expandIcon = const Icon(LucideIcons.chevronsUpDown), this.canUnselect = true, this.autoClose = false, this.popupConstraints, this.valueSelectionHandler, this.valueSelectionPredicate, this.theme});
  /// Builds one selected value in the trigger (usually a `MultiSelectChip`).
  final SelectValueBuilder<T> itemBuilder;
  /// The selected values.
  final Iterable<T>? value;
  /// Called with the next selection; null disables the select.
  final ValueChanged<Iterable<T>?>? onChanged;
  /// Overrides the enabled state; null means `onChanged != null`.
  final bool? enabled;
  /// Shown in the trigger while no value is selected.
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
  /// Whether picking a selected item removes it. Default: true.
  final bool canUnselect;
  /// Whether picking an item closes the popup. Default: false, so several
  /// values can be toggled in a row.
  final bool autoClose;
  /// Popup size constraints; null resolves `SelectTheme.constraints`.
  final BoxConstraints? popupConstraints;
  /// Custom selection mapping; null toggles the item.
  final SelectValueSelectionHandler<Iterable<T>>? valueSelectionHandler;
  /// Custom selection test; null is `value.contains(test)`.
  final SelectValueSelectionPredicate<Iterable<T>>? valueSelectionPredicate;
  /// Widget-leg theme override, merged over the component/app/defaults legs.
  final SelectTheme? theme;
  Widget build(BuildContext context);
}
```
