// QA for `chip` previews (P7-Q1, updated for the P7-C1 examples).
//
// Regression cover for: the dead `autofocus` on Chip and ChipButton (now
// honoured through an owned focus node).

import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/chip/chip.dart';
import 'package:dashcn/src/components/chip/preview.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  double? width,
}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: SizedBox(
          key: const ValueKey<String>('stage'),
          width: width,
          child: child,
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in chipPreviews) {
      for (final colors in <ThemeColors>[
        ThemeColors.lightFallback,
        ThemeColors.darkFallback,
      ]) {
        await tester.pumpWidget(
          _frame(
            Builder(builder: preview.builder),
            data: ThemeData(colors: colors),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          tester.takeException(),
          isNull,
          reason: '${preview.name} light/dark',
        );
      }
    }
  });

  testWidgets('autofocus focuses a pressable chip', (tester) async {
    await tester.pumpWidget(
      _frame(Chip(autofocus: true, onPressed: () {}, child: const Text('c'))),
    );
    await tester.pump();
    await tester.pump();
    expect(Focus.of(tester.element(find.text('c'))).hasPrimaryFocus, isTrue);
  });

  testWidgets('autofocus focuses a chip button', (tester) async {
    await tester.pumpWidget(
      _frame(
        ChipButton(autofocus: true, onPressed: () {}, child: const Text('x')),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(Focus.of(tester.element(find.text('x'))).hasPrimaryFocus, isTrue);
  });

  testWidgets('removable preview counts clicks on the x', (tester) async {
    await tester.pumpWidget(_frame(Builder(builder: chipPreviews[0].builder)));
    await tester.pumpAndSettle();
    expect(find.text('4 of 4 shown'), findsOneWidget);
    await tester.tap(find.byIcon(LucideIcons.x).first);
    await tester.pump();
    await tester.pump();
    expect(find.text('3 of 4 shown'), findsOneWidget);
    // Reset restores the list, so the example is re-runnable.
    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(find.text('4 of 4 shown'), findsOneWidget);
  });

  testWidgets('selectable preview counts toggles', (tester) async {
    await tester.pumpWidget(_frame(Builder(builder: chipPreviews[1].builder)));
    await tester.pumpAndSettle();
    expect(find.text('2 selected'), findsOneWidget);
    await tester.tap(find.text('Sports'));
    await tester.pump();
    await tester.pump();
    expect(find.text('3 selected'), findsOneWidget);
    await tester.tap(find.text('Travel'));
    await tester.pump();
    await tester.pump();
    expect(find.text('2 selected'), findsOneWidget);
  });

  testWidgets('chip examples are centred in the stage', (tester) async {
    for (final preview in chipPreviews) {
      await tester.pumpWidget(
        _frame(Builder(builder: preview.builder), width: 720),
      );
      await tester.pumpAndSettle();
      final RenderBox stage = tester.renderObject(
        find.byKey(const ValueKey<String>('stage')),
      );
      final double stageCentre =
          stage.localToGlobal(Offset.zero).dx + stage.size.width / 2;
      double left = double.infinity;
      double right = -double.infinity;
      for (final Element e in find.byType(Chip).evaluate()) {
        final RenderBox box = e.renderObject! as RenderBox;
        final Rect rect = box.localToGlobal(Offset.zero) & box.size;
        left = math.min(left, rect.left);
        right = math.max(right, rect.right);
      }
      expect(left.isFinite && right > left, isTrue);
      expect(
        (left + right) / 2,
        closeTo(stageCentre, 1),
        reason: '${preview.name} must centre its chips',
      );
    }
  });

  testWidgets('static chip builds no Clickable', (tester) async {
    await tester.pumpWidget(_frame(const Chip(child: Text('s'))));
    await tester.pump();
    expect(find.byType(Clickable), findsNothing);
  });
}
