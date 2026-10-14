---
title: "Class: InputLeadingFeature"
description: "Adds a widget before the editable text."
---

```dart
/// Adds a widget before the editable text.
class InputLeadingFeature extends InputFeature {
  /// Creates a leading feature.
  const InputLeadingFeature(this.prefix, {super.visibility});
  /// The widget shown before the editable text.
  final Widget prefix;
  Iterable<Widget> buildLeading(InputFeatureState state, BuildContext context);
}
```
