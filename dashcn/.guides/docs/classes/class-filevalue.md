---
title: "Class: FileValue"
description: "One selected file, as the registry models it."
---

```dart
/// One selected file, as the registry models it.
///
/// A platform-neutral value type: the picker component converts whatever the
/// platform hands it into this, and every downstream widget reads only this
/// shape.
class FileValue {
  /// Creates a file value.
  const FileValue({required this.id, required this.name, required this.size, this.bytes, this.path, this.mimeType, this.extension, this.source});
  /// Stable identity of this file inside a selection (upload state, form value).
  final String id;
  /// File name including the extension, as shown to the user.
  final String name;
  /// Size in bytes.
  final int size;
  /// File contents, when the picker was asked to read them.
  final Uint8List? bytes;
  /// Platform path, where one exists (null on the web).
  final String? path;
  /// MIME type, when known.
  final String? mimeType;
  /// Extension without the dot; derived from [name] when null.
  final String? extension;
  /// The platform object this came from, for callers that need it.
  ///
  /// Deliberately `Object?` so layer 2 never names a platform type.
  final Object? source;
  /// Lower-cased extension without the dot; empty when there is none.
  ///
  /// The old `resolvedExtension` used `name.split('.')`, so a name of
  /// `.gitignore` reported `gitignore` as its extension. A leading dot now
  /// yields empty, as does a trailing one.
  String get resolvedExtension;
  /// Whether the file looks like an image: its MIME type says so, or its
  /// extension is one the platforms decode natively.
  bool get isImage;
  /// Extensions treated as images when no MIME type is available.
  static const Set<String> imageFileExtensions = <String>{'png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp', 'svg', 'heic'};
  String toString();
}
```
