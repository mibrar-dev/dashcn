// The `video_player` component: a dependency-free video chrome.
//
// The UI drives a [VideoPlaybackController] (play, pause, seek, position,
// duration, buffered, volume, mute, speed, looping, captions). The docs app wires
// `package:video_player` to it; the kit ships [FakeVideoPlaybackController].

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../primitives/focus_outline.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'video_player_controller.dart';
import 'video_player_controls.dart';
import 'video_player_scrub.dart';
import 'video_player_stage.dart';
import 'video_player_style.dart';

export 'video_player_controller.dart';
export 'video_player_controls.dart';
export 'video_player_header.dart';
export 'video_player_menu.dart';
export 'video_player_scrub.dart';
export 'video_player_stage.dart';
export 'video_player_style.dart';
export 'video_player_volume.dart';

/// SPEC glass control bar over a 16:9 frame: title header, 10s skips,
/// speed/captions more-menu, auto-hide, live badge and camera fallback.
class VideoPlayer extends StatefulWidget {
  /// Creates a video player.
  const VideoPlayer({
    super.key,
    this.controller,
    this.title,
    this.subtitle,
    this.poster,
    this.content,
    this.captions,
    this.aspectRatio = 16 / 9,
    this.showControls = true,
    this.controlsVisible,
    this.showFullscreenButton = true,
    this.supportedSpeeds = kVideoSpeeds,
    this.onFullscreenRequested,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.theme,
    this.posterBuilder,
    this.controlsBuilder,
    this.playButtonBuilder,
    this.progressBuilder,
    this.headerBuilder,
    this.timeLabelBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.moreBuilder,
    this.captionsButtonBuilder,
    this.fullscreenButtonBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.initialPosition,
    this.initialVolume,
    this.initialMuted = false,
    this.initialSpeed = 1.0,
    this.initialLooping = false,
    this.initialCaptionsEnabled,
  });

  /// Playback controller; an internal fake is owned when null.
  final VideoPlaybackController? controller;

  /// Title shown in the control bar header.
  final String? title;

  /// Subtitle shown under the title (e.g. "Season 3 episode 6").
  final String? subtitle;

  /// Still shown before first play (or when no [content]).
  final Widget? poster;

  /// The video frame (docs adapter plugs the plugin texture here).
  final Widget? content;

  /// Caption/label overlay above the control bar.
  final Widget? captions;

  /// Width / height of the frame.
  final double aspectRatio;

  /// Whether the control bar is shown.
  final bool showControls;

  /// Pins control bar visibility (null = auto-hide while playing).
  ///
  /// Test/screenshot escape hatch: `false` renders the hidden state.
  final bool? controlsVisible;

  /// Whether the fullscreen button is shown.
  final bool showFullscreenButton;

  /// Speeds offered by the speed menu.
  final List<double> supportedSpeeds;

  /// Called when fullscreen is requested (button or `f` key).
  final VoidCallback? onFullscreenRequested;

  /// Accessible label for the player.
  final String? semanticLabel;

  /// Focus node for keyboard control; one is created when null.
  final FocusNode? focusNode;

  /// Whether to take focus on first build.
  final bool autofocus;

  /// Widget-leg theme override.
  final VideoPlayerTheme? theme;

  /// Overrides the poster/frame area.
  final VideoPartBuilder? posterBuilder;

  /// Overrides the whole control bar.
  final Widget Function(
    BuildContext context,
    VideoPlaybackController controller,
    Widget defaults,
  )?
  controlsBuilder;

  /// Overrides the play/pause buttons.
  final VideoPartBuilder? playButtonBuilder;

  /// Overrides the scrub bar.
  final Widget Function(
    BuildContext context,
    VideoPlaybackController controller,
    VideoScrubBar defaults,
  )?
  progressBuilder;

  /// Overrides the bar header (title/subtitle/time).
  final VideoPartBuilder? headerBuilder;

  /// Overrides the time labels.
  final VideoPartBuilder? timeLabelBuilder;

  /// Overrides the volume cluster.
  final VideoPartBuilder? volumeBuilder;

  /// Overrides the speed menu.
  final VideoPartBuilder? speedBuilder;

  /// Overrides the more (three dots) menu.
  final VideoPartBuilder? moreBuilder;

  /// Overrides the captions toggle button.
  final VideoPartBuilder? captionsButtonBuilder;

  /// Overrides the fullscreen button.
  final VideoPartBuilder? fullscreenButtonBuilder;

  /// Overrides the loading indicator.
  final VideoPartBuilder? loadingBuilder;

  /// Builds the error overlay; receives the controller error.
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  /// Uncontrolled initial position (used when [controller] is null).
  final Duration? initialPosition;

  /// Uncontrolled initial volume.
  final double? initialVolume;

  /// Uncontrolled initial mute.
  final bool initialMuted;

  /// Uncontrolled initial speed.
  final double initialSpeed;

  /// Uncontrolled initial looping.
  final bool initialLooping;

  /// Uncontrolled initial captions enabled.
  final bool? initialCaptionsEnabled;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlaybackController? _owned;
  FocusNode? _ownedFocus;
  Timer? _hideTimer;
  bool _controlsVisible = true;
  bool _focused = false;

