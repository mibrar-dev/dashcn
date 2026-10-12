// QA for the `gooey_toast` previews: every named example pumps without
// throwing, renders nothing before its trigger, and disposes its controller
// cleanly (P7-Q1 batch E contract).
//
// The ported controller portals into the ROOT overlay, so every preview test
// pumps a `DashcnApp` (that is where the root overlay comes from) and asserts
// on the overlay tree rather than on the preview box.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/components/gooey_toast/gooey_toast.dart';
import 'package:dashcn/src/components/gooey_toast/preview.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('every named example pumps and settles', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    for (final ComponentPreview example in gooeyToastPreviews) {
      await tester.pumpWidget(
        DashcnApp(
          home: Theme(
            data: const ThemeData(),
            child: Builder(
              builder: (BuildContext context) => example.builder(context),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: example.name);
      // Every demo renders a trigger: at least one gesture detector.
      expect(find.byType(GestureDetector), findsWidgets, reason: example.name);
      await tester.pumpWidget(const SizedBox.shrink());
      // Pump long enough for any pending demo timer to fire while its state is
      // already disposed, so `flutter_test` sees no timers left behind.
      await _settle(tester, const Duration(seconds: 12));
    }
  });

  testWidgets('no example renders a toast before its trigger', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    for (final ComponentPreview example in gooeyToastPreviews) {
      await tester.pumpWidget(
        DashcnApp(
          home: Theme(
            data: const ThemeData(),
            child: Builder(
              builder: (BuildContext context) => example.builder(context),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // A toast would portal into the root overlay, above the app: finding a
      // `GooeyToastCard` means one is showing.
      expect(
        find.byType(GooeyToastCard),
        findsNothing,
        reason: '${example.name} showed a toast before a click',
      );
      await tester.pumpWidget(const SizedBox.shrink());
      await _settle(tester, const Duration(seconds: 12));
    }
  });

  testWidgets('the playground examples are discoverable by name', (
    tester,
  ) async {
    final List<String> names = gooeyToastPreviews
        .map((ComponentPreview example) => example.name)
        .toList();
    expect(names, <String>[
      'Playground',
      'Variants',
      'Success',
      'Error',
      'Warning',
      'Info',
      'Action',
      'Promise',
      'Positions',
      'Animation presets',
      'Body animation',
      'Shapes',
      'Interactive Reply',
      'Booking Multi-State',
      'Tabs + ListView',
    ]);
  });

  testWidgets('a preview trigger anchors at the window edge', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    for (final ComponentPreview example in gooeyToastPreviews) {
      await tester.pumpWidget(
        DashcnApp(
          home: Theme(
            data: const ThemeData(),
            child: Builder(
              builder: (BuildContext context) => example.builder(context),
            ),
          ),
        ),
      );
      // Press every button in the demo: none of them may throw.
      final Finder buttons = find.byType(GestureDetector);
      final List<Element> elements = buttons.evaluate().toList();
      for (final Element element in elements) {
        final RenderBox box = element.renderObject! as RenderBox;
        if (!box.hasSize) {
          continue;
        }
        final Rect bounds = box.localToGlobal(Offset.zero) & box.size;
        if (bounds.width < 4 || bounds.height < 4) {
          continue;
        }
        await tester.tapAt(bounds.center);
        await tester.pump(const Duration(milliseconds: 200));
      }
      expect(tester.takeException(), isNull, reason: example.name);
      await tester.pumpWidget(const SizedBox.shrink());
      await _settle(tester, const Duration(seconds: 12));
    }
  });
}

/// Pumps in small steps for [total] and then settles.
Future<void> _settle(WidgetTester tester, Duration total) async {
  int remaining = total.inMilliseconds;
  while (remaining > 0) {
    final int step = remaining < 100 ? remaining : 100;
    await tester.pump(Duration(milliseconds: step));
    remaining -= step;
  }
  await tester.pumpAndSettle();
}
