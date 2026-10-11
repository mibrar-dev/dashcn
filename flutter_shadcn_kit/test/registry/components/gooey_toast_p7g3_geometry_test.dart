// P7-G3: the gooey silhouette matches the reference (`main`) for the docs-example
// configuration — canvas 360 wide, base roundness 16, the sharp shape
// (→ 16 × 0.9 = 14.4). The geometry is ported verbatim from
// `_buildGooeyShapePath` / `_buildGooeyBodyPath` / `_buildGooeyShoulderBlendPath`,
// so these font-independent facts are identical to the reference renderer.
//
// The pill width scales with the title (font-dependent), so this pins what does
// not move: the closed pill is exactly its content height (40), and the opened
// body spans the whole canvas width, like the reference.

import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/gooey_toast/gooey_toast.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_content.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_shape.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_surface.dart';
import 'package:flutter_test/flutter_test.dart';

const double _kCanvasWidth = 360;
const double _kResolvedRoundness = 16 * 0.9; // sharp
const double _kPillBase = 40 + (16 * 0.9) * 0.5 * 3;

void main() {
  test(
    'the reference-config silhouette has a 40px pill and full-width body',
    () {
      for (final String title in <String>[
        'Success',
        'Error',
        'Action Required',
        'Processing',
      ]) {
        final double pillW = GooeySurfacePill.measureWidth(
          title: title,
          style: gooeyTitleTextStyle,
          direction: TextDirection.ltr,
          pillHeight: kGooeySurfacePillHeight,
          maxWidth: _kCanvasWidth,
          extra: 10,
        );
        expect(pillW, inInclusiveRange(kGooeySurfacePillHeight, _kCanvasWidth));

        // Closed: the pill is exactly its 40px content height (the padded pill
        // squashed back down), like the reference (`_kToastHeight`).
        final GooeyShapeGeometry closed = GooeyShapeGeometry(
          roundness: _kResolvedRoundness,
          pillX: (_kCanvasWidth - pillW) / 2,
          pillWidth: pillW,
          pillHeight: 40,
          pillCanvasHeight: _kPillBase,
          pillScaleY: 40 / _kPillBase,
        );
        expect(
          closed
              .buildSilhouette(const Size(_kCanvasWidth, 40))
              .getBounds()
              .height,
          closeTo(40, 0.001),
          reason: '$title closed pill',
        );

        // Open: the body widens to the full canvas width (the reference morphs
        // the body from the pill width to `size.width`).
        final GooeyShapeGeometry open = GooeyShapeGeometry(
          roundness: _kResolvedRoundness,
          pillX: (_kCanvasWidth - pillW) / 2,
          pillWidth: pillW,
          pillHeight: 40,
          pillCanvasHeight: _kPillBase,
          pillScaleY: 1,
          bodyHeight: 120,
          bodyScaleY: 1,
        );
        final Rect bounds = open
            .buildSilhouette(const Size(_kCanvasWidth, 160))
            .getBounds();
        expect(
          bounds.right,
          closeTo(_kCanvasWidth, 0.5),
          reason: '$title body',
        );
      }
    },
  );
}
