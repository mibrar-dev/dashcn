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
import 'dart:math';

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
      player.bufferedPositionStream.listen((_) => notifyListeners()),
      player.playerStateStream.listen((_) => notifyListeners()),
      player.playingStream.listen((_) => notifyListeners()),
      player.volumeStream.listen((_) => notifyListeners()),
      player.speedStream.listen((_) => notifyListeners()),
      player.loopModeStream.listen((_) => notifyListeners()),
    ]);
  }

  /// The wrapped audio player; owned by the caller.
  final audio.AudioPlayer player;

  final List<StreamSubscription<Object?>> _subscriptions =
      <StreamSubscription<Object?>>[];

  double _unmutedVolume = 1;

  List<AudioTrack> _tracks = const <AudioTrack>[];
  int _currentIndex = 0;
  bool _shuffled = false;
  Object? _error;
  final Random _random = Random();

  /// Clears the last reported error.
  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _fail(Object error) {
    _error = error;
    notifyListeners();
  }

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
  Object? get error => _error;

  @override
  Future<void> play() async {
    try {
      await player.play();
    } catch (error) {
      _fail(error);
      rethrow;
    }
  }

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seekTo(Duration position) {
    final Duration end = duration <= Duration.zero ? position : duration;
    final Duration target = position <= Duration.zero
        ? Duration.zero
        : (position >= end ? end : position);
    return player.seek(target);
  }

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

  /// Playlist: live URL, downloaded file or live stream per track.
  @override
  List<AudioTrack> get tracks => _tracks;

  @override
  int get currentIndex => _currentIndex;

  /// Loads a queue; the first (or [index]) track starts loading.
  Future<void> setTracks(List<AudioTrack> tracks, {int index = 0}) async {
    _tracks = tracks;
    _currentIndex = tracks.isEmpty ? 0 : index.clamp(0, tracks.length - 1);
    clearError();
    await _loadCurrent(autoPlay: false);
    notifyListeners();
  }

  Future<void> _loadCurrent({bool autoPlay = true}) async {
    final AudioTrack? track = currentTrack;
    final String? src = track?.src;
    if (src == null) return;
    try {
      if (src.startsWith('http')) {
        await player.setUrl(src);
      } else {
        await player.setFilePath(src);
      }
      clearError();
      if (autoPlay) await play();
    } catch (error) {
      _fail(error);
      rethrow;
    }
  }

  @override
  Future<void> next() async {
    if (!hasNext) return;
    if (_shuffled && _tracks.length > 1) {
      int pick = _currentIndex;
      while (pick == _currentIndex) {
        pick = _random.nextInt(_tracks.length);
      }
      _currentIndex = pick;
    } else {
      _currentIndex++;
    }
    await _loadCurrent();
    notifyListeners();
  }

  @override
  Future<void> previous() async {
    if (!hasPrevious) {
      await seekTo(Duration.zero);
      return;
    }
    if (_shuffled && _tracks.length > 1) {
      int pick = _currentIndex;
      while (pick == _currentIndex) {
        pick = _random.nextInt(_tracks.length);
      }
      _currentIndex = pick;
    } else {
      _currentIndex--;
    }
    await _loadCurrent();
    notifyListeners();
  }

  @override
  Future<void> setTrack(int index) async {
    if (_tracks.isEmpty) return;
    _currentIndex = index.clamp(0, _tracks.length - 1);
    await _loadCurrent();
    notifyListeners();
  }

  @override
  bool get isShuffled => _shuffled;

  @override
  Future<void> setShuffled(bool shuffled) async {
    _shuffled = shuffled;
    await player.setShuffleModeEnabled(shuffled);
    notifyListeners();
  }

  @override
  void dispose() {
    for (final StreamSubscription<Object?> sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }
}
