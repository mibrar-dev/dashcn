import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/action_sheet/action_sheet.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
