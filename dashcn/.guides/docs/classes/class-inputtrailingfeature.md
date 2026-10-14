---
title: "Class: InputTrailingFeature"
description: "Adds a widget after the editable text."
---

```dart
/// Adds a widget after the editable text.
class InputTrailingFeature extends InputFeature {
  /// Creates a trailing feature.
  const InputTrailingFeature(this.suffix, {super.visibility});
  /// The widget shown after the editable text.
  final Widget suffix;
  Iterable<Widget> buildTrailing(InputFeatureState state, BuildContext context);
}
```
