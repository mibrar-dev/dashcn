---
title: "Class: RadioGroupTheme"
description: "Group-level settings for a single-select group."
---

```dart
/// Group-level settings for a single-select group.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class RadioGroupTheme extends ComponentThemeData implements Mergeable<RadioGroupTheme> {
  /// Creates a radio group theme.
  const RadioGroupTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.direction, this.items, this.itemsGap, this.card});
  /// Arrow-key reading order; null falls back to the widget's [Axis.vertical].
  final Axis? direction;
  /// Row styling for this group's items.
  final SelectableRadioTheme? items;
  /// Space between two items; null resolves 12 (upstream `gap-3`).
  ///
  /// A upstream pixel value at the default density: the widget scales it with
  /// the ambient density and scaling, like every other spacing it derives.
  final double? itemsGap;
  /// Surface styling for this group's card items.
  final SelectableCardTheme? card;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  RadioGroupTheme merge(RadioGroupTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
