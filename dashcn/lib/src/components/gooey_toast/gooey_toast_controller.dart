// Scope and controller of the `gooey_toast` component.
//
// Ported from the working `main` implementation (`GooeyToastController.show`):
// toasts are inserted as [OverlayEntry]s into the ROOT overlay, so they anchor
// to the window edge instead of covering the trigger inside whatever box the
// caller lives in. That is the one thing the queue-based rewrite got wrong, and
// it is why the controller no longer goes through `primitives/toast_queue`.
//
// The resolved payload/record live in `gooey_toast_payload.dart`, edge anchors
// and stack offsets in `primitives/gooey/gooey_stack.dart`, and the visible card
// in `gooey_toast.dart` (presentation, not state).

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../primitives/gooey/gooey_content.dart';
import '../../primitives/toast_queue/toast_placement.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'gooey_toast.dart';
import 'gooey_toast_stack.dart';

export 'gooey_toast_payload.dart';

/// Default lifetime of a gooey toast when no duration is configured.
const Duration kGooeyDefaultDuration = Duration(milliseconds: 6000);

/// Delay between the collapse and compact phases of a `transition` update.
const Duration kGooeyTransitionCompactGap = Duration(milliseconds: 72);

/// Bounds of the collapse phase, as a fraction of the closing animation.
const int _kTransitionCloseMinMs = 160;

/// Upper bound of the collapse phase in milliseconds.
const int _kTransitionCloseMaxMs = 620;

GooeyToastTheme gooeyToastThemeOf(
  BuildContext context, {
  GooeyToastTheme? widget,
}) => resolveComponentStyle<GooeyToastTheme, GooeyToastTheme>(
  context,
  widget: widget,
  select: (GooeyToastTheme theme) => theme,
  defaults: gooeyToastDefaults,
);

/// Publishes a [GooeyToastController] (and its resolved theme) to the subtree.
class GooeyToastScope extends InheritedWidget {
  /// Creates a scope.
  const GooeyToastScope({
    super.key,
    required this.controller,
    required this.theme,
    required super.child,
  });

  /// Controller of the enclosing layer.
  final GooeyToastController controller;

  /// Theme resolved by the enclosing layer.
  final GooeyToastTheme theme;

  /// Nearest scope above [context], or null.
  static GooeyToastScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GooeyToastScope>();

  @override
  bool updateShouldNotify(GooeyToastScope oldWidget) =>
      !identical(oldWidget.controller, controller) || oldWidget.theme != theme;
}

/// Owns the gooey toasts of a layer and renders them into the root overlay.
class GooeyToastController extends ChangeNotifier {
  /// Creates a controller.
  GooeyToastController();

  final Map<String, GooeyToastRecord> _records = <String, GooeyToastRecord>{};

  int _nonce = 0;

  /// Active toasts, newest first.
  List<GooeyToastDetails> get activeToasts {
    final List<GooeyToastDetails> items =
        _records.values.map((GooeyToastRecord record) {
          final GooeyToastPayload data = record.data.value;
          return GooeyToastDetails(
            id: record.id,
            stateTag: data.stateTag,
            title: data.title,
            description: data.description,
            state: data.state,
            position: data.position,
            expandDirection: data.expandDirection,
            duration: data.duration,
            persistUntilDismissed: data.persistUntilDismissed,
            updatedAt: record.updatedAt,
          );
        }).toList()..sort(
          (GooeyToastDetails a, GooeyToastDetails b) =>
              b.updatedAt.compareTo(a.updatedAt),
        );
    return List<GooeyToastDetails>.unmodifiable(items);
  }

  /// Whether a toast with [id] is active.
  bool containsToast(String id) => _records.containsKey(id);

  /// Dismisses the toast with [id], if present.
  void dismiss(String id) {
    final GooeyToastRecord? record = _records.remove(id);
    if (record == null) {
      return;
    }
    for (final GooeyToastRecord sibling in _records.values) {
      sibling.entry.markNeedsBuild();
    }
    record.entry.remove();
    record.dispose();
    notifyListeners();
  }

  /// Pauses or resumes the countdown of the toast [id].
  ///
  /// Pausing keeps the remaining lifetime, so a toast hovered for half its
  /// duration still shows for the other half once the pointer leaves.
  void setInteracting(String id, bool value) {
    final GooeyToastRecord? record = _records[id];
    if (record == null || record.interacting == value) {
      return;
    }
    record.interacting = value;
    final GooeyToastPayload data = record.data.value;
    if (data.persistUntilDismissed || data.duration <= Duration.zero) {
      return;
    }
    if (value) {
      record.remaining = _remainingOf(record) ?? data.duration;
      record.dismissTimer?.cancel();
      record.dismissTimer = null;
      record.dismissStartedAt = null;
      return;
    }
    final Duration remaining = record.remaining ?? data.duration;
    if (remaining <= Duration.zero) {
      dismiss(id);
      return;
    }
    _armCountdown(record, remaining);
  }

