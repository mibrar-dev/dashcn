---
title: "Class: KeyboardShortcutTheme"
description: "Styling of one key cap."
---

```dart
/// Styling of one key cap.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class KeyboardShortcutTheme extends ComponentThemeData implements Mergeable<KeyboardShortcutTheme> {
  /// Creates a keyboard-shortcut theme.
  const KeyboardShortcutTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.spacing, this.keyPadding, this.keyBackground, this.keyForeground, this.keyBorderRadius, this.keyTextStyle, this.keyShadows});
  /// Horizontal gap between two caps; null resolves
  /// [keyboardShortcutDefaultSpacing].
  final double? spacing;
  /// Padding inside one cap; null resolves
  /// [keyboardShortcutDefaultKeyPadding] (density-scaled).
  final EdgeInsetsGeometry? keyPadding;
  /// Fill of one cap; null resolves `background` at 70% alpha.
  final ThemedColor? keyBackground;
  /// Label colour of one cap; null resolves `mutedForeground`.
  final ThemedColor? keyForeground;
  /// Corner radius of one cap; null resolves the ambient `radiusMd`.
  final BorderRadiusGeometry? keyBorderRadius;
  /// Label text style; null resolves [keyboardShortcutDefaultTextStyle].
  final TextStyle? keyTextStyle;
  /// Shadows under one cap; null draws none (the upstream look).
  final List<BoxShadow>? keyShadows;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  KeyboardShortcutTheme merge(KeyboardShortcutTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
