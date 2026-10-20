// Reports the laid-out extent of a child along one axis.
//
// Components that lay their children out themselves need to know how wide
// each child ended up: a toolbar that collapses into an overflow menu, a
// segmented control that slides its thumb. The extent is reported after the
// layout, in a post-frame callback, so the owner can rebuild with the
// measured numbers.
//
// Layer 2 (primitives): may import foundation/theme plus Flutter
// non-Material libraries only.

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Reports the extent of [child] along [axis] after it was laid out.
///
/// The callback fires once per size change (not once per frame), so the
/// owner can rebuild without looping.
class MeasuredExtent extends SingleChildRenderObjectWidget {
  /// Creates a measured extent.
  const MeasuredExtent({
    super.key,
    required this.axis,
    required this.onExtent,
    required Widget content,
  }) : super(child: content);

  /// The axis the extent is measured along.
  final Axis axis;

  /// Called with the child's extent after every layout that changed it.
  final ValueChanged<double> onExtent;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderMeasuredExtent(axis: axis, onExtent: onExtent);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    final _RenderMeasuredExtent object = renderObject as _RenderMeasuredExtent;
    object
      ..axis = axis
      ..onExtent = onExtent;
  }
}

class _RenderMeasuredExtent extends RenderProxyBox {
  _RenderMeasuredExtent({required this.axis, required this.onExtent});

  Axis axis;
  ValueChanged<double> onExtent;
  double _last = -1;

  @override
  void performLayout() {
    super.performLayout();
    final double extent = axis == Axis.horizontal ? size.width : size.height;
    if ((extent - _last).abs() < 0.5) {
      return;
    }
    _last = extent;
    final ValueChanged<double> report = onExtent;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      report(extent);
    });
  }
}
