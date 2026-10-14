---
title: "Class: FormTheme"
description: "Label, hint, message and spacing choices for form layouts."
---

```dart
/// Label, hint, message and spacing choices for form layouts.
class FormTheme extends ComponentThemeData implements Mergeable<FormTheme> {
  /// Creates a form theme.
  const FormTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.spacing, this.messageSpacing, this.labelStyle, this.hintStyle, this.messageStyle, this.labelColor, this.hintColor, this.messageColor});
  /// Vertical gap between the label row and the control: upstream `gap-2` (8).
  final double? spacing;
  /// Vertical gap between the control and its hint or error text: upstream
  /// `gap-1.5` (6).
  final double? messageSpacing;
  /// Label text style; colour comes from [labelColor].
  final TextStyle? labelStyle;
  /// Hint text style; colour comes from [hintColor].
  final TextStyle? hintStyle;
  /// Error message style; colour comes from [messageColor].
  final TextStyle? messageStyle;
  /// Label colour; defaults to `foreground`.
  final ThemedColor? labelColor;
  /// Hint colour; defaults to `mutedForeground`.
  final ThemedColor? hintColor;
  /// Error message colour; defaults to `destructive`.
  final ThemedColor? messageColor;
  /// Returns a copy with the given fields replaced.
  FormTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<double?>? messageSpacing, ValueGetter<TextStyle?>? labelStyle, ValueGetter<TextStyle?>? hintStyle, ValueGetter<TextStyle?>? messageStyle, ValueGetter<ThemedColor?>? labelColor, ValueGetter<ThemedColor?>? hintColor, ValueGetter<ThemedColor?>? messageColor});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  FormTheme merge(FormTheme? fallback);
  /// Lerps scalars; styles and token references step at t < 0.5.
  static FormTheme lerp(FormTheme a, FormTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
