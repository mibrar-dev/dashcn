// Registry-owned theme data for the `code_snippet` component.
//
// User-owned overrides live in `code_snippet_theme.dart`; CLI updates may
// replace this file.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';

/// Theme of the code snippet container.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget).
class CodeSnippetTheme extends ComponentThemeData
    implements Mergeable<CodeSnippetTheme> {
  /// Creates a code snippet theme.
  const CodeSnippetTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.background,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.showCopyButton,
    this.copyIcon,
    this.copiedIcon,
    this.copyIconColor,
    this.copiedIconColor,
    this.actionSpacing,
    this.copyFeedbackDuration,
  });

  /// Container fill. Default: the `card` token.
  final ThemedColor? background;

  /// Border color. Default: the `border` token.
  final ThemedColor? borderColor;

  /// Border width, scaled. Default: 1.
  final double? borderWidth;

  /// Corner radius. Default: ambient `radiusLg`.
  final BorderRadiusGeometry? borderRadius;

  /// Inner padding. Default: one density step on start/top/bottom, 3.5 on
  /// the end (room for the top-right actions row).
  final EdgeInsetsGeometry? padding;

  /// Whether the copy button renders in the actions row. Default: true.
  final bool? showCopyButton;

  /// Idle copy icon. Default: [LucideIcons.copy].
  final IconData? copyIcon;

  /// Feedback icon shown after copying. Default: [LucideIcons.check].
  final IconData? copiedIcon;

  /// Idle copy icon color. Default: `mutedForeground`.
  final ThemedColor? copyIconColor;

  /// Copied feedback icon color. Default: `primary`.
  final ThemedColor? copiedIconColor;

  /// Gap between action buttons in logical pixels, unscaled. Default: 4.
  final double? actionSpacing;

  /// How long the copied feedback icon stays visible. Default: 1500 ms.
  final Duration? copyFeedbackDuration;

  /// Returns a copy with the given fields replaced.
  CodeSnippetTheme copyWith({
    ValueGetter<ThemedColor?>? background,
    ValueGetter<ThemedColor?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<bool?>? showCopyButton,
    ValueGetter<IconData?>? copyIcon,
    ValueGetter<IconData?>? copiedIcon,
    ValueGetter<ThemedColor?>? copyIconColor,
    ValueGetter<ThemedColor?>? copiedIconColor,
    ValueGetter<double?>? actionSpacing,
    ValueGetter<Duration?>? copyFeedbackDuration,
  }) {
    return CodeSnippetTheme(
      background: background == null ? this.background : background(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
      showCopyButton: showCopyButton == null
          ? this.showCopyButton
          : showCopyButton(),
      copyIcon: copyIcon == null ? this.copyIcon : copyIcon(),
      copiedIcon: copiedIcon == null ? this.copiedIcon : copiedIcon(),
      copyIconColor: copyIconColor == null
          ? this.copyIconColor
          : copyIconColor(),
      copiedIconColor: copiedIconColor == null
          ? this.copiedIconColor
          : copiedIconColor(),
      actionSpacing: actionSpacing == null
          ? this.actionSpacing
          : actionSpacing(),
      copyFeedbackDuration: copyFeedbackDuration == null
          ? this.copyFeedbackDuration
          : copyFeedbackDuration(),
    );
  }

  /// Receiver wins per field; [fallback] only fills null cells.
  @override
  CodeSnippetTheme merge(CodeSnippetTheme? fallback) {
    if (fallback == null) return this;
    return CodeSnippetTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      background: background ?? fallback.background,
      borderColor: borderColor ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      borderRadius: borderRadius ?? fallback.borderRadius,
      padding: padding ?? fallback.padding,
      showCopyButton: showCopyButton ?? fallback.showCopyButton,
      copyIcon: copyIcon ?? fallback.copyIcon,
      copiedIcon: copiedIcon ?? fallback.copiedIcon,
      copyIconColor: copyIconColor ?? fallback.copyIconColor,
      copiedIconColor: copiedIconColor ?? fallback.copiedIconColor,
      actionSpacing: actionSpacing ?? fallback.actionSpacing,
      copyFeedbackDuration:
          copyFeedbackDuration ?? fallback.copyFeedbackDuration,
    );
  }

  /// Scalars interpolate; the rest steps at `t = 0.5`.
  static CodeSnippetTheme lerp(
    CodeSnippetTheme a,
    CodeSnippetTheme b,
    double t,
  ) {
    double? scale(double? x, double? y) {
      if (x == null) return y;
      if (y == null) return x;
      return x + (y - x) * t;
    }

    return CodeSnippetTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      background: t < 0.5 ? a.background : b.background,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: scale(a.borderWidth, b.borderWidth),
      borderRadius: t < 0.5 ? a.borderRadius : b.borderRadius,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
      showCopyButton: t < 0.5 ? a.showCopyButton : b.showCopyButton,
      copyIcon: t < 0.5 ? a.copyIcon : b.copyIcon,
      copiedIcon: t < 0.5 ? a.copiedIcon : b.copiedIcon,
      copyIconColor: t < 0.5 ? a.copyIconColor : b.copyIconColor,
      copiedIconColor: t < 0.5 ? a.copiedIconColor : b.copiedIconColor,
      actionSpacing: scale(a.actionSpacing, b.actionSpacing),
      copyFeedbackDuration: t < 0.5
          ? a.copyFeedbackDuration
          : b.copyFeedbackDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CodeSnippetTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.background == background &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.showCopyButton == showCopyButton &&
        other.copyIcon == copyIcon &&
        other.copiedIcon == copiedIcon &&
        other.copyIconColor == copyIconColor &&
        other.copiedIconColor == copiedIconColor &&
        other.actionSpacing == actionSpacing &&
        other.copyFeedbackDuration == copyFeedbackDuration;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    background,
    borderColor,
    borderWidth,
    borderRadius,
    padding,
    showCopyButton,
    copyIcon,
    copiedIcon,
    copyIconColor,
    copiedIconColor,
    actionSpacing,
    copyFeedbackDuration,
  );
}

/// Built-in code snippet defaults.
const CodeSnippetTheme codeSnippetDefaults = CodeSnippetTheme(
  background: ThemedColor.ref(ColorRef.card),
  borderColor: ThemedColor.ref(ColorRef.border),
  borderWidth: 1,
  padding: DirectionalEdgeInsetsDensity.only(
    start: 1,
    top: 1,
    end: 3.5,
    bottom: 1,
  ),
  showCopyButton: true,
  copyIcon: LucideIcons.copy,
  copiedIcon: LucideIcons.check,
  copyIconColor: ThemedColor.ref(ColorRef.mutedForeground),
  copiedIconColor: ThemedColor.ref(ColorRef.primary),
  actionSpacing: 4,
  copyFeedbackDuration: Duration(milliseconds: 1500),
);
