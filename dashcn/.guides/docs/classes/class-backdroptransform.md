---
title: "Class: BackdropTransform"
description: "Describes how the backdrop behind a sheet or drawer is transformed as it  animates between closed (`t == 0`) and fully open (`t == 1`)."
---

```dart
/// Describes how the backdrop behind a sheet or drawer is transformed as it
/// animates between closed (`t == 0`) and fully open (`t == 1`).
///
/// Implementations control the visual wrapping ([wrapBackdrop]) and how much
/// layout space the transform frees along each axis ([resolveExtraSize]); the
/// freed space is what lets a drawer slide into the gap the scaled backdrop
/// leaves behind.
abstract class BackdropTransform {
  /// Const constructor for subclasses.
  const BackdropTransform();
  /// A transform that does nothing: the backdrop is untouched and no extra
  /// layout space is produced. Used by sheets that do not scale the backdrop.
  static const BackdropTransform none = NoBackdropTransform();
  /// Wraps [child] (the backdrop content) for progress [t].
  ///
  /// [isRoot] is true for the bottom-most layer in a stack of sheets (the one
  /// wrapping the actual app content); root layers may additionally clip their
  /// corners as they scale in.
  Widget wrapBackdrop(BuildContext context, Widget child, double t, {bool isRoot = true});
  /// Space freed per axis by this transform for a backdrop of [size] at
  /// progress [t]. Returns [Size.zero] when nothing is freed.
  Size resolveExtraSize(Size size, double t, {bool isRoot = true});
}
```
