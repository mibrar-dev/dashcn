// The async status machine for the `button` component (`P7-S1`).
//
// [ButtonStatus] is the state machine and [ButtonStatusController] drives
// the uncontrolled leg (press -> loading -> success/failure -> idle).
// The status widgets (slot, label, content) live in
// `button_status_content.dart` so each file stays under the size guide.
//
// Not independently installable; ships inside the `button` component.

import 'dart:async';

import 'package:flutter/widgets.dart';
import '../../primitives/localizations/localizations.dart';

/// Async lifecycle of a button: idle, loading, success or failure.
enum ButtonStatus { idle, loading, success, failure }

/// Default auto-reset delay after success/failure; null stays put.
const Duration buttonDefaultStatusReset = Duration(milliseconds: 1500);

/// Screen-reader announcement for a non-idle status; null when idle.
///
/// English fallback for code without a [BuildContext]; widget builds should
/// prefer [buttonStatusAnnouncementOf], which reads the ambient locale.
String? buttonStatusAnnouncement(ButtonStatus status) {
  return switch (status) {
    ButtonStatus.idle => null,
    ButtonStatus.loading => 'Loading',
    ButtonStatus.success => 'Success',
    ButtonStatus.failure => 'Failure',
  };
}

/// Locale-aware [buttonStatusAnnouncement] for widget builds.
///
/// Reads the ambient [ComponentLocalizations]; falls back to English when no
/// delegate was installed.
String? buttonStatusAnnouncementOf(BuildContext context, ButtonStatus status) {
  final ComponentLocalizations strings = ComponentLocalizations.of(context);
  return switch (status) {
    ButtonStatus.idle => null,
    ButtonStatus.loading => strings.announcementLoading,
    ButtonStatus.success => strings.announcementSuccess,
    ButtonStatus.failure => strings.announcementFailure,
  };
}

/// Drives one button's uncontrolled status machine.
///
/// Press runs [run]: loading is entered synchronously, a normal return moves
/// to success and a throw moves to failure (the error is reported through
/// [onError] and never rethrown), then an idle reset is armed after
/// [resetDuration] (null stays). Re-running cancels a pending reset.
/// Controlled buttons (`Button.status != null`) never use this: the widget
/// renders the parent-owned status instead.
class ButtonStatusController extends ChangeNotifier {
  /// Creates a controller with the given reset timing and callbacks.
  ButtonStatusController({
    this.resetDuration = buttonDefaultStatusReset,
    this.onError,
  });

  /// Auto-reset delay after success/failure; null stays on the end state.
  Duration? resetDuration;

  /// Called with the error thrown by the async work on failure.
  void Function(Object error, StackTrace stackTrace)? onError;

  ButtonStatus _status = ButtonStatus.idle;
  Timer? _timer;

  /// Current machine state.
  ButtonStatus get status => _status;

  /// Whether the button is mid-flight (and must stay disabled).
  bool get isLoading => _status == ButtonStatus.loading;

  /// Runs [work] through loading -> success/failure -> idle.
  ///
  /// Re-entrant presses while loading are ignored; a pending auto-reset is
  /// cancelled when a new run starts.
  Future<void> run(Future<void> Function() work) async {
    if (_status == ButtonStatus.loading) {
      return;
    }
    _timer?.cancel();
    _timer = null;
    _set(ButtonStatus.loading);
    try {
      await work();
    } catch (error, stackTrace) {
      onError?.call(error, stackTrace);
      _set(ButtonStatus.failure);
      _armReset();
      return;
    }
    _set(ButtonStatus.success);
    _armReset();
  }

  /// Returns to idle now, cancelling a pending auto-reset.
  void reset() {
    _timer?.cancel();
    _timer = null;
    if (_status != ButtonStatus.idle) {
      _set(ButtonStatus.idle);
    }
  }

  void _armReset() {
    final Duration? duration = resetDuration;
    if (duration == null) {
      return;
    }
    _timer?.cancel();
    _timer = Timer(duration, () {
      _timer = null;
      _set(ButtonStatus.idle);
    });
  }

  void _set(ButtonStatus next) {
    if (_status == next) {
      return;
    }
    _status = next;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
