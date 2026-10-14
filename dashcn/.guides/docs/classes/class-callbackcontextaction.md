---
title: "Class: CallbackContextAction"
description: "An [Intent] action backed by a plain callback."
---

```dart
/// An [Intent] action backed by a plain callback.
class CallbackContextAction<T extends Intent> extends ContextAction<T> {
  /// The callback invoked by the action.
  final OnContextInvokeCallback onInvoke;
  CallbackContextAction({required this.onInvoke});
  Object? invoke(T intent, [BuildContext? context]);
}
```
