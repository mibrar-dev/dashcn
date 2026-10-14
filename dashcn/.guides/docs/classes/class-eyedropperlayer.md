---
title: "Class: EyeDropperLayer"
description: "Wraps a subtree and enables sampling colours from it."
---

```dart
/// Wraps a subtree and enables sampling colours from it.
///
/// While a picking session is active the layer freezes a screenshot of the
/// subtree, follows the pointer with a magnified preview and completes the
/// session on tap (or cancels it with Escape).
class EyeDropperLayer extends StatefulWidget {
  /// Creates an eye-dropper layer.
  const EyeDropperLayer({super.key, required this.child, this.previewAlignment, this.showPreview, this.previewSize, this.previewScale, this.previewLabelBuilder, this.theme});
  /// The subtree that can be sampled.
  final Widget child;
  /// Pins the preview to this alignment; null makes it follow the pointer.
  final AlignmentGeometry? previewAlignment;
  /// Whether the magnified preview is shown. Default: theme value (true).
  final bool? showPreview;
  /// Preview size override. Default: theme value (100x100), scaled.
  final Size? previewSize;
  /// Magnification override. Default: theme value (8).
  final double? previewScale;
  /// Custom label under the preview; defaults to the hex value.
  final PreviewLabelBuilder? previewLabelBuilder;
  /// Widget-leg style override, merged on top of the component/app/defaults.
  final EyeDropperTheme? theme;
  State<EyeDropperLayer> createState();
}
```
