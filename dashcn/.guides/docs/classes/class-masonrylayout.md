---
title: "Class: MasonryLayout"
description: "A staggered grid: each child is placed in the shortest column."
---

```dart
/// A staggered grid: each child is placed in the shortest column.
///
/// ```dart
/// MasonryLayout.fixed(
///   crossAxisCount: 3,
///   mainAxisSpacing: 16,
///   crossAxisSpacing: 16,
///   children: <Widget>[cardA, cardB, cardC],
/// )
/// ```
///
/// [MasonryLayout.fixed] pins the column count; [MasonryLayout.responsive]
/// derives it from the incoming width with the same rule as
/// `SliverGridDelegateWithMaxCrossAxisExtent`.
class MasonryLayout extends MultiChildRenderObjectWidget {
  /// Creates a staggered grid with exactly [crossAxisCount] columns.
  const MasonryLayout.fixed({super.key, required super.children, required int crossAxisCount, this.mainAxisSpacing = 0, this.crossAxisSpacing = 0, this.textDirection});
  /// Creates a staggered grid whose column count follows the incoming width,
  /// targeting columns of at most [maxCrossAxisExtent] logical pixels.
  const MasonryLayout.responsive({super.key, required super.children, required double maxCrossAxisExtent, this.mainAxisSpacing = 0, this.crossAxisSpacing = 0, this.textDirection});
  /// Fixed column count; null in the [MasonryLayout.responsive] form.
  final int? crossAxisCount;
  /// Target column width; null in the [MasonryLayout.fixed] form.
  final double? maxCrossAxisExtent;
  /// Space kept between two children stacked in one column.
  final double mainAxisSpacing;
  /// Space kept between two neighbouring columns.
  final double crossAxisSpacing;
  /// Direction the columns run in; null resolves `Directionality.of(context)`.
  final TextDirection? textDirection;
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, MasonryLayoutRender renderObject);
}
```
