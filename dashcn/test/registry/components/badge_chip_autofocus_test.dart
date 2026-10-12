// P7-Z: `Clickable` owns autofocus; badge/chip only forward it.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/badge/badge.dart';
import 'package:dashcn/src/components/chip/chip.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(Widget child) {
  return ShadcnTheme(
    data: const ShadcnThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Center(child: child),
    ),
  );
}

void main() {
  group('badge autofocus', () {
    testWidgets('forwards to Clickable and gains focus', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Badge(autofocus: true, onPressed: null, child: Text('static')),
        ),
      );
      await tester.pump();
      // Static badges never enter the focus tree.
      expect(
        find.descendant(
          of: find.byType(Badge),
          matching: find.byType(Clickable),
        ),
        findsNothing,
      );

      await tester.pumpWidget(
        _frame(
          Badge(autofocus: true, onPressed: () {}, child: const Text('press')),
        ),
      );
      await tester.pump();
      await tester.pump();
      final Clickable clickable = tester.widget<Clickable>(
        find.descendant(
          of: find.byType(Badge),
          matching: find.byType(Clickable),
        ),
      );
      expect(clickable.autofocus, isTrue);
      expect(Focus.of(tester.element(find.text('press'))).hasFocus, isTrue);
    });

    testWidgets('external node receives focus', (tester) async {
      final FocusNode node = FocusNode();
      addTearDown(node.dispose);
      await tester.pumpWidget(
        _frame(
          Badge(
            autofocus: true,
            focusNode: node,
            onPressed: () {},
            child: const Text('ext'),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(node.hasFocus, isTrue);
    });
  });

  group('chip autofocus', () {
    testWidgets('pressable chip forwards and gains focus', (tester) async {
      await tester.pumpWidget(
        _frame(Chip(autofocus: true, onPressed: () {}, child: const Text('c'))),
      );
      await tester.pump();
      await tester.pump();
      final Clickable clickable = tester.widget<Clickable>(
        find.descendant(
          of: find.byType(Chip),
          matching: find.byType(Clickable),
        ),
      );
      expect(clickable.autofocus, isTrue);
      expect(Focus.of(tester.element(find.text('c'))).hasFocus, isTrue);
    });

    testWidgets('ChipButton forwards autofocus', (tester) async {
      await tester.pumpWidget(
        _frame(
          ChipButton(
            autofocus: true,
            onPressed: () {},
            child: const Icon(IconData(0x1)),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      final Clickable clickable = tester.widget<Clickable>(
        find.descendant(
          of: find.byType(ChipButton),
          matching: find.byType(Clickable),
        ),
      );
      expect(clickable.autofocus, isTrue);
    });

    testWidgets('static chip builds no Clickable', (tester) async {
      await tester.pumpWidget(_frame(const Chip(child: Text('static'))));
      expect(
        find.descendant(
          of: find.byType(Chip),
          matching: find.byType(Clickable),
        ),
        findsNothing,
      );
    });
  });
}
