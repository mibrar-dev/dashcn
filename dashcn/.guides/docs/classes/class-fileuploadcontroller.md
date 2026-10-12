---
title: "Class: FileUploadController"
description: "Coordinates the file list, validation, the upload queue and concurrency."
---

```dart
/// Coordinates the file list, validation, the upload queue and concurrency.
///
/// One queue drives every file: [addFiles] validates, [startUploads] queues
/// the non-success items up to `maxConcurrent`, and [retry] puts one failed
/// file back in line. [removeFile] cancels a queued or active upload.
class FileUploadController extends ChangeNotifier {
  /// Creates a controller, optionally with [initialItems] already listed.
  FileUploadController({List<FileItem>? initialItems, this.constraints = const FileConstraints(), FileUploadMessage? message});
  /// Acceptance constraints; [addFiles] enforces them unless the caller passes
  /// a one-off override.
  final FileConstraints constraints;
  /// The current rows, in insertion order.
  List<FileItem> get items;
  /// Rejections from the last [addFiles] call plus upload failures.
  List<FileError> get errors;
  /// Whether any row is mid-transfer.
  bool get isUploading;
  /// Whether the list has any rows.
  bool get hasItems;
  /// Replaces every row; ongoing uploads are cancelled.
  void setItems(List<FileItem> items);
  /// Empties the list, the errors and every upload.
  void clear();
  /// Validates [files] against [constraints] (or [overrideConstraints]),
  /// appends the accepted rows, replaces the validation errors and returns the
  /// added files.
  ///
  /// The old widget validated *and* the controller validated, so two different
  /// constraint sets could disagree; this is the only validation site now.
  List<FileValue> addFiles(List<FileValue> files, {FileConstraints? overrideConstraints});
  /// Removes [file], cancelling a queued or active upload.
  void removeFile(FileValue file);
  /// Appends [error] to [errors] and notifies (used for picker failures that
  /// produce no file row).
  void reportError(FileError error);
  /// Replaces the row for [file] with a new status/progress.
  ///
  /// A null [progress] clears the bar; a non-null one keeps it. The old
  /// `FileUploadItem.copyWith` cleared progress on *every* call, so a status
  /// change silently reset a running bar.
  void updateItem(FileValue file, FileStatus status, double? progress);
  /// Starts (or restarts) uploads with [upload].
  ///
  /// [files] limits the batch; null queues every non-success row. Rows already
  /// queued or uploading are skipped, so calling this twice never double-starts
  /// an upload. The callbacks are stored for [retry].
  void startUploads(FileUploadFn upload, {List<FileValue>? files, int maxConcurrent = 1, void Function(FileValue file, double progress)? onProgress, VoidCallback? onUploadStart, ValueChanged<List<FileValue>>? onComplete, ValueChanged<FileError>? onError});
  /// Re-queues one failed [file] with the function and callbacks of the last
  /// [startUploads] call; does nothing before one.
  void retry(FileValue file);
  void dispose();
}
```
