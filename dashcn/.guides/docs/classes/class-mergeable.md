---
title: "Class: Mergeable"
description: "Merge contract for resolver slices."
---

```dart
/// Merge contract for resolver slices. The receiver is the higher-priority
/// leg and wins; [fallback] (the lower-priority leg) fills only null cells.
/// Constraining the resolver to this interface makes override-wins
/// structural instead of a caller-supplied lambda.
abstract class Mergeable<S> {
  /// Merges [fallback] under this value; this value's cells win.
  S merge(S? fallback);
}
```
