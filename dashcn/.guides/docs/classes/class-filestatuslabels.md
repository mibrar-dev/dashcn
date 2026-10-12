---
title: "Class: FileStatusLabels"
description: "Labels for the transfer states."
---

```dart
/// Labels for the transfer states.
///
/// The defaults are the upstream English wording; a localized component reads
/// `ComponentLocalizations` and passes translated values instead.
class FileStatusLabels {
  /// Creates a label set.
  const FileStatusLabels({this.queued = 'Queued', this.uploading = 'Uploading', this.completed = 'Completed', this.failed = 'Failed'});
  /// Label for [FileStatus.queued].
  final String queued;
  /// Label for [FileStatus.uploading].
  final String uploading;
  /// Label for [FileStatus.success].
  final String completed;
  /// Label for [FileStatus.error].
  final String failed;
  /// The label for [status].
  String resolve(FileStatus status);
}
```
