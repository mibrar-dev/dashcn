---
title: "Class: AlertDialogTheme"
description: "Typography and spacing of the alert dialog header and footer."
---

```dart
/// Typography and spacing of the alert dialog header and footer.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class AlertDialogTheme extends ComponentThemeData implements Mergeable<AlertDialogTheme> {
  /// Creates an alert dialog theme.
  const AlertDialogTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.iconColor, this.titleStyle, this.descriptionStyle, this.iconGap, this.headerGap, this.footerGap, this.actionGap, this.footerAlignment});
  /// Colour of the header icon. Default: the `mutedForeground` token.
  final ThemedColor? iconColor;
  /// Title text style; its colour falls back to the `foreground` token when
  /// the style carries none.
  final TextStyle? titleStyle;
  /// Description text style; its colour falls back to the `mutedForeground`
  /// token when the style carries none.
  final TextStyle? descriptionStyle;
  /// Space between the header icon and the title/description column.
  /// Default: 16.
  final double? iconGap;
  /// Space between the title and the description. Default: 8.
  final double? headerGap;
  /// Space between the header block and the footer action row. Default: 24.
  final double? footerGap;
  /// Space between the footer action buttons. Default: 8.
  final double? actionGap;
  /// Main-axis alignment of the footer action row. Default:
  /// [MainAxisAlignment.end].
  final MainAxisAlignment? footerAlignment;
  /// Returns a copy with the given fields replaced.
  AlertDialogTheme copyWith({ValueGetter<ThemedColor?>? iconColor, ValueGetter<TextStyle?>? titleStyle, ValueGetter<TextStyle?>? descriptionStyle, ValueGetter<double?>? iconGap, ValueGetter<double?>? headerGap, ValueGetter<double?>? footerGap, ValueGetter<double?>? actionGap, ValueGetter<MainAxisAlignment?>? footerAlignment});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  AlertDialogTheme merge(AlertDialogTheme? fallback);
  /// Colours step at `t = 0.5`; dimensions are lerped.
  static AlertDialogTheme lerp(AlertDialogTheme a, AlertDialogTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
