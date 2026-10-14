---
title: "Class: FilterBarSheetScaffold"
description: "The card used inside the mobile filter sheet."
---

```dart
/// The card used inside the mobile filter sheet.
///
/// Public because the old `filter_bar_style.dart` exposed it and apps may
/// reuse the sheet chrome; `FilterBar` builds it internally.
class FilterBarSheetScaffold extends StatelessWidget {
  /// Creates a sheet scaffold.
  const FilterBarSheetScaffold({super.key, required this.title, required this.child, this.onClose, this.footer, this.maxHeight = 560, this.contentPadding});
  /// Sheet title.
  final String title;
  /// Sheet body.
  final Widget child;
  /// Called by the close button; null hides it.
  final VoidCallback? onClose;
  /// Optional footer pinned below the body.
  final Widget? footer;
  /// Maximum card height before the body scrolls.
  final double maxHeight;
  /// Padding around the body.
  final EdgeInsetsGeometry? contentPadding;
  Widget build(BuildContext context);
}
```
