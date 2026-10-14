---
title: "Class: HSVColorSlider"
description: "Interactive slider for one or two HSV channels."
---

```dart
/// Interactive slider for one or two HSV channels.
class HSVColorSlider extends StatefulWidget {
  /// Creates an HSV slider.
  const HSVColorSlider({super.key, required this.color, required this.sliderType, this.onChanging, this.onChanged, this.reverse = false, this.radius = const Radius.circular(0), this.padding = EdgeInsets.zero, this.enabled = true, this.style, this.focusNode, this.autofocus = false});
  /// The current colour.
  final HSVColor color;
  /// Which channel(s) this slider drives.
  final HSVColorSliderType sliderType;
  /// Called while the value changes.
  final ValueChanged<HSVColor>? onChanging;
  /// Called when the interaction completes.
  final ValueChanged<HSVColor>? onChanged;
  /// Swaps the channel axes (and the cursor orientation).
  final bool reverse;
  /// Corner radius of the gradient.
  final Radius radius;
  /// Padding between gradient and cursor bar edge.
  final EdgeInsets padding;
  /// Whether gestures/keys are accepted.
  final bool enabled;
  /// Widget-leg style override.
  final HSVSliderStyle? style;
  /// Focus node; one is created internally when null and [autofocus].
  final FocusNode? focusNode;
  /// Request focus on first build.
  final bool autofocus;
  State<HSVColorSlider> createState();
}
```
