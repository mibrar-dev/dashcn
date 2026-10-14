---
title: "Enum: SliderVariant"
description: "Visual variants of the slider component."
---

```dart
/// Visual variants of the slider component.
///
/// Maps to the old presets: `standard` <- `brightness` (bar thumb, pill
/// track), `soft` <- `rangeSoft` (circle thumb, thicker track), `dots` <-
/// `stepsDots` (circle thumb, dot marks), `wave` <- `waveform` (circle
/// thumb, bar marks).
enum SliderVariant {
  /// Default filled pill with a bar thumb.
  standard,
  /// Thicker track with a circle thumb.
  soft,
  /// Circle thumb with per-step dots.
  dots,
  /// Circle thumb with an audio-wave bar overlay.
  wave,
}
```
