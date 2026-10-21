// Docs-only adapter: `package:video_player` -> [VideoPlaybackController].
//
// The kit (`dashcn/`) stays dependency-free: it only knows the small
// controller interface. This file lives in the docs app, which is allowed
// plugin dependencies (see `docs/pubspec.yaml`: `video_player`).
//
// Usage:
// ```dart
// final inner = VideoPlayerController.networkUrl(Uri.parse(url));
// await inner.initialize();
// final controller = PluginVideoAdapter(inner);
// VideoPlayer(controller: controller, content: controller.buildView());
// // ... later:
// controller.dispose(); // stops forwarding; does NOT dispose `inner`.
// inner.dispose();
// ```

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart' as plugin;

import '../ui/dashcn/components/video_player/video_player.dart';

/// Bridges a `package:video_player` controller to the kit interface.
///
/// The plugin controller is owned by the caller (it is never disposed here);
/// this adapter only forwards state and calls. Muting is emulated by
/// parking the volume at 0 and restoring it on unmute.
class PluginVideoAdapter extends VideoPlaybackController {
  /// Creates an adapter forwarding [inner].
  PluginVideoAdapter(this.inner) {
    inner.addListener(_forward);
  }

  /// The wrapped plugin controller; owned by the caller.
  final plugin.VideoPlayerController inner;

  double _unmutedVolume = 1;
  bool _isLive = false;
  String? _sourceLabel;

  void _forward() => notifyListeners();

  /// Marks the current source live (LIVE badge, no total) with a label.
  void setSource({required bool isLive, String? label}) {
    _isLive = isLive;
    _sourceLabel = label;
    notifyListeners();
  }

  @override
  bool get isLive => _isLive;

  @override
  String? get sourceLabel => _sourceLabel;

  @override
  Duration get position => inner.value.position;

  @override
  Duration get duration => inner.value.duration;

  @override
  Duration get buffered {
    final List<plugin.DurationRange> ranges = inner.value.buffered;
    if (ranges.isEmpty) return Duration.zero;
    return ranges.last.end;
  }

  @override
  double get volume => inner.value.volume;

  @override
  bool get isMuted => inner.value.volume <= 0;

  @override
  double get playbackSpeed => inner.value.playbackSpeed;

  @override
  bool get isPlaying => inner.value.isPlaying;

  @override
  bool get isBuffering => inner.value.isBuffering;

  @override
  bool get isLooping => inner.value.isLooping;

  @override
  Object? get error =>
      inner.value.hasError ? inner.value.errorDescription : null;

  /// The plugin texture view for the player's `content` slot.
  Widget buildView() => plugin.VideoPlayer(inner);

  @override
  Future<void> play() => inner.play();

  @override
  Future<void> pause() => inner.pause();

  @override
  Future<void> seekTo(Duration position) => inner.seekTo(position);

  @override
  Future<void> setVolume(double volume) {
    if (volume > 0) _unmutedVolume = volume;
    return inner.setVolume(volume);
  }

  @override
  Future<void> setMuted(bool muted) {
    return inner.setVolume(muted ? 0 : _unmutedVolume);
  }

  @override
  Future<void> setPlaybackSpeed(double speed) => inner.setPlaybackSpeed(speed);

  @override
  Future<void> setLooping(bool looping) => inner.setLooping(looping);

  @override
  void dispose() {
    inner.removeListener(_forward);
    super.dispose();
  }
}
