---
title: "Class: ButtonGroupData"
description: "Corner-radius multipliers for one button inside a [ButtonGroup]."
---

```dart
/// Corner-radius multipliers for one button inside a [ButtonGroup].
///
/// Start/end values are mapped to left/right by the ambient text direction in
/// [apply], so groups flip correctly under RTL.
class ButtonGroupData {
  /// Creates data with per-corner multipliers.
  const ButtonGroupData({required this.topStart, required this.topEnd, required this.bottomStart, required this.bottomEnd});
  /// Multiplies every corner by [value].
  const ButtonGroupData.all(double value);
  /// Multiplies the horizontal edges (start/end).
  const ButtonGroupData.horizontal({double start = 1, double end = 1});
  /// Multiplies the vertical edges (top/bottom).
  const ButtonGroupData.vertical({double top = 1, double bottom = 1});
  /// No modification: full radius on every corner.
  static const ButtonGroupData none = ButtonGroupData.all(1);
  /// Removes every corner: an inner button of a group.
  static const ButtonGroupData zero = ButtonGroupData.all(0);
  /// First button of a horizontal group: start radius kept, end flattened.
  static const ButtonGroupData horizontalStart = ButtonGroupData.horizontal(end: 0);
  /// Last button of a horizontal group: start flattened, end radius kept.
  static const ButtonGroupData horizontalEnd = ButtonGroupData.horizontal(start: 0);
  /// First button of a vertical group: top radius kept, bottom flattened.
  static const ButtonGroupData verticalTop = ButtonGroupData.vertical(bottom: 0);
  /// Last button of a vertical group: top flattened, bottom radius kept.
  static const ButtonGroupData verticalBottom = ButtonGroupData.vertical(top: 0);
  /// Outer top-start corner multiplier.
  final double topStart;
  /// Outer top-end corner multiplier.
  final double topEnd;
  /// Outer bottom-start corner multiplier.
  final double bottomStart;
  /// Outer bottom-end corner multiplier.
  final double bottomEnd;
  /// Data for the button at [index] of a horizontal group of [length].
  factory ButtonGroupData.horizontalIndex(int index, int length);
  /// Data for the button at [index] of a vertical group of [length].
  factory ButtonGroupData.verticalIndex(int index, int length);
  /// Scales [radius] by the corner multipliers for [direction].
  BorderRadius apply(BorderRadius radius, TextDirection direction);
  /// Multiplies this data with an enclosing group's data (nested groups).
  ButtonGroupData combine(ButtonGroupData other);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
