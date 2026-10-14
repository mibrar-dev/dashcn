---
title: "Class: ToastTheme"
description: "Visual and timing contract of a toast stack."
---

```dart
/// Visual and timing contract of a toast stack.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ToastTheme extends ComponentThemeData implements Mergeable<ToastTheme> {
  /// Creates a toast theme.
  const ToastTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.foreground, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.maxWidth, this.shadows, this.duration, this.animationDuration, this.pauseOnHover, this.showCloseButton, this.gap, this.offset});
  /// Surface fill. Default: the `popover` token.
  final ThemedColor? background;
  /// Content colour. Default: the `popoverForeground` token.
  final ThemedColor? foreground;
  /// Border colour; null draws no border. Default: the `border` token.
  final ThemedColor? borderColor;
  /// Border width; `0` hides the border. Default: `1`.
  final double? borderWidth;
  /// Corner radius; null resolves the ambient `radiusMd` at build.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding. Default: [toastDefaultPadding] (upstream `p-4`).
  final EdgeInsetsGeometry? padding;
  /// Maximum card width. Default: `380`.
  final double? maxWidth;
  /// Drop shadows; null resolves the ambient `shadowLg`, `const []` removes.
  final List<BoxShadow>? shadows;
  /// Default auto-dismiss duration. Default: `3s`.
  final Duration? duration;
  /// Entry animation duration. Default: `250ms`.
  final Duration? animationDuration;
  /// Whether hovering or pressing a toast pauses its countdown. Default: `true`.
  final bool? pauseOnHover;
  /// Whether each toast shows a close button. Default: `true`.
  final bool? showCloseButton;
  /// Gap between stacked toasts. Default: `8`.
  final double? gap;
  /// Screen-edge inset of the stack. Default: `EdgeInsets.all(24)`.
  final EdgeInsetsGeometry? offset;
  /// Returns a copy with the given fields replaced.
  ToastTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? foreground, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? maxWidth, ValueGetter<List<BoxShadow>?>? shadows, ValueGetter<Duration?>? duration, ValueGetter<Duration?>? animationDuration, ValueGetter<bool?>? pauseOnHover, ValueGetter<bool?>? showCloseButton, ValueGetter<double?>? gap, ValueGetter<EdgeInsetsGeometry?>? offset});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ToastTheme merge(ToastTheme? fallback);
  /// Colours, durations and flags step at `t < 0.5`; dimensions and shadows
  /// interpolate.
  static ToastTheme lerp(ToastTheme a, ToastTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
