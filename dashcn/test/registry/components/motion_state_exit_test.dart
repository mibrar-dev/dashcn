// State-change and error-exit animation tests for the motion pass:
// checkbox box fill glides, tabs pill fill is instant by default and animated
// opt-in, and form error messages collapse away instead of vanishing.

import 'package:dashcn/src/components/checkbox/checkbox.dart';
import 'package:dashcn/src/components/form/form.dart';
import 'package:dashcn/src/components/tabs/tabs.dart';
import 'package:dashcn/src/primitives/motion/motion_collapse.dart';
import 'package:dashcn/src/primitives/motion/motion_spec.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(Widget child, {double width = 800}) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: SizedBox(width: width, child: child),
      ),
    ),
  );
}

void main() {
  group('checkbox box fill', () {
    testWidgets('fill glides to the checked colour', (tester) async {
      await tester.pumpWidget(
        _frame(const Checkbox(value: CheckboxValue.unchecked, onChanged: null)),
      );
      // The box keeps its DecoratedBox identity; the tween drives it.
      expect(
        find.ancestor(
          of: find.byKey(kCheckboxBoxKey),
          matching: find.byType(TweenAnimationBuilder<Decoration?>),
        ),
        findsOneWidget,
      );
      expect(
        tester.widget<DecoratedBox>(find.byKey(kCheckboxBoxKey)),
        isNotNull,
      );
      await tester.pumpWidget(
        _frame(const Checkbox(value: CheckboxValue.checked, onChanged: null)),
      );
      await tester.pump(const Duration(milliseconds: 50));
      final Color? mid =
          (tester.widget<DecoratedBox>(find.byKey(kCheckboxBoxKey)).decoration
                  as BoxDecoration?)
              ?.color;
      // Mid-flight the fill is a blend, not the settled checked colour.
      expect(mid, isNotNull);
      expect(mid, isNot(ThemeColors.lightFallback.primary));
      await tester.pumpAndSettle();
      expect(
        (tester.widget<DecoratedBox>(find.byKey(kCheckboxBoxKey)).decoration
                as BoxDecoration?)
            ?.color,
        ThemeColors.lightFallback.primary,
      );
    });

    testWidgets('motion spec is accepted', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Checkbox(
            value: CheckboxValue.checked,
            onChanged: null,
            motion: MotionSpec(disabled: true),
          ),
        ),
      );
      await tester.pumpWidget(
        _frame(
          const Checkbox(
            value: CheckboxValue.unchecked,
            onChanged: null,
            motion: MotionSpec(disabled: true),
          ),
        ),
      );
      await tester.pump();
      expect(find.byKey(kCheckboxBoxKey), findsOneWidget);
    });
  });

  group('tabs pill fill', () {
    List<TabItem> items() => const <TabItem>[
      TabItem(child: Text('One')),
      TabItem(child: Text('Two')),
    ];

    /// The pill is the only AnimatedContainer carrying a real decoration
    /// (TabButton's Clickable paints with a null decoration).
    Finder pillAnimates() => find.byWidgetPredicate(
      (Widget widget) =>
          widget is AnimatedContainer && widget.decoration is BoxDecoration,
    );

    testWidgets('fill swaps instantly by default', (tester) async {
      await tester.pumpWidget(_frame(Tabs(index: 0, children: items())));
      expect(pillAnimates(), findsNothing);
      // The pills themselves are plain Containers.
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('motion spec animates the fill', (tester) async {
      await tester.pumpWidget(
        _frame(Tabs(index: 0, motion: const MotionSpec(), children: items())),
      );
      expect(pillAnimates(), findsWidgets);
      await tester.pumpWidget(
        _frame(Tabs(index: 1, motion: const MotionSpec(), children: items())),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AnimatedContainer), findsWidgets);
    });
  });

  group('form error exit', () {
    Widget messages(String? message) => FormFieldMessages(
      spacing: 4,
      hintStyle: const TextStyle(),
      messageStyle: const TextStyle(),
      message: message,
    );

    testWidgets('clearing the message collapses instead of cutting', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(messages('Required')));
      expect(find.text('Required'), findsOneWidget);
      await tester.pumpWidget(_frame(messages(null)));
      await tester.pump(const Duration(milliseconds: 50));
      // Exit is playing: still mounted, already shrinking.
      expect(find.text('Required'), findsOneWidget);
      expect(find.byType(MotionCollapse), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Required'), findsNothing);
    });

    testWidgets('no overflow at 375 px with the error showing', (tester) async {
      await tester.pumpWidget(
        _frame(messages('This field cannot be empty.'), width: 375),
      );
      await tester.pumpAndSettle();
      expect(find.text('This field cannot be empty.'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
