---
title: "Class: ErrorAction"
description: "A user action rendered by the error UI."
---

```dart
/// A user action rendered by the error UI.
class ErrorAction {
  /// Creates an error action.
  const ErrorAction({required this.label, required this.onPressed, this.primary = false, this.icon, this.type = ErrorActionType.custom});
  /// Retry the failed operation.
  factory ErrorAction.retry(VoidCallback onRetry, {ComponentLocalizations strings = ComponentLocalizations.english});
  /// Report the error.
  factory ErrorAction.report(VoidCallback onReport, {ComponentLocalizations strings = ComponentLocalizations.english});
  /// Navigate back.
  factory ErrorAction.back(VoidCallback onBack, {ComponentLocalizations strings = ComponentLocalizations.english});
  /// Log in again.
  factory ErrorAction.login(VoidCallback onLogin, {ComponentLocalizations strings = ComponentLocalizations.english});
  /// Open settings.
  factory ErrorAction.settings(VoidCallback onSettings, {ComponentLocalizations strings = ComponentLocalizations.english});
  /// Contact support.
  factory ErrorAction.contactSupport(VoidCallback onContact, {ComponentLocalizations strings = ComponentLocalizations.english});
  /// Dismiss the error.
  ///
  /// The label is [ComponentLocalizations.dialogDismiss] - Flutter's translated
  /// `modalBarrierDismissLabel` - because the two share the English string.
  factory ErrorAction.dismiss(VoidCallback onDismiss, {ComponentLocalizations strings = ComponentLocalizations.english});
  /// Button label.
  final String label;
  /// Called on press.
  final VoidCallback onPressed;
  /// Whether the action is the primary control.
  final bool primary;
  /// Optional leading icon.
  final IconData? icon;
  /// Semantic kind of the action.
  final ErrorActionType type;
}
```
