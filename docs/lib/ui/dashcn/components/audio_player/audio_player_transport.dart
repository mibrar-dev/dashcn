// Transport row for `audio_player`: play, skip, speed, repeat, mute.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/tap_target.dart';
import '../../primitives/localizations/localizations.dart';
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

/// Formats a duration as spoken text for accessibility.
///
/// English fallback for code without locale access; widget builds should
/// prefer [formatAudioSpokenDuration], which pluralizes in the ambient locale.
String _formatSpokenDuration(Duration value) {
  final int total = value.inSeconds.clamp(0, 86400 * 99);
  final int h = total ~/ 3600;
  final int m = (total % 3600) ~/ 60;
  final int s = total % 60;
  final List<String> parts = <String>[];
  if (h > 0) parts.add('$h ${h == 1 ? "hour" : "hours"}');
  if (m > 0) parts.add('$m ${m == 1 ? "minute" : "minutes"}');
  if (s > 0 || parts.isEmpty) parts.add('$s ${s == 1 ? "second" : "seconds"}');
  return parts.join(' ');
}

/// Formats playhead and duration as slider valuetext time.
///
/// English fallback for code without a [BuildContext]; widget builds should
/// prefer [formatAudioTimeValuetextIn], which reads the ambient locale.
String formatAudioTimeValuetext(Duration position, Duration duration) {
  return '${_formatSpokenDuration(position)} of ${_formatSpokenDuration(duration)}';
}

/// Locale-aware spoken duration for accessibility announcements.
String formatAudioSpokenDuration(
  ComponentLocalizations strings,
  Duration value,
) {
  final int total = value.inSeconds.clamp(0, 86400 * 99);
  final int h = total ~/ 3600;
  final int m = (total % 3600) ~/ 60;
  final int s = total % 60;
  final List<String> parts = <String>[];
  if (h > 0) parts.add(strings.mediaHours(h));
  if (m > 0) parts.add(strings.mediaMinutes(m));
  if (s > 0 || parts.isEmpty) parts.add(strings.mediaSeconds(s));
  return parts.join(' ');
}

/// Locale-aware [formatAudioTimeValuetext] for widget builds.
String formatAudioTimeValuetextIn(
  BuildContext context,
  Duration position,
  Duration duration,
) {
  final ComponentLocalizations strings = ComponentLocalizations.of(context);
  return strings.mediaPositionOf(
    formatAudioSpokenDuration(strings, position),
    formatAudioSpokenDuration(strings, duration),
  );
}

