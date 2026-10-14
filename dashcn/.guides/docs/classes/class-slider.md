---
title: "Class: Slider"
description: "A single-thumb slider."
---

```dart
/// A single-thumb slider.
///
/// Two controlled shapes:
/// * [Slider] (single value) — `value` + `onChanged`;
/// * [Slider.range] — `value` as [SliderValue] + `onRangeChanged`.
class Slider extends StatefulWidget {
  const Slider({super.key, required this.value, required this.onChanged, this.min = 0, this.max = 1, this.snap = const SliderSnap.none(), this.variant = SliderVariant.standard, this.enabled = true, this.theme, this.semanticLabel, this.focusNode, this.autofocus = false});
  /// Creates a two-thumb range slider.
  const Slider.range({super.key, required SliderValue value, required this.onRangeChanged, this.min = 0, this.max = 1, this.snap = const SliderSnap.none(), this.variant = SliderVariant.standard, this.enabled = true, this.minRange = 0, this.allowSwap = false, this.theme, this.semanticLabel, this.focusNode, this.autofocus = false});
  /// Current single value (single mode). Ignored in range mode.
  final double value;
  /// Called with the next value (single mode).
  final ValueChanged<double>? onChanged;
  /// Current range value (range mode). Null in single mode.
  final SliderValue? rangeValue;
  /// Called with the next range value (range mode).
  final ValueChanged<SliderValue>? onRangeChanged;
  /// Domain minimum.
  final double min;
  /// Domain maximum; must be greater than [min].
  final double max;
  /// Snapping applied to tap/drag/keyboard output.
  final SliderSnap snap;
  /// Visual variant (track/thumb/mark style).
  final SliderVariant variant;
  /// Whether the slider reacts to gestures and keys.
  final bool enabled;
  /// Minimum distance between the two range thumbs.
  final double minRange;
  /// Whether range thumbs may cross and swap roles while dragging.
  final bool allowSwap;
  /// Widget-leg theme override, merged under style/tree/app legs.
  final SliderStyle? theme;
  /// Accessibility label.
  final String? semanticLabel;
  /// Focus node; one is created internally when null.
  final FocusNode? focusNode;
  /// Whether to take focus when first built.
  final bool autofocus;
  /// Whether this slider is in range mode.
  bool get isRange;
  State<Slider> createState();
}
```
