---
title: "Class: SelectTheme"
description: "Theme container for the select component."
---

```dart
/// Theme container for the select component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class SelectTheme extends ComponentThemeData implements Mergeable<SelectTheme> {
  /// Creates a select theme.
  const SelectTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.variant, this.trigger, this.popup, this.itemPadding, this.constraints});
  /// Button variant of the trigger. Default: [ButtonVariant.outline]
  /// (`filled: true` on the widget selects [ButtonVariant.secondary]).
  final ButtonVariant? variant;
  /// Per-state trigger rows merged over the variant's button style, so a
  /// theme can restyle colours without losing the trigger metrics.
  final ButtonVariantStyle? trigger;
  /// Surface override passed to the popup as its widget leg.
  final MenuPopupTheme? popup;
  /// Padding of one option row. Default: [selectDefaultItemPadding].
  final EdgeInsetsGeometry? itemPadding;
  /// Popup size constraints. Default: 192-320 wide and 240 high (the popup
  /// is always trigger-wide through the popover's anchor-fixed sizing).
  final BoxConstraints? constraints;
  /// Returns a copy with the given fields replaced.
  SelectTheme copyWith({ValueGetter<ButtonVariant?>? variant, ValueGetter<ButtonVariantStyle?>? trigger, ValueGetter<MenuPopupTheme?>? popup, ValueGetter<EdgeInsetsGeometry?>? itemPadding, ValueGetter<BoxConstraints?>? constraints});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SelectTheme merge(SelectTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
