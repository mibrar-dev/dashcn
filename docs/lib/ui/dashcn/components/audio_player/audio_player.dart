// Compact pill + expanded card audio chrome on one shared controller.
// Next/previous move through [AudioTrack]s; the docs app wires `just_audio`,
// the kit ships [FakeAudioPlaybackController].

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../primitives/focus_outline.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../primitives/surface.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';
import 'audio_player_controller.dart';
import 'audio_player_fake.dart';
import 'audio_player_layout.dart';
import 'audio_player_progress.dart';
import 'audio_player_style.dart';
import 'audio_player_transport.dart';

export 'audio_player_controller.dart';
export 'audio_player_fake.dart';
export 'audio_player_layout.dart';
export 'audio_player_metrics.dart';
export 'audio_player_playlist.dart';
export 'audio_player_progress.dart';
export 'audio_player_style.dart';
export 'audio_player_transport.dart';

/// Compact pill or expanded card audio player.
class AudioPlayer extends StatefulWidget {
  /// Creates an audio player.
  const AudioPlayer({
    super.key,
    this.controller,
    this.variant = AudioPlayerVariant.compact,
    this.title,
    this.subtitle,
    this.cover,
    this.skipBack = const Duration(seconds: 10),
    this.skipForward = const Duration(seconds: 10),
    this.supportedSpeeds = kAudioSpeeds,
    this.showVolume = true,
    this.showSpeed = true,
    this.initialSpeedOpen = false,
    this.onDownload,
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
    this.previousBuilder,
    this.nextBuilder,
    this.shuffleBuilder,
    this.repeatBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.downloadBuilder,
    this.loadingBuilder,
    this.initialPosition,
    this.initialVolume,
    this.initialMuted = false,
    this.initialSpeed = 1.0,
    this.initialLooping = false,
  });

  /// Shared playback controller; an internal fake is owned when null.
  final AudioPlaybackController? controller;

  /// Compact pill (default) or expanded card.
  final AudioPlayerVariant variant;

  /// Fallback title when the controller has no track.
  final String? title;

  /// Fallback artist when the controller has no track.
  final String? subtitle;

  /// Cover art shown by the expanded card.
  final Widget? cover;

  /// Keyboard skip steps, J/L (10s each).
  final Duration skipBack;
  final Duration skipForward;

  /// Speeds cycled by the compact chip.
  final List<double> supportedSpeeds;

  /// Whether the volume cluster shows.
  final bool showVolume;

  /// Whether the speed control shows.
  final bool showSpeed;

  /// Whether the expanded card speed menu starts open.
  final bool initialSpeedOpen;

  /// Called when the compact download icon is tapped.
  final VoidCallback? onDownload;

  /// Accessible label for the player.
  final String? semanticLabel;

  /// Focus node for keyboard control.
  final FocusNode? focusNode;

  /// Whether to take focus on first build.
  final bool autofocus;

  /// Widget-leg theme override.
  final AudioPlayerTheme? theme;

  /// Builder slots for every visible part.
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
  final AudioPartBuilder? previousBuilder;
  final AudioPartBuilder? nextBuilder;
  final AudioPartBuilder? shuffleBuilder;
  final AudioPartBuilder? repeatBuilder;
  final AudioPartBuilder? volumeBuilder;
  final AudioPartBuilder? speedBuilder;
  final AudioPartBuilder? downloadBuilder;
  final AudioPartBuilder? loadingBuilder;

  /// Uncontrolled initial state (used when [controller] is null).
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
    final double densityBase =
        ambient.density.baseContentPadding * ambient.scaling;
    final double? opacity = resolveSurfaceOpacity(
      context,
      component: style.surfaceOpacity,
    );
    final double? blur = resolveSurfaceBlur(
      context,
      component: style.surfaceBlur,
    );
    final bool compact = widget.variant == AudioPlayerVariant.compact;
    final BorderRadiusGeometry radius =
        style.borderRadius ??
        (compact ? BorderRadius.circular(14) : BorderRadius.circular(20));
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
      supportedSpeeds: widget.supportedSpeeds,
      showVolume: widget.showVolume,
      showSpeed: widget.showSpeed,
      initialSpeedOpen: widget.initialSpeedOpen,
      onDownload: widget.onDownload,
      coverBuilder: widget.coverBuilder,
      titleBuilder: widget.titleBuilder,
      subtitleBuilder: widget.subtitleBuilder,
      progressBuilder: widget.progressBuilder,
      waveformBuilder: widget.waveformBuilder,
      controlsBuilder: widget.controlsBuilder,
      playButtonBuilder: widget.playButtonBuilder,
      previousBuilder: widget.previousBuilder,
      nextBuilder: widget.nextBuilder,
      shuffleBuilder: widget.shuffleBuilder,
      repeatBuilder: widget.repeatBuilder,
      volumeBuilder: widget.volumeBuilder,
      speedBuilder: widget.speedBuilder,
      downloadBuilder: widget.downloadBuilder,
      loadingBuilder: widget.loadingBuilder,
    );
    Widget body = Container(
      padding: _resolveBodyPadding(style.padding, densityBase, compact),
      decoration: BoxDecoration(
        color: surfaceColor(base, opacity),
        border: Border.all(
          color: style.borderColor?.resolve(colors) ?? colors.border,
          width: style.borderWidth ?? 1,
        ),
        borderRadius: radius,
        boxShadow: compact
            ? const <BoxShadow>[
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: AnimatedOpacity(opacity: 1, duration: fade, child: content),
    );
    // The expanded cover art overflows its window by design (SPEC
    // half-circle crop): clip it to the card. The compact pill never
    // bleeds, and its shadow must paint outside the card.
    Widget card = compact ? body : ClipRRect(borderRadius: radius, child: body);
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
        label:
            widget.semanticLabel ??
            ComponentLocalizations.of(context).mediaAudioPlayer,
        child: card,
      ),
    );
  }
}

/// Resolves the card padding against [densityBase].
///
/// Theme padding uses density-px (`EdgeInsetsDensity`); plain insets pass
/// through. The compact pill keeps horizontal padding only so the card stays
/// 48px tall (SPEC reference 1): 12 px horizontal. The expanded card uses
/// the 16 px density token on all sides.
EdgeInsetsGeometry _resolveBodyPadding(
  EdgeInsetsGeometry? padding,
  double densityBase,
  bool compact,
) {
  final EdgeInsetsGeometry base =
      padding ??
      (compact
          ? const EdgeInsetsDensity.pxSymmetric(horizontal: 12)
          : const EdgeInsetsDensity.pxAll(16));
  final EdgeInsets resolved = resolveEdgeInsets(
    base,
    densityBase,
  ).resolve(TextDirection.ltr);
  if (!compact) {
    // Expanded default padding is horizontal-only (`audioPlayerDefaults`),
    // so `resolved` carries 0 vertical and the transport row paints on the
    // card edge. Guarantee the 16 px density token top/bottom while keeping
    // any explicit horizontal/vertical the theme already provides.
    final EdgeInsets vertical = resolveEdgeInsets(
      const EdgeInsetsDensity.pxAll(16),
      densityBase,
    ).resolve(TextDirection.ltr);
    final double top = resolved.top <= 0 ? vertical.top : resolved.top;
    final double bottom = resolved.bottom <= 0
        ? vertical.bottom
        : resolved.bottom;
    return EdgeInsets.only(
      left: resolved.left,
      right: resolved.right,
      top: top,
      bottom: bottom,
    );
  }
  return EdgeInsets.only(left: resolved.left, right: resolved.right);
}
