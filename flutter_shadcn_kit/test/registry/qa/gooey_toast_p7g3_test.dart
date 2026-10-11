// P7-G3 contracts — the gooey toast now matches the reference (`main`):
// a light near-white surface (user: "still not looking the same"), NO stroke,
// the `Confirm` action button on the action variant, and NO close button.
// Geometry constants equal the reference are pinned in the component test.

import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/app/app.dart';
import 'package:flutter_shadcn_kit/registry/components/gooey_toast/gooey_toast.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_chip.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_close.dart';
import 'package:flutter_shadcn_kit/registry/primitives/gooey/gooey_paint.dart';
import 'package:flutter_shadcn_kit/registry/theme/color_tokens.dart';
import 'package:flutter_test/flutter_test.dart';

/// P0: the kit's surface must equal main's light near-white.
const Color _kRefSurface = Color(0xFFF7F8FA);

Future<void> _advanceMilliseconds(WidgetTester tester, Duration total) async {
  int remaining = total.inMilliseconds;
  while (remaining > 0) {
    final int step = remaining < 100 ? remaining : 100;
    await tester.pump(Duration(milliseconds: step));
    remaining -= step;
  }
}

void main() {
  test('the default surface fill is main\'s light near-white', () {
    final ThemedColor? fill = gooeyToastDefaults.fill;
    expect(fill, isA<LiteralColor>());
    expect((fill as LiteralColor).color, _kRefSurface);
  });

  test('the surface fill stays light against a dark colour scheme', () {
    // In dark site mode the toast is still the light reference surface.
    final Color resolved = gooeyToastDefaults.fill!.resolve(
      ShadcnColors.darkFallback,
    );
    expect(resolved, _kRefSurface);
    expect(resolved.computeLuminance(), greaterThan(0.8));
  });

  testWidgets('no stroke is painted around the surface', (tester) async {
    final GooeyToastController controller = GooeyToastController();
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ShadcnApp(
        home: GooeyToastLayer(
          controller: controller,
          child: const SizedBox.shrink(),
        ),
      ),
    );
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      GooeyToastOptions(title: 'Saved', description: 'Body'),
    );
    await _advanceMilliseconds(tester, const Duration(milliseconds: 900));
    await tester.pump();
    final List<GooeyShapePainter> painters = tester
        .widgetList<CustomPaint>(find.byType(CustomPaint))
        .map((CustomPaint p) => p.painter)
        .whereType<GooeyShapePainter>()
        .toList();
    expect(painters, isNotEmpty);
    // The reference has no border; every painter paints fill only.
    expect(
      painters.where((GooeyShapePainter p) => p.borderColor != null),
      isEmpty,
    );
    controller.dispose();
  });

  testWidgets('the action variant renders the Confirm button', (tester) async {
    final GooeyToastController controller = GooeyToastController();
    await tester.pumpWidget(
      ShadcnApp(
        home: GooeyToastLayer(
          controller: controller,
          child: const SizedBox.shrink(),
        ),
      ),
    );
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      const GooeyToastOptions(
        title: 'Action Required',
        description: 'Review and confirm this request.',
        state: GooeyToastState.action,
        action: GooeyToastAction(label: 'Confirm', onPressed: _noop),
      ),
    );
    await _advanceMilliseconds(tester, const Duration(milliseconds: 900));
    expect(find.byType(GooeyActionChip), findsOne);
    expect(find.text('Confirm'), findsOne);
    controller.dispose();
  });

  testWidgets('no close button exists at any phase', (tester) async {
    final GooeyToastController controller = GooeyToastController();
    await tester.pumpWidget(
      ShadcnApp(
        home: GooeyToastLayer(
          controller: controller,
          child: const SizedBox.shrink(),
        ),
      ),
    );
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      const GooeyToastOptions(title: 'Saved', description: 'Body'),
    );
    // Closed pill and open body: neither shows a close button.
    await tester.pump();
    expect(find.byType(GooeyCloseButton), findsNothing);
    await _advanceMilliseconds(tester, const Duration(milliseconds: 900));
    await tester.pump();
    expect(find.byType(GooeyCloseButton), findsNothing);
    controller.dispose();
  });
}

void _noop() {}
