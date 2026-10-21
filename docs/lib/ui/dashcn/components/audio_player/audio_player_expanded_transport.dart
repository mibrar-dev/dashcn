// Expanded card transport for `audio_player` (SPEC reference 2).
//
// Split from `audio_player_expanded.dart` so both files stay small: shuffle,
// previous, the 56px black play button, next, repeat.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/tap_target.dart';
import '../../primitives/localizations/localizations.dart';
import 'audio_player_controller.dart';
import 'audio_player_style.dart';
import 'audio_player_transport.dart';

/// Five-button transport row for the expanded card.
class AudioExpandedTransport extends StatelessWidget {
  /// Creates a transport row.
  const AudioExpandedTransport({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    required this.muted,
    this.controlsBuilder,
    this.playButtonBuilder,
    this.previousBuilder,
    this.nextBuilder,
    this.shuffleBuilder,
    this.repeatBuilder,
    this.loadingBuilder,
  });

  /// Playback controller (shared with the compact pill).
  final AudioPlaybackController controller;

  /// Resolved theme.
  final AudioPlayerTheme style;

  /// Active icons.
  final Color fg;

  /// Inactive icons.
  final Color muted;

  /// Builder slots for the row and every button.
  final AudioPartBuilder? controlsBuilder;
  final AudioPartBuilder? playButtonBuilder;
  final AudioPartBuilder? previousBuilder;
  final AudioPartBuilder? nextBuilder;
  final AudioPartBuilder? shuffleBuilder;
  final AudioPartBuilder? repeatBuilder;
  final AudioPartBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    final AudioPlaybackController c = controller;
    if (controlsBuilder != null) return controlsBuilder!(context, c);
    final double iconSize = style.iconSize ?? 18;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        shuffleBuilder?.call(context, c) ??
            _toggleButton(
              label: c.isShuffled
                  ? ComponentLocalizations.of(context).mediaShuffleDisable
                  : ComponentLocalizations.of(context).mediaShuffleEnable,
              icon: LucideIcons.shuffle,
              active: c.isShuffled,
              fg: fg,
              muted: muted,
              size: iconSize,
              onTap: c.toggleShuffle,
            ),
        const SizedBox(width: 4),
        previousBuilder?.call(context, c) ??
            _transportButton(
              label: ComponentLocalizations.of(context).mediaPreviousTrack,
              icon: LucideIcons.skipBack,
              fg: fg,
              size: iconSize,
              onTap: c.previous,
            ),
        const SizedBox(width: 8),
        playButtonBuilder?.call(context, c) ?? _bigPlay(context, c),
        const SizedBox(width: 8),
        nextBuilder?.call(context, c) ??
            _transportButton(
              label: ComponentLocalizations.of(context).mediaNextTrack,
              icon: LucideIcons.skipForward,
              fg: fg,
              size: iconSize,
              onTap: c.next,
            ),
        const SizedBox(width: 4),
        repeatBuilder?.call(context, c) ??
            _toggleButton(
              label: c.isLooping
                  ? ComponentLocalizations.of(context).mediaRepeatDisable
                  : ComponentLocalizations.of(context).mediaRepeatEnable,
              icon: LucideIcons.repeat,
              active: c.isLooping,
              fg: fg,
              muted: muted,
              size: iconSize,
              onTap: () => c.setLooping(!c.isLooping),
            ),
      ],
    );
  }

  Widget _bigPlay(BuildContext context, AudioPlaybackController c) {
    if (c.isBuffering && loadingBuilder != null) {
      return loadingBuilder!(context, c);
    }
    final double size = style.controlSize ?? 56;
    final Widget icon = c.isBuffering
        ? const Icon(
            LucideIcons.loaderCircle,
            size: 24,
            color: Color(0xFFFFFFFF),
          )
        : Icon(
            c.isPlaying ? LucideIcons.pause : LucideIcons.play,
            size: 24,
            color: const Color(0xFFFFFFFF),
          );
    return Semantics(
      label: c.isPlaying
          ? ComponentLocalizations.of(context).mediaPause
          : ComponentLocalizations.of(context).mediaPlay,
      button: true,
      child: TapTarget(
        minWidth: 56,
        minHeight: 56,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: c.toggle,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: Color(0xFF18181B),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: icon,
          ),
        ),
      ),
    );
  }
}

Widget _transportButton({
  required String label,
  required IconData icon,
  required Color fg,
  required double size,
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
          width: 40,
          height: 40,
          child: Center(
            child: Icon(icon, size: size, color: fg),
          ),
        ),
      ),
    ),
  );
}

Widget _toggleButton({
  required String label,
  required IconData icon,
  required bool active,
  required Color fg,
  required Color muted,
  required double size,
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
          width: 40,
          height: 40,
          child: Center(
            child: Icon(icon, size: size, color: active ? fg : muted),
          ),
        ),
      ),
    ),
  );
}
