// The component preview frame + stage (spec §2.4, P7-D1 polish, P7-D1b centring):
//
//  * The frame is `R:card` with `padding: 0`, `borderWidth: 1` and no shadow
//    — the registry card supports border-only, no-padding surfaces, so the
//    old plan's `D:PreviewFrame` is NOT needed (spec §6 open question 3).
//    P7-D1: the corner radius is `rounded-lg` (the upstream card radius).
//  * [PreviewStage] is the centered stage that hosts the deferred
//    `preview.dart` export (D4 wires the loader). P7-D1: responsive padding
//    (`p-10` desktop / `p-4` mobile), a configurable minimum height (350 px
//    for the main demo, 200 px for example cards) and a subtle dotted-grid
//    background drawn from the border token.
//    P7-D1b: the stage centres the example bounding box on both axes
//    (`Container(alignment: center)` + `ConstrainedBox` + `Align.center`);
//    the examples themselves are centred by design (button `Align.center`,
//    badge/calendar `Column(center)`, inputs/tables/alerts/cards with explicit
//    max widths, never stretched), so the Button demo no longer sits at the
//    left edge.
//  * P7-D2b (user feedback: "blurred, not grey"): the canvas is back to the
//    ORIGINAL surface — the page/background token, as before P7-D2. No tint.
//    The dot grid stays as the subtle frosted texture: blurred on its own
//    layer ([ImageFiltered] + [RepaintBoundary], never over the content),
//    drawn from the foreground token at 8% (light) / 10% (dark) with a
//    radial fade that keeps the centre calm. Components separate from the
//    canvas through their own border/shadow tokens.

import 'dart:math' as math;
import 'dart:ui' show ImageFilter, PointMode;

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/card/card.dart';
import '../ui/dashcn/theme/color_tokens.dart';
import '../ui/dashcn/theme/theme.dart';
import 'docs_tokens.dart';

/// The bordered, rounded preview card frame (640×~399 at 1440).
class PreviewFrame extends StatelessWidget {
  /// Creates the frame.
  const PreviewFrame({
    super.key,
    required this.child,
    this.clipBehavior = Clip.antiAlias,
  });

  /// Frame content (toolbar, stage and/or code teaser).
  final Widget child;

