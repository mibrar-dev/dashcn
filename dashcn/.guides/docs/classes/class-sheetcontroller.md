---
title: "Class: SheetController"
description: "Controls a [PinnedSheet]: reads position, drives it to a [SheetStage]."
---

```dart
/// Controls a [PinnedSheet]: reads position, drives it to a [SheetStage].
class SheetController extends ChangeNotifier {
  bool get isAttached;
  double get offset;
  double get fraction;
  bool get isOpen;
  SheetStage get stage;
  /// Animates to [stage] with the default duration/curve when assigned.
  set stage(SheetStage stage);
  Future<void> animateTo(SheetStage stage, {Duration duration = kDefaultDuration, Curve curve = Curves.linear});
  void jumpTo(SheetStage stage);
  Future<void> open({Duration duration = kDefaultDuration, Curve curve = Curves.easeOut});
  Future<void> close({Duration duration = kDefaultDuration, Curve curve = Curves.easeOut});
}
```
