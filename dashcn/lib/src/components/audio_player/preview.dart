// Named examples for the `audio_player` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Every example
// owns its `FakeAudioPlaybackController` and shrink-wraps in a bounded box.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import 'audio_player.dart';

/// Default compact card with title and subtitle.
class _DefaultAudio extends StatefulWidget {
  const _DefaultAudio();

  @override
  State<_DefaultAudio> createState() => _DefaultAudioState();
}

class _DefaultAudioState extends State<_DefaultAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: AudioPlayer(
        controller: _controller,
        title: 'Midnight drive',
        subtitle: 'Neon Coastline',
      ),
    );
  }
}

/// Player with comfortable density tokens.
class _ComfortableAudio extends StatefulWidget {
  const _ComfortableAudio();

  @override
  State<_ComfortableAudio> createState() => _ComfortableAudioState();
}

class _ComfortableAudioState extends State<_ComfortableAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: AudioPlayer(
        controller: _controller,
        title: 'Comfortable edition',
        subtitle: 'Studio Master',
        theme: const AudioPlayerTheme(
          controlSize: 40,
          iconSize: 18,
          coverSize: 48,
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}

/// Responsive player on phone width (volume hidden).
class _PhoneAudio extends StatefulWidget {
  const _PhoneAudio();

  @override
  State<_PhoneAudio> createState() => _PhoneAudioState();
}

class _PhoneAudioState extends State<_PhoneAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: AudioPlayer(
        controller: _controller,
        title: 'Mobile podcast',
        subtitle: 'Volume hidden on phone',
      ),
    );
  }
}

/// Player with speed menu open.
class _SpeedMenuOpenAudio extends StatefulWidget {
  const _SpeedMenuOpenAudio();

  @override
  State<_SpeedMenuOpenAudio> createState() => _SpeedMenuOpenAudioState();
}

class _SpeedMenuOpenAudioState extends State<_SpeedMenuOpenAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    playbackSpeed: 1.5,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: AudioPlayer(
        controller: _controller,
        title: 'Speed menu open',
        subtitle: '1.5x selected',
        initialSpeedOpen: true,
      ),
    );
  }
}

/// Compact single-row player.
class _CompactAudio extends StatefulWidget {
  const _CompactAudio();

  @override
  State<_CompactAudio> createState() => _CompactAudioState();
}

class _CompactAudioState extends State<_CompactAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    isPlaying: true,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.compact,
        title: 'Compact episode',
      ),
    );
  }
}

/// Player with a cover-art slot.
class _CoverAudio extends StatefulWidget {
  const _CoverAudio();

  @override
  State<_CoverAudio> createState() => _CoverAudioState();
}

class _CoverAudioState extends State<_CoverAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: AudioPlayer(
        controller: _controller,
        title: 'Cover story',
        subtitle: 'Side A',
        cover: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)],
            ),
          ),
          child: const Icon(
            LucideIcons.music,
            size: 24,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

/// Waveform slot replacing the progress bar.
class _WaveformAudio extends StatefulWidget {
  const _WaveformAudio();

  @override
  State<_WaveformAudio> createState() => _WaveformAudioState();
}

class _WaveformAudioState extends State<_WaveformAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: AudioPlayer(
        controller: _controller,
        title: 'Waveform mix',
        waveformBuilder: (context, c, defaults) => GestureDetector(
          onTapDown: (_) => c.seekTo(c.duration * 0.75),
          child: SizedBox(
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 32; i++)
                  Container(
                    width: 4,
                    height: 8 + (i % 5) * 3.0,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    color: const Color(0xFF71717A),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Skip back/forward and speed controls.
class _SkipAudio extends StatefulWidget {
  const _SkipAudio();

  @override
  State<_SkipAudio> createState() => _SkipAudioState();
}

class _SkipAudioState extends State<_SkipAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    playbackSpeed: 1.5,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: AudioPlayer(
        controller: _controller,
        title: 'Skip demo',
        skipBack: const Duration(seconds: 15),
        skipForward: const Duration(seconds: 30),
      ),
    );
  }
}

/// Customized theme plus a custom play button.
class _CustomAudio extends StatefulWidget {
  const _CustomAudio();

  @override
  State<_CustomAudio> createState() => _CustomAudioState();
}

class _CustomAudioState extends State<_CustomAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: AudioPlayer(
        controller: _controller,
        title: 'Custom theme',
        subtitle: 'Rose accent',
        theme: const AudioPlayerTheme(
          accent: ThemedColor.value(Color(0xFFE11D48)),
          controlSize: 48,
        ),
        playButtonBuilder: (context, c) => GestureDetector(
          onTap: c.toggle,
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFE11D48),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              c.isPlaying ? LucideIcons.pause : LucideIcons.play,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultAudio();
Widget _comfortable(BuildContext context) => const _ComfortableAudio();
Widget _phone(BuildContext context) => const _PhoneAudio();
Widget _speedMenuOpen(BuildContext context) => const _SpeedMenuOpenAudio();
Widget _compact(BuildContext context) => const _CompactAudio();
Widget _cover(BuildContext context) => const _CoverAudio();
Widget _waveform(BuildContext context) => const _WaveformAudio();
Widget _skip(BuildContext context) => const _SkipAudio();
Widget _custom(BuildContext context) => const _CustomAudio();

/// Named docs examples for `audio_player`; the first entry is the default.
const List<ComponentPreview> audioPlayerPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Comfortable', _comfortable),
  ComponentPreview('Phone width', _phone),
  ComponentPreview('Speed menu open', _speedMenuOpen),
  ComponentPreview('Compact', _compact),
  ComponentPreview('Cover art', _cover),
  ComponentPreview('Waveform slot', _waveform),
  ComponentPreview('Skip and speed', _skip),
  ComponentPreview('Customized', _custom),
];
