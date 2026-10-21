// Sizing, density and spacing foundation (DESIGN.md).
//
// Compact is the default everywhere: [DensityTokens.compact] is the
// [ThemeData.densityTokens] default, the per-instance default, and the
// fallback when no override is set.
//
// Three presets, one scale:
//   compact (default): control 32, icon 16, row 32-36, hPad 12, vPad 6-8,
//     gap 6-8, body 13-14.
//   comfortable: control 40, icon 20, row 40-44, hPad 12-14, gap 8-10,
//     body 14-15.
//   touch: control 48, icon 24, row 48-56 (WCAG 2.5.8 min 24; touch UX
//     44-48). Used on phone widths automatically (see [isPhoneWidth] and
//     [resolveDensityTokens]).
//
// Spacing scale: 4 px base (4, 8, 12, 16, 24, 32). No ad-hoc values.
// Icons: 16 compact, 20 comfortable, 24 touch; inside buttons never exceed
// 60% of the control height (see [buttonIconSize]).
// Overlays: min width 160 compact, max 320 compact (wider on larger
// densities).

import 'package:flutter/widgets.dart';

import 'theme.dart';

/// Phone-width breakpoint: below this width [resolveDensityTokens] returns
/// [DensityTokens.touch] unless the caller passes an explicit override.
const double kPhoneWidthBreakpoint = 600.0;

/// Whether [width] counts as a phone width (touch density applies).
bool isPhoneWidth(double width) => width < kPhoneWidthBreakpoint;

/// 4 px base spacing scale (DESIGN.md: 4, 8, 12, 16, 24, 32).
const double kSpace1 = 4.0;
const double kSpace2 = 8.0;
const double kSpace3 = 12.0;
const double kSpace4 = 16.0;
const double kSpace6 = 24.0;
const double kSpace8 = 32.0;

/// Ordered spacing scale steps.
const List<double> kSpacingScaleSteps = <double>[
  kSpace1,
  kSpace2,
  kSpace3,
  kSpace4,
  kSpace6,
  kSpace8,
];

/// Overlay width bounds per density (DESIGN.md § overlays).
const double kOverlayMinWidthCompact = 160.0;
const double kOverlayMaxWidthCompact = 320.0;

/// Density preset: compact (default), comfortable, touch.
enum DensityPreset { compact, comfortable, touch }

/// Per-density sizing tokens (DESIGN.md defaults).
///
/// Reachable from the theme ([ThemeData.densityTokens]) and per instance
/// (e.g. `Button(densityTokens: ...)`, `ListTile(densityTokens: ...)` and
/// the `themeDensityTokens` leg on component themes).
class DensityTokens {
  const DensityTokens({
    required this.preset,
    required this.controlHeight,
    required this.iconSize,
    required this.rowMinHeight,
    required this.rowMaxHeight,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.gap,
    required this.bodyTextSize,
    required this.subtitleTextSize,
    required this.overlayMinWidth,
    required this.overlayMaxWidth,
  });

  /// Compact default: control 32, icon 16, row 32-36.
  static const DensityTokens compact = DensityTokens(
    preset: DensityPreset.compact,
    controlHeight: 32.0,
    iconSize: 16.0,
    rowMinHeight: 32.0,
    rowMaxHeight: 36.0,
    horizontalPadding: 12.0,
    verticalPadding: 6.0,
    gap: 8.0,
    bodyTextSize: 14.0,
    subtitleTextSize: 13.0,
    overlayMinWidth: 160.0,
    overlayMaxWidth: 320.0,
  );

  /// Comfortable: control 40, icon 20, row 40-44.
  static const DensityTokens comfortable = DensityTokens(
    preset: DensityPreset.comfortable,
    controlHeight: 40.0,
    iconSize: 20.0,
    rowMinHeight: 40.0,
    rowMaxHeight: 44.0,
    horizontalPadding: 14.0,
    verticalPadding: 8.0,
    gap: 10.0,
    bodyTextSize: 15.0,
    subtitleTextSize: 14.0,
    overlayMinWidth: 180.0,
    overlayMaxWidth: 360.0,
  );

  /// Touch: control 48, icon 24, row 48-56.
  static const DensityTokens touch = DensityTokens(
    preset: DensityPreset.touch,
    controlHeight: 48.0,
    iconSize: 24.0,
    rowMinHeight: 48.0,
    rowMaxHeight: 56.0,
    horizontalPadding: 16.0,
    verticalPadding: 12.0,
    gap: 12.0,
    bodyTextSize: 16.0,
    subtitleTextSize: 15.0,
    overlayMinWidth: 200.0,
    overlayMaxWidth: 400.0,
  );

  /// Tokens for [preset].
  static DensityTokens fromPreset(DensityPreset preset) {
    return switch (preset) {
      DensityPreset.compact => compact,
      DensityPreset.comfortable => comfortable,
      DensityPreset.touch => touch,
    };
  }

  /// Which preset these tokens belong to.
  final DensityPreset preset;

  /// Default control height (button md, input, select trigger).
  final double controlHeight;

  /// Default icon size (16 / 20 / 24).
  final double iconSize;

