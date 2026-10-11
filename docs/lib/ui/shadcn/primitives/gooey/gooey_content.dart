// Content pieces of a gooey surface: the compact pill, the expanded body, the
// state icon bubble and the inline action chip.
//
// All pieces are widgets-only and take resolved styles/colours, so the surface
// (which owns the animation) stays free of token lookups.

import 'package:flutter/rendering.dart' show RenderProxyBox;
import 'package:flutter/widgets.dart';

import '../../theme/density.dart';
import '../../theme/theme.dart';

/// Timing and choreography of the compact pill morph.
///
/// Changing a toast's title/state in place (the promise and multi-state flows)
/// cross-fades the outgoing compact frame out and the incoming one in instead
/// of snapping: the old label slides up while the new one rises from below, and
/// both scale from [scaleFrom] up to `1`.
@immutable
class GooeyCompactMorph {
  /// Creates a morph profile.
  const GooeyCompactMorph({
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeInOutCubicEmphasized,
    this.slideOffset = const Offset(0, 0.10),
    this.scaleFrom = 0.80,
  });

  /// Duration of the morph.
  final Duration duration;

  /// Curve of the morph.
  final Curve curve;

  /// Slide delta in normalized axis units; `dy` scales with the pill height.
  final Offset slideOffset;

  /// Starting scale of both frames.
  final double scaleFrom;
}

/// The outgoing compact frame while a morph runs.
///
/// [progress] is the eased morph position: `0` fully on the previous frame,
/// `1` settled on the current one. A progress of `1` (the default) means no
/// morph is running and only the current frame paints.
@immutable
class GooeyCompactMorphFrame {
  /// Creates a morph frame.
  const GooeyCompactMorphFrame({
    this.progress = 1,
    this.title,
    this.titleStyle,
    this.leading,
  });

  /// Eased morph position, `0..1`.
  final double progress;

  /// Outgoing compact title, or null when no morph runs.
  final String? title;

  /// Outgoing compact title style, tone already applied.
  final TextStyle? titleStyle;

  /// Outgoing leading widget (state icon).
  final Widget? leading;
}

/// Compact pill content: leading icon and title, cross-faded while morphing.
///
/// Morphing keeps both frames in one [Stack] so the pill never changes size:
/// the outgoing label slides out as the incoming one slides in.
class GooeySurfacePill extends StatelessWidget {
  /// Creates pill content.
  const GooeySurfacePill({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.width,
    required this.height,
    required this.morph,
    this.morphSlide = const Offset(0, 0.10),
    this.morphScaleFrom = 0.80,
    this.leading,
    this.expandUp = false,
    this.onTap,
  });