  /// Shows a gooey toast and returns its id.
  ///
  /// [behavior] decides what happens when the slot is already occupied;
  /// `transition` reuses the live record so the pill morphs between states
  /// instead of being torn down (the promise and multi-state flows).
  String showGooeyToast(
    BuildContext context,
    GooeyToastOptions options, {
    String? id,
    GooeyToastNewToastBehavior? behavior,
    Duration? duration,
    bool autoDismiss = true,
    VoidCallback? onDismissed,
  }) {
    final GooeyToastScope? scope = GooeyToastScope.maybeOf(context);
    final GooeyToastTheme theme = scope?.theme ?? gooeyToastThemeOf(context);
    final ToastPlacement placement = options.position.placement(
      options.expandDirection,
    );
    final bool reused = id != null && id.isNotEmpty && _records.containsKey(id);
    final GooeyToastNewToastBehavior resolvedBehavior =
        behavior ??
        (reused
            ? GooeyToastNewToastBehavior.transition
            : GooeyToastNewToastBehavior.stack);
    final bool reuse =
        resolvedBehavior == GooeyToastNewToastBehavior.transition && reused;
    final String toastId = reuse ? id : (id ?? _nextId());

    final OverlayState? overlay = Overlay.maybeOf(context, rootOverlay: true);
    assert(
      overlay != null,
      'showGooeyToast needs an Overlay: wrap the app in a Navigator '
      '(DashcnApp does).',
    );
    if (overlay == null) {
      return toastId;
    }

    final bool persist = options.persistUntilDismissed || !autoDismiss;
    final GooeyToastPayload payload = _payloadFor(
      context,
      toastId,
      options,
      theme,
    );
    final Duration lifetime = persist ? Duration.zero : payload.duration;

    final GooeyToastRecord? existing = _records[toastId];
    if (existing != null) {
      if (resolvedBehavior == GooeyToastNewToastBehavior.transition) {
        _runTransition(existing, payload);
        return toastId;
      }
      existing.data.value = payload;
      existing.updatedAt = DateTime.now();
      _armCountdown(existing, lifetime, onDismissed: onDismissed);
      _markAllEntriesDirty();
      notifyListeners();
      return toastId;
    }

    if (resolvedBehavior == GooeyToastNewToastBehavior.dismissPrevious) {
      for (final String previousId in _idsIn(placement)) {
        dismiss(previousId);
      }
    }

    final GooeyToastRecord record = GooeyToastRecord(
      id: toastId,
      entry: gooeyToastEntry(
        toastId,
        recordOf: (String id) => _records[id],
        indexOf: _indexInRegion,
        controller: this,
      ),
      data: ValueNotifier<GooeyToastPayload>(payload),
      updatedAt: DateTime.now(),
    );
    _records[toastId] = record;
    overlay.insert(record.entry);
    _armCountdown(record, lifetime, onDismissed: onDismissed);
    _markAllEntriesDirty();
    notifyListeners();
    return toastId;
  }

  @override
  void dispose() {
    for (final String id in _records.keys.toList()) {
      dismiss(id);
    }
    super.dispose();
  }

  // ------------------------------------------------------------------
  // Payload resolution.
  // ------------------------------------------------------------------

  GooeyToastPayload _payloadFor(
    BuildContext context,
    String id,
    GooeyToastOptions options,
    GooeyToastTheme theme,
  ) {
    return GooeyToastPayload(
      id: id,
      title: options.title,
      description: options.description,
      state: options.state,
      position: options.position,
      expandDirection: options.expandDirection,
      showDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      duration: options.duration ?? theme.duration ?? kGooeyDefaultDuration,
      icon: options.icon,
      compactChild: options.compactChild,
      expandedChild: options.expandedChild,
      action: options.action,
      autopilot: options.autopilot,
      stateTag: options.stateTag,
      width: options.width ?? theme.width ?? 350,
      roundness: options.roundness ?? theme.roundness ?? 18,
      animationStyle:
          options.animationStyle ??
          theme.animationStyle ??
          GooeyToastAnimationStyle.sileo,
      shapeStyle:
          options.shapeStyle ??
          theme.shapeStyle ??
          GooeyToastShapeStyle.defaultShape,
      bodyAnimationStyle:
          options.bodyAnimationStyle ??
          theme.bodyAnimationStyle ??
          GooeyToastBodyAnimationStyle.fade,
      compactMorph:
          options.compactMorph ??
          theme.compactMorph ??
          const GooeyCompactMorph(),
      persistUntilDismissed: options.persistUntilDismissed,
      fill: theme.fill ?? ThemedColor.value(gooeySurfaceFill),
      onExpansionChanged: options.onExpansionChanged,
    );
  }

