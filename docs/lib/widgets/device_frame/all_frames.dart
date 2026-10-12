// The P9-1 "All" mode: every framed spec side by side.
//
// Wide layouts show a `Wrap` of the four frames scaled down with a
// `FittedBox` (each frame keeps its own subtree: the same widget instance
// may appear four times — widgets are immutable configs, so each site gets
// its own element tree). Below 700 px the frames become a horizontal snap
// scroller (`PageView`, one frame per page, scaled to fit the page).

import 'package:flutter/widgets.dart';

import 'device_frame.dart';
import 'device_spec.dart';

/// Gap between frames in both modes.
const double kAllFramesGap = 24;

/// Width below which "All" becomes a snap scroller.
const double kAllFramesScrollerBreakpoint = 700;

/// All four framed specs for [child].
class AllFrames extends StatelessWidget {
  /// Creates the four-frame view.
  const AllFrames({
    super.key,
    required this.child,
    this.orientation = DeviceOrientation.portrait,
  });

  /// The preview rendered inside every frame (one subtree per frame).
  final Widget child;

  /// Portrait or landscape.
  final DeviceOrientation orientation;

  /// Natural (unscaled) extent of the four-frame row.
  Size naturalSize() {
    double width = 0;
    double height = 0;
    for (final DeviceSpec spec in kFramedSpecs) {
      final Size total = spec.totalFor(orientation);
      width += total.width;
      if (total.height > height) {
        height = total.height;
      }
    }
    return Size(width + kAllFramesGap * (kFramedSpecs.length - 1), height);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < kAllFramesScrollerBreakpoint) {
          return _Scroller(orientation: orientation, child: child);
        }
        final Size natural = naturalSize();
        return Align(
          alignment: Alignment.topCenter,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: natural.width,
              height: natural.height,
              child: Wrap(
                spacing: kAllFramesGap,
                runSpacing: kAllFramesGap,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  for (final DeviceSpec spec in kFramedSpecs)
                    DeviceFrame(
                      key: ValueKey<String>('all-frame-${spec.id.queryValue}'),
                      spec: spec,
                      orientation: orientation,
                      child: child,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The narrow "All" mode: one frame per snap page, scaled to fit.
class _Scroller extends StatelessWidget {
  const _Scroller({required this.child, required this.orientation});

  final Widget child;
  final DeviceOrientation orientation;

  @override
  Widget build(BuildContext context) {
    double height = 0;
    for (final DeviceSpec spec in kFramedSpecs) {
      final double total = spec.totalFor(orientation).height;
      if (total > height) {
        height = total;
      }
    }
    return SizedBox(
      height: height,
      child: PageView(
        children: <Widget>[
          for (final DeviceSpec spec in kFramedSpecs)
            Padding(
              padding: const EdgeInsets.all(16),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: DeviceFrame(
                  key: ValueKey<String>('all-page-${spec.id.queryValue}'),
                  spec: spec,
                  orientation: orientation,
                  child: child,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