  /// Clip behaviour; defaults to clipping the rounded corners.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ThemedColor themedBorder = ThemedColor.value(theme.colors.border);
    final Color border = theme.colors.border;
    final BorderRadius radius = theme.borderRadiusLg;
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 48),
      child: Card(
        padding: EdgeInsets.zero,
        borderWidth: 1,
        borderColor: themedBorder,
        borderRadius: radius,
        shadows: const <BoxShadow>[],
        clipBehavior: clipBehavior,
        child: Stack(
          children: <Widget>[
            child,
            // Redrawn above the child: `Card` paints its border before the
            // content, and the full-bleed stage/teaser surfaces would cover
            // it — the reference's 1 px frame stays visible on every side.
            // The overlay is paint-only: `DecoratedBox.hitTestSelf` returns
            // true for its whole rect, so it must not take pointer events
            // (that would dead-zone the stage demos and the View Code pill).
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    border: Border.all(color: border),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The preview stage: a bounded, centered box with a dotted-grid background.
///
/// When [child] is null the stage renders empty (D4 loads the deferred
/// preview and passes it in).
class PreviewStage extends StatelessWidget {
  /// Creates a preview stage.
  const PreviewStage({
    super.key,
    this.child,
    this.chromeless = false,
    this.minHeight = DocsMetrics.previewStageHeight,
    this.pattern = true,
  });

  /// The preview widget (external previews should not paint their own page
  /// background; the stage supplies it).
  final Widget? child;

  /// Chromeless variant (spec §2.4): `h-auto`, `p-0` — no fixed stage box.
  final bool chromeless;

  /// Minimum stage height (P7-D1: 350 for the main demo, 200 for examples).
  final double minHeight;

  /// Whether the subtle dotted-grid background renders.
  final bool pattern;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (chromeless) {
      return child ?? const SizedBox.shrink();
    }
    // P6-F4: the stage hands the preview a *bounded* box. The old harness
    // put a horizontal `SingleChildScrollView` outside the width constraint,
    // so the preview saw unbounded width (and, through the `Column`, unbounded
    // height): every `SizedBox(width: double.infinity)` / `Expanded` /
    // `EditableText` preview threw or painted blank (audit D4/D5/D6). The new
    // examples shrink-wrap (no `Expanded`, no outer fixed box, no infinite
    // width), so the stage only needs a bounded width and a minimum height.
    // Wide leftovers overflow loudly instead of vanishing, which is what the
    // render audit asserts against.
    // P7-D1b: the stage centres the example box (`Align.center`); the examples
    // are centred by design (see the button/badge/calendar/input preview
    // fixes), so no `IntrinsicWidth` is needed here — intrinsics would query
    // every example's subtree and throw for any example containing a
    // `LayoutBuilder` (the all-pages sweep caught this).
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double viewport = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : DocsMetrics.articleWidth;
        final bool compact = viewport < 640;
        final double padding = compact ? 16 : 40;
        final double maxContent = viewport - padding * 2 > 0
            ? viewport - padding * 2
            : 0;
        // P7-D2b: the canvas is the page/background token again (as before
        // P7-D2; user feedback: blurred, not grey). No tint — components
        // separate from the canvas through their own border/shadow tokens.
        // The pattern lives on its own blurred layer *under* the content:
        // scrolling or animating the preview never re-runs the blur, and
        // the content itself is never filtered.
        final Color canvas = previewCanvasColor(theme.colors);
        final Color dot = previewDotColor(theme.colors);
        // Semantics container: unfamed previews (app, overlay_configuration,
        // page_route) own a nested `Navigator` whose routes insert a
        // `ModalBarrier` (`BlockSemantics`) each. Without a boundary here
        // that barrier would hide sibling page content (e.g. the docs
        // article title) from assistive tech. Framed previews are scoped
        // by `DeviceFrame` instead.
        return Semantics(
          container: true,
          explicitChildNodes: true,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: minHeight),
            color: canvas,
            // A `Stack` (not `CustomPaint(painter:, child:)`): the pattern
            // needs an `ImageFiltered` blur, which only works on a child box.
            // The content stays a *non-positioned* child so it keeps sizing
            // the stage (a `Stack` requires bounded constraints, which the
            // page scrollable does not provide); `alignment: center` re-centres
            // it horizontally because `RenderStack` loosens the width of
            // non-positioned children (P7-D1b centring would otherwise pin it
            // top-start). The pattern is `Positioned.fill` under it.
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                if (pattern)
                  Positioned.fill(
                    child: RepaintBoundary(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: kPreviewPatternBlur,
                          sigmaY: kPreviewPatternBlur,
                        ),
                        child: CustomPaint(
                          painter: PreviewDotGridPainter(color: dot),
                          // A static raster: cache it, never mark it dirty.
                          isComplex: true,
                          willChange: false,
                        ),
                      ),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(padding),
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContent),
                    child: Align(
                      alignment: Alignment.center,
                      child: child ?? const SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Blur radius of the preview dot-pattern layer (P7-D2).
///
/// Small on purpose: it softens the 1 px dots into a calm texture without
/// erasing them, and keeps the (cached) filter cost trivial.
const double kPreviewPatternBlur = 1.5;

/// Dot-grid spacing in logical pixels (unchanged from the pre-P7-D2 painter).
const double kPreviewDotStep = 20;

/// Dot radius in logical pixels (unchanged from the pre-P7-D2 painter).
const double kPreviewDotRadius = 1;

/// Canvas fill behind component previews (P7-D2b).
///
/// The page/background token — the ORIGINAL surface from before P7-D2.
/// P7-D2 had tinted this (muted nudged 8% toward foreground) so surfaces
/// would differ from their backdrop; user feedback ("blurred, not grey")
/// reverted it: no tint, components separate through their own
/// border/shadow tokens, and the blurred dot pattern supplies the texture.
Color previewCanvasColor(ThemeColors colors) => colors.background;

/// Edge-strength dot alpha (P7-D2): 8% of foreground in light, 10% in dark.
double previewDotAlpha(Brightness brightness) =>
    brightness == Brightness.dark ? 0.10 : 0.08;

/// Dot colour at full (edge) strength, derived from the foreground token.
///
/// Multiplies (never replaces) the token's own alpha, so alpha-bearing
/// foregrounds stay correct. Dots toward the centre paint fainter (radial
/// fade in [PreviewDotGridPainter]); this is the outer-edge strength the
/// widget tests assert.
Color previewDotColor(ThemeColors colors) => colors.foreground.withValues(
  alpha: colors.foreground.a * previewDotAlpha(colors.brightness),
);

/// Soft dotted grid drawn from the foreground token (P7-D2).
///
/// Public so widget tests can assert the dot alpha and the repaint contract.
/// Dots keep the old 20 px grid and 1 px radius, but paint through two
/// softeners: the stage blurs this whole layer ([kPreviewPatternBlur]), and
/// each dot's alpha is scaled by its distance from the centre
/// ([_kPatternCentreCalm] at the centre, full past 80% toward the corners),
/// so the component sits in a calm spot while the texture survives at the
/// edges. Dots batch into 8 alpha buckets drawn with [Canvas.drawPoints],
/// so a repaint is one loop plus 8 draw calls.
class PreviewDotGridPainter extends CustomPainter {
  /// Creates the painter.
  const PreviewDotGridPainter({
    required this.color,
    this.step = kPreviewDotStep,
    this.dotRadius = kPreviewDotRadius,
  });

  /// The dot colour at full (edge) strength (see [previewDotColor]).
  final Color color;

  /// Grid spacing in logical pixels.
  final double step;

  /// Dot radius in logical pixels.
  final double dotRadius;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }
    const int buckets = 8;
    final List<List<Offset>> layers = List<List<Offset>>.generate(
      buckets,
      (_) => <Offset>[],
    );
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double maxDist = math.sqrt(cx * cx + cy * cy);
    for (double y = step / 2; y < size.height; y += step) {
      for (double x = step / 2; x < size.width; x += step) {
        final double dx = x - cx;
        final double dy = y - cy;
        final double d = maxDist <= 0
            ? 1
            : math.sqrt(dx * dx + dy * dy) / maxDist;
        final double strength =
            _kPatternCentreCalm +
            (1 - _kPatternCentreCalm) * _smoothstep(0.1, 0.8, d);
        final int bucket = (strength * buckets).floor().clamp(0, buckets - 1);
        layers[bucket].add(Offset(x, y));
      }
    }
    for (int i = 0; i < buckets; i++) {
      final List<Offset> points = layers[i];
      if (points.isEmpty) {
        continue;
      }
      final double strength = (i + 0.5) / buckets;
      canvas.drawPoints(
        PointMode.points,
        points,
        Paint()
          ..color = color.withValues(alpha: color.a * strength)
          ..strokeWidth = dotRadius * 2
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant PreviewDotGridPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.step != step ||
      oldDelegate.dotRadius != dotRadius;
}

/// Dot strength at the exact centre (P7-D2): the pattern is present but calm
/// where the component sits, full strength toward the edges.
const double _kPatternCentreCalm = 0.15;

/// Hermite smoothstep between [e0] and [e1] (0 below, 1 above).
double _smoothstep(double e0, double e1, double x) {
  final double t = ((x - e0) / (e1 - e0)).clamp(0.0, 1.0);
  return t * t * (3 - 2 * t);
}
