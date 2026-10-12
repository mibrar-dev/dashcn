---
title: "Class: InputIconFeature"
description: "Base for features rendered as one small icon button."
---

```dart
/// Base for features rendered as one small icon button.
abstract class InputIconFeature extends InputFeature {
  /// Creates an icon feature at [position].
  const InputIconFeature({this.position = InputFeaturePosition.trailing, super.visibility, super.skipFocusTraversal});
  /// Where the button is placed.
  final InputFeaturePosition position;
  /// The button icon.
  Widget buildIcon(BuildContext context);
  /// Called when the button is pressed.
  void onPressed(InputFeatureState state, BuildContext context);
  /// The button widget; the password hold mode overrides this.
  Widget buildButton(InputFeatureState state, BuildContext context);
  Iterable<Widget> buildLeading(InputFeatureState state, BuildContext context);
  Iterable<Widget> buildTrailing(InputFeatureState state, BuildContext context);
}
```
