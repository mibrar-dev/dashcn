// Playground builder contract + theme-token resolver.
//
// A [PlaygroundBuilder] renders one component from [PlaygroundValues]; the
// code sample is generated generically by `code.dart`, so builders only map
// values to widgets. Components without a builder are absent from
// `kPlaygroundBuilders` and the page shows "Playground coming soon".

import 'package:flutter/widgets.dart';

import '../ui/dashcn/theme/color_tokens.dart';
import '../ui/dashcn/theme/theme.dart';
import 'values.dart';

/// Renders one component from playground values.
typedef PlaygroundBuilder =
    Widget Function(BuildContext context, PlaygroundValues values);

/// Resolves a playground token name to its themed colour.
///
/// Returns null for null (the component default applies).
Color? playgroundTokenColor(BuildContext context, String? token) {
  if (token == null) {
    return null;
  }
  final ThemeColors colors = Theme.of(context).colors;
  return switch (token) {
    'background' => colors.background,
    'foreground' => colors.foreground,
    'card' => colors.card,
    'cardForeground' => colors.cardForeground,
    'popover' => colors.popover,
    'popoverForeground' => colors.popoverForeground,
    'primary' => colors.primary,
    'primaryForeground' => colors.primaryForeground,
    'secondary' => colors.secondary,
    'secondaryForeground' => colors.secondaryForeground,
    'muted' => colors.muted,
    'mutedForeground' => colors.mutedForeground,
    'accent' => colors.accent,
    'accentForeground' => colors.accentForeground,
    'destructive' => colors.destructive,
    'destructiveForeground' => colors.destructiveForeground,
    'border' => colors.border,
    'input' => colors.input,
    'ring' => colors.ring,
    'chart1' => colors.chart1,
    'chart2' => colors.chart2,
    'chart3' => colors.chart3,
    'chart4' => colors.chart4,
    'chart5' => colors.chart5,
    'sidebar' => colors.sidebar,
    'sidebarForeground' => colors.sidebarForeground,
    'sidebarPrimary' => colors.sidebarPrimary,
    'sidebarPrimaryForeground' => colors.sidebarPrimaryForeground,
    'sidebarAccent' => colors.sidebarAccent,
    'sidebarAccentForeground' => colors.sidebarAccentForeground,
    'sidebarBorder' => colors.sidebarBorder,
    'sidebarRing' => colors.sidebarRing,
    _ => null,
  };
}
