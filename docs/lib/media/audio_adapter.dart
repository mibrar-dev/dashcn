// Docs-only adapter: `package:just_audio` -> [AudioPlaybackController].
//
// The kit (`dashcn/`) stays dependency-free: it only knows the small
// controller interface. This file lives in the docs app, which is allowed
// plugin dependencies (see `docs/pubspec.yaml`: `just_audio`).
//
// Usage:
// ```dart
// final player = AudioPlayer(); // just_audio
// await player.setUrl(url);
// final controller = JustAudioAdapter(player);
// AudioPlayer(controller: controller, title: 'Episode');
// // ... later:
// controller.dispose(); // cancels subscriptions; does NOT dispose `player`.
// player.dispose();
// ```

import 'dart:async';

import 'package:just_audio/just_audio.dart' as audio;

import '../ui/dashcn/components/audio_player/audio_player.dart';

/// Bridges a `just_audio` player to the kit interface.
///
/// The audio player is owned by the caller (it is never disposed here);
/// this adapter subscribes to its streams and forwards state and calls.
/// Muting is emulated by parking the volume at 0 and restoring it.
class JustAudioAdapter extends AudioPlaybackController {
  /// Creates an adapter forwarding [player].
  JustAudioAdapter(this.player) {
    _subscriptions.addAll(<StreamSubscription<Object?>>[
      player.positionStream.listen((_) => notifyListeners()),
      player.durationStream.listen((_) => notifyListeners()),
      player.playerStateStream.listen((_) => notifyListeners()),
      player.playingStream.listen((_) => notifyListeners()),
      player.volumeStream.listen((_) => notifyListeners()),
      player.speedStream.listen((_) => notifyListeners()),
    ]);
  }

  /// The wrapped audio player; owned by the caller.
  final audio.AudioPlayer player;

  final List<StreamSubscription<Object?>> _subscriptions =
      <StreamSubscription<Object?>>[];

  double _unmutedVolume = 1;

  @override
  Duration get position => player.position;

  @override
  Duration get duration => player.duration ?? Duration.zero;

  @override
  Duration get buffered => player.bufferedPosition;

  @override
  double get volume => player.volume;

  @override
  bool get isMuted => player.volume <= 0;

  @override
  double get playbackSpeed => player.speed;

  @override
  bool get isPlaying => player.playing;

  @override
  bool get isBuffering =>
      player.processingState == audio.ProcessingState.buffering ||
      player.processingState == audio.ProcessingState.loading;

  @override
  bool get isLooping => player.loopMode == audio.LoopMode.one;

  @override
  Object? get error => null;

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seekTo(Duration position) => player.seek(position);

  @override
  Future<void> setVolume(double volume) {
    if (volume > 0) _unmutedVolume = volume;
    return player.setVolume(volume);
  }

  @override
  Future<void> setMuted(bool muted) {
    return player.setVolume(muted ? 0 : _unmutedVolume);
  }

  @override
  Future<void> setPlaybackSpeed(double speed) => player.setSpeed(speed);

  @override
  Future<void> setLooping(bool looping) =>
      player.setLoopMode(looping ? audio.LoopMode.one : audio.LoopMode.off);

  @override
  void dispose() {
    for (final StreamSubscription<Object?> sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }
}
