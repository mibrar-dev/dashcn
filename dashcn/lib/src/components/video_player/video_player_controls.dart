// Control bar for `video_player`: header + scrub + buttons + more menu.
//
// SPEC: frosted bar with 12 px padding: title (white 14) and muted
// subtitle, elapsed/total right aligned to the title baseline. Thin progress
// with dot thumb. Bottom row: play, back 10s, forward 10s left with 8 px
// gaps; volume, captions, fullscreen, more right with 8 px gaps (32 px
// visuals, 48 px touch targets). The more menu holds speeds (0.5x-3x),
// captions on/off and quality.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/surface.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'video_player_buttons.dart';
import 'video_player_controller.dart';
import 'video_player_header.dart';
import 'video_player_menu.dart';
import 'video_player_metrics.dart';
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
    final VideoPlayerMetrics metrics = resolveVideoMetrics(style);
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
      padding: resolveEdgeInsets(
        style.controlsPadding ?? metrics.controlsPadding,
        ambient.density.baseContentPadding * ambient.scaling,
      ),
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
          const SizedBox(height: 8),
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
              strings: ComponentLocalizations.of(context),
            ),
          const SizedBox(height: 8),
          _buttons(context, c, compactVolume: compactVolume, metrics: metrics),
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
    final VideoPlayerTheme style = widget.style;
    final double trackHeight =
        style.trackHeight ?? resolveVideoMetrics(style).trackHeight;
    final VideoScrubBar defaults = VideoScrubBar(
      position: c.position,
      duration: _total(c),
      buffered: c.buffered,
      enabled: !c.isLive,
      onSeek: c.seekTo,
      trackColor: widget.style.track?.resolve(colors) ?? colors.border,
      bufferedColor: widget.style.buffered?.resolve(colors) ?? colors.border,
      fillColor: widget.style.accent?.resolve(colors) ?? widget.fg,
      thumbColor: widget.style.thumb?.resolve(colors) ?? widget.fg,
      trackHeight: trackHeight,
    );
    return widget.progressBuilder?.call(context, c, defaults) ?? defaults;
  }

  Widget _buttons(
    BuildContext context,
    VideoPlaybackController c, {
    required bool compactVolume,
    required VideoPlayerMetrics metrics,
  }) {
    final double iconSize = widget.style.iconSize ?? metrics.iconSize;
    // 32 px visuals with 8 px gaps; 48 px touch targets via the invisible
    // hit area (desktop layouts stay 32 px).
    const double target = 48;
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
        const SizedBox(width: 8),
        videoIconButton(
          label: ComponentLocalizations.of(context).mediaSkipBack(10),
          icon: LucideIcons.rotateCcw,
          size: iconSize,
          fg: widget.fg,
          minTarget: target,
          onTap: () => c.seekBy(const Duration(seconds: -10)),
        ),
        const SizedBox(width: 8),
        videoIconButton(
          label: ComponentLocalizations.of(context).mediaSkipForward(10),
          icon: LucideIcons.rotateCw,
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
        const SizedBox(width: 8),
        if (widget.captionsButtonBuilder != null)
          widget.captionsButtonBuilder!(context, c)
        else
          videoIconButton(
            label: c.areCaptionsEnabled
                ? ComponentLocalizations.of(context).mediaCaptionsHide
                : ComponentLocalizations.of(context).mediaCaptionsShow,
            icon: c.areCaptionsEnabled
                ? LucideIcons.captions
                : LucideIcons.captionsOff,
            size: iconSize,
            fg: widget.fg,
            minTarget: target,
            onTap: c.toggleCaptions,
          ),
        const SizedBox(width: 8),
        if (widget.showFullscreenButton)
          widget.fullscreenButtonBuilder?.call(context, c) ??
              videoIconButton(
                label: ComponentLocalizations.of(context).mediaFullscreen,
                icon: LucideIcons.fullscreen,
                size: iconSize,
                fg: widget.fg,
                minTarget: target,
                onTap: widget.onFullscreenRequested,
              ),
        if (widget.showFullscreenButton) const SizedBox(width: 8),
        widget.moreBuilder?.call(context, c) ??
            (widget.speedBuilder?.call(context, c) ??
                videoMoreButton(
                  style: widget.style,
                  fg: widget.fg,
                  c: c,
                  minTarget: target,
                  onTap: () => setState(() => _menuOpen = !_menuOpen),
                  strings: ComponentLocalizations.of(context),
                )),
      ],
    );
  }

  /// Speed/captions menu section: wrapping speed chips, captions toggle and
  /// quality note (SPEC more-menu).
}

