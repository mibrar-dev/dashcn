// Controller for the `overflow_marquee` component: programmatic play/pause
// and reset controls.

import 'package:flutter/foundation.dart';

/// Controls playback of an [OverflowMarquee].
///
/// Enables callers to pause, resume, toggle, or reset the scrolling
/// animation from outside the widget subtree (controlled mode).
class MarqueeController extends ChangeNotifier {
  /// Creates a marquee controller.
  MarqueeController({bool isPlaying = true}) : _playing = isPlaying;

  bool _playing;

  /// Whether the marquee is actively playing (scrolling).
  bool get isPlaying => _playing;

  /// Whether the marquee is paused.
  bool get isPaused => !_playing;

  /// Pauses the marquee animation.
  void pause() {
    if (!_playing) return;
    _playing = false;
    notifyListeners();
  }

  /// Resumes the marquee animation.
  void resume() {
    if (_playing) return;
    _playing = true;
    notifyListeners();
  }

  /// Toggles between playing and paused states.
  void toggle() {
    _playing = !_playing;
    notifyListeners();
  }
}
