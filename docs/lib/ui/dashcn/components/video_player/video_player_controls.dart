// Control bar for `video_player`: header + scrub + buttons + more menu.
//
// SPEC: frosted bar inset ~16px, radius ~14. Top: title (white 14) and muted
// subtitle, elapsed/total right. Thin progress with dot thumb. Bottom row:
// play, back 10s, forward 10s left; volume, captions, fullscreen, more right.
// The more menu holds speeds (0.5x-3x), captions on/off and quality.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/surface.dart';
import '../../theme/theme.dart';
import 'video_player_buttons.dart';
import 'video_player_controller.dart';
import 'video_player_header.dart';
import 'video_player_menu.dart';
import 'video_player_scrub.dart';
import 'video_player_style.dart';
import 'video_player_volume.dart';

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
    this.title,
    this.subtitle,
    this.supportedSpeeds = kVideoSpeeds,
    this.showFullscreenButton = true,
    this.onFullscreenRequested,
    this.initialSpeedOpen = false,
    this.playButtonBuilder,
    this.progressBuilder,
    this.headerBuilder,
    this.timeLabelBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.moreBuilder,
    this.captionsButtonBuilder,
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

  /// Title shown in the bar header (white 14).
  final String? title;

  /// Subtitle shown under the title (muted).
  final String? subtitle;

  /// Speeds offered by the more menu.
  final List<double> supportedSpeeds;

  /// Whether the fullscreen button shows.
  final bool showFullscreenButton;

  /// Fullscreen callback.
  final VoidCallback? onFullscreenRequested;

  /// Whether the more menu starts open.
  final bool initialSpeedOpen;

  /// Builder slots (mirrors [VideoPlayer] slots).
  final VideoPartBuilder? playButtonBuilder;
  final Widget Function(
    BuildContext context,
    VideoPlaybackController controller,
    VideoScrubBar defaults,
  )?
  progressBuilder;
  final VideoPartBuilder? headerBuilder;
  final VideoPartBuilder? timeLabelBuilder;
  final VideoPartBuilder? volumeBuilder;
  final VideoPartBuilder? speedBuilder;
  final VideoPartBuilder? moreBuilder;
  final VideoPartBuilder? captionsButtonBuilder;
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
  late bool _menuOpen;

  @override
  void initState() {
    super.initState();
    _menuOpen = widget.initialSpeedOpen;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: surfaceColor(base, opacity),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          videoBarHeader(
            context: context,
            c: c,
            style: style,
            fg: widget.fg,
            total: _total,
            title: widget.title ?? c.sourceLabel,
            subtitle: widget.subtitle,
            headerBuilder: widget.headerBuilder,
            timeLabelBuilder: widget.timeLabelBuilder,
          ),
          const SizedBox(height: 2),
          _scrub(context, c),
          if (_menuOpen &&
              widget.moreBuilder == null &&
              widget.speedBuilder == null)
            videoMenuSection(
              c: c,
              style: style,
              fg: widget.fg,
              speeds: widget.supportedSpeeds,
              onDone: () => setState(() => _menuOpen = false),
            ),
          _buttons(context, c, compactVolume: compactVolume),
        ],
      ),
    );
    bar = GlassSurface(
      surfaceBlur: blur,
      borderRadius: BorderRadius.circular(14),
      child: bar,
    );
    final Widget defaults = AnimatedOpacity(
      opacity: 1,
      duration: widget.fade,
      child: bar,
    );
    return widget.controlsBuilder?.call(context, c, defaults) ?? defaults;
  }

  Duration _total(VideoPlaybackController c) {
    if (c.duration > Duration.zero) return c.duration;
    return const Duration(minutes: 3, seconds: 42);
  }

  Widget _scrub(BuildContext context, VideoPlaybackController c) {
    final colors = Theme.of(context).colors;
    final VideoScrubBar defaults = VideoScrubBar(
      position: c.position,
      duration: _total(c),
      buffered: c.buffered,
      enabled: !c.isLive,
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

  Widget _buttons(
    BuildContext context,
    VideoPlaybackController c, {
    required bool compactVolume,
  }) {
    final double iconSize = widget.style.iconSize ?? 16;
    // SPEC compact density: 32px targets under 380px bar width.
    final double target = compactVolume ? 32 : 48;
    return Row(
      children: <Widget>[
        videoPlayButton(
          context,
          widget.style,
          widget.fg,
          c,
          minTarget: target,
          overrideBuilder: widget.playButtonBuilder,
        ),
        videoIconButton(
          label: 'Back 10 seconds',
          icon: LucideIcons.skipBack,
          size: iconSize,
          fg: widget.fg,
          minTarget: target,
          onTap: () => c.seekBy(const Duration(seconds: -10)),
        ),
        videoIconButton(
          label: 'Forward 10 seconds',
          icon: LucideIcons.skipForward,
          size: iconSize,
          fg: widget.fg,
          minTarget: target,
          onTap: () => c.seekBy(const Duration(seconds: 10)),
        ),
        const Spacer(),
        if (widget.volumeBuilder != null)
          widget.volumeBuilder!(context, c)
        else
          videoVolumeCluster(
            context: context,
            c: c,
            style: widget.style,
            fg: widget.fg,
            compact: compactVolume,
            minTarget: target,
          ),
        if (widget.captionsButtonBuilder != null)
          widget.captionsButtonBuilder!(context, c)
        else
          videoIconButton(
            label: c.areCaptionsEnabled ? 'Hide captions' : 'Show captions',
            icon: c.areCaptionsEnabled
                ? LucideIcons.captions
                : LucideIcons.captionsOff,
            size: iconSize,
            fg: widget.fg,
            minTarget: target,
            onTap: c.toggleCaptions,
          ),
        if (widget.showFullscreenButton)
          widget.fullscreenButtonBuilder?.call(context, c) ??
              videoIconButton(
                label: 'Fullscreen',
                icon: LucideIcons.fullscreen,
                size: iconSize,
                fg: widget.fg,
                minTarget: target,
                onTap: widget.onFullscreenRequested,
              ),
        widget.moreBuilder?.call(context, c) ??
            (widget.speedBuilder?.call(context, c) ??
                videoMoreButton(
                  style: widget.style,
                  fg: widget.fg,
                  c: c,
                  minTarget: target,
                  onTap: () => setState(() => _menuOpen = !_menuOpen),
                )),
      ],
    );
  }

  /// Speed/captions menu section: wrapping speed chips, captions toggle and
  /// quality note (SPEC more-menu).
}