/// Minimal phone bar (under 600 px, YouTube-mobile style): a single thin bar
/// with play, draggable seek, time and fullscreen. No title row, no speed or
/// captions menu; the title lives in the overlay the player shows on tap.
class VideoMinimalBar extends StatelessWidget {
  /// Creates a minimal bar.
  const VideoMinimalBar({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    this.showFullscreenButton = true,
    this.onFullscreenRequested,
    this.playButtonBuilder,
    this.progressBuilder,
    this.fullscreenButtonBuilder,
  });

  /// Playback controller.
  final VideoPlaybackController controller;

  /// Resolved theme.
  final VideoPlayerTheme style;

  /// Foreground colour.
  final Color fg;

  /// Whether the fullscreen button shows.
  final bool showFullscreenButton;

  /// Fullscreen callback.
  final VoidCallback? onFullscreenRequested;

  /// Builder slots.
  final VideoPartBuilder? playButtonBuilder;
  final Widget Function(
    BuildContext context,
    VideoPlaybackController controller,
    VideoScrubBar defaults,
  )?
  progressBuilder;
  final VideoPartBuilder? fullscreenButtonBuilder;

  Duration _total(VideoPlaybackController c) {
    if (c.duration > Duration.zero) return c.duration;
    return const Duration(minutes: 3, seconds: 42);
  }

  @override
  Widget build(BuildContext context) {
    final VideoPlaybackController c = controller;
    final ThemeData ambient = Theme.of(context);
    final VideoPlayerMetrics metrics = resolveVideoMetrics(style);
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
    final double iconSize = style.iconSize ?? metrics.iconSize;
    final VideoScrubBar defaults = VideoScrubBar(
      position: c.position,
      duration: _total(c),
      buffered: c.buffered,
      enabled: !c.isLive,
      onSeek: c.seekTo,
      trackColor: style.track?.resolve(ambient.colors) ?? ambient.colors.border,
      bufferedColor:
          style.buffered?.resolve(ambient.colors) ?? ambient.colors.border,
      fillColor: style.accent?.resolve(ambient.colors) ?? fg,
      thumbColor: style.thumb?.resolve(ambient.colors) ?? fg,
      trackHeight: style.trackHeight ?? metrics.trackHeight,
    );
    final Widget time = Text(
      c.isLive
          ? formatMediaTime(c.position)
          : '${formatMediaTime(c.position)} / ${formatMediaTime(_total(c))}',
      maxLines: 1,
      style:
          style.timeTextStyle ??
          TextStyle(color: fg.withAlpha(0xCC), fontSize: 12),
    );
    Widget bar = Container(
      padding: resolveEdgeInsets(
        style.controlsPadding ?? metrics.controlsPadding,
        ambient.density.baseContentPadding * ambient.scaling,
      ),
      decoration: BoxDecoration(
        color: surfaceColor(base, opacity),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          videoPlayButton(
            context,
            style,
            fg,
            c,
            minTarget: 48,
            overrideBuilder: playButtonBuilder,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: progressBuilder?.call(context, c, defaults) ?? defaults,
          ),
          const SizedBox(width: 8),
          time,
          if (showFullscreenButton) ...<Widget>[
            const SizedBox(width: 8),
            fullscreenButtonBuilder?.call(context, c) ??
                videoIconButton(
                  label: ComponentLocalizations.of(context).mediaFullscreen,
                  icon: LucideIcons.fullscreen,
                  size: iconSize,
                  fg: fg,
                  minTarget: 48,
                  onTap: onFullscreenRequested,
                ),
          ],
        ],
      ),
    );
    return GlassSurface(
      surfaceBlur: blur,
      borderRadius: BorderRadius.circular(14),
      child: bar,
    );
  }
}
