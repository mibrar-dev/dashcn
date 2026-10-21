// In-memory [AudioPlaybackController] for previews and tests.
//
// No timers: `play` flips [isPlaying] only. Tests advance with [tick].
// Playlist state (tracks, index, shuffle) lets one fake drive the compact
// pill and the expanded card together.

import 'package:flutter/widgets.dart';

import 'audio_player_controller.dart';

/// In-memory playback controller with playlist support.
class FakeAudioPlaybackController extends AudioPlaybackController {
  /// Creates a fake with the given initial state.
  FakeAudioPlaybackController({
    Duration? duration,
    Duration? position,
    Duration? buffered,
    double? volume,
    bool? isMuted,
    double? playbackSpeed,
    bool? isPlaying,
    bool? isBuffering,
    bool? isLooping,
    List<String>? cues,
    List<AudioTrack>? tracks,
    int? currentIndex,
    bool? isShuffled,
    this.onPlay,
    this.onPause,
    this.onSeek,
  }) : _duration = duration ?? const Duration(minutes: 4, seconds: 5),
       _position = position ?? const Duration(minutes: 1, seconds: 12),
       _buffered = buffered ?? const Duration(minutes: 2, seconds: 30),
       _volume = volume ?? 0.8,
       _isMuted = isMuted ?? false,
       _playbackSpeed = playbackSpeed ?? 1.0,
       _isPlaying = isPlaying ?? false,
       _isBuffering = isBuffering ?? false,
       _isLooping = isLooping ?? false,
       _cues = cues ?? const <String>[],
       _tracks = tracks ?? const <AudioTrack>[],
       _currentIndex = (currentIndex ?? 0).clamp(
         0,
         (tracks ?? const <AudioTrack>[]).isEmpty ? 0 : (tracks!.length - 1),
       ),
       _isShuffled = isShuffled ?? false;

  final Duration _duration;
  Duration _position;
  final Duration _buffered;
  double _volume;
  bool _isMuted;
  double _playbackSpeed;
  bool _isPlaying;
  bool _isBuffering;
  bool _isLooping;
  final List<String> _cues;
  final List<AudioTrack> _tracks;
  int _currentIndex;
  bool _isShuffled;
  Object? _error;

  /// Called on play (for callback tests).
  final VoidCallback? onPlay;

  /// Called on pause (for callback tests).
  final VoidCallback? onPause;

  /// Called with every seek target (for callback tests).
  final ValueChanged<Duration>? onSeek;

  @override
  Duration get position => _position;

  @override
  Duration get duration => _duration;

  @override
  Duration get buffered => _buffered;

  @override
  double get volume => _volume;

  @override
  bool get isMuted => _isMuted;

  @override
  double get playbackSpeed => _playbackSpeed;

  @override
  bool get isPlaying => _isPlaying;

  @override
  bool get isBuffering => _isBuffering;

  @override
  bool get isLooping => _isLooping;

  @override
  List<String> get cues => _cues;

  @override
  Object? get error => _error;

  @override
  List<AudioTrack> get tracks => _tracks;

  @override
  int get currentIndex => _currentIndex;

  @override
  bool get isShuffled => _isShuffled;

  /// Puts the controller into a loading state.
  void setBuffering(bool value) {
    _isBuffering = value;
    notifyListeners();
  }

  /// Puts the controller into an error state.
  void setError(Object? value) {
    _error = value;
    notifyListeners();
  }

  /// Advances the playhead without a seek callback.
  void tick(Duration delta) {
    if (_duration <= Duration.zero) return;
    _position = _clampAudioPosition(_position + delta, _duration);
    if (_position >= _duration) {
      if (_isLooping) {
        _position = Duration.zero;
      } else if (hasNext) {
        _currentIndex++;
        _position = Duration.zero;
      } else {
        _isPlaying = false;
      }
    }
    notifyListeners();
  }

  @override
  Future<void> play() async {
    _isPlaying = true;
    onPlay?.call();
    notifyListeners();
  }

  @override
  Future<void> pause() async {
    _isPlaying = false;
    onPause?.call();
    notifyListeners();
  }

  @override
  Future<void> seekTo(Duration position) async {
    final Duration end = _duration <= Duration.zero ? position : _duration;
    _position = _clampAudioPosition(position, end);
    onSeek?.call(_position);
    notifyListeners();
  }

  @override
  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    notifyListeners();
  }

  @override
  Future<void> setMuted(bool muted) async {
    _isMuted = muted;
    notifyListeners();
  }

  @override
  Future<void> setPlaybackSpeed(double speed) async {
    _playbackSpeed = speed;
    notifyListeners();
  }

  @override
  Future<void> setLooping(bool looping) async {
    _isLooping = looping;
    notifyListeners();
  }

  @override
  Future<void> next() async {
    if (!hasNext) return;
    if (_isShuffled && _tracks.length > 1) {
      var idx = _currentIndex;
      var guard = 0;
      while (idx == _currentIndex && guard++ < 8) {
        idx = (_currentIndex + 1 + guard) % _tracks.length;
      }
      _currentIndex = idx;
    } else {
      _currentIndex++;
    }
    _position = Duration.zero;
    notifyListeners();
  }

  @override
  Future<void> previous() async {
    if (!hasPrevious) {
      await seekTo(Duration.zero);
      return;
    }
    _currentIndex--;
    _position = Duration.zero;
    notifyListeners();
  }

  @override
  Future<void> setTrack(int index) async {
    if (_tracks.isEmpty) return;
    _currentIndex = index.clamp(0, _tracks.length - 1);
    _position = Duration.zero;
    notifyListeners();
  }

  @override
  Future<void> setShuffled(bool shuffled) async {
    _isShuffled = shuffled;
    notifyListeners();
  }
}

/// Clamps [value] into 0..[end].
Duration _clampAudioPosition(Duration value, Duration end) {
  if (value <= Duration.zero) return Duration.zero;
  if (value >= end) return end;
  return value;
}