  VideoPlaybackController get _controller =>
      widget.controller ??
      (_owned ??= FakeVideoPlaybackController(
        position: widget.initialPosition,
        volume: widget.initialVolume,
        isMuted: widget.initialMuted,
        playbackSpeed: widget.initialSpeed,
        isLooping: widget.initialLooping,
        areCaptionsEnabled:
            widget.initialCaptionsEnabled ?? (widget.captions != null),
      ));

  FocusNode get _focus => widget.focusNode ?? (_ownedFocus ??= FocusNode());

  @override
  void initState() {
    super.initState();
    if (widget.controlsVisible != null) {
      _controlsVisible = widget.controlsVisible!;
    }
    if (widget.autofocus && widget.focusNode == null) {
      _ownedFocus = FocusNode(debugLabel: 'VideoPlayer');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _ownedFocus?.requestFocus();
      });
    }
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controlsVisible != null &&
        widget.controlsVisible != oldWidget.controlsVisible) {
      _controlsVisible = widget.controlsVisible!;
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _owned?.dispose();
    _ownedFocus?.dispose();
    super.dispose();
  }

  void _onActivity({Duration timeout = const Duration(seconds: 3)}) {
    if (widget.controlsVisible != null) return;
    if (!_controlsVisible) {
      setState(() => _controlsVisible = true);
    }
    _hideTimer?.cancel();
    if (_controller.isPlaying) {
      _hideTimer = Timer(timeout, () {
        if (mounted && _controller.isPlaying) {
          setState(() => _controlsVisible = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => _frame(context),
    );
  }

  Widget _frame(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final VideoPlayerTheme style =
        resolveComponentStyle<VideoPlayerTheme, VideoPlayerTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: videoPlayerDefaults,
        );
    final ThemeColors colors = ambient.colors;
    final Color fg =
        style.foreground?.resolve(colors) ?? const Color(0xFFFFFFFF);
    final BorderRadiusGeometry radius =
        style.borderRadius ?? BorderRadius.circular(18);
    final Duration fade = resolveMotionDuration(
      context,
      style.fadeDuration ?? kDefaultDuration,
    );
    final VideoPlaybackController c = _controller;
    final bool controlsVisible = widget.controlsVisible ?? _controlsVisible;
    final bool showPoster =
        widget.poster != null && !c.isPlaying && c.position <= Duration.zero;

    Widget stage = VideoPlayerStage(
      controller: c,
      style: style,
      fg: fg,
      showPoster: showPoster,
      poster: widget.poster,
      content: widget.content,
      captions: widget.captions,
      showControls: widget.showControls,
      posterBuilder: widget.posterBuilder,
      playButtonBuilder: widget.playButtonBuilder,
      loadingBuilder: widget.loadingBuilder,
      errorBuilder: widget.errorBuilder,
    );

    Widget frame = MouseRegion(
      onHover: (_) => _onActivity(
        timeout: style.controlsTimeout ?? const Duration(seconds: 3),
      ),
      onEnter: (_) => _onActivity(
        timeout: style.controlsTimeout ?? const Duration(seconds: 3),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              c.toggle();
              _onActivity(
                timeout: style.controlsTimeout ?? const Duration(seconds: 3),
              );
            },
            child: stage,
          ),
          if (widget.showControls)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: AnimatedOpacity(
                opacity: controlsVisible ? 1.0 : 0.0,
                duration: fade,
                child: IgnorePointer(
                  ignoring: !controlsVisible,
                  child: VideoControlsBar(
                    controller: c,
                    style: style,
                    fg: fg,
                    fade: fade,
                    title: widget.title,
                    subtitle: widget.subtitle,
                    supportedSpeeds: widget.supportedSpeeds,
                    showFullscreenButton: widget.showFullscreenButton,
                    onFullscreenRequested: widget.onFullscreenRequested,
                    playButtonBuilder: widget.playButtonBuilder,
                    progressBuilder: widget.progressBuilder,
                    headerBuilder: widget.headerBuilder,
                    timeLabelBuilder: widget.timeLabelBuilder,
                    volumeBuilder: widget.volumeBuilder,
                    speedBuilder: widget.speedBuilder,
                    moreBuilder: widget.moreBuilder,
                    captionsButtonBuilder: widget.captionsButtonBuilder,
                    fullscreenButtonBuilder: widget.fullscreenButtonBuilder,
                    controlsBuilder: widget.controlsBuilder,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    frame = Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF27272A)),
        borderRadius: radius,
      ),
      child: ClipRRect(borderRadius: radius, child: frame),
    );
    frame = FocusOutline(focused: _focused, borderRadius: radius, child: frame);
    frame = Semantics(
      label: widget.semanticLabel ?? 'Video player',
      child: frame,
    );
    return Focus(
      focusNode: _focus,
      autofocus: widget.autofocus,
      onFocusChange: (v) => setState(() => _focused = v),
      onKeyEvent: (node, event) {
        _onActivity();
        return handleVideoKey(
          event: event,
          controller: c,
          onFullscreenRequested: widget.onFullscreenRequested,
        );
      },
      child: AspectRatio(aspectRatio: widget.aspectRatio, child: frame),
    );
  }
}
