// Sizing metrics for `audio_player` across density levels.
//
// Split from `audio_player_style.dart` so both files stay small. The widget
// resolves one of these tables from the theme `themeDensity` leg
// (see `resolveAudioMetrics` in `audio_player_style.dart`); null density
// keeps the compact default look. SPEC fixes the hero sizes (56px expanded
// play button, ~280px half-circle cover, 20px title), so the tables drive
// icons, padding and track height only.

import 'package:flutter/widgets.dart';

import '../../theme/density.dart';

/// Sizing metrics for `audio_player` across density levels.
class AudioPlayerMetrics {
  /// Creates sizing metrics.
  const AudioPlayerMetrics({
    required this.playButtonSize,
    required this.smallButtonSize,
    required this.iconSize,
    required this.coverSize,
    required this.padding,
    required this.trackHeight,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.timeFontSize,
  });

  /// Play button diameter.
  final double playButtonSize;

  /// Secondary transport button diameter.
  final double smallButtonSize;

  /// Transport icon size.
  final double iconSize;

  /// Square cover art width/height.
  final double coverSize;

  /// Internal card padding.
  final EdgeInsetsGeometry padding;

  /// Scrub bar track height.
  final double trackHeight;

  /// Title font size.
  final double titleFontSize;

  /// Subtitle font size.
  final double subtitleFontSize;

  /// Time label font size.
  final double timeFontSize;

  /// Compact metrics (default look).
  static const AudioPlayerMetrics compact = AudioPlayerMetrics(
    playButtonSize: 32,
    smallButtonSize: 32,
    iconSize: 16,
    coverSize: 44,
    padding: EdgeInsetsDensity.pxAll(12),
    trackHeight: 4,
    titleFontSize: 13,
    subtitleFontSize: 12,
    timeFontSize: 11,
  );

  /// Comfortable metrics.
  static const AudioPlayerMetrics comfortable = AudioPlayerMetrics(
    playButtonSize: 40,
    smallButtonSize: 36,
    iconSize: 18,
    coverSize: 48,
    padding: EdgeInsetsDensity.pxAll(16),
    trackHeight: 4,
    titleFontSize: 14,
    subtitleFontSize: 13,
    timeFontSize: 12,
  );

  /// Touch metrics for phone screens.
  static const AudioPlayerMetrics touch = AudioPlayerMetrics(
    playButtonSize: 48,
    smallButtonSize: 44,
    iconSize: 20,
    coverSize: 56,
    padding: EdgeInsetsDensity.pxAll(16),
    trackHeight: 6,
    titleFontSize: 15,
    subtitleFontSize: 14,
    timeFontSize: 13,
  );
}
