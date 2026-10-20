// The metrics of the `segmented_control` component.
//
// The painted track keeps the height the style asks for on every platform.
// On a touch platform the control's *box* grows to the platform tap
// minimum, so every segment stays a 48 px target; the growth is transparent
// space around the track and the painted track never changes.

import 'dart:math' as math;

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/platform.dart';
import '../../primitives/touch_hit_area.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'segmented_control_style.dart';

/// The sizes of one segmented control.
class SegmentedControlMetrics {
  /// Creates the metrics of a control.
  const SegmentedControlMetrics({
    required this.height,
    required this.iconSize,
    required this.gap,
    required this.padding,
    required this.trackHeight,
    required this.boxHeight,
    required this.margin,
  });

  /// The height the style asks the control to be.
  final double height;

  /// The size of a segment's icon.
  final double iconSize;

  /// The gap between two segments.
  final double gap;

  /// The padding between the track and the control's box.
  final EdgeInsets padding;

  /// The height of the painted track.
  final double trackHeight;

  /// The height of the control's box (the track plus the touch growth).
  final double boxHeight;

  /// The transparent space above and below the painted track.
  final double margin;
}

/// The measured widths of a segmented control's segments.
///
/// The thumb is placed from these widths, so they arrive after the layout.
/// [report] asks the owner for a new frame through [onChanged] so the thumb
/// can be placed.
class SegmentedControlWidths {
  /// Creates the measured widths of a control.
  SegmentedControlWidths({required this.onChanged});

  /// Called when a width changed and the control has to be rebuilt.
  final VoidCallback onChanged;

  final List<double> _widths = <double>[];
  bool _rebuildScheduled = false;

  /// How many segments have been measured.
  int get length => _widths.length;

  /// The measured width of every segment, in order.
  List<double> get values => _widths;

  /// The measured width of the segment at [index].
  double operator [](int index) => _widths[index];

  /// Reports the measured extent of the segment at [index].
  ///
  /// The extent arrives after the layout, in the post-frame phase, so the
  /// rebuild can be scheduled right away. Scheduling it here also asks for
  /// the frame that paints the thumb: without it a control that nothing
  /// else animates would never place its thumb.
  void report(int index, double extent) {
    if (index < _widths.length && (_widths[index] - extent).abs() < 0.5) {
      return;
    }
    while (_widths.length <= index) {
      _widths.add(0);
    }
    _widths[index] = extent;
    if (_rebuildScheduled) {
      return;
    }
    _rebuildScheduled = true;
    onChanged();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _rebuildScheduled = false;
    });
  }
}

/// Resolves the sizes of a segmented control.
///
/// [controlStyle] holds the control's own values and [segmentStyle] the
/// segment's; the size table fills the gaps the styles leave.
SegmentedControlMetrics segmentedControlMetrics({
  required BuildContext context,
  required SegmentedControlStyle controlStyle,
  required SegmentedControlStyle segmentStyle,
  required SegmentedControlSize size,
}) {
  final ThemeData ambient = Theme.of(context);
  final double height = controlStyle.height ?? segmentedControlHeightFor(size);
  final double iconSize =
      segmentStyle.iconSize ?? segmentedControlIconFor(size);
  final double gap = controlStyle.gap ?? 0;
  final EdgeInsets padding = resolveEdgeInsets(
    controlStyle.padding ?? EdgeInsets.zero,
    ambient.density.baseContentPadding * ambient.scaling,
  ).resolve(Directionality.of(context));

  final double trackHeight = math.max(height - padding.vertical, 0);
  final bool touch =
      isMobile(ambient.platform) &&
      ambient.touchTargets != TouchTargets.shrinkWrap;
  final double minTap = touch ? touchMinEdge(ambient.platform) : 0;
  final double boxHeight = math.max(trackHeight, minTap);

  return SegmentedControlMetrics(
    height: height,
    iconSize: iconSize,
    gap: gap,
    padding: padding,
    trackHeight: trackHeight,
    boxHeight: boxHeight,
    margin: (boxHeight - trackHeight) / 2,
  );
}
