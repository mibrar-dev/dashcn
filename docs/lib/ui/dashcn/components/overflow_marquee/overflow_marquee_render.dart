// Render object and layout widget for the `overflow_marquee` component.

import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'overflow_marquee_style.dart';

/// Hosts the marquee render object.
class MarqueeLayout extends SingleChildRenderObjectWidget {
  /// Creates a marquee layout widget.
  const MarqueeLayout({
    super.key,
    required this.direction,
    required this.speed,
    required this.gap,
    required this.loop,
    required this.reducedMotion,
    required this.elapsed,
    required this.textDirection,
    required super.child,
  });

  /// Direction of marquee scroll.
  final AxisDirectional direction;

  /// Speed in pixels per second.
  final double speed;

  /// Gap between looping instances in pixels.
  final double gap;

  /// Whether continuous looping is enabled.
  final bool loop;

  /// Whether reduced motion is active.
  final bool reducedMotion;

  /// Elapsed scroll time notifier.
  final ValueListenable<Duration> elapsed;

  /// Ambient text direction.
  final TextDirection textDirection;

  @override
  RenderMarquee createRenderObject(BuildContext context) {
    return RenderMarquee(
      initialDirection: direction,
      initialSpeed: speed,
      initialGap: gap,
      initialLoop: loop,
      initialReducedMotion: reducedMotion,
      initialElapsed: elapsed,
      initialTextDirection: textDirection,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderMarquee renderObject) {
    renderObject
      ..direction = direction
      ..speed = speed
      ..gap = gap
      ..loop = loop
      ..reducedMotion = reducedMotion
      ..textDirection = textDirection
      ..elapsed = elapsed;
  }
}

/// Renders the child repeatedly at offset positions to create a continuous
/// seamless looping marquee.
class RenderMarquee extends RenderShiftedBox {
  /// Creates a marquee render box.
  RenderMarquee({
    required AxisDirectional initialDirection,
    required double initialSpeed,
    required double initialGap,
    required bool initialLoop,
    required bool initialReducedMotion,
    required TextDirection initialTextDirection,
    required ValueListenable<Duration> initialElapsed,
  }) : _direction = initialDirection,
       _speed = initialSpeed,
       _gap = initialGap,
       _loop = initialLoop,
       _reducedMotion = initialReducedMotion,
       _textDirection = initialTextDirection,
       _elapsed = initialElapsed,
       super(null);

  AxisDirectional _direction;
  AxisDirectional get direction => _direction;
  set direction(AxisDirectional val) {
    if (_direction == val) return;
    _direction = val;
    markNeedsLayout();
  }

  double _speed;
  double get speed => _speed;
  set speed(double val) {
    if (_speed == val) return;
    _speed = val;
    markNeedsPaint();
  }

  double _gap;
  double get gap => _gap;
  set gap(double val) {
    if (_gap == val) return;
    _gap = val;
    markNeedsPaint();
  }

  bool _loop;
  bool get loop => _loop;
  set loop(bool val) {
    if (_loop == val) return;
    _loop = val;
    markNeedsPaint();
  }

  bool _reducedMotion;
  bool get reducedMotion => _reducedMotion;
  set reducedMotion(bool val) {
    if (_reducedMotion == val) return;
    _reducedMotion = val;
    markNeedsPaint();
  }

  TextDirection _textDirection;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection val) {
    if (_textDirection == val) return;
    _textDirection = val;
    markNeedsLayout();
  }

  ValueListenable<Duration> _elapsed;
  ValueListenable<Duration> get elapsed => _elapsed;
  set elapsed(ValueListenable<Duration> val) {
    if (identical(_elapsed, val)) return;
    if (attached) _elapsed.removeListener(_onTick);
    _elapsed = val;
    if (attached) _elapsed.addListener(_onTick);
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _elapsed.addListener(_onTick);
  }

  @override
  void detach() {
    _elapsed.removeListener(_onTick);
    super.detach();
  }

  void _onTick() {
    final RenderBox? child = this.child;
    if (child != null && child.parentData is BoxParentData) {
      final List<Offset> offsets = computeOffsets();
      (child.parentData! as BoxParentData).offset = offsets.isNotEmpty
          ? offsets.first
          : Offset.zero;
    }
    markNeedsPaint();
  }

