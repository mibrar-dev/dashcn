// Named examples for the `video_player` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Every example
// owns its `FakeVideoPlaybackController` and shrink-wraps in a bounded box.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import 'video_player.dart';

/// Default player with compact density.
class _DefaultVideo extends StatefulWidget {
  const _DefaultVideo();

  @override
  State<_DefaultVideo> createState() => _DefaultVideoState();
}

class _DefaultVideoState extends State<_DefaultVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(
          controller: _controller,
          content: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF312E81), Color(0xFF0EA5E9)],
              ),
            ),
            child: const Text(
              'Demo frame',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Player with comfortable density tokens.
class _ComfortableVideo extends StatefulWidget {
  const _ComfortableVideo();

  @override
  State<_ComfortableVideo> createState() => _ComfortableVideoState();
}

class _ComfortableVideoState extends State<_ComfortableVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(
          controller: _controller,
          theme: const VideoPlayerTheme(
            controlSize: 56,
            iconSize: 20,
            controlsPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          content: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF0F172A), Color(0xFF334155)],
              ),
            ),
            child: const Text(
              'Comfortable density',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Player scaled for phone width.
class _PhoneVideo extends StatefulWidget {
  const _PhoneVideo();

  @override
  State<_PhoneVideo> createState() => _PhoneVideoState();
}

class _PhoneVideoState extends State<_PhoneVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(
          controller: _controller,
          content: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF1E1B4B), Color(0xFF4338CA)],
              ),
            ),
            child: const Text(
              'Phone width (320px)',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Player with control bar visible.
class _ControlBarOpenVideo extends StatefulWidget {
  const _ControlBarOpenVideo();

  @override
  State<_ControlBarOpenVideo> createState() => _ControlBarOpenVideoState();
}

class _ControlBarOpenVideoState extends State<_ControlBarOpenVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    isPlaying: false,
    position: const Duration(minutes: 1, seconds: 15),
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
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(
          controller: _controller,
          content: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF047857), Color(0xFF10B981)],
              ),
            ),
            child: const Text(
              'Control bar open',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Player with speed menu opened.
class _SpeedMenuOpenVideo extends StatefulWidget {
  const _SpeedMenuOpenVideo();

  @override
  State<_SpeedMenuOpenVideo> createState() => _SpeedMenuOpenVideoState();
}

class _SpeedMenuOpenVideoState extends State<_SpeedMenuOpenVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    playbackSpeed: 1.25,
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
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(
          controller: _controller,
          controlsBuilder: (context, c, defaults) => VideoControlsBar(
            controller: c,
            style: videoPlayerDefaults,
            fg: const Color(0xFFFFFFFF),
            fade: Duration.zero,
            initialSpeedOpen: true,
          ),
          content: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF4C1D95), Color(0xFF7C3AED)],
              ),
            ),
            child: const Text(
              'Speed menu open',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Player with a poster still and captions.
class _PosterVideo extends StatefulWidget {
  const _PosterVideo();

  @override
  State<_PosterVideo> createState() => _PosterVideoState();
}

class _PosterVideoState extends State<_PosterVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    position: Duration.zero,
    duration: const Duration(minutes: 2, seconds: 5),
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
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(
          controller: _controller,
          poster: Container(
            color: const Color(0xFF18181B),
            alignment: Alignment.center,
            child: const Icon(LucideIcons.image, size: 40),
          ),
          captions: const Text('Captions: hello, world'),
        ),
      ),
    );
  }
}

/// Loading state with the indicator slot.
class _LoadingVideo extends StatefulWidget {
  const _LoadingVideo();

  @override
  State<_LoadingVideo> createState() => _LoadingVideoState();
}

class _LoadingVideoState extends State<_LoadingVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    isBuffering: true,
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
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(controller: _controller),
      ),
    );
  }
}

/// Error state with a retry slot.
class _ErrorVideo extends StatefulWidget {
  const _ErrorVideo();

  @override
  State<_ErrorVideo> createState() => _ErrorVideoState();
}

class _ErrorVideoState extends State<_ErrorVideo> {
  late final FakeVideoPlaybackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FakeVideoPlaybackController();
    _controller.setError(Exception('network'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(controller: _controller),
      ),
    );
  }
}

/// Fullscreen callback demo.
class _FullscreenVideo extends StatefulWidget {
  const _FullscreenVideo();

  @override
  State<_FullscreenVideo> createState() => _FullscreenVideoState();
}

class _FullscreenVideoState extends State<_FullscreenVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController();
  String _status = 'windowed';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 360,
          child: ColoredBox(
            color: const Color(0xFF000000),
            child: VideoPlayer(
              controller: _controller,
              content: const ColoredBox(color: Color(0xFF27272A)),
              onFullscreenRequested: () =>
                  setState(() => _status = 'fullscreen requested'),
            ),
          ),
        ),
        Text(_status),
      ],
    );
  }
}

/// Customized theme, custom scrub colours and a custom play button.
class _CustomVideo extends StatefulWidget {
  const _CustomVideo();

  @override
  State<_CustomVideo> createState() => _CustomVideoState();
}

class _CustomVideoState extends State<_CustomVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
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
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: VideoPlayer(
          controller: _controller,
          content: const ColoredBox(color: Color(0xFF3F3F46)),
          theme: const VideoPlayerTheme(
            accent: ThemedColor.value(Color(0xFFE11D48)),
            controlSize: 64,
          ),
          playButtonBuilder: (context, c) => GestureDetector(
            onTap: c.toggle,
            child: Container(
              width: 64,
              height: 64,
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
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultVideo();
Widget _comfortable(BuildContext context) => const _ComfortableVideo();
Widget _phone(BuildContext context) => const _PhoneVideo();
Widget _controlBarOpen(BuildContext context) => const _ControlBarOpenVideo();
Widget _speedMenuOpen(BuildContext context) => const _SpeedMenuOpenVideo();
Widget _poster(BuildContext context) => const _PosterVideo();
Widget _loading(BuildContext context) => const _LoadingVideo();
Widget _error(BuildContext context) => const _ErrorVideo();
Widget _fullscreen(BuildContext context) => const _FullscreenVideo();
Widget _custom(BuildContext context) => const _CustomVideo();

/// Named docs examples for `video_player`; the first entry is the default.
const List<ComponentPreview> videoPlayerPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Comfortable', _comfortable),
  ComponentPreview('Phone width', _phone),
  ComponentPreview('Control bar open', _controlBarOpen),
  ComponentPreview('Speed menu open', _speedMenuOpen),
  ComponentPreview('Poster and captions', _poster),
  ComponentPreview('Loading', _loading),
  ComponentPreview('Error', _error),
  ComponentPreview('Fullscreen callback', _fullscreen),
  ComponentPreview('Customized', _custom),
];
