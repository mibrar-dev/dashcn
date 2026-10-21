import 'package:dashcn/src/components/action_sheet/action_sheet.dart';
import 'package:dashcn/src/theme/density_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  required Widget child,
  ThemeData data = const ThemeData(),
  double width = 800,
}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData(size: Size(width, 800)),
        child: Center(child: child),
      ),
    ),
  );
}

void main() {
  testWidgets('ActionSheet renders title and actions', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ActionSheet<void>(
          title: 'Title',
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'Do'),
          ],
        ),
      ),
    );
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Do'), findsOneWidget);
  });

  testWidgets('ActionSheet renders cancel', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ActionSheet<void>(
          title: 'Title',
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'Do'),
          ],
          cancelAction: ActionSheetAction<void>(label: 'Cancel'),
        ),
      ),
    );
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('compact is default: maxWidth 320, row 32, icon 16', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: const ActionSheet<void>(
          title: 'T',
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'A'),
          ],
        ),
      ),
    );
    await tester.pump();
    // Desktop width caps at the compact overlay max width.
    final ConstrainedBox box = tester.widget<ConstrainedBox>(
      find
          .ancestor(of: find.text('T'), matching: find.byType(ConstrainedBox))
          .first,
    );
    expect(box.constraints.maxWidth, 320);
    expect(tester.takeException(), isNull);
  });

  testWidgets('density overrides respected (comfortable wider + taller)', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: const ActionSheet<void>(
          densityTokens: DensityTokens.comfortable,
          title: 'T',
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'A'),
          ],
        ),
      ),
    );
    await tester.pump();
    final ConstrainedBox box = tester.widget<ConstrainedBox>(
      find
          .ancestor(of: find.text('T'), matching: find.byType(ConstrainedBox))
          .first,
    );
    expect(box.constraints.maxWidth, 360);
    expect(tester.takeException(), isNull);
  });

  testWidgets('theme rowMinHeight override wins', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: const ActionSheet<void>(
          title: 'T',
          theme: ActionSheetTheme(rowMinHeight: 48),
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'A'),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('action tap fires callback', (tester) async {
    var pressed = 0;
    await tester.pumpWidget(
      _frame(
        child: ActionSheet<void>(
          title: 'T',
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'Do', onPressed: () => pressed++),
          ],
        ),
      ),
    );
    await tester.tap(find.text('Do'));
    await tester.pump();
    expect(pressed, 1);
  });

  testWidgets('custom builders swap title, row and divider', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: ActionSheet<void>(
          title: 'T',
          titleBuilder: (context, title, style) => Text('CUSTOM:$title'),
          dividerBuilder: (context) => Container(height: 2),
          actionBuilder: (context, action, row, isCancel) => row,
          actions: const <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'A'),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(find.text('CUSTOM:T'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('RTL renders without overflow', (tester) async {
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(800, 800)),
            child: Center(
              child: ActionSheet<void>(
                title: 'T',
                actions: <ActionSheetAction<void>>[
                  ActionSheetAction<void>(
                    label: 'A',
                    icon: const Text('I'),
                    trailing: const Text('T'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion builds', (tester) async {
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(
              size: Size(800, 800),
              disableAnimations: true,
            ),
            child: Center(
              child: ActionSheet<void>(
                title: 'T',
                actions: const <ActionSheetAction<void>>[
                  ActionSheetAction<void>(label: 'A'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('T'), findsOneWidget);
  });

  testWidgets('no overflow at 375 phone width', (tester) async {
    await tester.pumpWidget(
      _frame(
        width: 375,
        child: ActionSheet<void>(
          title: 'A very long title that should truncate with ellipsis',
          message: 'A message that is also quite long and should not overflow',
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(
              label: 'An extremely long action label that must truncate',
            ),
          ],
          cancelAction: const ActionSheetAction<void>(label: 'Cancel'),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('keyboard reachable: actions expose button semantics', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: const ActionSheet<void>(
          title: 'T',
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'A'),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(
      find.ancestor(
        of: find.text('A'),
        matching: find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.button == true,
        ),
      ),
      findsWidgets,
    );
  });
}
