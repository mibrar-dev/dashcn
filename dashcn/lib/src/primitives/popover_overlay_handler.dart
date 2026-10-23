// Default `OverlayHandler`: inserts the popover entries into an [Overlay] and
// animates them in/out.
//
// Ported from `shared/primitives/_impl/utils/popover_overlay_handler.dart`.

import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../foundation/data.dart';
import '../theme/theme.dart';
import 'animated_value_builder.dart';
import 'motion/motion_scope.dart';
import 'overlay.dart';
import 'popover.dart';
import 'popover_overlay_state.dart';
import 'popover_overlay_widget.dart';

/// Resolves an overlay leg: the caller's explicit duration, else [fallback],
/// scaled by the theme intensity. Reduced motion keeps only a short opacity
/// fade (see [kOverlayReducedFade]); the transform is dropped by the state.
Duration _overlayDuration(
  BuildContext context,
  Duration? explicit,
  Duration fallback,
) {
  if (motionReduced(context)) {
    return kOverlayReducedFade;
  }
  return resolveMotionDuration(context, explicit ?? fallback);
}

/// Default popover overlay handler.
class PopoverOverlayHandler extends OverlayHandler {
  /// Creates a [PopoverOverlayHandler].
  const PopoverOverlayHandler();

  @override
  OverlayCompleter<T> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    ui.Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    ui.Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    ui.Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    bool scaleOnEnter = true,
    OverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
    PopupAdaptive? adaptive,
  }) {
    final TextDirection textDirection = Directionality.of(context);
    final Alignment resolvedAlignment = alignment.resolve(textDirection);
    anchorAlignment ??= alignment * -1;
    final Alignment resolvedAnchorAlignment = anchorAlignment.resolve(
      textDirection,
    );
    final OverlayState overlay = Overlay.of(context, rootOverlay: rootOverlay);
    final themes = InheritedTheme.capture(from: context, to: overlay.context);
    final data = Data.capture(from: context, to: overlay.context);

    Size? anchorSize;
    if (position == null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final Offset pos = renderBox.localToGlobal(Offset.zero);
      anchorSize = renderBox.size;
      position = Offset(
        pos.dx +
            anchorSize.width / 2 +
            anchorSize.width / 2 * resolvedAnchorAlignment.x,
        pos.dy +
            anchorSize.height / 2 +
            anchorSize.height / 2 * resolvedAnchorAlignment.y,
      );
    }
    final OverlayPopoverEntry<T> popoverEntry = OverlayPopoverEntry<T>();
    final completer = popoverEntry.completer;
    final animationCompleter = popoverEntry.animationCompleter;
    final ValueNotifier<bool> isClosed = ValueNotifier(false);

    // Focus returns to the opener on close — the same contract as
    // `DialogRoute.openerFocus` — so Escape and outside-tap leave keyboard
    // users where they started (select triggers, menu anchors, picker
    // prompt buttons, command inputs). Captured before insertion; restored
    // once per close, guarded like the dialog shell (still mounted and
    // focusable), so programmatic closes after unmount stay silent.
    final FocusNode? openerFocus = FocusManager.instance.primaryFocus;
    void restoreOpenerFocus() {
      final FocusNode? opener = openerFocus;
      if (opener == null || !opener.canRequestFocus) {
        return;
      }
      final BuildContext? openerContext = opener.context;
      if (openerContext == null || !openerContext.mounted) {
        return;
      }
      opener.requestFocus();
    }

    completer.future.then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) => restoreOpenerFocus());
    });

    OverlayEntry? barrierEntry;
    late OverlayEntry overlayEntry;
    if (modal) {
      if (consumeOutsideTaps) {
        barrierEntry = OverlayEntry(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                if (!barrierDismissable || isClosed.value) return;
                isClosed.value = true;
                completer.complete();
              },
            );
          },
        );
      } else {
        barrierEntry = OverlayEntry(
          builder: (context) {
            return Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (event) {
                if (!barrierDismissable || isClosed.value) return;
                isClosed.value = true;
                completer.complete();
              },
            );
          },
        );
      }
    }

    overlayEntry = OverlayEntry(
      builder: (innerContext) {
        return RepaintBoundary(
          child: AnimatedBuilder(
            animation: isClosed,
            builder: (innerContext, child) {
              return FocusScope(
                autofocus: dismissBackdropFocus,
                canRequestFocus: !isClosed.value,
                // Root Escape: every popover closes on Escape, even when the
                // scope itself holds focus (editor popovers with nothing
                // focused yet). Inner handlers win because they sit deeper:
                // menu traversal (one level / all at root), the select
                // search field, autocomplete's own Escape and showPopup's
                // DismissIntent all handle first and stop bubbling here.
                onKeyEvent: (FocusNode node, KeyEvent event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.escape &&
                      !isClosed.value) {
                    isClosed.value = true;
                    completer.complete();
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: AnimatedValueBuilder<double>(
                  value: isClosed.value ? 0.0 : 1.0,
                  initialValue: 0.0,
                  // Enter decelerates over 150 ms; exit accelerates over
                  // 100 ms and only fades (no scale), per the overlay motion
                  // spec. `showDuration` is the enter, `dismissDuration` the
                  // exit.
                  curve: isClosed.value
                      ? Theme.of(innerContext).motion.curves.emphasizedIn
                      : Theme.of(innerContext).motion.curves.emphasizedOut,
                  duration: isClosed.value
                      ? _overlayDuration(
                          innerContext,
                          dismissDuration,
                          Theme.of(innerContext).motion.durations.instant,
                        )
                      : _overlayDuration(
                          innerContext,
                          showDuration,
                          Theme.of(innerContext).motion.durations.fast,
                        ),
                  onEnd: (value) {
                    if (value == 0.0 && isClosed.value) {
                      popoverEntry.remove();
                      popoverEntry.dispose();
                      animationCompleter.complete();
                    }
                  },
                  builder: (innerContext, animation, child) {
                    return PopoverOverlayWidget(
                      animation: animation,
                      closing: isClosed.value,
                      scaleOnEnter: scaleOnEnter,
                      onTapOutside: () {
                        if (isClosed.value) return;
                        if (!modal) {
                          isClosed.value = true;
                          completer.complete();
                        }
                      },
                      key: key,
                      anchorContext: context,
                      position: position!,
                      alignment: resolvedAlignment,
                      themes: themes,
                      builder: builder,
                      anchorSize: anchorSize,
                      anchorAlignment: resolvedAnchorAlignment,
                      widthConstraint: widthConstraint,
                      heightConstraint: heightConstraint,
                      regionGroupId: regionGroupId,
                      offset: offset,
                      transitionAlignment: transitionAlignment,
                      margin: margin,
                      follow: follow,
                      consumeOutsideTaps: consumeOutsideTaps,
                      onTickFollow: onTickFollow,
                      allowInvertHorizontal: allowInvertHorizontal,
                      allowInvertVertical: allowInvertVertical,
                      adaptive: adaptive,
                      data: data,
                      onClose: () {
                        if (isClosed.value) return Future.value();
                        isClosed.value = true;
                        completer.complete();
                        return animationCompleter.future;
                      },
                      onImmediateClose: () {
                        popoverEntry.remove();
                        completer.complete();
                      },
                      onCloseWithResult: (value) {
                        if (isClosed.value) return Future.value();
                        isClosed.value = true;
                        completer.complete(value as T);
                        return animationCompleter.future;
                      },
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
    popoverEntry.initialize(overlayEntry, barrierEntry);
    if (barrierEntry != null) {
      overlay.insert(barrierEntry);
    }
    overlay.insert(overlayEntry);
    return popoverEntry;
  }
}
