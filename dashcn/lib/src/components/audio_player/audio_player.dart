// The `audio_player` component: compact and full audio chrome.
//
// The UI drives an [AudioPlaybackController] (play, pause, seek, volume,
// mute, speed, looping). The docs app wires an audio plugin to it; the kit
// ships [FakeAudioPlaybackController].

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../primitives/focus_outline.dart';
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
    this.initialSpeedOpen = false,
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

  final AudioPlaybackController? controller;
  final AudioPlayerVariant variant;
  final String? title;
  final String? subtitle;
  final Widget? cover;
  final Duration skipBack;
  final Duration skipForward;
  final List<double> supportedSpeeds;
  final bool showVolume;
  final bool showSpeed;
  final bool initialSpeedOpen;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final AudioPlayerTheme? theme;
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
  final Duration? initialPosition;
  final double? initialVolume;
  final bool initialMuted;
  final double initialSpeed;
  final bool initialLooping;

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  AudioPlaybackController? _owned;
  FocusNode? _ownedFocus;
  bool _focused = false;

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
      initialSpeedOpen: widget.initialSpeedOpen,
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
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
    card = FocusOutline(focused: _focused, borderRadius: radius, child: card);
    return Focus(
      focusNode: _focus,
      autofocus: widget.autofocus,
      onFocusChange: (v) => setState(() => _focused = v),
      onKeyEvent: (node, event) => handleAudioKey(
        event: event,
        controller: c,
        skipBack: widget.skipBack,
        skipForward: widget.skipForward,
      ),
      child: Semantics(
        label: widget.semanticLabel ?? 'Audio player',
        child: card,
      ),
    );
  }
}
