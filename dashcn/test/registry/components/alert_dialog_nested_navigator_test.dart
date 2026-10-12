// Regression (user report 2026-10-11): pressing an alert action whose callback
// popped the CALLER's context popped the page under the dialog when the app
// has a nested navigator (the docs site), leaving that navigator empty
// (`_history.isNotEmpty` assertion). `actionsBuilder` hands the dialog's own
// context to the actions, so popping it closes the dialog only.
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('actions pop the dialog, not the page of a nested navigator', (
    WidgetTester tester,
  ) async {
    late BuildContext pageContext;
    final GlobalKey<NavigatorState> inner = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      ShadcnTheme(
        data: const ShadcnThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          // Root navigator (the app) hosting a nested navigator (the router).
          child: Navigator(
            onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
              settings: settings,
              pageBuilder: (_, _, _) => Navigator(
                key: inner,
                onGenerateRoute: (RouteSettings s) => PageRouteBuilder<void>(
                  settings: s,
                  pageBuilder: (BuildContext context, _, _) {
                    pageContext = context;
                    return const Center(child: Text('home page'));
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Object? result;
    showAlertDialog<bool>(
      context: pageContext,
      title: const Text('Delete this project?'),
      actionsBuilder: (BuildContext dialogContext) => <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(dialogContext, true),
          child: const Text('Delete'),
        ),
      ],
    ).then((bool? value) => result = value);
    await tester.pumpAndSettle();
    expect(find.text('Delete this project?'), findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(result, isTrue);
    expect(find.text('Delete this project?'), findsNothing);
    expect(find.text('home page'), findsOneWidget);
    expect(inner.currentState!.canPop(), isFalse);
  });
}