/// Accessible transport button meeting touch targets via TapTarget.
Widget audioSmallButton({
  required String label,
  required IconData icon,
  required double size,
  required Color fg,
  VoidCallback? onTap,
}) {
  return Semantics(
    label: label,
    button: true,
    child: TapTarget(
      minWidth: 48,
      minHeight: 48,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: Icon(icon, size: size, color: fg),
          ),
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
  final double size = style.controlSize ?? 32;
  final double iconSize = style.iconSize ?? 16;
  final ThemeData ambient = Theme.of(context);
  Widget icon = Icon(
    c.isPlaying ? LucideIcons.pause : LucideIcons.play,
    size: iconSize,
    color: fg,
  );
  if (c.isBuffering) {
    icon = loadingOverride != null
        ? loadingOverride(context, c)
        : Icon(LucideIcons.loaderCircle, size: iconSize, color: fg);
  }
  return Semantics(
    label: c.isPlaying
        ? ComponentLocalizations.of(context).mediaPause
        : ComponentLocalizations.of(context).mediaPlay,
    button: true,
    child: TapTarget(
      minWidth: 48,
      minHeight: 48,
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
    ),
  );
}

/// Handles keyboard events for audio playback.
KeyEventResult handleAudioKey({
  required KeyEvent event,
  required AudioPlaybackController controller,
  required Duration skipBack,
  required Duration skipForward,
}) {
  if (event is! KeyDownEvent) return KeyEventResult.ignored;
  switch (event.logicalKey) {
    case LogicalKeyboardKey.space:
    case LogicalKeyboardKey.keyK:
      controller.toggle();
      return KeyEventResult.handled;
    case LogicalKeyboardKey.arrowRight:
      controller.seekTo(controller.position + const Duration(seconds: 5));
      return KeyEventResult.handled;
    case LogicalKeyboardKey.arrowLeft:
      controller.seekTo(controller.position - const Duration(seconds: 5));
      return KeyEventResult.handled;
    case LogicalKeyboardKey.arrowUp:
      controller.setVolume((controller.volume + 0.1).clamp(0.0, 1.0));
      return KeyEventResult.handled;
    case LogicalKeyboardKey.arrowDown:
      controller.setVolume((controller.volume - 0.1).clamp(0.0, 1.0));
      return KeyEventResult.handled;
    case LogicalKeyboardKey.keyJ:
      controller.seekTo(controller.position - skipBack);
      return KeyEventResult.handled;
    case LogicalKeyboardKey.keyL:
      controller.seekTo(controller.position + skipForward);
      return KeyEventResult.handled;
    case LogicalKeyboardKey.keyM:
      controller.setMuted(!controller.isMuted);
      return KeyEventResult.handled;
  }
  return KeyEventResult.ignored;
}

/// Speed cycler with an inline option list.
class AudioSpeedButton extends StatefulWidget {
  const AudioSpeedButton({
    super.key,
    required this.controller,
    required this.fg,
    this.supportedSpeeds = kAudioSpeeds,
    this.initialOpen = false,
    this.overrideBuilder,
  });

  final AudioPlaybackController controller;
  final Color fg;
  final List<double> supportedSpeeds;
  final bool initialOpen;
  final AudioPartBuilder? overrideBuilder;

  @override
  State<AudioSpeedButton> createState() => _AudioSpeedButtonState();
}

class _AudioSpeedButtonState extends State<AudioSpeedButton> {
  late bool _open;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen;
  }

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
          Container(
            decoration: BoxDecoration(
              color: const Color(0xEE18181B),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0x33FFFFFF)),
            ),
            child: Column(
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
                      label: ComponentLocalizations.of(context).mediaSpeed(s),
                      button: true,
                      child: TapTarget(
                        minWidth: 64,
                        minHeight: 48,
                        child: Container(
                          width: 64,
                          height: 32,
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
                  ),
              ],
            ),
          ),
        Semantics(
          label: ComponentLocalizations.of(
            context,
          ).mediaPlaybackSpeed(c.playbackSpeed),
          button: true,
          child: TapTarget(
            minWidth: 48,
            minHeight: 48,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _open = !_open),
              child: SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: ExcludeSemantics(
                    child: Text(
                      '${c.playbackSpeed}x',
                      style: TextStyle(
                        color: widget.fg,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
  const AudioTransportRow({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    this.skipBack = const Duration(seconds: 10),
    this.skipForward = const Duration(seconds: 10),
    this.supportedSpeeds = kAudioSpeeds,
    this.showVolume = true,
    this.showSpeed = true,
    this.initialSpeedOpen = false,
    this.controlsBuilder,
    this.playButtonBuilder,
    this.volumeBuilder,
    this.speedBuilder,
    this.loadingBuilder,
  });

  final AudioPlaybackController controller;
  final AudioPlayerTheme style;
  final Color fg;
  final Duration skipBack;
  final Duration skipForward;
  final List<double> supportedSpeeds;
  final bool showVolume;
  final bool showSpeed;
  final bool initialSpeedOpen;
  final AudioPartBuilder? controlsBuilder;
  final AudioPartBuilder? playButtonBuilder;
  final AudioPartBuilder? volumeBuilder;
  final AudioPartBuilder? speedBuilder;
  final AudioPartBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    if (controlsBuilder != null) return controlsBuilder!(context, controller);
    final AudioPlaybackController c = controller;
    final double iconSize = style.iconSize ?? 16;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        audioSmallButton(
          label: ComponentLocalizations.of(
            context,
          ).mediaSkipBack(skipBack.inSeconds),
          icon: LucideIcons.skipBack,
          size: iconSize,
          fg: fg,
          onTap: () => c.seekTo(c.position - skipBack),
        ),
        const SizedBox(width: 4),
        audioPlayButton(
          context,
          style,
          fg,
          c,
          overrideBuilder: playButtonBuilder,
          loadingOverride: loadingBuilder,
        ),
        const SizedBox(width: 4),
        audioSmallButton(
          label: ComponentLocalizations.of(
            context,
          ).mediaSkipForward(skipForward.inSeconds),
          icon: LucideIcons.skipForward,
          size: iconSize,
          fg: fg,
          onTap: () => c.seekTo(c.position + skipForward),
        ),
        const SizedBox(width: 4),
        if (showSpeed)
          AudioSpeedButton(
            controller: c,
            fg: fg,
            supportedSpeeds: supportedSpeeds,
            initialOpen: initialSpeedOpen,
            overrideBuilder: speedBuilder,
          ),
        const SizedBox(width: 4),
        audioSmallButton(
          label: c.isLooping
              ? ComponentLocalizations.of(context).mediaRepeatDisable
              : ComponentLocalizations.of(context).mediaRepeatEnable,
          icon: LucideIcons.repeat,
          size: iconSize,
          fg: fg,
          onTap: () => c.setLooping(!c.isLooping),
        ),
        if (showVolume) ...[
          const SizedBox(width: 4),
          volumeBuilder?.call(context, c) ??
              audioSmallButton(
                label: c.isMuted
                    ? ComponentLocalizations.of(context).mediaUnmute
                    : ComponentLocalizations.of(context).mediaMute,
                icon: c.isMuted ? LucideIcons.volumeOff : LucideIcons.volume2,
                size: iconSize,
                fg: fg,
                onTap: () => c.setMuted(!c.isMuted),
              ),
        ],
      ],
    );
  }
}
