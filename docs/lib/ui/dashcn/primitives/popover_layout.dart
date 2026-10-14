// `PopoverLayout`: positions and constrains its child relative to an anchor.
//
// Ported from `shared/primitives/_impl/core/popover_layout.dart`; the render
// object lives in `popover_layout_render.dart`.

import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'overlay.dart';
import 'popover_layout_render.dart';

/// Positions a popover relative to an anchor, with automatic inversion when
/// the content would overflow the viewport.
class PopoverLayout extends SingleChildRenderObjectWidget {
  /// Popover alignment relative to the anchor.
  final Alignment alignment;

  /// Anchor alignment used to compute the attachment point.
  final Alignment anchorAlignment;

  /// Explicit position (overrides the alignment-derived one).
  final Offset? position;

  /// Size of the anchor widget.
  final Size? anchorSize;

  /// Width constraint strategy.
  final PopoverConstraint widthConstraint;

  /// Height constraint strategy.
  final PopoverConstraint heightConstraint;

  /// Additional offset from the computed position.
  final Offset? offset;

  /// Margin around the popover.
  final EdgeInsets margin;

  /// Scale factor applied to the popover.
  final double scale;

  /// Alignment point used for the scale transform.
  final Alignment scaleAlignment;

  /// Filter quality for scaled content.
  final FilterQuality? filterQuality;

  /// Whether horizontal inversion is allowed.
  final bool allowInvertHorizontal;

  /// Whether vertical inversion is allowed.
  final bool allowInvertVertical;

  /// Creates a popover layout.
  const PopoverLayout({
    super.key,
    required this.alignment,
    required this.position,
    required this.anchorAlignment,
    required this.widthConstraint,
    required this.heightConstraint,
    this.anchorSize,
    this.offset,
    required this.margin,
    required Widget super.child,
    required this.scale,
    required this.scaleAlignment,
    this.filterQuality,
    this.allowInvertHorizontal = true,
    this.allowInvertVertical = true,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return PopoverLayoutRender(
      alignment: alignment,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      anchorSize: anchorSize,
      offset: offset,
      margin: margin,
      scale: scale,
      scaleAlignment: scaleAlignment,
      filterQuality: filterQuality,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant PopoverLayoutRender renderObject,
  ) {
    renderObject.updateConfiguration(
      alignment: alignment,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      anchorSize: anchorSize,
      offset: offset,
      margin: margin,
      scale: scale,
      scaleAlignment: scaleAlignment,
      filterQuality: filterQuality,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
    );
  }
}

/// Width hug for popover panels: the child takes its natural width, capped
/// at [maxWidth] and at the incoming maximum minus [gutter] (the overlay
/// margin), so grids take the cap while small content hugs its own width.
///
/// A plain `ConstrainedBox` cannot do this job: under the overlay's flexible
/// constraint the incoming maximum is the viewport, and stretchy content
/// (rows of `Expanded`) fills all of it. Capping the maximum is enough, with
/// no intrinsic query, so `LayoutBuilder` descendants stay safe.
class PopoverHugWidth extends SingleChildRenderObjectWidget {
  /// Creates a width hug.
  const PopoverHugWidth({
    super.key,
    required this.maxWidth,
    required this.gutter,
    required super.child,
  });

  /// Panel cap; grids of `Expanded` rows take all of it.
  final double maxWidth;

  /// Horizontal space the overlay margin reserves; subtracted from the cap.
  final double gutter;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderPopoverHugWidth(maxWidth: maxWidth, gutter: gutter);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderPopoverHugWidth renderObject,
  ) {
    renderObject.maxWidth = maxWidth;
    renderObject.gutter = gutter;
  }
}

/// The render object behind [PopoverHugWidth].
class RenderPopoverHugWidth extends RenderProxyBox {
  /// Creates a width-hug render object.
  RenderPopoverHugWidth({required this._maxWidth, required this._gutter});

  double _maxWidth;
  double _gutter;

  /// Panel cap; relayouts on change.
  set maxWidth(double value) {
    if (value == _maxWidth) return;
    _maxWidth = value;
    markNeedsLayout();
  }

  /// Overlay-margin gutter; relayouts on change.
  set gutter(double value) {
    if (value == _gutter) return;
    _gutter = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final RenderBox? child = this.child;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    final BoxConstraints incoming = constraints;
    double hi = math.min(_maxWidth, incoming.maxWidth - _gutter);
    if (hi < incoming.minWidth) hi = incoming.minWidth;
    if (hi < 0) hi = 0;
    child.layout(
      BoxConstraints(
        minWidth: incoming.minWidth,
        maxWidth: hi,
        minHeight: incoming.minHeight,
        maxHeight: incoming.maxHeight,
      ),
      parentUsesSize: true,
    );
    size = incoming.constrain(child.size);
  }
}
