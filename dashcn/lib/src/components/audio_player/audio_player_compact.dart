// Compact pill for `audio_player` (SPEC reference 1).
//
// A single horizontal pill (~48px tall, radius 14, bottom-edge progress):
// play/pause (icon only), elapsed, total, truncated title, volume + slider,
// speed cycler, download. Hover/focus on the volume icon reveals the slider.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/tap_target.dart';
import '../../theme/theme.dart';
import 'audio_player_controller.dart';
import 'audio_player_compact_parts.dart';
import 'audio_player_playlist.dart';
import 'audio_player_style.dart';
import 'audio_player_transport.dart';

/// Compact pill body; the card wrapper lives in [AudioPlayer].
class AudioCompactPill extends StatelessWidget {
  /// Creates a compact pill.
  const AudioCompactPill({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    required this.muted,
    this.title,
    this.subtitle,
    this.supportedSpeeds = kAudioSpeeds,
    this.showVolume = true,
    this.showSpeed = true,
    this.onDownload,
    this.playButtonBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.downloadBuilder,
    this.progressBuilder,
  });

  /// Playback controller (shared with the expanded card).
  final AudioPlaybackController controller;

  /// Resolved theme.
  final AudioPlayerTheme style;

  /// Primary text/icons.
  final Color fg;

  /// Secondary text.
  final Color muted;

  /// Fallback title when the controller has no track.
  final String? title;

  /// Artist fallback (unused by the pill; kept for API parity).
  final String? subtitle;

  /// Speeds cycled by the number chip.
  final List<double> supportedSpeeds;

  /// Whether the volume cluster shows.
  final bool showVolume;

  /// Whether the speed chip shows.
  final bool showSpeed;

  /// Called when the download icon is tapped.
  final VoidCallback? onDownload;

  /// Builder slots for every visible part.
  final AudioPartBuilder? playButtonBuilder;
  final AudioPartBuilder? volumeBuilder;
  final AudioPartBuilder? speedBuilder;
  final AudioPartBuilder? downloadBuilder;

  /// Overrides the bottom-edge progress line.
  final Widget Function(
    BuildContext context,
    AudioPlaybackController controller,
    double fraction,
  )?
  progressBuilder;

  @override
  Widget build(BuildContext context) {
    final AudioPlaybackController c = controller;
    final String name = resolveAudioTitle(c, title);
    final double fraction = c.duration <= Duration.zero
        ? 0
        : (c.position.inMicroseconds / c.duration.inMicroseconds).clamp(
            0.0,
            1.0,
          );
    final ThemeData ambient = Theme.of(context);
    final Color fill =
        style.accent?.resolve(ambient.colors) ?? ambient.colors.primary;

    return SizedBox(
      height: 48,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              children: <Widget>[
                _iconPlay(context, c),
                Text(
                  formatAudioTime(c.position),
                  style: TextStyle(color: fg, fontSize: 12),
                ),
                const SizedBox(width: 4),
                Text(
                  formatAudioTime(c.duration),
                  style: TextStyle(color: muted, fontSize: 12),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: fg,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (showVolume)
                  volumeBuilder?.call(context, c) ??
                      AudioVolumeButton(controller: c, fg: fg),
                if (showSpeed)
                  speedBuilder?.call(context, c) ??
                      AudioSpeedChip(
                        controller: c,
                        fg: fg,
                        speeds: supportedSpeeds,
                      ),
                downloadBuilder?.call(context, c) ??
                    audioPillButton(
                      label: 'Download',
                      icon: LucideIcons.download,
                      fg: fg,
                      onTap: onDownload,
                    ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 0,
            height: 2,
            child:
                progressBuilder?.call(context, c, fraction) ??
                ExcludeSemantics(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    child: ColoredBox(
                      color: fg.withAlpha(0x24),
                      child: Align(
                        alignment:
                            Directionality.of(context) == TextDirection.rtl
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: fraction,
                          child: ColoredBox(color: fill),
                        ),
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _iconPlay(BuildContext context, AudioPlaybackController c) {
    if (playButtonBuilder != null) return playButtonBuilder!(context, c);
    return Semantics(
      label: c.isPlaying ? 'Pause' : 'Play',
      button: true,
      child: TapTarget(
        minWidth: 48,
        minHeight: 48,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: c.toggle,
          child: SizedBox(
            width: 32,
            height: 48,
            child: Icon(
              c.isPlaying ? LucideIcons.pause : LucideIcons.play,
              size: style.iconSize ?? 20,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}
