---
title: "Class: SelectPopupBody"
description: "The body of a select popup: resolves the row widgets for the current  search query and lays them out inside [surface]."
---

```dart
/// The body of a select popup: resolves the row widgets for the current
/// search query and lays them out inside [surface].
///
/// [searchField] enables the query field (and the query passed to
/// [builder]); [spacer] is inserted between the field and the rows. The
/// surface and search field are builders so this widget stays at layer 2.
class SelectPopupBody extends StatefulWidget {
  /// Creates a popup body.
  const SelectPopupBody({super.key, required this.surface, this.searchField, this.spacer, this.items, this.builder, this.emptyBuilder, this.constraints});
  /// Wraps the resolved content in the component's surface.
  final SelectPopupSurfaceBuilder surface;
  /// Builds the search field; null hides it and disables the search query.
  final SelectPopupSearchBuilder? searchField;
  /// Inserted between the search field and the rows.
  final Widget? spacer;
  /// Static rows; ignored when [builder] is set.
  final FutureOr<List<Widget>>? items;
  /// Builds the rows for a search query; enables the query when set.
  final SelectPopupItemsBuilder? builder;
  /// Shown when the resolved row list is empty; defaults to a 48px spacer.
  final WidgetBuilder? emptyBuilder;
  /// Size constraints; defaults to a 128 minimum width and 240 high. There
  /// is no maximum width: the popup hugs the widest option (never narrower
  /// than the trigger through the popover's anchor-minimum sizing) and the
  /// viewport caps it.
  final BoxConstraints? constraints;
  State<SelectPopupBody> createState();
}
```
