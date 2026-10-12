---
title: "Class: CommandTheme"
description: "Theme container for the command palette."
---

```dart
/// Theme container for the command palette.
class CommandTheme extends ComponentThemeData implements Mergeable<CommandTheme> {
  /// Creates a command theme.
  const CommandTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.foreground, this.mutedForeground, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.itemHighlight, this.itemHighlightForeground, this.itemPadding, this.shadows, this.maxWidth, this.maxHeight});
  /// Palette surface fill.
  final ThemedColor? background;
  /// Item title colour.
  final ThemedColor? foreground;
  /// Empty/loading/footer text colour.
  final ThemedColor? mutedForeground;
  /// Surface border colour; null draws no border.
  final ThemedColor? borderColor;
  /// Surface border width.
  final double? borderWidth;
  /// Surface corner radius; null falls back to `theme.borderRadiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Padding around the result list: the cmdk command surface's `p-1` (4)
  /// as density multipliers, resolved by `Command` against
  /// `density.baseContentPadding * scaling`.
  final EdgeInsetsGeometry? padding;
  /// Background of the item under SubFocus.
  final ThemedColor? itemHighlight;
  /// Text/icon colour while an item is highlighted.
  final ThemedColor? itemHighlightForeground;
  /// Padding inside one result row: upstream `px-2 py-1.5` (8/6) as density
  /// multipliers.
  ///
  /// `Command` never builds the rows — the app supplies them through
  /// `CommandBuilder` — so the row host resolves this before handing it to a
  /// `Clickable`.
  final EdgeInsetsGeometry? itemPadding;
  /// Surface shadows; empty draws none.
  final List<BoxShadow>? shadows;
  /// Dialog width used by `showCommandDialog` when no constraints are given.
  final double? maxWidth;
  /// Dialog height used by `showCommandDialog` when no constraints are given.
  final double? maxHeight;
  /// Returns a copy with the given fields replaced.
  CommandTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? foreground, ValueGetter<ThemedColor?>? mutedForeground, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<ThemedColor?>? itemHighlight, ValueGetter<ThemedColor?>? itemHighlightForeground, ValueGetter<EdgeInsetsGeometry?>? itemPadding, ValueGetter<List<BoxShadow>?>? shadows, ValueGetter<double?>? maxWidth, ValueGetter<double?>? maxHeight});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  CommandTheme merge(CommandTheme? fallback);
  /// Lerps scalar fields; token references and lists step at t < 0.5.
  static CommandTheme lerp(CommandTheme a, CommandTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