  String _nextId() => 'gooey-${_nonce++}';

  // ------------------------------------------------------------------
  // Region bookkeeping.
  // ------------------------------------------------------------------

  List<GooeyToastRecord> _region(ToastPlacement placement) {
    final List<GooeyToastRecord> items =
        _records.values
            .where(
              (GooeyToastRecord record) =>
                  record.data.value.placement == placement,
            )
            .toList()
          ..sort(
            (GooeyToastRecord a, GooeyToastRecord b) =>
                b.updatedAt.compareTo(a.updatedAt),
          );
    return items;
  }

  int _indexInRegion(String id, ToastPlacement placement) => _region(
    placement,
  ).indexWhere((GooeyToastRecord record) => record.id == id);

  List<String> _idsIn(ToastPlacement placement) => _region(
    placement,
  ).map((GooeyToastRecord record) => record.id).toList(growable: false);

  void _markAllEntriesDirty() {
    for (final GooeyToastRecord record in _records.values) {
      record.entry.markNeedsBuild();
    }
  }

  // ------------------------------------------------------------------
  // Lifetime.
  // ------------------------------------------------------------------

  void _armCountdown(
    GooeyToastRecord record,
    Duration lifetime, {
    VoidCallback? onDismissed,
  }) {
    record.dismissTimer?.cancel();
    record.dismissTimer = null;
    record.dismissStartedAt = null;
    record.remaining = null;
    if (lifetime <= Duration.zero) {
      return;
    }
    if (record.interacting) {
      record.remaining = lifetime;
      return;
    }
    final String id = record.id;
    record.remaining = lifetime;
    record.dismissStartedAt = DateTime.now();
    record.dismissTimer = Timer(lifetime, () {
      final GooeyToastRecord? live = _records.remove(id);
      if (live == null) {
        return;
      }
      for (final GooeyToastRecord sibling in _records.values) {
        sibling.entry.markNeedsBuild();
      }
      live.entry.remove();
      live.dispose();
      notifyListeners();
      onDismissed?.call();
    });
  }

  Duration? _remainingOf(GooeyToastRecord record) {
    final DateTime? startedAt = record.dismissStartedAt;
    if (startedAt == null) {
      return record.remaining;
    }
    final Duration base = record.remaining ?? Duration.zero;
    final Duration elapsed = DateTime.now().difference(startedAt);
    final Duration next = base - elapsed;
    return next.isNegative ? Duration.zero : next;
  }

  /// Collapse → compact → expand: the staged handoff of `transition`.
  ///
  /// The current body collapses first, the next compact state lands once it is
  /// shut, and only then does the new body open. A stale
  /// [GooeyToastRecord.transitionToken] aborts an interrupted flow, so a rapid
  /// second transition never leaves the toast stuck half-open.
  void _runTransition(GooeyToastRecord record, GooeyToastPayload next) {
    record.transitionToken++;
    final int token = record.transitionToken;
    record.cancelTransitionTimers();
    final GooeyToastPayload current = record.data.value;
    final Duration closeDelay = Duration(
      milliseconds: (current.animationStyle.duration.inMilliseconds * 0.72)
          .round()
          .clamp(_kTransitionCloseMinMs, _kTransitionCloseMaxMs),
    );
    const Duration compactGap = kGooeyTransitionCompactGap;

    record.data.value = current.replace(
      stateTag: '${current.stateTag ?? current.title}:close-current',
      description: null,
      expandedChild: null,
      action: null,
      autopilot: null,
      onExpansionChanged: null,
    );
    record.updatedAt = DateTime.now();
    _markAllEntriesDirty();
    notifyListeners();

    record.transitionTimers.add(
      Timer(closeDelay, () {
        final GooeyToastRecord? live = _records[record.id];
        if (live == null || live.transitionToken != token) {
          return;
        }
        live.data.value = next.replace(
          stateTag: '${next.stateTag ?? next.title}:compact-next',
          description: null,
          expandedChild: null,
          action: null,
          autopilot: null,
          onExpansionChanged: null,
        );
        live.updatedAt = DateTime.now();
        _markAllEntriesDirty();
        notifyListeners();
        if (!next.hasBody) {
          return;
        }
        record.transitionTimers.add(
          Timer(compactGap, () {
            final GooeyToastRecord? opened = _records[record.id];
            if (opened == null || opened.transitionToken != token) {
              return;
            }
            opened.data.value = next.replace(
              stateTag: '${next.stateTag ?? next.title}:expanded-next',
              autopilot: GooeyAutopilot(
                expandDelay: Duration.zero,
                collapseDelay: next.autopilot?.collapseDelay,
              ),
            );
            opened.updatedAt = DateTime.now();
            _markAllEntriesDirty();
            notifyListeners();
          }),
        );
      }),
    );
  }
}
