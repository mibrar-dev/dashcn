---
title: "Class: FileUploadItemsView"
description: "Renders the file rows: a list, a grid or caller-keyed groups."
---

```dart
/// Renders the file rows: a list, a grid or caller-keyed groups.
///
/// ```dart
/// FileUploadItemsView(
///   items: items,
///   layout: FileUploadItemsLayout.grid,
///   columns: 3,
///   onRemove: (item) => remove(item.file),
/// )
/// ```
class FileUploadItemsView extends StatelessWidget {
  /// Creates a file items view.
  const FileUploadItemsView({super.key, required this.items, this.layout = FileUploadItemsLayout.list, this.columns = 2, this.groupKey, this.groupHeaderBuilder, this.statusLabels, this.iconBuilder, this.itemBuilder, this.progressBuilder, this.onRemove, this.onRetry, this.gap, this.maxHeight, this.theme});
  /// The rows to render.
  final List<FileItem> items;
  /// List or grid.
  final FileUploadItemsLayout layout;
  /// Grid columns; clamped to at least one.
  final int columns;
  /// Section key per row; null renders one flat list.
  final String Function(FileItem item)? groupKey;
  /// Builds a section header; null renders the key as muted text.
  final Widget Function(BuildContext context, String key)? groupHeaderBuilder;
  /// Status wording; null resolves the localized defaults.
  final FileStatusLabels? statusLabels;
  /// Row thumbnail builder; null renders [defaultFileIcon].
  final FileUploadIconBuilder? iconBuilder;
  /// Custom row builder; null renders [FileUploadRow].
  final FileUploadItemBuilder? itemBuilder;
  /// Progress widget per row; null renders none.
  final Widget? Function(FileItem item)? progressBuilder;
  /// Called when a row's remove action is pressed.
  final ValueChanged<FileItem>? onRemove;
  /// Called when a failed row's retry action is pressed.
  final ValueChanged<FileItem>? onRetry;
  /// Space between rows/sections; null resolves 12.
  final double? gap;
  /// Scroll cap; null grows with the content.
  final double? maxHeight;
  /// Row theme bridge; null lets each row resolve its own legs.
  final FileUploadRowTheme? theme;
  Widget build(BuildContext context);
}
```
