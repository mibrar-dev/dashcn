// Compact pill for `audio_player` (SPEC reference 1).
//
// A single horizontal pill (48px tall, radius 14, bottom-edge progress):
// play/pause (icon only), elapsed, total, truncated title, volume + slider,
// speed cycler, download. Hover/focus on the volume icon reveals the slider.
// The bottom-edge progress is a draggable seek line (tap/drag seeks, time
// labels update). Speed and volume keep 36 px visuals with 48 px touch
// targets. Card padding is the 12 px density token; the controls row uses
// 8 px gaps with times and title vertically centred.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/focus_tap.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'audio_player_controller.dart';
import '../../primitives/localizations/localizations.dart';
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
    final String name = resolveAudioTitle(
      c,
      title,
      ComponentLocalizations.of(context),
    );
    final double fraction = c.duration <= Duration.zero
        ? 0
        : (c.position.inMicroseconds / c.duration.inMicroseconds).clamp(
            0.0,
            1.0,
          );
    final ThemeData ambient = Theme.of(context);
    // Inactive track from the border token, active fill from the foreground
    // token: same pair as the expanded card and the video scrub bar so the
    // pill stays visible in both themes.
    final Color track =
        style.track?.resolve(ambient.colors) ?? ambient.colors.border;
    final Color fill = fg;
    // 8 px density gaps between controls; times and title share one
    // vertically centred row of 36 px controls in the 48 px pill.
    final double controlGap = ambient.density.baseGap * ambient.scaling * gapSm;

    return SizedBox(
      height: 48,
      child: Stack(
        children: <Widget>[
          Center(
            child: SizedBox(
              height: 36,
              child: Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _iconPlay(context, c),
                    Text(
                      formatAudioTime(c.position),
                      style: TextStyle(
                        color: fg,
                        fontSize: 12,
                        fontFeatures: const <FontFeature>[
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      formatAudioTime(c.duration),
                      style: TextStyle(
                        color: muted,
                        fontSize: 12,
                        fontFeatures: const <FontFeature>[
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                    SizedBox(width: controlGap),
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
                    SizedBox(width: controlGap),
                    if (showVolume)
                      volumeBuilder?.call(context, c) ??
                          AudioVolumeButton(controller: c, fg: fg),
                    if (showVolume && showSpeed) SizedBox(width: controlGap),
                    if (showSpeed)
                      speedBuilder?.call(context, c) ??
                          AudioSpeedChip(
                            controller: c,
                            fg: fg,
                            speeds: supportedSpeeds,
                          ),
                    SizedBox(width: controlGap),
                    downloadBuilder?.call(context, c) ??
                        audioPillButton(
                          label: ComponentLocalizations.of(
                            context,
                          ).mediaDownload,
                          icon: LucideIcons.download,
                          fg: fg,
                          onTap: onDownload,
                        ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 0,
            height: 12,
            child:
                progressBuilder?.call(context, c, fraction) ??
                _CompactSeekLine(
                  controller: c,
                  fraction: fraction,
                  track: track,
                  fill: fill,
                ),
          ),
        ],
      ),
    );
  }

  Widget _iconPlay(BuildContext context, AudioPlaybackController c) {
    if (playButtonBuilder != null) return playButtonBuilder!(context, c);
    return FocusableTap(
      label: c.isPlaying
          ? ComponentLocalizations.of(context).mediaPause
          : ComponentLocalizations.of(context).mediaPlay,
      onTap: c.toggle,
      minWidth: 36,
      minHeight: 36,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(
          c.isPlaying ? LucideIcons.pause : LucideIcons.play,
          size: style.iconSize ?? 16,
          color: fg,
        ),
      ),
    );
  }
}

/// Draggable bottom-edge seek line for the compact pill.
///
/// Tap jumps to the tapped position; horizontal drag seeks relative to the
/// line width (RTL-aware). The time labels above update through the shared
/// controller. The visual stays a 2 px line centred in a 12 px hit area so
/// the pill keeps its 48 px height.
class _CompactSeekLine extends StatelessWidget {
  const _CompactSeekLine({
    required this.controller,
    required this.fraction,
    required this.track,
    required this.fill,
  });

  final AudioPlaybackController controller;
  final double fraction;
  final Color track;
  final Color fill;

  void _seek(BuildContext context, Offset globalPosition, Size size) {
    final Duration duration = controller.duration;
    if (duration <= Duration.zero || size.width <= 0) return;
    final RenderBox box = context.findRenderObject()! as RenderBox;
    final double dx = box.globalToLocal(globalPosition).dx;
    final double w = size.width;
    if (w <= 0) return;
    double t = (dx / w).clamp(0.0, 1.0);
    if (Directionality.of(context) == TextDirection.rtl) t = 1 - t;
    controller.seekTo(
      Duration(microseconds: (t * duration.inMicroseconds).round()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: ComponentLocalizations.of(context).mediaSeek,
      slider: true,
      value: formatAudioTimeValuetextIn(
        context,
        controller.position,
        controller.duration,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final Size size = Size(constraints.maxWidth, 12);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) => _seek(context, d.globalPosition, size),
            onHorizontalDragUpdate: (d) =>
                _seek(context, d.globalPosition, size),
            child: SizedBox(
              height: 12,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1),
                  child: SizedBox(
                    height: 2,
                    child: ColoredBox(
                      color: track,
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
            ),
          );
        },
      ),
    );
  }
}
