---
title: "Class: GooeyToastDetails"
description: "Snapshot of one active toast, newest first in  `GooeyToastController."
---

```dart
/// Snapshot of one active toast, newest first in
/// `GooeyToastController.activeToasts`.
class GooeyToastDetails {
  /// Creates a snapshot.
  const GooeyToastDetails({required this.id, required this.stateTag, required this.title, required this.description, required this.state, required this.position, required this.expandDirection, required this.duration, required this.persistUntilDismissed, required this.updatedAt});
  /// Unique toast id.
  final String id;
  /// State discriminator of the compact content.
  final Object? stateTag;
  /// Current compact title.
  final String title;
  /// Current expanded description.
  final String? description;
  /// Current semantic state.
  final GooeyToastState state;
  /// Horizontal anchor.
  final GooeyToastPosition position;
  /// Vertical growth direction.
  final GooeyToastExpandDirection expandDirection;
  /// Configured lifetime before dismiss.
  final Duration duration;
  /// Whether the toast waits for a manual dismiss.
  final bool persistUntilDismissed;
  /// Timestamp of the last update.
  final DateTime updatedAt;
}
```
