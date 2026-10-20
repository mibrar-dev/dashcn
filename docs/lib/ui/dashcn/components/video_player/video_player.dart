// The `video_player` component: a dependency-free video chrome.
//
// The UI drives a [VideoPlaybackController] (play, pause, seek, position,
// duration, buffered, volume, mute, speed, looping). The docs app wires
// `package:video_player` to it; the kit ships [FakeVideoPlaybackController].

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'video_player_controller.dart';
import 'video_player_controls.dart';
import 'video_player_scrub.dart';
import 'video_player_style.dart';

export 'video_player_controller.dart';
export 'video_player_controls.dart';
export 'video_player_scrub.dart';
export 'video_player_style.dart';

/// Reserved strip for the floating control bar: scrub (48) + button row
/// (48) + outer offset (8) + margin.
///
/// The tap-to-toggle detector stops above this strip so bar buttons never
/// compete with playback toggling.
const double _barReserve = 112;

/// A video frame with poster, play overlay, scrub bar and control bar.
class VideoPlayer extends StatefulWidget {
  /// Creates a video player.
  const VideoPlayer({
    super.key,
    this.controller,
    this.poster,
    this.content,
    this.captions,
    this.aspectRatio = 16 / 9,
    this.showControls = true,
    this.showFullscreenButton = true,
    this.supportedSpeeds = const <double>[0.5, 1, 1.5, 2],
    this.onFullscreenRequested,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.theme,
    this.posterBuilder,
    this.controlsBuilder,
    this.playButtonBuilder,
    this.progressBuilder,
    this.timeLabelBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.fullscreenButtonBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.initialPosition,
    this.initialVolume,
    this.initialMuted = false,
    this.initialSpeed = 1.0,
    this.initialLooping = false,
  });

  /// Playback controller; an internal fake is owned when null.
  final VideoPlaybackController? controller;

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

  /// Overrides the time labels.
  final VideoPartBuilder? timeLabelBuilder;

  /// Overrides the volume cluster.
  final VideoPartBuilder? volumeBuilder;

  /// Overrides the speed menu.
  final VideoPartBuilder? speedBuilder;

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

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlaybackController? _owned;
  FocusNode? _ownedFocus;

  VideoPlaybackController get _controller =>
      widget.controller ??
      (_owned ??= FakeVideoPlaybackController(
        position: widget.initialPosition,
        volume: widget.initialVolume,
        isMuted: widget.initialMuted,
        playbackSpeed: widget.initialSpeed,
        isLooping: widget.initialLooping,
      ));

  FocusNode get _focus => widget.focusNode ?? (_ownedFocus ??= FocusNode());

  @override
  void initState() {
    super.initState();
    if (widget.autofocus && widget.focusNode == null) {
      _ownedFocus = FocusNode(debugLabel: 'VideoPlayer');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _ownedFocus?.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _owned?.dispose();
    _ownedFocus?.dispose();
    super.dispose();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final c = _controller;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.keyK:
        c.toggle();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowRight:
        c.seekTo(c.position + const Duration(seconds: 5));
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowLeft:
        c.seekTo(c.position - const Duration(seconds: 5));
        return KeyEventResult.handled;
      case LogicalKeyboardKey.keyM:
        c.setMuted(!c.isMuted);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.keyF:
        widget.onFullscreenRequested?.call();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.keyL:
        c.setLooping(!c.isLooping);
        return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
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
        style.borderRadius ?? ambient.borderRadiusLg;
    final Duration fade = resolveMotionDuration(
      context,
      style.fadeDuration ?? kDefaultDuration,
    );
    final VideoPlaybackController c = _controller;
    final bool showPoster =
        widget.poster != null && !c.isPlaying && c.position <= Duration.zero;

    Widget stage = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ColoredBox(
          color: style.background?.resolve(colors) ?? const Color(0xFF000000),
        ),
        if (widget.posterBuilder != null)
          widget.posterBuilder!(context, c)
        else if (widget.content != null)
          widget.content!
        else if (showPoster)
          widget.poster!,
        if (c.isBuffering)
          Center(
            child:
                widget.loadingBuilder?.call(context, c) ??
                Icon(LucideIcons.loaderCircle, size: 32, color: fg),
          ),
        if (c.error != null)
          Center(
            child:
                widget.errorBuilder?.call(context, c.error!) ??
                Text('Playback failed', style: TextStyle(color: fg)),
          ),
        if (!c.isPlaying && c.error == null && !c.isBuffering)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: widget.showControls ? _barReserve : 0,
            child: Center(
              child: videoPlayButton(context, style, fg, c, big: true),
            ),
          ),
        if (widget.captions != null)
          Positioned(
            left: 12,
            right: 12,
            bottom: widget.showControls ? 96 : 12,
            child: DefaultTextStyle(
              style:
                  style.captionsTextStyle ?? TextStyle(color: fg, fontSize: 13),
              textAlign: TextAlign.center,
              child: widget.captions!,
            ),
          ),
      ],
    );
    // The tap-to-toggle detector covers only the media area above the
    // control bar: the bar owns its own hit region, so pressing a button
    // never competes with (or toggles) playback.
    final Widget stageTap = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: c.toggle,
      child: stage,
    );
    Widget frame = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: widget.showControls ? _barReserve : 0,
          child: stageTap,
        ),
        if (widget.showControls)
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: VideoControlsBar(
              controller: c,
              style: style,
              fg: fg,
              fade: fade,
              supportedSpeeds: widget.supportedSpeeds,
              showFullscreenButton: widget.showFullscreenButton,
              onFullscreenRequested: widget.onFullscreenRequested,
              playButtonBuilder: widget.playButtonBuilder,
              progressBuilder: widget.progressBuilder,
              timeLabelBuilder: widget.timeLabelBuilder,
              volumeBuilder: widget.volumeBuilder,
              speedBuilder: widget.speedBuilder,
              fullscreenButtonBuilder: widget.fullscreenButtonBuilder,
              controlsBuilder: widget.controlsBuilder,
            ),
          ),
      ],
    );
    frame = ClipRRect(borderRadius: radius, child: frame);
    frame = Semantics(
      label: widget.semanticLabel ?? 'Video player',
      child: frame,
    );
    return Focus(
      focusNode: _focus,
      autofocus: widget.autofocus,
      onKeyEvent: _onKey,
      child: AspectRatio(aspectRatio: widget.aspectRatio, child: frame),
    );
  }
}
