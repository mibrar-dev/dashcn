---
title: "Class: SeparatedFlex"
description: "A [Flex] that inserts [separator] between every two [children]."
---

```dart
/// A [Flex] that inserts [separator] between every two [children].
class SeparatedFlex extends StatefulWidget {
  /// Main-axis alignment.
  final MainAxisAlignment mainAxisAlignment;
  /// Main-axis size.
  final MainAxisSize mainAxisSize;
  /// Cross-axis alignment.
  final CrossAxisAlignment crossAxisAlignment;
  /// Text direction passed to the [Flex].
  final TextDirection? textDirection;
  /// Vertical direction passed to the [Flex].
  final VerticalDirection verticalDirection;
  /// Text baseline passed to the [Flex].
  final TextBaseline? textBaseline;
  /// The children, without separators.
  final List<Widget> children;
  /// Flex direction.
  final Axis direction;
  /// Inserted between every two children.
  final Widget separator;
  /// Clip behavior passed to the [Flex].
  final Clip clipBehavior;
  /// Creates a [SeparatedFlex].
  const SeparatedFlex({super.key, required this.mainAxisAlignment, required this.mainAxisSize, required this.crossAxisAlignment, this.textDirection, required this.verticalDirection, this.textBaseline, required this.children, required this.separator, required this.direction, this.clipBehavior = Clip.none});
  State<SeparatedFlex> createState();
}
```
