---
title: "Mixin: ComponentLocalizationsFiles"
description: "File-picker, dropzone and upload text for [ComponentLocalizations]."
---

```dart
/// File-picker, dropzone and upload text for [ComponentLocalizations].
///
/// Flutter's ARB files have no file-upload equivalents, so these are English
/// fallbacks only: a locale may override them, but nothing else is copied in
/// here.
///
/// Applied by `ComponentLocalizations`.
mixin ComponentLocalizationsFiles {
  /// `dropzone` status line while nothing is happening.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get dropzoneIdle;
  /// `dropzone` status line while a drag hovers over the surface.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get dropzoneDragging;
  /// `dropzone` status line while the files are being written.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get dropzoneUploading;
  /// `dropzone` status line after a successful upload.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get dropzoneSuccess;
  /// `dropzone` status line after a failed upload.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get dropzoneError;
  /// `dropzone` status line while the surface is disabled.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get dropzoneDisabled;
  /// Default `dropzone` browse action label.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get dropzoneBrowse;
  /// Pick/browse label of the file surfaces.
  String get fileUploadChoose;
  /// Tile label while nothing is selected.
  String get fileUploadNoFile;
  /// Error shown when the platform picker threw.
  String get fileUploadPickFailed;
  /// Validation: more files than the constraint allows.
  String get fileUploadTooMany;
  /// Validation: one file is over the size limit.
  String get fileUploadTooLarge;
  /// Validation: extension or MIME type not allowed.
  String get fileUploadInvalidType;
  /// Upload failure without a file (e.g. the picker failed).
  String get fileUploadUploadFailed;
  /// Upload failure for one file.
  String fileUploadUploadFailedFor(String name);
  /// Status label for [FileStatus.queued].
  String get fileUploadStatusQueued;
  /// Status label for [FileStatus.uploading].
  String get fileUploadStatusUploading;
  /// Status label for [FileStatus.success].
  String get fileUploadStatusCompleted;
  /// Status label for [FileStatus.error].
  String get fileUploadStatusFailed;
  /// Type label for a file without an extension.
  String get fileUploadUnknownType;
  /// Row action: remove the file.
  String get fileUploadRemove;
  /// Row action: retry the upload.
  String get fileUploadRetry;
  /// Row action: preview the file.
  String get fileUploadPreview;
  /// Row action: download the file.
  String get fileUploadDownload;
}
```
