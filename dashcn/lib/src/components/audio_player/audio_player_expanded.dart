// Expanded card for `audio_player` (SPEC reference 2).
//
// Portrait card (~360px wide, radius 20): circular-cropped cover art as a
// big half-circle, equaliser glyph, uppercase artist, large centred title,
// full-width progress with centred mono times, and a 5-button transport row
// (shuffle, previous, 56px black play, next, repeat) wired to the playlist.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import 'audio_player_controller.dart';
import 'audio_player_expanded_transport.dart';
import 'audio_player_playlist.dart';
import 'audio_player_progress.dart';
import 'audio_player_style.dart';
import 'audio_player_transport.dart';

/// Expanded portrait card body; the card wrapper lives in [AudioPlayer].
class AudioExpandedCard extends StatelessWidget {
  /// Creates an expanded card.
  const AudioExpandedCard({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    required this.muted,
    this.title,
    this.subtitle,
    this.cover,
    this.supportedSpeeds = kAudioSpeeds,
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
    this.loadingBuilder,
  });

  /// Playback controller (shared with the compact pill).
  final AudioPlaybackController controller;

  /// Resolved theme.
  final AudioPlayerTheme style;

  /// Primary text/icons.
  final Color fg;

  /// Secondary text.
  final Color muted;

  /// Fallback title when the controller has no track.
  final String? title;

  /// Fallback artist when the controller has no track.
  final String? subtitle;

  /// Cover art shown in the half-circle.
  final Widget? cover;

  /// Speeds offered by long-press cycling (kept for API parity).
  final List<double> supportedSpeeds;

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
  final AudioPartBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _cover(context),
        const SizedBox(height: 12),
        _equaliser(context),
        const SizedBox(height: 8),
        _artist(context),
        const SizedBox(height: 4),
        _title(context),
        const SizedBox(height: 12),
        _progress(context),
        const SizedBox(height: 6),
        _times(context),
        const SizedBox(height: 12),
        _transport(context),
      ],
    );
  }

  Widget _cover(BuildContext context) {
    if (coverBuilder != null) return coverBuilder!(context, controller);
    final Widget art =
        cover ??
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: const Icon(
            LucideIcons.music,
            size: 56,
            color: Color(0xFFFFFFFF),
          ),
        );
    return LayoutBuilder(
      builder: (context, constraints) {
        final double w = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 328;
        final double d = (w * 0.86).clamp(200.0, 300.0);
        return SizedBox(
          height: 168,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: (w - d) / 2,
                top: -(d - 160),
                child: ClipOval(
                  child: SizedBox(width: d, height: d, child: art),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _equaliser(BuildContext context) {
    final colors = Theme.of(context).colors;
    final AudioProgressBar defaults = AudioProgressBar(
      position: controller.position,
      duration: controller.duration,
      buffered: controller.buffered,
      onSeek: controller.seekTo,
      trackColor: style.track?.resolve(colors) ?? colors.secondary,
      bufferedColor: style.buffered?.resolve(colors) ?? colors.muted,
      fillColor: fg,
      thumbColor: fg,
      trackHeight: style.trackHeight ?? 4,
    );
    if (waveformBuilder != null) {
      return waveformBuilder!(context, controller, defaults);
    }
    return ExcludeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < 5; i++)
            Container(
              width: 3,
              height: 6 + (i % 3) * 5.0,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              decoration: BoxDecoration(
                color: muted,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
        ],
      ),
    );
  }

  Widget _artist(BuildContext context) {
    if (subtitleBuilder != null) return subtitleBuilder!(context, controller);
    final String? artist = resolveAudioArtist(controller, subtitle);
    if (artist == null) return const SizedBox.shrink();
    return Text(
      artist.toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style:
          style.subtitleTextStyle ??
          TextStyle(
            color: muted,
            fontSize: 11,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  Widget _title(BuildContext context) {
    if (titleBuilder != null) return titleBuilder!(context, controller);
    return Text(
      resolveAudioTitle(controller, title),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style:
          style.titleTextStyle ??
          TextStyle(color: fg, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  Widget _progress(BuildContext context) {
    final colors = Theme.of(context).colors;
    final AudioProgressBar defaults = AudioProgressBar(
      position: controller.position,
      duration: controller.duration,
      buffered: controller.buffered,
      onSeek: controller.seekTo,
      trackColor: style.track?.resolve(colors) ?? colors.secondary,
      bufferedColor: style.buffered?.resolve(colors) ?? colors.muted,
      fillColor: fg,
      thumbColor: fg,
      trackHeight: style.trackHeight ?? 4,
    );
    return progressBuilder?.call(context, controller, defaults) ?? defaults;
  }

  Widget _times(BuildContext context) {
    final AudioPlaybackController c = controller;
    return Text(
      '${formatAudioTime(c.position)} / ${formatAudioTime(c.duration)}',
      textAlign: TextAlign.center,
      style:
          style.timeTextStyle ??
          TextStyle(
            color: muted,
            fontSize: 12,
            fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
          ),
    );
  }

  Widget _transport(BuildContext context) {
    return AudioExpandedTransport(
      controller: controller,
      style: style,
      fg: fg,
      muted: muted,
      controlsBuilder: controlsBuilder,
      playButtonBuilder: playButtonBuilder,
      previousBuilder: previousBuilder,
      nextBuilder: nextBuilder,
      shuffleBuilder: shuffleBuilder,
      repeatBuilder: repeatBuilder,
      loadingBuilder: loadingBuilder,
    );
  }
}
