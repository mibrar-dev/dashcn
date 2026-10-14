// Pull-gesture tracking for the `refresh_trigger` component.
//
// [RefreshPullInput] folds the three input paths — touch drags (scroll
// notifications), mouse drags (raw pointer events; scrollables never claim
// them) and wheel/trackpad ticks (`PointerScrollEvent`, which bypasses the
// gesture arena) — into one transition table, so every path shares the same
// arming extent, settle and snap-back semantics.
//
// Split out of `refresh_trigger.dart` for the ~400-line rule: this file owns
// the pull phase, the trigger state owns the refresh lifecycle. The owner
// drives rebuilds and refreshes through [onChanged]/[onFire], reads [phase]
// and [extent] for display, and writes [atEdge]/[minExtent] from layout and
// theme. Field writes never rebuild on their own; every method that mutates
// pull state calls exactly one of the callbacks.

import 'dart:async';

import 'package:flutter/widgets.dart';

/// Pull phase of [RefreshPullInput]; the trigger's refreshing/completed
/// stages live in the owner state, not here.
enum PullPhase {
  /// Waiting for user interaction.
  idle,

  /// Pulled outward; resolves on release, settle or abandon.
  pulling,
}

/// Tracks one pull gesture for a [RefreshTrigger].
///
/// All three input paths funnel through [accumulate] (grow/shrink the pull)
/// and the path-specific resolvers ([scrollEnd], the wheel settle timer,
/// [mouseUp]/[mouseCancel]), so the arming threshold and the fire/snap-back
/// decision exist exactly once.
class RefreshPullInput {
  /// Creates a pull tracker.
  RefreshPullInput({
    required this.onChanged,
    required this.onFire,
    this.minExtent = 75,
    this.wheelSettle = const Duration(milliseconds: 150),
  });

  /// Called after any mutation the owner must repaint for.
  VoidCallback onChanged;

  /// Called when an armed pull must refresh.
  VoidCallback onFire;

  /// Pull distance arming the refresh; the owner keeps it at the resolved
  /// theme extent.
  double minExtent;

  /// How long wheel ticks wait for more ticks before resolving.
  Duration wheelSettle;

  /// Current pull phase.
  PullPhase phase = PullPhase.idle;

  /// Accumulated outward pull in logical pixels.
  double extent = 0;

  /// Whether the child sits at the pull edge; the owner refreshes it from
  /// every depth-0 scroll notification (lists start there, hence true).
  bool atEdge = true;

  bool _dragActive = false;
  bool _wheelArmed = false;
  bool _mouseArmed = false;
  Timer? _wheelTimer;

  /// Cancels the pending wheel settle; the owner calls this on dispose.
  void dispose() {
    _wheelTimer?.cancel();
  }

  /// Returns the tracker to idle without notifying; the owner calls this
  /// when it takes over (refresh starts) and rebuilds itself.
  void reset() {
    _wheelTimer?.cancel();
    _wheelArmed = false;
    _mouseArmed = false;
    _dragActive = false;
    phase = PullPhase.idle;
    extent = 0;
  }

  /// Folds an outward pull delta into the pull: positive deltas grow it past
  /// the arming extent, negative ones shrink it back toward zero. Starting a
  /// pull from idle requires the pull edge.
  void accumulate(double outward) {
    if (phase != PullPhase.idle && phase != PullPhase.pulling) return;
    if (outward <= 0) {
      if (phase == PullPhase.pulling) {
        extent = (extent + outward).clamp(0, double.infinity);
        onChanged();
      }
      return;
    }
    if (phase == PullPhase.idle) {
      if (!atEdge) return;
      phase = PullPhase.pulling;
      extent = 0;
    }
    extent += outward;
    onChanged();
  }

  /// Resolves a pull: past the arming extent it fires, below it the pull
  /// snaps back. `allowFire` is false for abandon paths (wheel turning back,
  /// cancelled drags), which snap back without refreshing.
  void resolve({required bool allowFire}) {
    if (phase != PullPhase.pulling) return;
    if (allowFire && extent >= minExtent) {
      _mouseArmed = false;
      onFire();
    } else {
      phase = PullPhase.idle;
      extent = 0;
      onChanged();
    }
  }

  /// A drag gesture started: it owns the pull now — wheel ticks stand down
  /// and a stale mouse arm is dropped (the drag's end resolves instead).
  void scrollStart() {
    _dragActive = true;
    _wheelTimer?.cancel();
    _wheelArmed = false;
    _mouseArmed = false;
  }

  /// A touch-drag delta, signed outward (the owner derives the sign from the
  /// notification's axis and direction).
  void scrollDelta(double outward) {
    accumulate(outward);
  }

  /// A drag gesture ended: an armed pull refreshes, a short one snaps back.
  void scrollEnd() {
    _dragActive = false;
    _wheelTimer?.cancel();
    _wheelArmed = false;
    _mouseArmed = false;
    resolve(allowFire: true);
  }

  /// A wheel/trackpad tick, signed outward (positive pulls). Outward ticks at
  /// the edge grow the pull and restart the settle timer; inward ticks
  /// abandon a wheel pull that never armed; ticks into content never pull.
  void wheelTick(double outward) {
    if (_dragActive) return;
    if (outward <= 0) {
      if (_wheelArmed && phase == PullPhase.pulling) {
        _wheelTimer?.cancel();
        _wheelArmed = false;
        resolve(allowFire: false);
      }
      return;
    }
    if (!atEdge) return;
    if (phase != PullPhase.idle && phase != PullPhase.pulling) return;
    if (phase == PullPhase.idle) {
      phase = PullPhase.pulling;
      extent = 0;
    }
    _wheelArmed = true;
    extent += outward;
    onChanged();
    _wheelTimer?.cancel();
    _wheelTimer = Timer(wheelSettle, () {
      if (_dragActive) return;
      if (phase != PullPhase.pulling || !_wheelArmed) return;
      _wheelArmed = false;
      resolve(allowFire: true);
    });
  }

  /// A mouse press armed a pull; the caller gates the device and button.
  /// Arming needs an idle pull — the edge is re-checked on the first move,
  /// which also covers presses that started mid-content.
  void mouseDown() {
    if (phase != PullPhase.idle) return;
    _mouseArmed = true;
  }

  /// A mouse move while armed. `pressed` must reflect the primary button;
  /// hover moves (no buttons) end the pull as a release would.
  void mouseMove(double outward, bool pressed) {
    if (!_mouseArmed) return;
    if (!pressed) {
      mouseUp();
      return;
    }
    if (!atEdge) {
      _mouseArmed = false;
      return;
    }
    if (phase != PullPhase.idle && phase != PullPhase.pulling) {
      _mouseArmed = false;
      return;
    }
    accumulate(outward);
  }

  /// A mouse release resolves an armed pull.
  void mouseUp() {
    if (!_mouseArmed) return;
    _mouseArmed = false;
    resolve(allowFire: true);
  }

  /// A cancelled mouse drag snaps back without refreshing.
  void mouseCancel() {
    if (!_mouseArmed) return;
    _mouseArmed = false;
    resolve(allowFire: false);
  }
}