  /// List-tile row height bounds.
  final double rowMinHeight;
  final double rowMaxHeight;

  /// Container/content padding (horizontal 10-12 compact, 12-14
  /// comfortable; vertical 6-8 compact).
  final double horizontalPadding;
  final double verticalPadding;

  /// Gap between siblings (6-8 compact, 8-10 comfortable).
  final double gap;

  /// Body text size (13-14 compact, 14-15 comfortable); subtitles are one
  /// step smaller.
  final double bodyTextSize;
  final double subtitleTextSize;

  /// Overlay width bounds (min 160 / max 320 compact).
  final double overlayMinWidth;
  final double overlayMaxWidth;

  DensityTokens copyWith({
    DensityPreset? preset,
    double? controlHeight,
    double? iconSize,
    double? rowMinHeight,
    double? rowMaxHeight,
    double? horizontalPadding,
    double? verticalPadding,
    double? gap,
    double? bodyTextSize,
    double? subtitleTextSize,
    double? overlayMinWidth,
    double? overlayMaxWidth,
  }) {
    return DensityTokens(
      preset: preset ?? this.preset,
      controlHeight: controlHeight ?? this.controlHeight,
      iconSize: iconSize ?? this.iconSize,
      rowMinHeight: rowMinHeight ?? this.rowMinHeight,
      rowMaxHeight: rowMaxHeight ?? this.rowMaxHeight,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      verticalPadding: verticalPadding ?? this.verticalPadding,
      gap: gap ?? this.gap,
      bodyTextSize: bodyTextSize ?? this.bodyTextSize,
      subtitleTextSize: subtitleTextSize ?? this.subtitleTextSize,
      overlayMinWidth: overlayMinWidth ?? this.overlayMinWidth,
      overlayMaxWidth: overlayMaxWidth ?? this.overlayMaxWidth,
    );
  }

  static DensityTokens lerp(DensityTokens a, DensityTokens b, double t) {
    double l(double x, double y) => x + (y - x) * t;
    return DensityTokens(
      preset: t < 0.5 ? a.preset : b.preset,
      controlHeight: l(a.controlHeight, b.controlHeight),
      iconSize: l(a.iconSize, b.iconSize),
      rowMinHeight: l(a.rowMinHeight, b.rowMinHeight),
      rowMaxHeight: l(a.rowMaxHeight, b.rowMaxHeight),
      horizontalPadding: l(a.horizontalPadding, b.horizontalPadding),
      verticalPadding: l(a.verticalPadding, b.verticalPadding),
      gap: l(a.gap, b.gap),
      bodyTextSize: l(a.bodyTextSize, b.bodyTextSize),
      subtitleTextSize: l(a.subtitleTextSize, b.subtitleTextSize),
      overlayMinWidth: l(a.overlayMinWidth, b.overlayMinWidth),
      overlayMaxWidth: l(a.overlayMaxWidth, b.overlayMaxWidth),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DensityTokens &&
          other.preset == preset &&
          other.controlHeight == controlHeight &&
          other.iconSize == iconSize &&
          other.rowMinHeight == rowMinHeight &&
          other.rowMaxHeight == rowMaxHeight &&
          other.horizontalPadding == horizontalPadding &&
          other.verticalPadding == verticalPadding &&
          other.gap == gap &&
          other.bodyTextSize == bodyTextSize &&
          other.subtitleTextSize == subtitleTextSize &&
          other.overlayMinWidth == overlayMinWidth &&
          other.overlayMaxWidth == overlayMaxWidth;

  @override
  int get hashCode => Object.hash(
    preset,
    controlHeight,
    iconSize,
    rowMinHeight,
    rowMaxHeight,
    horizontalPadding,
    verticalPadding,
    gap,
    bodyTextSize,
    subtitleTextSize,
    overlayMinWidth,
    overlayMaxWidth,
  );
}

/// Icon size driven by [tokens] (16 / 20 / 24).
double resolveIconSize(DensityTokens tokens) => tokens.iconSize;

/// Button icon size: never exceeds 60% of the control height (DESIGN.md).
double buttonIconSize(DensityTokens tokens) {
  final double capped = tokens.controlHeight * 0.6;
  return tokens.iconSize < capped ? tokens.iconSize : capped;
}

/// Effective tokens for [context]: [override] wins, otherwise phone widths
/// (< [kPhoneWidthBreakpoint]) use [DensityTokens.touch], otherwise the
/// ambient [ThemeData.densityTokens].
DensityTokens resolveDensityTokens(
  BuildContext context, {
  DensityTokens? override,
}) {
  if (override != null) return override;
  final ThemeData theme = Theme.of(context);
  double width = 0.0;
  try {
    width = MediaQuery.widthOf(context);
  } on FlutterError {
    // No MediaQuery in scope: fall through to the theme value.
  }
  // A zero/unset width (bare MediaQueryData in unit tests) is not a phone:
  // only a real narrow viewport opts into touch.
  if (width > 0 && isPhoneWidth(width)) return DensityTokens.touch;
  return theme.densityTokens;
}
