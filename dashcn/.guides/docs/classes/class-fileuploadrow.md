---
title: "Class: FileUploadRow"
description: "Reference for FileUploadRow"
---

```dart
class FileUploadRow extends StatelessWidget {
  /// Creates a file row.
  const FileUploadRow({super.key, required this.item, this.theme, this.progress, this.statusLabels, this.onRemove, this.onRetry, this.onPreview, this.onDownload, this.thumbnail, this.iconBuilder});
  /// The row's file and transfer state.
  final FileItem item;
  /// Widget-leg style override, merged on top of the component/app/defaults.
  final FileUploadRowTheme? theme;
  /// Progress indicator shown under the row; null hides it.
  final Widget? progress;
  /// Status wording; null resolves the localized defaults.
  final FileStatusLabels? statusLabels;
  /// Removes the file.
  final VoidCallback? onRemove;
  /// Retries a failed upload.
  final VoidCallback? onRetry;
  /// Previews the file.
  final VoidCallback? onPreview;
  /// Downloads the file.
  final VoidCallback? onDownload;
  /// Thumbnail override; null renders the image bytes or the file icon.
  final Widget? thumbnail;
  /// Thumbnail builder for the default icon; null renders [defaultFileIcon].
  final FileUploadIconBuilder? iconBuilder;
  Widget build(BuildContext context);
}
```
