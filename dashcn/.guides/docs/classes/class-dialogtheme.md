---
title: "Class: DialogTheme"
description: "Theme of the modal dialog shell."
---

```dart
/// Theme of the modal dialog shell.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills the
/// gap from the next leg (defaults < app < scoped < widget). `borderRadius` and
/// `shadows` stay null in [dialogDefaults] because their real defaults come
/// from the ambient token set (`radiusLg` and `shadowLg`) and are therefore
/// resolved at build, not in this const.
class DialogTheme extends ComponentThemeData implements Mergeable<DialogTheme> {
  const DialogTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.insetPadding, this.barrierColor, this.maxWidth, this.transitionDuration, this.shadows});
  /// Surface color of the dialog card. Default: the `card` token.
  final ThemedColor? background;
  /// Border color of the dialog card. Default: the `border` token.
  final ThemedColor? borderColor;
  /// Border width in logical pixels. Default: `1.0`; `0` hides the border.
  final double? borderWidth;
  /// Corner radius of the dialog card. Default: ambient `radiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Padding between the card border and its content (upstream `p-6`).
  /// Resolved against the density content padding when it is a density
  /// padding. Default: `padMd` x density content padding (24px at default
  /// density). Full-screen dialogs keep this padding.
  final EdgeInsetsGeometry? padding;
  /// Padding between the screen edge and the card. Resolved against the
  /// density content padding when it is a density padding. Default:
  /// `padSm` x density content padding (16px at default density); a
  /// full-screen dialog uses `EdgeInsets.zero`.
  final EdgeInsetsGeometry? insetPadding;
  /// Color of the modal barrier behind the dialog. Default: black at 50%.
  final ThemedColor? barrierColor;
  /// Maximum width of the dialog card. `null` means unconstrained.
  final double? maxWidth;
  /// Duration of the open and close transitions. Default: 150ms.
  final Duration? transitionDuration;
  /// Drop shadows of the dialog card. Default: the `shadowLg` entry of the
  /// ambient shadow scale; `const []` removes them.
  final List<BoxShadow>? shadows;
  DialogTheme copyWith({ValueGetter<Density?>? themeDensity, ValueGetter<SpacingScale?>? themeSpacing, ValueGetter<ShadowScale?>? themeShadows, ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<EdgeInsetsGeometry?>? insetPadding, ValueGetter<ThemedColor?>? barrierColor, ValueGetter<double?>? maxWidth, ValueGetter<Duration?>? transitionDuration, ValueGetter<List<BoxShadow>?>? shadows});
  /// Receiver wins per field; [fallback] only fills null cells.
  DialogTheme merge(DialogTheme? fallback);
  /// Colors, geometry and durations step at `t = 0.5`; shadows and scalars
  /// interpolate.
  static DialogTheme lerp(DialogTheme a, DialogTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
