// Resolved payload and live record of one gooey toast.
//
// Split out of `gooey_toast_controller.dart` so that file stays readable. The
// payload is the immutable, theme-resolved description of a shown toast; the
// record is its live overlay entry, its notifier and its countdown state.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../primitives/gooey/gooey_content.dart';
import '../../primitives/toast_queue/toast_placement.dart';
import '../../theme/color_tokens.dart';
import 'gooey_toast_options.dart';
import 'gooey_toast_style.dart';

/// Sentinel for "leave this field alone" in [GooeyToastPayload.replace].
const Object _kUnset = Object();

class GooeyToastPayload {
  /// Creates a payload.
  const GooeyToastPayload({
    required this.id,
    required this.title,
    required this.state,
    required this.position,
    required this.expandDirection,
    required this.showDirection,
    required this.duration,
    required this.width,
    required this.roundness,
    required this.animationStyle,
    required this.shapeStyle,
    required this.bodyAnimationStyle,
    required this.compactMorph,
    required this.persistUntilDismissed,
    required this.fill,
    this.stateTag,
    this.description,
    this.icon,
    this.compactChild,
    this.expandedChild,
    this.action,
    this.autopilot,
    this.onExpansionChanged,
  });

  /// Stable id of the toast this payload belongs to.
  final String id;

  /// Identity of the compact content; changing it morphs the pill in place.
  final Object? stateTag;

  final String title;

  final String? description;

  final GooeyToastState state;

  final GooeyToastPosition position;

  final GooeyToastExpandDirection expandDirection;

  /// Text direction of the show context, so an RTL layout mirrors the anchor.
  ///
  /// Captured at show time: the toast's overlay entry lives above every
  /// `Directionality` in the caller's subtree, so it cannot inherit theirs.
  final TextDirection showDirection;

  final Duration duration;

  final IconData? icon;

  final Widget? compactChild;

  final Widget? expandedChild;

  final GooeyToastAction? action;

  final double width;

  final double roundness;

  final GooeyAutopilot? autopilot;

  final GooeyToastAnimationStyle animationStyle;

  final GooeyToastShapeStyle shapeStyle;

  final GooeyToastBodyAnimationStyle bodyAnimationStyle;

  final GooeyCompactMorph compactMorph;

  final bool persistUntilDismissed;

  final ThemedColor fill;

  final ValueChanged<bool>? onExpansionChanged;

  /// Screen placement this payload anchors to.
  ToastPlacement get placement => position.placement(expandDirection);

  /// Whether the body grows upwards.
  bool get expandUp => expandDirection == GooeyToastExpandDirection.top;

  /// Whether the expanded body has anything to show.
  bool get hasBody =>
      description != null || expandedChild != null || action != null;

  /// Copies with the given fields replaced; a nullable field is wiped only when
  /// it is explicitly passed as `null`, so `replace(description: null)` clears
  /// it while `replace()` keeps everything.
  GooeyToastPayload replace({
    Object? stateTag = _kUnset,
    String? title,
    GooeyToastState? state,
    Duration? duration,
    Object? description = _kUnset,
    Object? expandedChild = _kUnset,
    Object? action = _kUnset,
    Object? autopilot = _kUnset,
    Object? onExpansionChanged = _kUnset,
    GooeyCompactMorph? compactMorph,
    bool? persistUntilDismissed,
  }) {
    return GooeyToastPayload(
      id: id,
      title: title ?? this.title,
      state: state ?? this.state,
      position: position,
      expandDirection: expandDirection,
      showDirection: showDirection,
      duration: duration ?? this.duration,
      width: width,
      roundness: roundness,
      animationStyle: animationStyle,
      shapeStyle: shapeStyle,
      bodyAnimationStyle: bodyAnimationStyle,
      compactMorph: compactMorph ?? this.compactMorph,
      persistUntilDismissed:
          persistUntilDismissed ?? this.persistUntilDismissed,
      fill: fill,
      stateTag: identical(stateTag, _kUnset) ? this.stateTag : stateTag,
      icon: icon,
      compactChild: compactChild,
      description: identical(description, _kUnset)
          ? this.description
          : description as String?,
      expandedChild: identical(expandedChild, _kUnset)
          ? this.expandedChild
          : expandedChild as Widget?,
      action: identical(action, _kUnset)
          ? this.action
          : action as GooeyToastAction?,
      autopilot: identical(autopilot, _kUnset)
          ? this.autopilot
          : autopilot as GooeyAutopilot?,
      onExpansionChanged: identical(onExpansionChanged, _kUnset)
          ? this.onExpansionChanged
          : onExpansionChanged as ValueChanged<bool>?,
    );
  }
}

/// One live toast: its overlay entry, payload notifier and countdown state.
class GooeyToastRecord {
  /// Creates a record.
  GooeyToastRecord({
    required this.id,
    required this.entry,
    required this.data,
    required this.updatedAt,
  });

  /// Stable toast id.
  final String id;

  /// Inserted overlay entry.
  final OverlayEntry entry;

  /// Mutable payload driving overlay rebuilds.
  final ValueNotifier<GooeyToastPayload> data;

  /// Last mutation timestamp, used for region ordering (newest first).
  DateTime updatedAt;

  /// Countdown timer while the toast is not interacting.
  Timer? dismissTimer;

  /// Remaining lifetime while paused by hover/press.
  Duration? remaining;

  /// When the running countdown started.
  DateTime? dismissStartedAt;

  /// Whether pointer interaction is active.
  bool interacting = false;

  /// Monotonic token invalidating stale transition callbacks.
  int transitionToken = 0;

  /// Timers driving staged transitions.
  final List<Timer> transitionTimers = <Timer>[];

  /// Cancels the staged transition timers.
  void cancelTransitionTimers() {
    for (final Timer timer in transitionTimers) {
      timer.cancel();
    }
    transitionTimers.clear();
  }

  /// Releases the entry and every timer.
  void dispose() {
    cancelTransitionTimers();
    dismissTimer?.cancel();
    data.dispose();
  }
}

/// Resolves the gooey toast theme for [context].
///
/// The [widget] leg is the one callers pass to a `GooeyToastLayer`; the
/// controller uses the same resolver so a layer-level override reaches the
/// geometry it resolves (width, roundness, animation preset).
