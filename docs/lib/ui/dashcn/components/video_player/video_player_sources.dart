// Sources and cues for `video_player` (SPEC: online MP4, live stream,
// live camera + WebVTT-style caption cues).
//
// Split from `video_player_controller.dart` so both files stay small.

/// Standard speed steps for video (SPEC: 0.5x to 3x).
const List<double> kVideoSpeeds = <double>[0.5, 1, 1.25, 1.5, 2, 3];

/// One selectable video source (SPEC: online MP4, live stream, live camera).
///
/// The kit never fetches [uri]: the docs app wires `package:video_player`
/// to it. The camera entry has no URI and shows a fallback message when
/// permission is denied.
class VideoSource {
  /// Creates a video source.
  const VideoSource({
    required this.label,
    required this.detail,
    this.uri,
    this.isLive = false,
    this.isCamera = false,
  });

  /// Short label shown in the docs example switcher.
  final String label;

  /// Subtitle line (file name, stream kind).
  final String detail;

  /// Playable URL; null for the camera feed.
  final String? uri;

  /// Whether this is a live source (LIVE badge, no total duration).
  final bool isLive;

  /// Whether this is the camera feed (fallback message when denied).
  final bool isCamera;
}

/// The three SPEC sources, in order.
const List<VideoSource> demoVideoSources = <VideoSource>[
  VideoSource(
    label: 'Online MP4',
    detail: 'Butterfly.mp4',
    uri:
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ),
  VideoSource(
    label: 'Live stream',
    detail: 'HLS test stream',
    uri: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
    isLive: true,
  ),
  VideoSource(
    label: 'Live feed',
    detail: 'Camera (fallback message when denied)',
    isLive: true,
    isCamera: true,
  ),
];

/// One caption cue with a start, end and text.
class VideoCaptionCue {
  /// Creates a caption cue.
  const VideoCaptionCue({
    required this.start,
    required this.end,
    required this.text,
  });

  /// Cue start timestamp.
  final Duration start;

  /// Cue end timestamp.
  final Duration end;

  /// Cue text to display.
  final String text;

  /// Whether this cue is active at [position].
  bool isActive(Duration position) => position >= start && position <= end;
}