  /// Measures the pill width needed to fit [title] and a 24px leading icon.
  static double measureWidth({
    required String title,
    required TextStyle style,
    required TextDirection direction,
    required double pillHeight,
    required double maxWidth,
    double extra = 10,
  }) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: title, style: style),
      textDirection: direction,
      maxLines: 1,
    )..layout();
    const double iconWidth = 24;
    const double iconGap = 8;
    const double padding = 16;
    final double inner = iconWidth + iconGap + painter.width;
    return (inner + padding + extra).clamp(pillHeight, maxWidth).toDouble();
  }

  /// Compact label.
  final String title;

  /// Compact label style, tone already applied.
  final TextStyle titleStyle;

  /// Pill width.
  final double width;

  /// Pill height.
  final double height;

  /// Current morph frame.
  final GooeyCompactMorphFrame morph;

  /// Slide of both frames in normalized axis units; `dy` scales with [height].
  final Offset morphSlide;

  /// Starting scale of both frames.
  final double morphScaleFrom;

  /// Leading widget (state icon).
  final Widget? leading;

  /// Whether the body grows upwards, flipping the morph slide.
  final bool expandUp;

  /// Called when the pill is tapped; null keeps the pill static.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double gap = ShadcnTheme.of(context).density.baseGap;
    final GooeyCompactMorphFrame frame = morph;
    final double t = frame.progress.clamp(0.0, 1.0).toDouble();
    final bool morphing = t < 0.999 && frame.title != null;
    final double previousOpacity = morphing ? (1 - t).clamp(0.0, 1.0) : 0.0;
    final double currentOpacity = morphing ? t.clamp(0.0, 1.0) : 1.0;
    final Widget pill = MouseRegion(
      cursor: onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(8),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              if (morphing)
                _compactFrame(
                  opacity: previousOpacity,
                  slide: -morphSlide.dy,
                  scale:
                      morphScaleFrom + (1 - morphScaleFrom) * previousOpacity,
                  style: frame.titleStyle ?? titleStyle,
                  title: frame.title!,
                  leading: frame.leading,
                  gap: gap,
                ),
              _compactFrame(
                opacity: currentOpacity,
                slide: morphSlide.dy * (1 - t),
                scale: morphScaleFrom + (1 - morphScaleFrom) * currentOpacity,
                title: title,
                style: titleStyle,
                leading: leading,
                gap: gap,
              ),
            ],
          ),
        ),
      ),
    );
    return pill;
  }

  Widget _compactFrame({
    required double opacity,
    required double slide,
    required double scale,
    required String title,
    required TextStyle style,
    required Widget? leading,
    required double gap,
  }) {
    if (opacity <= 0.002) {
      return const SizedBox.shrink();
    }
    final double dy = slide * height;
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0).toDouble(),
      child: Transform.translate(
        offset: Offset(0, expandUp ? -dy : dy),
        child: Transform.scale(
          scale: scale.clamp(0.65, 1.15).toDouble(),
          child: Row(
            children: <Widget>[
              if (leading != null) ...<Widget>[leading, SizedBox(width: gap)],
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Expanded body content with a 16px inner padding, measured through
/// [GooeyMeasure] so the surface can size its silhouette.
class GooeySurfaceBody extends StatelessWidget {
  /// Creates body content.
  const GooeySurfaceBody({
    super.key,
    required this.width,
    required this.onSizeChanged,
    this.description,
    this.descriptionStyle,
    this.body,
    this.action,
  });

  /// Surface width.
  final double width;

  /// Called when the laid-out body size changes.
  final ValueChanged<Size> onSizeChanged;

  /// Body text; ignored when [body] is set.
  final String? description;

  /// Body text style.
  final TextStyle? descriptionStyle;

  /// Custom body replacing [description] and [action].
  final Widget? body;

  /// Action widget below the description.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData theme = ShadcnTheme.of(context);
    final Widget content =
        body ??
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (description != null)
              Text(description!, style: descriptionStyle),
            if (action != null)
              Padding(
                padding: EdgeInsets.only(top: theme.density.baseGap * 1.5),
                child: action,
              ),
          ],
        );
    return GooeyMeasure(
      onSizeChanged: onSizeChanged,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: resolveEdgeInsets(
            EdgeInsetsDensity.pxAll(16),
            theme.density.baseContentPadding * theme.scaling,
          ),
          child: content,
        ),
      ),
    );
  }
}

/// Reports its child's laid-out size after each layout pass.
class GooeyMeasure extends SingleChildRenderObjectWidget {
  /// Creates a measure widget.
  const GooeyMeasure({
    super.key,
    required this.onSizeChanged,
    required super.child,
  });

  /// Called with the new size when it changes between layout passes.
  final ValueChanged<Size> onSizeChanged;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _GooeyMeasureRender(onSizeChanged);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _GooeyMeasureRender).onSizeChanged = onSizeChanged;
  }
}

class _GooeyMeasureRender extends RenderProxyBox {
  _GooeyMeasureRender(this.onSizeChanged);

  ValueChanged<Size> onSizeChanged;
  Size? _lastSize;

  @override
  void performLayout() {
    super.performLayout();
    final Size next = child?.size ?? size;
    if (_lastSize == next) {
      return;
    }
    _lastSize = next;
    WidgetsBinding.instance.addPostFrameCallback((_) => onSizeChanged(next));
  }
}
