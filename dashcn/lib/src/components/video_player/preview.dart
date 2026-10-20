// Named examples for the `video_player` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Every example
// owns its `FakeVideoPlaybackController` and shrink-wraps in a bounded box.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import 'video_player.dart';

/// Default player with a poster frame behind the content.
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
      child: VideoPlayer(
        controller: _controller,
        content: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF312E81), Color(0xFF0EA5E9)],
            ),
          ),
          // Explicit light-on-dark demo copy: the harness stage paints the
          // default (dark) text style, which falls below 4.5:1 on this
          // gradient. Real frames are video pixels, not text.
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
      child: VideoPlayer(
        controller: _controller,
        poster: Container(
          color: const Color(0xFF18181B),
          alignment: Alignment.center,
          child: const Icon(LucideIcons.image, size: 40),
        ),
        captions: const Text('Captions: hello, world'),
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
    return SizedBox(width: 360, child: VideoPlayer(controller: _controller));
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
    return SizedBox(width: 360, child: VideoPlayer(controller: _controller));
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
          child: VideoPlayer(
            controller: _controller,
            content: const ColoredBox(color: Color(0xFF27272A)),
            onFullscreenRequested: () =>
                setState(() => _status = 'fullscreen requested'),
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
    );
  }
}

Widget _default(BuildContext context) => const _DefaultVideo();

Widget _poster(BuildContext context) => const _PosterVideo();

Widget _loading(BuildContext context) => const _LoadingVideo();

Widget _error(BuildContext context) => const _ErrorVideo();

Widget _fullscreen(BuildContext context) => const _FullscreenVideo();

Widget _custom(BuildContext context) => const _CustomVideo();

/// Named docs examples for `video_player`; the first entry is the default.
const List<ComponentPreview> videoPlayerPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Poster and captions', _poster),
  ComponentPreview('Loading', _loading),
  ComponentPreview('Error', _error),
  ComponentPreview('Fullscreen callback', _fullscreen),
  ComponentPreview('Customized', _custom),
];
