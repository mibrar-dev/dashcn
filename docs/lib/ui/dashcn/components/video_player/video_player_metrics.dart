// Sizing metrics for `video_player` across density levels.
//
// Split from `video_player_style.dart` so both files stay small. The widget
// resolves one of these tables from the theme `themeDensity` leg
// (see `resolveVideoMetrics` in `video_player_style.dart`); null density
// keeps the default SPEC look (64px centre button, 16px icons).

import 'package:flutter/widgets.dart';

import '../../theme/density.dart';

/// Sizing metrics for `video_player` across density levels.
class VideoPlayerMetrics {
  /// Creates sizing metrics.
  const VideoPlayerMetrics({
    required this.controlSize,
    required this.iconSize,
    required this.controlsPadding,
    required this.trackHeight,
    required this.fontSize,
  });

  /// Centre play button diameter.
  final double controlSize;

  /// Icon size for bar controls.
  final double iconSize;

  /// Internal padding of the control bar.
  final EdgeInsetsGeometry controlsPadding;

  /// Scrub bar track height.
  final double trackHeight;

  /// Time and speed label font size.
  final double fontSize;

  /// Compact metrics (default look).
  static const VideoPlayerMetrics compact = VideoPlayerMetrics(
    controlSize: 64,
    iconSize: 16,
    controlsPadding: EdgeInsetsDensity.pxSymmetric(horizontal: 10, vertical: 6),
    trackHeight: 4,
    fontSize: 12,
  );

  /// Comfortable metrics.
  static const VideoPlayerMetrics comfortable = VideoPlayerMetrics(
    controlSize: 64,
    iconSize: 20,
    controlsPadding: EdgeInsetsDensity.pxSymmetric(horizontal: 12, vertical: 8),
    trackHeight: 4,
    fontSize: 13,
  );

  /// Touch metrics for phone screens.
  static const VideoPlayerMetrics touch = VideoPlayerMetrics(
    controlSize: 72,
    iconSize: 24,
    controlsPadding: EdgeInsetsDensity.pxSymmetric(
      horizontal: 16,
      vertical: 10,
    ),
    trackHeight: 6,
    fontSize: 14,
  );
}
