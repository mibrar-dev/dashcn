---
title: "Class: ComponentPreview"
description: "One named docs example of a component."
---

```dart
/// One named docs example of a component.
class ComponentPreview {
  /// Creates an example.
  const ComponentPreview(this.name, this.builder, {this.description});
  /// Label shown in the docs `Select`.
  final String name;
  /// Builds the example; it receives the ambient theme through the context.
  final WidgetBuilder builder;
  /// Optional one-line explanation rendered under the example `Select`.
  final String? description;
}
```