  @override
  bool get alwaysNeedsCompositing => child != null;

  @override
  void performLayout() {
    final RenderBox? child = this.child;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    child.layout(_childConstraints(constraints), parentUsesSize: true);
    final double width = constraints.hasBoundedWidth
        ? constraints.maxWidth
        : child.size.width;
    final double height = constraints.hasBoundedHeight
        ? constraints.maxHeight
        : child.size.height;
    size = constraints.constrain(Size(width, height));

    final List<Offset> offsets = computeOffsets();
    (child.parentData! as BoxParentData).offset = offsets.isNotEmpty
        ? offsets.first
        : Offset.zero;
  }

  BoxConstraints _childConstraints(BoxConstraints c) {
    final bool isHorizontal =
        _direction == AxisDirectional.start ||
        _direction == AxisDirectional.end;
    return isHorizontal
        ? c.copyWith(minWidth: 0, maxWidth: double.infinity)
        : c.copyWith(minHeight: 0, maxHeight: double.infinity);
  }

  /// Calculates instance offsets for the visible viewport window.
  List<Offset> computeOffsets() {
    final RenderBox? child = this.child;
    if (child == null) return const <Offset>[];

    final bool isHorizontal =
        _direction == AxisDirectional.start ||
        _direction == AxisDirectional.end;
    final double viewport = isHorizontal ? size.width : size.height;
    final double extent = isHorizontal ? child.size.width : child.size.height;

    if (extent <= 0 || viewport <= 0) {
      return const <Offset>[Offset.zero];
    }

    if (_reducedMotion) {
      final AxisDirection concrete = _direction.resolve(_textDirection);
      if (isHorizontal &&
          concrete == AxisDirection.right &&
          extent > viewport) {
        return <Offset>[Offset(viewport - extent, 0)];
      }
      return const <Offset>[Offset.zero];
    }

    if (!_loop && extent <= viewport) {
      final AxisDirection concrete = _direction.resolve(_textDirection);
      if (isHorizontal && concrete == AxisDirection.right) {
        return <Offset>[Offset(viewport - extent, 0)];
      }
      return const <Offset>[Offset.zero];
    }

    final double unit = extent + _gap;
    if (unit <= 0) return const <Offset>[Offset.zero];

    final double elapsedSec = _elapsed.value.inMicroseconds / 1000000.0;
    final double distance = elapsedSec * _speed;
    final double shift = distance % unit;
    final AxisDirection concrete = _direction.resolve(_textDirection);

    final List<Offset> offsets = <Offset>[];
    if (isHorizontal) {
      if (concrete == AxisDirection.left) {
        double x = -shift;
        while (x < viewport) {
          if (x + extent > 0) offsets.add(Offset(x, 0));
          x += unit;
        }
      } else {
        final double base = extent > viewport ? viewport - extent : 0.0;
        double x = base + shift;
        while (x > -extent) {
          x -= unit;
        }
        while (x < viewport) {
          if (x + extent > 0) offsets.add(Offset(x, 0));
          x += unit;
        }
      }
    } else {
      if (concrete == AxisDirection.up) {
        double y = -shift;
        while (y < viewport) {
          if (y + extent > 0) offsets.add(Offset(0, y));
          y += unit;
        }
      } else {
        final double base = extent > viewport ? viewport - extent : 0.0;
        double y = base + shift;
        while (y > -extent) {
          y -= unit;
        }
        while (y < viewport) {
          if (y + extent > 0) offsets.add(Offset(0, y));
          y += unit;
        }
      }
    }

    return offsets.isEmpty ? const <Offset>[Offset.zero] : offsets;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox? child = this.child;
    if (child == null) return;
    for (final Offset inst in computeOffsets()) {
      context.paintChild(child, offset + inst);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final RenderBox? child = this.child;
    if (child == null) return false;
    for (final Offset inst in computeOffsets()) {
      final bool hit = result.addWithPaintOffset(
        offset: inst,
        position: position,
        hitTest: (BoxHitTestResult r, Offset trans) =>
            child.hitTest(r, position: trans),
      );
      if (hit) return true;
    }
    return false;
  }
}
