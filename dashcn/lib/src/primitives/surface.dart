// The `surface` primitive: one shared frosted-glass surface for every
// floating/raised component (card, dialog, popover, menu, tooltip, toast,
// navigation bar, scaffold app bar, sheet/drawer, …).
//
// A surface's background colour gets [surfaceOpacity] alpha and, when
// [surfaceBlur] > 0, a [BackdropFilter] blur behind it (frosted glass),
// clipped to the surface's border radius. Null/1.0 opacity and null/0 blur
// is exactly today's opaque rendering: no colour change and no extra layer.
//
// Resolution order for both knobs (component value wins over global):
// widget override > component theme > ambient [ThemeData.surfaceOpacity] /
// [ThemeData.surfaceBlur] > opaque default (1.0 / 0).
//
// Widgets-only; no Material/Cupertino. Layer 2 (primitives): may import
// foundation/theme plus Flutter non-Material libraries only.

import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// Applies [opacity] to [base].
///
/// Returns [base] unchanged when [opacity] is null or >= 1.0 (the opaque
/// default: no visual change), transparent when <= 0.0, otherwise the base
/// colour with its alpha multiplied by [opacity].
Color surfaceColor(Color base, double? opacity) {
  if (opacity == null || opacity >= 1.0) return base;
  if (opacity <= 0.0) return base.withValues(alpha: 0.0);
  return base.withValues(alpha: (base.a * opacity).clamp(0.0, 1.0));
}

/// Resolves the effective surface opacity.
///
/// [widget] is the widget-leg override, [component] the component theme
/// value; either non-null wins over the ambient [ThemeData.surfaceOpacity].
/// Returns null when every leg is null (callers treat null as opaque via
/// [surfaceColor]).
double? resolveSurfaceOpacity(
  BuildContext context, {
  double? widget,
  double? component,
}) {
  if (widget != null) return widget;
  if (component != null) return component;
  return Theme.of(context).surfaceOpacity;
}

/// Resolves the effective surface blur sigma in logical pixels.
///
/// Same leg order as [resolveSurfaceOpacity]. Returns null when every leg
/// is null (callers treat null as no blur via [GlassSurface]).
double? resolveSurfaceBlur(
  BuildContext context, {
  double? widget,
  double? component,
}) {
  if (widget != null) return widget;
  if (component != null) return component;
  return Theme.of(context).surfaceBlur;
}

/// Whether [blur] draws a blur layer (> 0 only).
bool hasSurfaceBlur(double? blur) => blur != null && blur > 0;

/// A blur layer clipped to [borderRadius].
///
/// Returns [child] unchanged when [surfaceBlur] is null or <= 0, so the
/// default opaque rendering adds no extra layer. Otherwise wraps [child] in
/// `ClipRRect + BackdropFilter(ImageFilter.blur)` matching the surface's
/// border radius (frosted glass behind the already-translucent fill).
class GlassSurface extends StatelessWidget {
  /// Creates a glass blur layer around [child].
  const GlassSurface({
    super.key,
    required this.child,
    this.surfaceBlur,
    this.borderRadius,
  });

  /// The already-painted surface (its fill already carries [surfaceColor]).
  final Widget child;

  /// Backdrop blur sigma; null or <= 0 draws no blur layer.
  final double? surfaceBlur;

  /// Clip radius of the blur layer. Default: square corners.
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (!hasSurfaceBlur(surfaceBlur)) return child;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: surfaceBlur!, sigmaY: surfaceBlur!),
        child: child,
      ),
    );
  }
}

/// Backwards-compatible alias of [GlassSurface] kept for the
/// `outlined_container` component, which historically owned the blur
/// wrapper. New code should use [GlassSurface] directly.
typedef SurfaceBlur = GlassSurface;
