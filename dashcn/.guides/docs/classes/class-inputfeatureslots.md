---
title: "Class: InputFeatureSlots"
description: "Per-feature mutable slots for one field."
---

```dart
/// Per-feature mutable slots for one field.
///
/// [sync] carries slots over to replacement feature instances at the same
/// index when [InputFeature.canUpdate] holds, and disposes the rest.
class InputFeatureSlots {
  /// The slot [feature] already owns, or null.
  Object? slotOf(InputFeature feature);
  /// The slot of [feature], created by [create] on first use.
  T slot<T extends Object>(InputFeature feature, T Function() create);
  /// Carries slots to the new feature instances and disposes removed ones.
  void sync({required InputFeatureState state, required List<InputFeature> oldFeatures, required List<InputFeature> newFeatures});
}
```
