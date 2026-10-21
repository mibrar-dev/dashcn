// Expanded card for `audio_player` (SPEC reference 2).
//
// Portrait card (~360px wide, radius 20): circular-cropped cover art as a
// big half-circle, equaliser glyph, uppercase artist, large centred title,
// full-width progress with centred mono times, and a 5-button transport row
// (shuffle, previous, 56px black play, next, repeat) wired to the playlist.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/density.dart';
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
    this.showSpeed = true,
    this.initialSpeedOpen = false,
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
    this.speedBuilder,
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

  /// Speeds offered by the speed menu.
  final List<double> supportedSpeeds;

  /// Whether the speed control shows.
  final bool showSpeed;

  /// Whether the expanded speed menu starts open.
  final bool initialSpeedOpen;

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
  final AudioPartBuilder? speedBuilder;
  final AudioPartBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    // Density-driven gaps: at the default density baseGap is 8, so these
    // match the SPEC 12/6/8 rhythm while scaling with the theme instead of
    // pinning larger fixed sizes that overflow the 720x420 docs stage.
    final ThemeData ambient = Theme.of(context);
    final double gap = ambient.density.baseGap * ambient.scaling;
    final double sectionGap = gap * gapMd;
    final double xsGap = gap * 0.75;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _cover(context, gap),
        SizedBox(height: sectionGap),
        _equaliser(context),
        SizedBox(height: sectionGap),
        _artist(context),
        SizedBox(height: xsGap),
        _title(context),
        SizedBox(height: sectionGap),
        _progress(context),
        SizedBox(height: gap * gapSm),
        _times(context),
        SizedBox(height: sectionGap),
        _transport(context),
      ],
    );
  }

  Widget _cover(BuildContext context, double gap) {
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
        // Density-derived half-circle window: gap * 19 is 152 at the default
        // density (8px base gap), 16 smaller than the fixed 168 that overflowed
        // the 720x420 stage by 11px once the 48px touch targets land. The
        // compact pill keeps its SPEC 48px height; only the expanded cover
        // shrinks, and it still scales with the theme density.
        final double coverHeight = gap * 19;
        return SizedBox(
          height: coverHeight,
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
    // Row + Expanded lets the line flex to the available width and truncate
    // instead of forcing the Column wider/taller on narrow stages.
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
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
          ),
        ),
      ],
    );
  }

  Widget _title(BuildContext context) {
    if (titleBuilder != null) return titleBuilder!(context, controller);
    // Same flex + truncate contract as the compact pill title: the Expanded
    // gives the Row's remaining width to the label and the ellipsis keeps a
    // long track name on one line instead of overflowing the card.
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            resolveAudioTitle(
              controller,
              title,
              ComponentLocalizations.of(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:
                style.titleTextStyle ??
                TextStyle(color: fg, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ],
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
    final Widget times = Text(
      '${formatAudioTime(c.position)} / ${formatAudioTime(c.duration)}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style:
          style.timeTextStyle ??
          TextStyle(
            color: muted,
            fontSize: 12,
            fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
          ),
    );
    if (!showSpeed && speedBuilder == null) return times;
    return Row(
      children: <Widget>[
        const SizedBox(width: 32),
        Expanded(child: times),
        speedBuilder?.call(context, c) ??
            AudioSpeedButton(
              controller: c,
              fg: fg,
              supportedSpeeds: supportedSpeeds,
              initialOpen: initialSpeedOpen,
            ),
      ],
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
