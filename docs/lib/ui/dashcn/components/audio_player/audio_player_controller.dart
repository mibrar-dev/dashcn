// Dependency-free playback controller for the `audio_player` component.
//
// The kit ships no media plugin: the UI drives this small `ChangeNotifier`
// interface (play, pause, seek, position, duration, buffered, volume, mute,
// speed, looping). `FakeAudioPlaybackController` backs previews and tests.

import 'package:flutter/widgets.dart';

/// Minimal playback surface the audio UI needs.
abstract class AudioPlaybackController extends ChangeNotifier {
  /// Current playhead.
  Duration get position;

  /// Total length; zero when unknown.
  Duration get duration;

  /// Buffered-ahead point.
  Duration get buffered;

  /// Volume 0..1.
  double get volume;

  /// Whether output is muted.
  bool get isMuted;

  /// Speed multiplier (1 = normal).
  double get playbackSpeed;

  /// Whether audio is playing.
  bool get isPlaying;

  /// Whether the player is waiting for data.
  bool get isBuffering;

  /// Whether playback loops at the end.
  bool get isLooping;

  /// Last fatal error, if any.
  Object? get error;

  /// Starts playback.
  Future<void> play();

  /// Pauses playback.
  Future<void> pause();

  /// Toggles play/pause.
  Future<void> toggle() => isPlaying ? pause() : play();

  /// Seeks to [position], clamped to 0..[duration].
  Future<void> seekTo(Duration position);

  /// Seeks relative by [offset].
  Future<void> seekBy(Duration offset) => seekTo(position + offset);

  /// Sets volume 0..1.
  Future<void> setVolume(double volume);

  /// Mutes or unmutes.
  Future<void> setMuted(bool muted);

  /// Sets the speed multiplier.
  Future<void> setPlaybackSpeed(double speed);

  /// Enables or disables looping.
  Future<void> setLooping(bool looping);
}

/// In-memory [AudioPlaybackController] for previews and tests.
///
/// No timers: `play` flips [isPlaying] only. Tests advance with [tick].
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
       _isLooping = isLooping ?? false;

  final Duration _duration;
  Duration _position;
  final Duration _buffered;
  double _volume;
  bool _isMuted;
  double _playbackSpeed;
  bool _isPlaying;
  bool _isBuffering;
  bool _isLooping;
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
  Object? get error => _error;

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
    if (_position >= _duration && _isLooping) {
      _position = Duration.zero;
    } else if (_position >= _duration) {
      _isPlaying = false;
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
}

/// Clamps [value] into 0..[end].
Duration _clampAudioPosition(Duration value, Duration end) {
  if (value <= Duration.zero) return Duration.zero;
  if (value >= end) return end;
  return value;
}
