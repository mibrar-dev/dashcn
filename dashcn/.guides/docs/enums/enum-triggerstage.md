---
title: "Enum: TriggerStage"
description: "Lifecycle stages of a refresh trigger."
---

```dart
/// Lifecycle stages of a refresh trigger.
enum TriggerStage {
  /// Waiting for user interaction.
  idle,
  /// Pulling, but below the arming extent.
  pulling,
  /// The refresh callback is running.
  refreshing,
  /// The refresh finished; showing confirmation briefly.
  completed,
}
```
