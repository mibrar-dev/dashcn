// Control bar for `video_player`: scrub + buttons + volume + speed.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/surface.dart';
import '../../theme/theme.dart';
import 'video_player_buttons.dart';
import 'video_player_controller.dart';
import 'video_player_scrub.dart';
import 'video_player_style.dart';

export 'video_player_buttons.dart';

/// Floating control bar with frosted surface.
class VideoControlsBar extends StatefulWidget {
  /// Creates a control bar.
  const VideoControlsBar({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    required this.fade,
    this.supportedSpeeds = const <double>[0.5, 1, 1.5, 2],
    this.showFullscreenButton = true,
    this.onFullscreenRequested,
    this.playButtonBuilder,
    this.progressBuilder,
    this.timeLabelBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.fullscreenButtonBuilder,
    this.controlsBuilder,
  });

  /// Playback controller.
  final VideoPlaybackController controller;

  /// Resolved theme.
  final VideoPlayerTheme style;

  /// Foreground colour.
  final Color fg;

  /// Controls fade duration.
  final Duration fade;

  /// Speeds offered.
  final List<double> supportedSpeeds;

  /// Whether fullscreen shows.
  final bool showFullscreenButton;

  /// Fullscreen callback.
  final VoidCallback? onFullscreenRequested;

  /// Builder slots (mirrors [VideoPlayer] slots).
  final VideoPartBuilder? playButtonBuilder;
  final Widget Function(
    BuildContext context,
    VideoPlaybackController controller,
    VideoScrubBar defaults,
  )?
  progressBuilder;
  final VideoPartBuilder? timeLabelBuilder;
  final VideoPartBuilder? volumeBuilder;
  final VideoPartBuilder? speedBuilder;
  final VideoPartBuilder? fullscreenButtonBuilder;
  final Widget Function(
    BuildContext context,
    VideoPlaybackController controller,
    Widget defaults,
  )?
  controlsBuilder;

  @override
  State<VideoControlsBar> createState() => _VideoControlsBarState();
}

