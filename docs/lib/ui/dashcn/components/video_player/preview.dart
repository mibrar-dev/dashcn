// Named examples for the `video_player` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Every example
// owns its `FakeVideoPlaybackController` and shrink-wraps in a bounded box.
// The source examples map to the three SPEC sources: online MP4, live stream
// URL and live camera feed (fallback message when permission is denied).

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import 'video_player.dart';

/// Gradient frame used by the previews (the live app plugs the texture).
Widget _frame(List<Color> colors, String label) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Default player: online MP4 with title and subtitle header.
class _DefaultVideo extends StatefulWidget {
  const _DefaultVideo();

  @override
  State<_DefaultVideo> createState() => _DefaultVideoState();
}

class _DefaultVideoState extends State<_DefaultVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    sourceLabel: demoVideoSources[0].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
          content: _frame(const <Color>[
            Color(0xFF312E81),
            Color(0xFF0EA5E9),
          ], 'Online MP4'),
        ),
      ),
    );
  }
}

/// Live stream source: LIVE badge, no total duration.
class _LiveVideo extends StatefulWidget {
  const _LiveVideo();

  @override
  State<_LiveVideo> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<_LiveVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    isPlaying: true,
    isLive: demoVideoSources[1].isLive,
    sourceLabel: demoVideoSources[1].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'Live stream',
          subtitle: 'HLS test stream',
          content: _frame(const <Color>[
            Color(0xFF7F1D1D),
            Color(0xFFDC2626),
          ], 'LIVE'),
        ),
      ),
    );
  }
}

/// Live camera feed: fallback message when permission is denied.
class _CameraVideo extends StatefulWidget {
  const _CameraVideo();

  @override
  State<_CameraVideo> createState() => _CameraVideoState();
}

class _CameraVideoState extends State<_CameraVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    isLive: demoVideoSources[2].isLive,
    sourceLabel: demoVideoSources[2].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'Live feed',
          subtitle: 'Camera',
          content: Container(
            color: const Color(0xFF18181B),
            alignment: Alignment.center,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(LucideIcons.cameraOff, size: 32, color: Color(0xFFFFFFFF)),
                SizedBox(height: 8),
                Text(
                  'Camera unavailable — permission denied',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Player with the more (speed) menu opened.
class _SpeedMenuOpenVideo extends StatefulWidget {
  const _SpeedMenuOpenVideo();

  @override
  State<_SpeedMenuOpenVideo> createState() => _SpeedMenuOpenVideoState();
}

class _SpeedMenuOpenVideoState extends State<_SpeedMenuOpenVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    playbackSpeed: 1.25,
    sourceLabel: demoVideoSources[0].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
          controlsBuilder: (context, c, defaults) => VideoControlsBar(
            controller: c,
            style: videoPlayerDefaults,
            fg: const Color(0xFFFFFFFF),
            fade: Duration.zero,
            title: 'For Bigger Blazes',
            subtitle: 'Season 3 episode 6',
            initialSpeedOpen: true,
          ),
          content: _frame(const <Color>[
            Color(0xFF4C1D95),
            Color(0xFF7C3AED),
          ], 'Speed menu open'),
        ),
      ),
    );
  }
}

/// Player with captions on (WebVTT-style cues).
class _CaptionsVideo extends StatefulWidget {
  const _CaptionsVideo();

  @override
  State<_CaptionsVideo> createState() => _CaptionsVideoState();
}

class _CaptionsVideoState extends State<_CaptionsVideo> {
  late final FakeVideoPlaybackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FakeVideoPlaybackController(
      position: const Duration(seconds: 12),
      areCaptionsEnabled: true,
      cues: const <VideoCaptionCue>[
        VideoCaptionCue(
          start: Duration(seconds: 10),
          end: Duration(seconds: 15),
          text: 'Hello, world',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'Captioned premiere',
          subtitle: 'English subtitles',
          content: _frame(const <Color>[
            Color(0xFF0F172A),
            Color(0xFF334155),
          ], 'Captions on'),
        ),
      ),
    );
  }
}

/// Player with the control bar hidden (auto-hide state while playing).
class _BarHiddenVideo extends StatefulWidget {
  const _BarHiddenVideo();

  @override
  State<_BarHiddenVideo> createState() => _BarHiddenVideoState();
}

class _BarHiddenVideoState extends State<_BarHiddenVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    isPlaying: true,
    sourceLabel: demoVideoSources[0].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          controlsVisible: false,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
          content: _frame(const <Color>[
            Color(0xFF047857),
            Color(0xFF10B981),
          ], 'Bar hidden'),
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
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    sourceLabel: demoVideoSources[0].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
          content: _frame(const <Color>[
            Color(0xFF1E1B4B),
            Color(0xFF4338CA),
          ], 'Phone width'),
        ),
      ),
    );
  }
}

/// Customized theme and custom play button.
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
      width: 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'Custom theme',
          subtitle: 'Rose accent',
          content: const ColoredBox(color: Color(0xFF3F3F46)),
          theme: const VideoPlayerTheme(
            accent: ThemedColor.value(Color(0xFFE11D48)),
            controlSize: 64,
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
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultVideo();
Widget _live(BuildContext context) => const _LiveVideo();
Widget _camera(BuildContext context) => const _CameraVideo();
Widget _speedMenuOpen(BuildContext context) => const _SpeedMenuOpenVideo();
Widget _captions(BuildContext context) => const _CaptionsVideo();
Widget _barHidden(BuildContext context) => const _BarHiddenVideo();
Widget _phone(BuildContext context) => const _PhoneVideo();
Widget _custom(BuildContext context) => const _CustomVideo();

/// Named docs examples for `video_player`; the first entry is the default.
const List<ComponentPreview> videoPlayerPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Live stream', _live),
  ComponentPreview('Camera fallback', _camera),
  ComponentPreview('Speed menu open', _speedMenuOpen),
  ComponentPreview('Captions on', _captions),
  ComponentPreview('Bar hidden', _barHidden),
  ComponentPreview('Phone width', _phone),
  ComponentPreview('Customized', _custom),
];
