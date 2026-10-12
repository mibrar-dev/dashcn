---
title: "Class: ErrorSystemTheme"
description: "Appearance of the error UI."
---

```dart
/// Appearance of the error UI.
class ErrorSystemTheme extends ComponentThemeData implements Mergeable<ErrorSystemTheme> {
  /// Creates an error system theme.
  const ErrorSystemTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.iconColor, this.iconSize, this.titleStyle, this.messageStyle, this.cardPadding, this.bannerBackground, this.bannerBorder, this.bannerPadding});
  /// Icon tint; null resolves the `destructive` token.
  final ThemedColor? iconColor;
  /// Icon size; null resolves 36.
  final double? iconSize;
  /// Title text style; its colour falls back to `foreground`.
  final TextStyle? titleStyle;
  /// Message text style; its colour falls back to `mutedForeground`.
  final TextStyle? messageStyle;
  /// Padding inside the full-page card; null resolves
  /// [errorSystemDefaultCardPadding] (upstream `p-6`, density-scaled).
  final EdgeInsetsGeometry? cardPadding;
  /// Banner fill; null resolves the `card` token.
  final ThemedColor? bannerBackground;
  /// Banner border; null resolves the `destructive` token.
  final ThemedColor? bannerBorder;
  /// Banner padding; null resolves [errorSystemDefaultBannerPadding]
  /// (upstream `px-4 py-3`, density-scaled).
  final EdgeInsetsGeometry? bannerPadding;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ErrorSystemTheme merge(ErrorSystemTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
