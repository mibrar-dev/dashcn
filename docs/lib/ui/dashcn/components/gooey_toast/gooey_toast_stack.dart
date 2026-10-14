// Overlay presentation of the gooey toast stack.
//
// Split out of `gooey_toast_controller.dart` so that file stays readable.
// Rebuilding one entry reads the controller's region, so every toast's offset
// and visibility track the newest-first ordering of its placement.

import 'package:flutter/widgets.dart';

import '../../primitives/gooey/gooey_stack.dart';
import '../../primitives/gooey/gooey_surface.dart';
import '../../primitives/toast_queue/toast_placement.dart';
import 'gooey_toast.dart';

/// Builds the overlay entry of the toast [toastId].
///
/// The entry is rebuilt whenever the controller marks it dirty (a new toast, a
/// dismiss, a transition) and whenever the payload notifier changes.
OverlayEntry gooeyToastEntry(
  String toastId, {
  required GooeyToastRecord? Function(String id) recordOf,
  required int Function(String id, ToastPlacement placement) indexOf,
  required GooeyToastController controller,
}) {
  const GooeyStackLayout layout = GooeyStackLayout();
  return OverlayEntry(
    builder: (BuildContext entryContext) {
      final GooeyToastRecord? record = recordOf(toastId);
      if (record == null) {
        return const SizedBox.shrink();
      }
      return ValueListenableBuilder<GooeyToastPayload>(
        valueListenable: record.data,
        builder: (BuildContext context, GooeyToastPayload payload, _) {
          final int index = indexOf(toastId, payload.placement);
          if (index < 0) {
            return const SizedBox.shrink();
          }
          final MediaQueryData? media = MediaQuery.maybeOf(entryContext);
          final Size viewport =
              media?.size ??
              Size(payload.width, kGooeySurfacePillHeight * 2.25);
          final GooeyEdgeAnchors anchors = GooeyEdgeAnchors.resolve(
            placement: payload.placement,
            width: payload.width,
            viewport: viewport,
            textDirection: payload.showDirection,
          );
          return GooeyAnchoredEntry(
            anchors: anchors,
            offset: layout.offsetAt(index),
            child: GooeyToastCard(payload: payload, controller: controller),
          );
        },
      );
    },
  );
}
