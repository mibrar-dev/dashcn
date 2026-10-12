---
title: "Class: HSLColorSlider"
description: "Interactive slider for one or two HSL channels."
---

```dart
/// Interactive slider for one or two HSL channels.
class HSLColorSlider extends StatefulWidget {
  /// Creates an HSL slider.
  const HSLColorSlider({super.key, required this.color, required this.sliderType, this.onChanging, this.onChanged, this.reverse = false, this.radius = const Radius.circular(0), this.padding = EdgeInsets.zero, this.enabled = true, this.style, this.focusNode, this.autofocus = false});
  /// The current colour.
  final HSLColor color;
  /// Which channel(s) this slider drives.
  final HSLColorSliderType sliderType;
  /// Called while the value changes.
  final ValueChanged<HSLColor>? onChanging;
  /// Called when the interaction completes.
  final ValueChanged<HSLColor>? onChanged;
  /// Swaps the channel axes (and the cursor orientation).
  final bool reverse;
  /// Corner radius of the gradient.
  final Radius radius;
  /// Padding between gradient and cursor bar edge.
  final EdgeInsets padding;
  /// Whether gestures/keys are accepted.
  final bool enabled;
  /// Widget-leg style override.
  final HSLSliderStyle? style;
  /// Focus node; one is created internally when null and [autofocus].
  final FocusNode? focusNode;
  /// Request focus on first build.
  final bool autofocus;
  State<HSLColorSlider> createState();
}
```
