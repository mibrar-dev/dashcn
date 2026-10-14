---
title: "Class: ScaffoldTheme"
description: "Theme of the scaffold layout shell."
---

```dart
/// Theme of the scaffold layout shell.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget).
class ScaffoldTheme extends ComponentThemeData implements Mergeable<ScaffoldTheme> {
  /// Creates a scaffold theme.
  const ScaffoldTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.headerBackground, this.footerBackground, this.showLoadingSparks, this.resizeToAvoidBottomInset});
  /// Fill of the body area. Default: the `background` token.
  final ThemedColor? background;
  /// Fill behind the header bars. Default: transparent (bars paint their own).
  final ThemedColor? headerBackground;
  /// Fill behind the footer bars. Default: transparent.
  final ThemedColor? footerBackground;
  /// Whether the loading bar shows sparks by default. Default: false.
  final bool? showLoadingSparks;
  /// Whether the body pads for the on-screen keyboard. Default: true.
  final bool? resizeToAvoidBottomInset;
  /// Returns a copy with the given fields replaced.
  ScaffoldTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? headerBackground, ValueGetter<ThemedColor?>? footerBackground, ValueGetter<bool?>? showLoadingSparks, ValueGetter<bool?>? resizeToAvoidBottomInset});
  /// Receiver wins per field; [fallback] only fills null cells.
  ScaffoldTheme merge(ScaffoldTheme? fallback);
  /// Booleans and colors step at `t = 0.5`.
  static ScaffoldTheme lerp(ScaffoldTheme a, ScaffoldTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
