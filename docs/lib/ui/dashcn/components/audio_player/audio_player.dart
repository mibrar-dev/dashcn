// The `audio_player` component: compact and full audio chrome.
//
// The UI drives an [AudioPlaybackController] (play, pause, seek, volume,
// mute, speed, looping). The docs app wires an audio plugin to it; the kit
// ships [FakeAudioPlaybackController].

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../primitives/surface.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'audio_player_controller.dart';
import 'audio_player_layout.dart';
import 'audio_player_progress.dart';
import 'audio_player_style.dart';
import 'audio_player_transport.dart';

export 'audio_player_controller.dart';
export 'audio_player_progress.dart';
export 'audio_player_style.dart';
export 'audio_player_transport.dart';

/// Compact or full audio player.
class AudioPlayer extends StatefulWidget {
  /// Creates an audio player.
  const AudioPlayer({
    super.key,
    this.controller,
    this.variant = AudioPlayerVariant.full,
    this.title,
    this.subtitle,
    this.cover,
    this.skipBack = const Duration(seconds: 10),
    this.skipForward = const Duration(seconds: 10),
    this.supportedSpeeds = const <double>[0.5, 1, 1.5, 2],
    this.showVolume = true,
    this.showSpeed = true,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.theme,
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
    this.initialPosition,
    this.initialVolume,
    this.initialMuted = false,
    this.initialSpeed = 1.0,
    this.initialLooping = false,
  });

  /// Playback controller; an internal fake is owned when null.
  final AudioPlaybackController? controller;

  /// Compact row or full card.
  final AudioPlayerVariant variant;

  /// Track title.
  final String? title;

  /// Track subtitle (artist, album).
  final String? subtitle;

  /// Cover art shown in the full layout.
  final Widget? cover;

  /// Skip-back step.
  final Duration skipBack;

  /// Skip-forward step.
  final Duration skipForward;

  /// Speeds offered by the speed control.
  final List<double> supportedSpeeds;

  /// Whether the volume cluster shows.
  final bool showVolume;

  /// Whether the speed control shows.
  final bool showSpeed;

  /// Accessible label.
  final String? semanticLabel;

  /// Focus node; one is created when null.
  final FocusNode? focusNode;

  /// Whether to take focus on first build.
  final bool autofocus;

  /// Widget-leg theme override.
  final AudioPlayerTheme? theme;

  /// Overrides the cover art.
  final AudioPartBuilder? coverBuilder;

  /// Overrides the title.
  final AudioPartBuilder? titleBuilder;

  /// Overrides the subtitle.
  final AudioPartBuilder? subtitleBuilder;

  /// Overrides the progress bar.
  final Widget Function(
    BuildContext context,
    AudioPlaybackController controller,
    AudioProgressBar defaults,
  )?
  progressBuilder;

  /// Waveform slot: replaces the bar with a custom waveform.
  final Widget Function(
    BuildContext context,
    AudioPlaybackController controller,
    AudioProgressBar defaults,
  )?
  waveformBuilder;

  /// Overrides the transport row.
  final AudioPartBuilder? controlsBuilder;

  /// Overrides the play button.
  final AudioPartBuilder? playButtonBuilder;

  /// Overrides the volume cluster.
  final AudioPartBuilder? volumeBuilder;

  /// Overrides the speed control.
  final AudioPartBuilder? speedBuilder;

  /// Overrides the loading indicator.
  final AudioPartBuilder? loadingBuilder;

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
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  AudioPlaybackController? _owned;
  FocusNode? _ownedFocus;

  AudioPlaybackController get _controller =>
      widget.controller ??
      (_owned ??= FakeAudioPlaybackController(
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
      _ownedFocus = FocusNode(debugLabel: 'AudioPlayer');
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
      case LogicalKeyboardKey.keyJ:
        c.seekTo(c.position - widget.skipBack);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.keyL:
        c.seekTo(c.position + widget.skipForward);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.keyM:
        c.setMuted(!c.isMuted);
        return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final AudioPlayerTheme style =
        resolveComponentStyle<AudioPlayerTheme, AudioPlayerTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: audioPlayerDefaults,
        );
    final ThemeColors colors = ambient.colors;
    final Color fg = style.foreground?.resolve(colors) ?? colors.cardForeground;
    final Color muted =
        style.mutedForeground?.resolve(colors) ?? colors.mutedForeground;
    final Color base = style.background?.resolve(colors) ?? colors.card;
    final double? opacity = resolveSurfaceOpacity(
      context,
      component: style.surfaceOpacity,
    );
    final double? blur = resolveSurfaceBlur(
      context,
      component: style.surfaceBlur,
    );
    final BorderRadiusGeometry radius =
        style.borderRadius ?? ambient.borderRadiusLg;
    final Duration fade = resolveMotionDuration(
      context,
      style.fadeDuration ?? kDefaultDuration,
    );
    final c = _controller;
    final Widget content = AudioPlayerBody(
      variant: widget.variant,
      controller: c,
      style: style,
      fg: fg,
      muted: muted,
      title: widget.title,
      subtitle: widget.subtitle,
      cover: widget.cover,
      skipBack: widget.skipBack,
      skipForward: widget.skipForward,
      supportedSpeeds: widget.supportedSpeeds,
      showVolume: widget.showVolume,
      showSpeed: widget.showSpeed,
      coverBuilder: widget.coverBuilder,
      titleBuilder: widget.titleBuilder,
      subtitleBuilder: widget.subtitleBuilder,
      progressBuilder: widget.progressBuilder,
      waveformBuilder: widget.waveformBuilder,
      controlsBuilder: widget.controlsBuilder,
      playButtonBuilder: widget.playButtonBuilder,
      volumeBuilder: widget.volumeBuilder,
      speedBuilder: widget.speedBuilder,
      loadingBuilder: widget.loadingBuilder,
    );
    Widget card = Container(
      padding:
          style.padding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: surfaceColor(base, opacity),
        border: Border.all(
          color: style.borderColor?.resolve(colors) ?? colors.border,
          width: style.borderWidth ?? 1,
        ),
        borderRadius: radius,
      ),
      child: AnimatedOpacity(opacity: 1, duration: fade, child: content),
    );
    card = GlassSurface(surfaceBlur: blur, borderRadius: radius, child: card);
    return Focus(
      focusNode: _focus,
      autofocus: widget.autofocus,
      onKeyEvent: _onKey,
      child: Semantics(
        label: widget.semanticLabel ?? 'Audio player',
        child: card,
      ),
    );
  }
}
