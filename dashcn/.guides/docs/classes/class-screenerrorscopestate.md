---
title: "Class: ScreenErrorScopeState"
description: "State of a [ScreenErrorScope]."
---

```dart
/// State of a [ScreenErrorScope].
class ScreenErrorScopeState extends State<ScreenErrorScope> {
  final HubScreenScope scope;
  /// The channel.
  ValueNotifier<AppError?> get notifier;
  /// Publishes [error].
  void set(AppError? error);
  /// Clears the channel.
  void clear();
  /// Runs [fn], publishing an [AppError] to this scope.
  Future<T?> run<T>(Future<T> Function() fn, {bool clearBeforeRun = true});
  /// The synchronous form of [run].
  T? runSync<T>(T Function() fn, {bool clearBeforeRun = true});
  void initState();
  void dispose();
  Widget build(BuildContext context);
}
```
