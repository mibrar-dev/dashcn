---
title: "Class: AppError"
description: "A UI-safe, user-facing error."
---

```dart
/// A UI-safe, user-facing error.
class AppError implements Exception {
  /// Creates an app error.
  AppError({required this.code, required this.title, required this.message, this.actions = const <ErrorAction>[], this.technicalDetails, this.metadata, DateTime? timestamp, this.fingerprint});
  /// Severity category.
  final AppErrorCode code;
  /// Short headline.
  final String title;
  /// User-facing message.
  final String message;
  /// Actions rendered by the UI.
  final List<ErrorAction> actions;
  /// Developer-only details; never rendered by default.
  final String? technicalDetails;
  /// Analytics metadata.
  final Map<String, Object?>? metadata;
  /// When the error was created.
  final DateTime timestamp;
  /// Stable identifier for deduplication.
  final String? fingerprint;
  /// Whether [technicalDetails] is present and non-blank.
  bool get hasTechnicalDetails;
  /// Whether [metadata] is non-empty.
  bool get hasMetadata;
  /// Whether [actions] is non-empty.
  bool get hasActions;
  /// Returns a copy with [newActions].
  AppError copyWithActions(List<ErrorAction> newActions);
  /// JSON form for analytics.
  Map<String, Object?> toJson();
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
