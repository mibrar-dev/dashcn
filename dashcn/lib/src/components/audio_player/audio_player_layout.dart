// Layouts for `audio_player`: SPEC compact pill vs expanded card.
//
// Split from `audio_player.dart` so both files stay small. The two bodies
// share one [AudioPlaybackController] (playlist, speed, volume).

import 'package:flutter/widgets.dart';

import 'audio_player_compact.dart';
import 'audio_player_controller.dart';
import 'audio_player_expanded.dart';
import 'audio_player_progress.dart';
import 'audio_player_style.dart';
import 'audio_player_transport.dart';

export 'audio_player_compact.dart';
export 'audio_player_compact_parts.dart';
export 'audio_player_expanded.dart';
export 'audio_player_expanded_transport.dart';

/// Compact pill or expanded card body.
class AudioPlayerBody extends StatelessWidget {
  /// Creates a body.
  const AudioPlayerBody({
    super.key,
    required this.variant,
    required this.controller,
    required this.style,
    required this.fg,
    required this.muted,
    this.title,
    this.subtitle,
    this.cover,
    this.supportedSpeeds = kAudioSpeeds,
    this.showVolume = true,
    this.showSpeed = true,
    this.initialSpeedOpen = false,
    this.onDownload,
    this.coverBuilder,
    this.titleBuilder,
    this.subtitleBuilder,
    this.progressBuilder,
    this.waveformBuilder,
    this.controlsBuilder,
    this.playButtonBuilder,
    this.previousBuilder,
    this.nextBuilder,
    this.shuffleBuilder,
    this.repeatBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.downloadBuilder,
    this.loadingBuilder,
  });

  /// Compact pill or expanded card.
  final AudioPlayerVariant variant;

  /// Shared playback controller.
  final AudioPlaybackController controller;

  /// Resolved theme.
  final AudioPlayerTheme style;

  /// Primary text/icons.
  final Color fg;

  /// Secondary text.
  final Color muted;

  /// Fallback title / artist when the controller has no track.
  final String? title;

  /// Fallback artist when the controller has no track.
  final String? subtitle;

  /// Cover art shown by the expanded card.
  final Widget? cover;

  /// Speeds cycled by the compact chip.
  final List<double> supportedSpeeds;

  /// Whether the volume cluster shows.
  final bool showVolume;

  /// Whether the speed control shows.
  final bool showSpeed;

  /// Whether the expanded speed menu starts open.
  final bool initialSpeedOpen;

  /// Called when the compact download icon is tapped.
  final VoidCallback? onDownload;

  /// Builder slots for every visible part.
  final AudioPartBuilder? coverBuilder;
  final AudioPartBuilder? titleBuilder;
  final AudioPartBuilder? subtitleBuilder;
  final Widget Function(
    BuildContext context,
    AudioPlaybackController controller,
    AudioProgressBar defaults,
  )?
  progressBuilder;
  final Widget Function(
    BuildContext context,
    AudioPlaybackController controller,
    AudioProgressBar defaults,
  )?
  waveformBuilder;
  final AudioPartBuilder? controlsBuilder;
  final AudioPartBuilder? playButtonBuilder;
  final AudioPartBuilder? previousBuilder;
  final AudioPartBuilder? nextBuilder;
  final AudioPartBuilder? shuffleBuilder;
  final AudioPartBuilder? repeatBuilder;
  final AudioPartBuilder? volumeBuilder;
  final AudioPartBuilder? speedBuilder;
  final AudioPartBuilder? downloadBuilder;
  final AudioPartBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AudioPlayerVariant.compact:
        return AudioCompactPill(
          controller: controller,
          style: style,
          fg: fg,
          muted: muted,
          title: title,
          subtitle: subtitle,
          supportedSpeeds: supportedSpeeds,
          showVolume: showVolume,
          showSpeed: showSpeed,
          onDownload: onDownload,
          playButtonBuilder: playButtonBuilder,
          volumeBuilder: volumeBuilder,
          speedBuilder: speedBuilder,
          downloadBuilder: downloadBuilder,
        );
      case AudioPlayerVariant.full:
        return AudioExpandedCard(
          controller: controller,
          style: style,
          fg: fg,
          muted: muted,
          title: title,
          subtitle: subtitle,
          cover: cover,
          supportedSpeeds: supportedSpeeds,
          showSpeed: showSpeed,
          initialSpeedOpen: initialSpeedOpen,
          coverBuilder: coverBuilder,
          titleBuilder: titleBuilder,
          subtitleBuilder: subtitleBuilder,
          progressBuilder: progressBuilder,
          waveformBuilder: waveformBuilder,
          controlsBuilder: controlsBuilder,
          playButtonBuilder: playButtonBuilder,
          previousBuilder: previousBuilder,
          nextBuilder: nextBuilder,
          shuffleBuilder: shuffleBuilder,
          repeatBuilder: repeatBuilder,
          speedBuilder: speedBuilder,
          loadingBuilder: loadingBuilder,
        );
    }
  }
}
