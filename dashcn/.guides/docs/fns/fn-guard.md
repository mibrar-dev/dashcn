---
title: "Function: guard"
description: "Runs [fn], publishing any error to [scope] (or [channel])."
---

Signature
```dart
Future<T?> guard<T>(Future<T> Function() fn, {ErrorScope? scope, ValueNotifier<AppError?>? channel, bool clearBeforeRun = true, ErrorMapper? mapper, ComponentLocalizations strings = ComponentLocalizations.english});
```
