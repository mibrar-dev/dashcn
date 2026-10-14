---
title: "Class: AppErrorHub"
description: "Singleton bus of [AppError] channels."
---

```dart
/// Singleton bus of [AppError] channels.
///
/// Use [app] for global, cross-navigation errors and [screen] for per-screen
/// channels (dispose via [disposeScreen] or a screen-scope widget).
class AppErrorHub {
  /// The shared instance.
  static final AppErrorHub I;
  /// Channel key for a session that expired.
  static const String sessionExpired = 'app.sessionExpired';
  /// Channel key for maintenance mode.
  static const String maintenanceMode = 'app.maintenanceMode';
  /// Channel key for an unavailable network.
  static const String networkUnavailable = 'app.networkUnavailable';
  /// Channel key for a critical update.
  static const String criticalUpdate = 'app.criticalUpdate';
  /// Channel key for a denied permission.
  static const String permissionDenied = 'app.permissionDenied';
  /// A persistent app-level channel.
  ValueNotifier<AppError?> app(String key);
  /// Clears an app-level channel.
  void clearApp(String key);
  /// Clears every app-level channel.
  void clearAllApp();
  /// Whether any app-level channel currently holds an error.
  bool get hasAppError;
  /// Every non-null app-level error.
  List<AppError> get activeAppErrors;
  /// A screen-level channel; dispose it with [disposeScreen].
  ValueNotifier<AppError?> screen(String key);
  /// Clears a screen-level channel.
  void clearScreen(String key);
  /// Clears every screen-level channel.
  void clearAllScreens();
  /// Disposes a screen-level channel.
  void disposeScreen(String key);
  /// Disposes every screen-level channel.
  void disposeAllScreens();
}
```
