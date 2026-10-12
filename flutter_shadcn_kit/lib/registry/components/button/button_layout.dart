// Layout metrics and state-aware paint for the `button` component: the size
// table with density-scaled padding, the border-aware inner minima and the
// per-state paint pipeline feeding the `Clickable` interaction primitive.
//
// Moved out of `button.dart` so that file stays on the widget and the status
// wiring. Not independently installable; ships inside `button`.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'button_style.dart';

/// Size-table metrics with density-scaled padding.
class ButtonSizeMetrics {
  /// Creates size metrics.
  const ButtonSizeMetrics({
    required this.padding,
    required this.minHeight,
    this.minWidth = 0,
    this.textStyle,
  });

  /// Horizontal size-table padding (vertical padding is zero; see below).
  final EdgeInsetsGeometry padding;

  /// Border-box total height (shadcn h-7/h-8/h-9/h-10).
  final double minHeight;

  /// Border-box total width; 0 means no minimum (36 for icon buttons).
  final double minWidth;

  /// Label text style; null falls back to [buttonDefaultTextStyle].
  final TextStyle? textStyle;
}

/// Border-box helper: `metrics` minima are totals, but the `Clickable`
/// padding wraps the `ConstrainedBox`, so the inner minimum subtracts the
/// resolved padding (e.g. an icon button with 36px total and zero padding
/// keeps a 36px inner minimum; a themed vertical padding does not stack).
///
/// A painted border is `BoxDecoration` padding and adds layout too, so the
/// minimum reserves `max(padding, border)` per side; the Clickable padding is
/// inset by the border width in exchange (F1: outline md measured 38, not 36).
double buttonInnerMin(
  double total,
  EdgeInsets padding,
  double border,
  bool horizontal,
) {
  final double used = horizontal
      ? math.max(padding.left, border) + math.max(padding.right, border)
      : math.max(padding.top, border) + math.max(padding.bottom, border);
  return (total - used).clamp(0, double.infinity).toDouble();
}

/// Design §1.3 size table, corrected to shadcn/ui (new-york, default
/// density): heights are border-box totals (h-7/h-8/h-9/h-10 = 28/32/36/40),
/// horizontal padding is px-2/px-3/px-4/px-6 (8/12/16/24). Vertical padding
/// is zero: the `Clickable` padding wraps the `ConstrainedBox`, so any
/// vertical padding would stack on top of `minHeight` (52 instead of 36 for
/// md). Height comes from `minHeight` + centering; all sizes use 14px w500.
ButtonSizeMetrics buttonMetricsFor(ButtonSize size, Density density) {
  final double scale =
      density.baseContentPadding / Density.defaultDensity.baseContentPadding;
  EdgeInsetsGeometry pad(double horizontal) {
    return EdgeInsets.symmetric(horizontal: horizontal * scale);
  }

  const TextStyle text = buttonDefaultTextStyle;

  return switch (size) {
    ButtonSize.xs => ButtonSizeMetrics(
      padding: pad(8),
      minHeight: 28,
      textStyle: text,
    ),
    ButtonSize.sm => ButtonSizeMetrics(
      padding: pad(12),
      minHeight: 32,
      textStyle: text,
    ),
    ButtonSize.md => ButtonSizeMetrics(
      padding: pad(16),
      minHeight: 36,
      textStyle: text,
    ),
    ButtonSize.lg => ButtonSizeMetrics(
      padding: pad(24),
      minHeight: 40,
      textStyle: text,
    ),
    ButtonSize.icon => const ButtonSizeMetrics(
      padding: EdgeInsets.zero,
      minHeight: 36,
      minWidth: 36,
    ),
  };
}

/// State-aware paint resolved for one button build: surface, label and icon.
///
/// Constructed per build from the resolved variant slice; the `Clickable`
/// takes its bound resolvers directly.
class ButtonPaintScheme {
  /// Resolves paint from the ambient theme and the resolved slice.
  ButtonPaintScheme({
    required this.theme,
    required this.resolved,
    required this.metrics,
    required this.radius,
    required this.borderWidth,
    required this.hasBorder,
  });

  /// Ambient theme (tokens for every state lookup).
  final ShadcnThemeData theme;

  /// Resolved variant slice for the button's variant.
  final ButtonVariantStyle resolved;

  /// Size-table metrics for the button's size.
  final ButtonSizeMetrics metrics;

  /// Resolved corner radius (group-aware).
  final BorderRadius radius;

  /// Border width used when a border color resolves.
  final double borderWidth;

  /// Whether a border color is declared at all.
  final bool hasBorder;

  Color? _colorFor(StateValue<ThemedColor>? value, Set<WidgetState> states) {
    return value?.resolve(states)?.resolve(theme.colors);
  }

  /// Rest-state label color, for status icons that inherit the foreground.
  Color restForeground() {
    return _colorFor(resolved.foreground, const <WidgetState>{}) ??
        theme.colors.foreground;
  }

  /// Surface (and reserved border width) for [states].
  ///
  /// Disabled entries are never set: every value falls back to its rest
  /// colour and the whole control is dimmed once by the widget.
  Decoration? decorationFor(Set<WidgetState> states) {
    final Color? background = _colorFor(resolved.background, states);
    final Color? borderColor = _colorFor(resolved.borderColor, states);
    return BoxDecoration(
      color: background,
      // A declared border always occupies its width (transparent where a
      // state has no colour), so the control size never depends on state.
      border: hasBorder
          ? Border.all(
              color: borderColor ?? const Color(0x00000000),
              width: borderWidth,
            )
          : null,
      borderRadius: radius,
    );
  }

  /// Label style for [states].
  TextStyle? textStyleFor(Set<WidgetState> states) {
    final TextStyle? base = resolved.textStyle ?? metrics.textStyle;
    if (base == null) {
      return null;
    }
    return base.copyWith(
      color: _colorFor(resolved.foreground, states),
      decoration: resolved.decoration?.resolve(states),
    );
  }

  /// Icon theme for [states].
  IconThemeData? iconThemeFor(Set<WidgetState> states) {
    final Color? color = _colorFor(resolved.foreground, states);
    return color == null ? null : IconThemeData(color: color);
  }
}
