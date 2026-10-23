// The painting helpers of the `segmented_control` component: the track and
// the sliding thumbs.
//
// They are plain functions so the widget file stays a widget file and the
// paint of the control can be read (and reused) on its own.

import 'package:flutter/widgets.dart';

import '../../primitives/motion/motion_scope.dart';
import '../../primitives/surface.dart';
import '../../theme/theme.dart';
import 'segmented_control_segment.dart';

/// Builds the track of a segmented control: the recessed surface the
/// segments sit in.
///
/// [padding] is the control's own padding; the track paints at the height
/// the caller gives and is centred in the control's box, so the touch growth
/// stays invisible.
Widget buildSegmentedControlTrack({
  required BuildContext context,
  required SegmentedControlStyle style,
  required double height,
  required BorderRadiusGeometry radius,
}) {
  final ThemeData ambient = Theme.of(context);
  final Color? fill = style.background?.resolve(ambient.colors);
  final Color? border = style.borderColor?.resolve(ambient.colors);
  final double borderWidth = style.borderWidth ?? 0;

  return GlassSurface(
    surfaceBlur: resolveSurfaceBlur(context, widget: style.surfaceBlur),
    borderRadius: radius,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: surfaceColor(
          fill ?? const Color(0x00000000),
          resolveSurfaceOpacity(context, widget: style.surfaceOpacity),
        ),
        borderRadius: radius,
        border: border == null || borderWidth <= 0
            ? null
            : Border.all(color: border, width: borderWidth),
        boxShadow: style.shadows == null || style.shadows!.isEmpty
            ? null
            : style.shadows,
      ),
      child: const SizedBox.expand(),
    ),
  );
}

/// Builds the layered body of a segmented control: the track, the sliding
/// thumbs and the row of segments.
///
/// The track is its own layer: it paints at the control's track height and
/// is centred in the control's box, so the touch growth stays invisible.
/// The segments and thumbs sit inside the track with the control padding as
/// the visible inset (28 px segments in a 36 px track).
Widget buildSegmentedControlStack<T>({
  required BuildContext context,
  required SegmentedControlStyle style,
  required Set<T> selection,
  required List<SegmentedControlSegment<T>> segments,
  required List<double> widths,
  required double margin,
  required EdgeInsets segmentPadding,
  required EdgeInsets linePadding,
  required double boxHeight,
  required bool rtl,
  required bool measured,
  required Widget track,
  required Widget line,
}) {
  return Stack(
    children: <Widget>[
      Positioned(top: margin, bottom: margin, left: 0, right: 0, child: track),
      ...buildSegmentedControlThumbs<T>(
        context: context,
        style: style,
        selection: selection,
        segments: segments,
        widths: widths,
        margin: margin,
        segmentPadding: segmentPadding,
        rtl: rtl,
        measured: measured,
      ),
      SizedBox(
        height: boxHeight,
        child: Padding(padding: linePadding, child: line),
      ),
    ],
  );
}

/// Builds the sliding thumbs of a segmented control: one per selected
/// segment.
///
/// [widths] holds the measured width of every segment; until all of them are
/// measured ([measured] is false) no thumb is drawn, so the thumb appears
/// straight on its segment instead of sliding in from the control's edge.
///
/// The row lays its segments out right-to-left in RTL, so the thumb is
/// measured from the right edge there and from the left edge in LTR.
List<Widget> buildSegmentedControlThumbs<T>({
  required BuildContext context,
  required SegmentedControlStyle style,
  required Set<T> selection,
  required List<SegmentedControlSegment<T>> segments,
  required List<double> widths,
  required double margin,
  required EdgeInsets segmentPadding,
  required bool rtl,
  required bool measured,
}) {
  if (!measured) {
    return const <Widget>[];
  }
  final ThemeData ambient = Theme.of(context);
  final Duration duration = resolveMotionDuration(
    context,
    ambient.motion.durations.fast,
  );
  final Curve curve = ambient.motion.curves.spring;
  final Color fill =
      style.thumbBackground?.resolve(ambient.colors) ??
      ambient.colors.background;
  final Color? border = style.thumbBorderColor?.resolve(ambient.colors);
  final double borderWidth = style.thumbBorderWidth ?? 0;
  final double gap = style.gap ?? 0;

  final List<Widget> thumbs = <Widget>[];
  double offset = 0;
  for (int i = 0; i < segments.length; i++) {
    final double width = i < widths.length ? widths[i] : 0;
    final bool selected = selection.contains(segments[i].value);
    if (selected) {
      final Widget thumb = DecoratedBox(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: style.borderRadius ?? ambient.borderRadiusMd,
          border: border == null || borderWidth <= 0
              ? null
              : Border.all(color: border, width: borderWidth),
        ),
      );
      // The thumb covers its segment exactly: the track padding stays
      // visible around it, like a tab pill inside its strip.
      final double thumbTop = margin + segmentPadding.top;
      final double thumbBottom = margin + segmentPadding.bottom;
      thumbs.add(
        AnimatedPositioned(
          duration: duration,
          curve: curve,
          left: rtl ? null : offset,
          right: rtl ? offset : null,
          width: width,
          top: thumbTop,
          bottom: thumbBottom,
          child: thumb,
        ),
      );
    }
    offset += width + gap;
  }
  return thumbs;
}
