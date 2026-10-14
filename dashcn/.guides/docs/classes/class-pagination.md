---
title: "Class: Pagination"
description: "A page selector."
---

```dart
/// A page selector.
///
/// ```dart
/// Pagination(
///   page: current,
///   totalPages: 20,
///   onPageChanged: (page) => setState(() => current = page),
/// );
/// ```
class Pagination extends StatelessWidget {
  /// Creates a pagination control.
  const Pagination({super.key, required this.page, required this.totalPages, required this.onPageChanged, this.maxPages = 3, this.showSkipToFirstPage = true, this.showSkipToLastPage = true, this.hidePreviousOnFirstPage = false, this.hideNextOnLastPage = false, this.showLabel, this.gap, this.theme});
  /// The active page (1-based). Out-of-range values are clamped for display.
  final int page;
  /// Total number of pages.
  final int totalPages;
  /// Called with the requested page number.
  final ValueChanged<int> onPageChanged;
  /// How many page buttons the window shows when the total exceeds it.
  final int maxPages;
  /// Whether a button jumping to the first page is shown before the window.
  final bool showSkipToFirstPage;
  /// Whether a button jumping to the last page is shown after the window.
  final bool showSkipToLastPage;
  /// Hides the previous button while on the first page.
  final bool hidePreviousOnFirstPage;
  /// Hides the next button while on the last page.
  final bool hideNextOnLastPage;
  /// Whether previous/next show a text label; null resolves the theme.
  final bool? showLabel;
  /// Gap override; null resolves [PaginationTheme.gap].
  final double? gap;
  /// Widget-leg theme override, merged on top of the other legs.
  final PaginationTheme? theme;
  /// Whether a previous page exists.
  bool get hasPrevious;
  /// Whether a next page exists.
  bool get hasNext;
  /// The page numbers currently shown in the window.
  Iterable<int> get pages;
  /// First page of the current window.
  int get firstShownPage;
  /// Last page of the current window.
  int get lastShownPage;
  /// Whether the window has earlier pages to jump back to.
  bool get hasMorePreviousPages;
  /// Whether the window has later pages to jump forward to.
  bool get hasMoreNextPages;
  Widget build(BuildContext context);
}
```
