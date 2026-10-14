---
title: "Class: InputFeatureCondition"
description: "A condition deciding whether an [InputFeature] is shown."
---

```dart
/// A condition deciding whether an [InputFeature] is shown.
abstract class InputFeatureCondition {
  /// Whether the feature should be visible for [state].
  bool canShow(InputFeatureState state);
  /// Logical AND with [other].
  InputFeatureCondition and(InputFeatureCondition other);
  /// Logical OR with [other].
  InputFeatureCondition or(InputFeatureCondition other);
  /// Logical NOT.
  InputFeatureCondition negate();
}
```
