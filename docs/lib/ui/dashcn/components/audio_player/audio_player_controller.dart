// Dependency-free playback controller for the `audio_player` component.
//
// The kit ships no media plugin: the UI drives this small `ChangeNotifier`
// interface (play, pause, seek, position, duration, buffered, volume, mute,
// speed, playlist, shuffle, looping). `FakeAudioPlaybackController` backs
// previews and tests; the docs app wires `package:just_audio` to it.

import 'package:flutter/widgets.dart';

/// Standard speed steps for audio (SPEC: 1x, 1.25x, 1.5x, 2x, 3x).
const List<double> kAudioSpeeds = <double>[1, 1.25, 1.5, 2, 3];

/// One playable audio track: live URL, downloaded file or live stream.
///
/// The kit never fetches [src]: the docs app adapter (`just_audio`) loads it.
/// Previews and tests use the title/artist/cover only.
class AudioTrack {
  /// Creates a track.
  const AudioTrack({
    required this.title,
    required this.artist,
    this.coverUrl,
    this.src,
  });

  /// Track title (compact pill truncates with ellipsis).
  final String title;

  /// Artist name (expanded card shows it uppercase, letter-spaced).
  final String artist;

  /// Cover art URL for the expanded card.
  final String? coverUrl;

  /// Playable source: live URL, file path/URL or live stream URL.
  final String? src;
}

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

  /// Optional transcript / lyric cues.
  List<String> get cues => const <String>[];

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

  /// Cycles to the next entry of [speeds] (wraps around).
  Future<void> cycleSpeed([List<double> speeds = kAudioSpeeds]) {
    final List<double> steps = speeds.isEmpty ? const <double>[1] : speeds;
    int next = steps.indexWhere((s) => s > playbackSpeed + 1e-9);
    if (next < 0) next = 0;
    return setPlaybackSpeed(steps[next]);
  }

  /// Enables or disables looping.
  Future<void> setLooping(bool looping);

  // -- Playlist (one shared controller drives compact + expanded) ----------

  /// Tracks in the queue; empty when the player is source-agnostic.
  List<AudioTrack> get tracks => const <AudioTrack>[];

  /// Index of the current track into [tracks].
  int get currentIndex => 0;

  /// The current track, or null when [tracks] is empty.
  AudioTrack? get currentTrack =>
      tracks.isEmpty ? null : tracks[currentIndex.clamp(0, tracks.length - 1)];

  /// Whether a next track exists.
  bool get hasNext => currentIndex + 1 < tracks.length;

  /// Whether a previous track exists.
  bool get hasPrevious => currentIndex > 0;

  /// Moves to the next track; no-op when [hasNext] is false.
  Future<void> next() async {}

  /// Moves to the previous track; no-op when [hasPrevious] is false.
  Future<void> previous() async {}

  /// Jumps to [index], clamped into [tracks].
  Future<void> setTrack(int index) async {}

  /// Whether shuffle is on.
  bool get isShuffled => false;

  /// Enables or disables shuffle.
  Future<void> setShuffled(bool shuffled) async {}

  /// Toggles shuffle.
  Future<void> toggleShuffle() => setShuffled(!isShuffled);
}
