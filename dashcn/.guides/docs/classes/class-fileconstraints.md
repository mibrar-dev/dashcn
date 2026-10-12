---
title: "Class: FileConstraints"
description: "The acceptance constraints a file component enforces."
---

```dart
/// The acceptance constraints a file component enforces.
///
/// The old `FileUploadHelpfulInfoData` duplicated exactly these five fields so
/// the help text and the validation could not drift; one type serves both.
class FileConstraints {
  /// Creates a constraint set. Every field is optional; null means "no limit".
  const FileConstraints({this.allowMultiple = true, this.maxFiles, this.maxFileSizeBytes, this.allowedExtensions, this.allowedMimeTypes});
  /// Whether more than one file may be selected.
  final bool allowMultiple;
  /// Maximum number of files in the whole selection.
  final int? maxFiles;
  /// Maximum size of a single file, in bytes.
  final int? maxFileSizeBytes;
  /// Allowed extensions, with or without a leading dot; case-insensitive.
  final List<String>? allowedExtensions;
  /// Allowed MIME types; `image/*`-style wildcards are honoured.
  final List<String>? allowedMimeTypes;
  /// Extensions normalised to lower case without the dot.
  Set<String> get normalizedExtensions;
  /// MIME types normalised to lower case, wildcards excluded.
  List<String> get normalizedMimeTypes;
  /// MIME type prefixes such as `image/`, lower case.
  List<String> get mimeTypePrefixes;
  /// Whether no limit and no type filter is configured, so a component can skip
  /// rendering the constraints help line.
  bool get isUnbounded;
}
```
