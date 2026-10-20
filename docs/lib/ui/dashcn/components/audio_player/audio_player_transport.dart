// Transport row for `audio_player`: play, skip, speed, repeat, mute.
//
// Split from `audio_player.dart` so both files stay small.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import 'audio_player_controller.dart';
import 'audio_player_style.dart';

/// Builds one audio part with live controller state.
typedef AudioPartBuilder =
    Widget Function(BuildContext context, AudioPlaybackController controller);

/// Formats a duration as m:ss or h:mm:ss.
String formatAudioTime(Duration value) {
  final int total = value.inSeconds.clamp(0, 86400 * 99);
  final int h = total ~/ 3600;
  final int m = (total % 3600) ~/ 60;
  final int s = total % 60;
  if (h > 0) {
    return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
  return '$m:${s.toString().padLeft(2, '0')}';
}

/// 48px accessible transport button.
Widget audioSmallButton({
  required String label,
  required IconData icon,
  required double size,
  required Color fg,
  VoidCallback? onTap,
}) {
  // The 48x48 box already meets the touch minimum: no TouchHitArea
  // growth, so the six-button transport row fits a 360px card.
  return Semantics(
    label: label,
    button: true,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: Icon(icon, size: size, color: fg),
        ),
      ),
    ),
  );
}

/// Round play/pause button.
Widget audioPlayButton(
  BuildContext context,
  AudioPlayerTheme style,
  Color fg,
  AudioPlaybackController c, {
  AudioPartBuilder? overrideBuilder,
  AudioPartBuilder? loadingOverride,
}) {
  if (overrideBuilder != null) return overrideBuilder(context, c);
  final double size = style.controlSize ?? 48;
  final ThemeData ambient = Theme.of(context);
  Widget icon = Icon(
    c.isPlaying ? LucideIcons.pause : LucideIcons.play,
    size: 22,
    color: fg,
  );
  if (c.isBuffering) {
    icon = loadingOverride != null
        ? loadingOverride(context, c)
        : Icon(LucideIcons.loaderCircle, size: 22, color: fg);
  }
  // The round button already meets the 48px touch minimum: no growth.
  return Semantics(
    label: c.isPlaying ? 'Pause' : 'Play',
    button: true,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: c.toggle,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              style.accent?.resolve(ambient.colors) ?? ambient.colors.primary,
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    ),
  );
}

/// Speed cycler with an inline option list.
class AudioSpeedButton extends StatefulWidget {
  /// Creates a speed button.
  const AudioSpeedButton({
    super.key,
    required this.controller,
    required this.fg,
    this.supportedSpeeds = const <double>[0.5, 1, 1.5, 2],
    this.overrideBuilder,
  });

  /// Playback controller.
  final AudioPlaybackController controller;

  /// Foreground colour.
  final Color fg;

  /// Speeds offered.
  final List<double> supportedSpeeds;

  /// Full override of the button.
  final AudioPartBuilder? overrideBuilder;

  @override
  State<AudioSpeedButton> createState() => _AudioSpeedButtonState();
}

class _AudioSpeedButtonState extends State<AudioSpeedButton> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final AudioPlaybackController c = widget.controller;
    if (widget.overrideBuilder != null) {
      return widget.overrideBuilder!(context, c);
    }
    final List<double> speeds = widget.supportedSpeeds.isEmpty
        ? const <double>[1]
        : widget.supportedSpeeds;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_open)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final double s in speeds)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    c.setPlaybackSpeed(s);
                    setState(() => _open = false);
                  },
                  child: Semantics(
                    label: 'Speed ${s}x',
                    button: true,
                    child: Container(
                      width: 64,
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
        Semantics(
          label: 'Playback speed ${c.playbackSpeed}x',
          button: true,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _open = !_open),
            child: SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: ExcludeSemantics(
                  child: Text(
                    '${c.playbackSpeed}x',
                    style: TextStyle(color: widget.fg, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Full transport row: skip back, play, skip forward, speed, repeat, mute.
class AudioTransportRow extends StatelessWidget {
  /// Creates a transport row.
  const AudioTransportRow({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    this.skipBack = const Duration(seconds: 10),
    this.skipForward = const Duration(seconds: 10),
    this.supportedSpeeds = const <double>[0.5, 1, 1.5, 2],
    this.showVolume = true,
    this.showSpeed = true,
    this.controlsBuilder,
    this.playButtonBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.loadingBuilder,
  });

  /// Playback controller.
  final AudioPlaybackController controller;

  /// Resolved theme.
  final AudioPlayerTheme style;

  /// Foreground colour.
  final Color fg;

  /// Skip-back step.
  final Duration skipBack;

  /// Skip-forward step.
  final Duration skipForward;

  /// Speeds offered.
  final List<double> supportedSpeeds;

  /// Whether volume shows.
  final bool showVolume;

  /// Whether speed shows.
  final bool showSpeed;

  /// Overrides the whole row.
  final AudioPartBuilder? controlsBuilder;

  /// Overrides the play button.
  final AudioPartBuilder? playButtonBuilder;

  /// Overrides the volume button.
  final AudioPartBuilder? volumeBuilder;

  /// Overrides the speed button.
  final AudioPartBuilder? speedBuilder;

  /// Overrides the loading indicator.
  final AudioPartBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    if (controlsBuilder != null) {
      return controlsBuilder!(context, controller);
    }
    final AudioPlaybackController c = controller;
    final double iconSize = style.iconSize ?? 20;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        audioSmallButton(
          label: 'Back ${skipBack.inSeconds} seconds',
          icon: LucideIcons.skipBack,
          size: iconSize,
          fg: fg,
          onTap: () => c.seekTo(c.position - skipBack),
        ),
        audioPlayButton(
          context,
          style,
          fg,
          c,
          overrideBuilder: playButtonBuilder,
          loadingOverride: loadingBuilder,
        ),
        audioSmallButton(
          label: 'Forward ${skipForward.inSeconds} seconds',
          icon: LucideIcons.skipForward,
          size: iconSize,
          fg: fg,
          onTap: () => c.seekTo(c.position + skipForward),
        ),
        if (showSpeed)
          AudioSpeedButton(
            controller: c,
            fg: fg,
            supportedSpeeds: supportedSpeeds,
            overrideBuilder: speedBuilder,
          ),
        audioSmallButton(
          label: c.isLooping ? 'Disable repeat' : 'Enable repeat',
          icon: LucideIcons.repeat,
          size: iconSize,
          fg: fg,
          onTap: () => c.setLooping(!c.isLooping),
        ),
        if (showVolume)
          volumeBuilder?.call(context, c) ??
              audioSmallButton(
                label: c.isMuted ? 'Unmute' : 'Mute',
                icon: c.isMuted ? LucideIcons.volumeOff : LucideIcons.volume2,
                size: iconSize,
                fg: fg,
                onTap: () => c.setMuted(!c.isMuted),
              ),
      ],
    );
  }
}
