// Named examples for the `audio_player` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Every example
// owns its `FakeAudioPlaybackController` and shrink-wraps in a bounded box.
// The playlist examples use the three SPEC reference tracks.
//
// Flexible widths: each example caps at its SPEC width (360 compact card,
// 420 pill, 320 phone) but shrinks to the stage when narrower (375 phone
// stage ~295, 1280 desktop stage ~560), so no card overflows by 300 px.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'audio_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Density gap for the shared example (12 px at the default density).
double _gapMd(BuildContext context) {
  final ThemeData ambient = Theme.of(context);
  return ambient.density.baseGap * ambient.scaling * gapMd;
}

/// Gradient cover used by the previews (the live app passes real artwork).
Widget _coverArt(List<Color> colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: const Icon(LucideIcons.music, size: 56, color: Color(0xFFFFFFFF)),
  );
}

/// Default: expanded card on the three-track SPEC playlist.
class _DefaultAudio extends StatefulWidget {
  const _DefaultAudio();

  @override
  State<_DefaultAudio> createState() => _DefaultAudioState();
}

class _DefaultAudioState extends State<_DefaultAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      360,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.full,
        cover: _coverArt(const <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)]),
      ),
    );
  }
}

/// Compact pill on the SPEC playlist (single shared controller concept).
class _CompactAudio extends StatefulWidget {
  const _CompactAudio();

  @override
  State<_CompactAudio> createState() => _CompactAudioState();
}

class _CompactAudioState extends State<_CompactAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    isPlaying: true,
    position: const Duration(minutes: 1, seconds: 1),
    duration: const Duration(minutes: 5, seconds: 40),
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      420,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.compact,
        onDownload: () {},
      ),
    );
  }
}

/// Expanded card, second track selected.
class _ExpandedAudio extends StatefulWidget {
  const _ExpandedAudio();

  @override
  State<_ExpandedAudio> createState() => _ExpandedAudioState();
}

class _ExpandedAudioState extends State<_ExpandedAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
    currentIndex: 1,
    position: const Duration(seconds: 29),
    duration: const Duration(minutes: 6, seconds: 12),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      360,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.full,
        cover: _coverArt(const <Color>[Color(0xFF0EA5E9), Color(0xFF312E81)]),
      ),
    );
  }
}

/// One controller drives the compact pill and the expanded card together.
class _SharedAudio extends StatefulWidget {
  const _SharedAudio();

  @override
  State<_SharedAudio> createState() => _SharedAudioState();
}

class _SharedAudioState extends State<_SharedAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      360,
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AudioPlayer(
              controller: _controller,
              variant: AudioPlayerVariant.compact,
              onDownload: () {},
            ),
            SizedBox(height: _gapMd(context)),
            AudioPlayer(
              controller: _controller,
              variant: AudioPlayerVariant.full,
              cover: _coverArt(const <Color>[
                Color(0xFF059669),
                Color(0xFF10B981),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact pill at phone width (volume icon stays, slider overlays).
class _PhoneAudio extends StatefulWidget {
  const _PhoneAudio();

  @override
  State<_PhoneAudio> createState() => _PhoneAudioState();
}

class _PhoneAudioState extends State<_PhoneAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      320,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.compact,
        onDownload: () {},
      ),
    );
  }
}

/// Customized theme plus a custom play button and download slot.
class _CustomAudio extends StatefulWidget {
  const _CustomAudio();

  @override
  State<_CustomAudio> createState() => _CustomAudioState();
}

class _CustomAudioState extends State<_CustomAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      360,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.full,
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
Widget _compact(BuildContext context) => const _CompactAudio();
Widget _expanded(BuildContext context) => const _ExpandedAudio();
Widget _shared(BuildContext context) => const _SharedAudio();
Widget _phone(BuildContext context) => const _PhoneAudio();
Widget _custom(BuildContext context) => const _CustomAudio();

/// Named docs examples for `audio_player`; the first entry is the default.
const List<ComponentPreview> audioPlayerPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Compact', _compact),
  ComponentPreview('Expanded card', _expanded),
  ComponentPreview('Shared playlist', _shared),
  ComponentPreview('Phone width', _phone),
  ComponentPreview('Customized', _custom),
];