class _VideoControlsBarState extends State<VideoControlsBar> {
  bool _speedOpen = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Below ~380px the mute-only cluster keeps the row inside the bar.
        final bool narrow = constraints.maxWidth < 380;
        return _bar(context, compactVolume: narrow);
      },
    );
  }

  Widget _bar(BuildContext context, {required bool compactVolume}) {
    final ThemeData ambient = Theme.of(context);
    final VideoPlaybackController c = widget.controller;
    final VideoPlayerTheme style = widget.style;
    final Color base =
        style.scrim?.resolve(ambient.colors) ?? const Color(0x99000000);
    final double? opacity = resolveSurfaceOpacity(
      context,
      component: style.surfaceOpacity,
    );
    final double? blur = resolveSurfaceBlur(
      context,
      component: style.surfaceBlur,
    );
    Widget bar = Container(
      padding:
          style.controlsPadding ??
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: surfaceColor(base, opacity),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _scrub(context, c),
          Row(
            children: <Widget>[
              videoPlayButton(
                context,
                style,
                widget.fg,
                c,
                overrideBuilder: widget.playButtonBuilder,
              ),
              Flexible(child: _timeLabel(context, c)),
              if (widget.volumeBuilder != null)
                widget.volumeBuilder!(context, c)
              else
                _volumeCluster(context, c, compact: compactVolume),
              if (!compactVolume) const Spacer(),
              if (widget.speedBuilder != null)
                widget.speedBuilder!(context, c)
              else
                _speedMenu(context, c),
              if (widget.showFullscreenButton)
                widget.fullscreenButtonBuilder?.call(context, c) ??
                    videoIconButton(
                      label: 'Fullscreen',
                      icon: LucideIcons.fullscreen,
                      size: style.iconSize ?? 20,
                      fg: widget.fg,
                      onTap: widget.onFullscreenRequested,
                    ),
            ],
          ),
        ],
      ),
    );
    bar = GlassSurface(
      surfaceBlur: blur,
      borderRadius: BorderRadius.circular(12),
      child: bar,
    );
    final Widget defaults = AnimatedOpacity(
      opacity: 1,
      duration: widget.fade,
      child: bar,
    );
    return widget.controlsBuilder?.call(context, c, defaults) ?? defaults;
  }

  Widget _scrub(BuildContext context, VideoPlaybackController c) {
    final colors = Theme.of(context).colors;
    final VideoScrubBar defaults = VideoScrubBar(
      position: c.position,
      duration: c.duration <= Duration.zero
          ? const Duration(minutes: 3, seconds: 42)
          : c.duration,
      buffered: c.buffered,
      onSeek: c.seekTo,
      trackColor:
          widget.style.track?.resolve(colors) ?? const Color(0x59FFFFFF),
      bufferedColor:
          widget.style.buffered?.resolve(colors) ?? const Color(0x99FFFFFF),
      fillColor: widget.style.accent?.resolve(colors) ?? colors.primary,
      thumbColor:
          widget.style.thumb?.resolve(colors) ?? const Color(0xFFFFFFFF),
      trackHeight: widget.style.trackHeight ?? 4,
    );
    return widget.progressBuilder?.call(context, c, defaults) ?? defaults;
  }

  Widget _timeLabel(BuildContext context, VideoPlaybackController c) {
    if (widget.timeLabelBuilder != null) {
      return widget.timeLabelBuilder!(context, c);
    }
    final Duration total = c.duration <= Duration.zero
        ? const Duration(minutes: 3, seconds: 42)
        : c.duration;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '${formatMediaTime(c.position)} / ${formatMediaTime(total)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            widget.style.timeTextStyle ??
            TextStyle(color: widget.fg, fontSize: 12),
      ),
    );
  }

  Widget _volumeCluster(
    BuildContext context,
    VideoPlaybackController c, {
    bool compact = false,
  }) {
    final Widget mute = videoIconButton(
      label: c.isMuted ? 'Unmute' : 'Mute',
      icon: c.isMuted ? LucideIcons.volumeOff : LucideIcons.volume2,
      size: widget.style.iconSize ?? 20,
      fg: widget.fg,
      onTap: () => c.setMuted(!c.isMuted),
    );
    if (compact) return mute;
    final double level = c.isMuted ? 0 : c.volume;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        mute,
        Semantics(
          label: 'Volume',
          slider: true,
          value: '${(level * 100).round()}%',
          increasedValue: '${(((level + 0.1).clamp(0.0, 1.0)) * 100).round()}%',
          decreasedValue: '${(((level - 0.1).clamp(0.0, 1.0)) * 100).round()}%',
          onIncrease: () => c.setVolume(level + 0.1),
          onDecrease: () => c.setVolume(level - 0.1),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) => c.setVolume(0.5),
            child: SizedBox(
              width: 72,
              height: 48,
              child: CustomPaint(
                painter: VolumePainter(
                  value: level,
                  fill: widget.fg,
                  rtl: Directionality.of(context) == TextDirection.rtl,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _speedMenu(BuildContext context, VideoPlaybackController c) {
    final List<double> speeds = widget.supportedSpeeds.isEmpty
        ? const <double>[1]
        : widget.supportedSpeeds;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_speedOpen)
          Container(
            decoration: BoxDecoration(
              color: const Color(0xCC000000),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final double s in speeds)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      c.setPlaybackSpeed(s);
                      setState(() => _speedOpen = false);
                    },
                    child: Semantics(
                      label: 'Speed ${s}x',
                      button: true,
                      child: Container(
                        width: 72,
                        height: 44,
                        alignment: Alignment.center,
                        child: ExcludeSemantics(
                          child: Text(
                            '${s}x',
                            style: TextStyle(
                              color: widget.fg,
                              fontSize: 12,
                              fontWeight: c.playbackSpeed == s
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        videoIconButton(
          label: 'Playback speed ${c.playbackSpeed}x',
          icon: LucideIcons.settings,
          size: widget.style.iconSize ?? 20,
          fg: widget.fg,
          text: '${c.playbackSpeed}x',
          onTap: () => setState(() => _speedOpen = !_speedOpen),
        ),
      ],
    );
  }
}
