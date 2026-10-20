// Layouts for `audio_player`: compact row and full card sections.
//
// Split from `audio_player.dart` so both files stay small.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'audio_player_controller.dart';
import 'audio_player_progress.dart';
import 'audio_player_style.dart';
import 'audio_player_transport.dart';

/// Compact row and full card body.
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
    this.skipBack = const Duration(seconds: 10),
    this.skipForward = const Duration(seconds: 10),
    this.supportedSpeeds = const <double>[0.5, 1, 1.5, 2],
    this.showVolume = true,
    this.showSpeed = true,
    this.coverBuilder,
    this.titleBuilder,
    this.subtitleBuilder,
    this.progressBuilder,
    this.waveformBuilder,
    this.controlsBuilder,
    this.playButtonBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.loadingBuilder,
  });

  /// Compact row or full card.
  final AudioPlayerVariant variant;

  /// Playback controller.
  final AudioPlaybackController controller;

  /// Resolved theme.
  final AudioPlayerTheme style;

  /// Foreground colour.
  final Color fg;

  /// Muted colour.
  final Color muted;

  /// Track title.
  final String? title;

  /// Track subtitle.
  final String? subtitle;

  /// Cover art.
  final Widget? cover;

  /// Skip steps.
  final Duration skipBack;
  final Duration skipForward;

  /// Speeds offered.
  final List<double> supportedSpeeds;

  /// Whether volume/speed show.
  final bool showVolume;
  final bool showSpeed;

  /// Builder slots.
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
  final AudioPartBuilder? volumeBuilder;
  final AudioPartBuilder? speedBuilder;
  final AudioPartBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return variant == AudioPlayerVariant.compact
        ? _compact(context)
        : _full(context);
  }

  Widget _compact(BuildContext context) {
    return Row(
      children: <Widget>[
        audioPlayButton(
          context,
          style,
          fg,
          controller,
          overrideBuilder: playButtonBuilder,
          loadingOverride: loadingBuilder,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_title(context), _progress(context)],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            formatAudioTime(controller.position),
            style: style.timeTextStyle ?? TextStyle(color: muted, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _full(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _cover(context),
        _title(context),
        _subtitle(context),
        _progress(context),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                formatAudioTime(controller.position),
                style:
                    style.timeTextStyle ??
                    TextStyle(color: muted, fontSize: 12),
              ),
              Text(
                formatAudioTime(controller.duration),
                style:
                    style.timeTextStyle ??
                    TextStyle(color: muted, fontSize: 12),
              ),
            ],
          ),
        ),
        AudioTransportRow(
          controller: controller,
          style: style,
          fg: fg,
          skipBack: skipBack,
          skipForward: skipForward,
          supportedSpeeds: supportedSpeeds,
          showVolume: showVolume,
          showSpeed: showSpeed,
          controlsBuilder: controlsBuilder,
          playButtonBuilder: playButtonBuilder,
          volumeBuilder: volumeBuilder,
          speedBuilder: speedBuilder,
          loadingBuilder: loadingBuilder,
        ),
      ],
    );
  }

  Widget _cover(BuildContext context) {
    if (coverBuilder != null) return coverBuilder!(context, controller);
    final ThemeColors colors = Theme.of(context).colors;
    final double size = style.coverSize ?? 176;
    final BorderRadiusGeometry radius =
        style.coverRadius ?? BorderRadius.circular(12);
    final Widget art =
        cover ??
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Icon(
            controller.isBuffering
                ? LucideIcons.loaderCircle
                : LucideIcons.audioLines,
            size: 48,
            color: fg,
          ),
        );
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: radius,
        child: ColoredBox(
          color: style.coverBackground?.resolve(colors) ?? colors.muted,
          child: SizedBox(width: size, height: size, child: art),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    if (titleBuilder != null) return titleBuilder!(context, controller);
    if (title == null) return const SizedBox.shrink();
    return Text(
      title!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style:
          style.titleTextStyle ??
          TextStyle(color: fg, fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  Widget _subtitle(BuildContext context) {
    if (subtitleBuilder != null) {
      return subtitleBuilder!(context, controller);
    }
    if (subtitle == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        subtitle!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style.subtitleTextStyle ?? TextStyle(color: muted, fontSize: 12),
      ),
    );
  }

  Widget _progress(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    final AudioProgressBar defaults = AudioProgressBar(
      position: controller.position,
      duration: controller.duration,
      buffered: controller.buffered,
      onSeek: controller.seekTo,
      trackColor: style.track?.resolve(colors) ?? colors.secondary,
      bufferedColor: style.buffered?.resolve(colors) ?? colors.muted,
      fillColor: style.accent?.resolve(colors) ?? colors.primary,
      thumbColor: style.thumb?.resolve(colors) ?? colors.primary,
      trackHeight: style.trackHeight ?? 4,
    );
    if (waveformBuilder != null) {
      return waveformBuilder!(context, controller, defaults);
    }
    return progressBuilder?.call(context, controller, defaults) ?? defaults;
  }
}
