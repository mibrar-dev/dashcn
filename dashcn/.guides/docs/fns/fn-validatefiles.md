---
title: "Function: validateFiles"
description: "Checks [incoming] against [constraints], counting [existing] towards the file  limit."
---

Signature
```dart
FileValidationResult validateFiles({required List<FileValue> incoming, required List<FileValue> existing, FileConstraints? constraints, required String Function(FileErrorCode code, FileValue? file) onError});
```
