// Named examples for the `video_player` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Every example
// owns its `FakeVideoPlaybackController` and shrink-wraps in a bounded box.
// The source examples map to the three SPEC sources: online MP4, live stream
// URL and live camera feed (fallback message when permission is denied).
//
// Flexible widths: each example caps at its SPEC width (640 desktop, 320
// phone) but shrinks to the stage when narrower (375 phone stage ~295,
// 1280 desktop stage ~560), so no card overflows.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import 'video_player.dart';

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
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: docsSample(context, 'For Bigger Blazes'),
          subtitle: docsSample(context, 'Season 3 episode 6'),
          content: _frame(const <Color>[
            Color(0xFF312E81),
            Color(0xFF0EA5E9),
          ], docsSample(context, 'Online MP4')),
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
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: docsSample(context, 'Live stream'),
          subtitle: docsSample(context, 'HLS test stream'),
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
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: docsSample(context, 'Live feed'),
          subtitle: docsSample(context, 'Camera'),
          content: Container(
            color: const Color(0xFF18181B),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(LucideIcons.cameraOff, size: 32, color: Color(0xFFFFFFFF)),
                SizedBox(height: 8),
                Text(
                  docsSample(context, 'Camera unavailable — permission denied'),
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
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: docsSample(context, 'For Bigger Blazes'),
          subtitle: docsSample(context, 'Season 3 episode 6'),
          controlsBuilder: (context, c, defaults) => VideoControlsBar(
            controller: c,
            style: videoPlayerDefaults,
            fg: const Color(0xFFFFFFFF),
            fade: Duration.zero,
            title: docsSample(context, 'For Bigger Blazes'),
            subtitle: docsSample(context, 'Season 3 episode 6'),
            initialSpeedOpen: true,
          ),
          content: _frame(const <Color>[
            Color(0xFF4C1D95),
            Color(0xFF7C3AED),
          ], docsSample(context, 'Speed menu open')),
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
      cues: <VideoCaptionCue>[
        VideoCaptionCue(
          start: Duration(seconds: 10),
          end: Duration(seconds: 15),
          text: docsSample(context, 'Hello, world'),
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
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: docsSample(context, 'Captioned premiere'),
          subtitle: docsSample(context, 'English subtitles'),
          content: _frame(const <Color>[
            Color(0xFF0F172A),
            Color(0xFF334155),
          ], docsSample(context, 'Captions on')),
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
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          controlsVisible: false,
          title: docsSample(context, 'For Bigger Blazes'),
          subtitle: docsSample(context, 'Season 3 episode 6'),
          content: _frame(const <Color>[
            Color(0xFF047857),
            Color(0xFF10B981),
          ], docsSample(context, 'Bar hidden')),
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
    return _capped(
      320,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: docsSample(context, 'For Bigger Blazes'),
          subtitle: docsSample(context, 'Season 3 episode 6'),
          content: _frame(const <Color>[
            Color(0xFF1E1B4B),
            Color(0xFF4338CA),
          ], docsSample(context, 'Phone width')),
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
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: docsSample(context, 'Custom theme'),
          subtitle: docsSample(context, 'Rose accent'),
          content: const ColoredBox(color: Color(0xFF3F3F46)),
          theme: const VideoPlayerTheme(
            accent: ThemedColor.value(Color(0xFFE11D48)),
            controlSize: 56,
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
List<ComponentPreview> get videoPlayerPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Live stream'), _live),
  ComponentPreview(docsSample(null, 'Camera fallback'), _camera),
  ComponentPreview(docsSample(null, 'Speed menu open'), _speedMenuOpen),
  ComponentPreview(docsSample(null, 'Captions on'), _captions),
  ComponentPreview(docsSample(null, 'Bar hidden'), _barHidden),
  ComponentPreview(docsSample(null, 'Phone width'), _phone),
  ComponentPreview(docsSample(null, 'Customized'), _custom),
];
