// P7-Z: the shrink-wrap dialog bounds unbounded editors to the viewport.

import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/primitives/form_core/object_form_field.dart';
import 'package:flutter_shadcn_kit/registry/primitives/form_core/object_form_prompt.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(Widget child, {Size size = const Size(800, 600)}) {
  return ShadcnTheme(
    data: const ShadcnThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData(size: size),
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
            settings: settings,
            pageBuilder: (BuildContext context, _, _) => Center(child: child),
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('ObjectFormPromptDialog bounds', () {
    testWidgets('unbounded width editor lays out without throwing', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          ObjectFormPromptDialog<String>(
            initialValue: null,
            editorBuilder:
                (BuildContext context, ObjectFormHandler<String> h) =>
                    const SizedBox(width: double.infinity, height: 40),
            onPrompt: (_) {},
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.byKey(kObjectFormDialogSurfaceKey), findsOneWidget);
      final Rect card = tester.getRect(find.byKey(kObjectFormDialogSurfaceKey));
      expect(card.width, lessThanOrEqualTo(480));
      expect(card.width, lessThanOrEqualTo(800));
    });

    testWidgets('unbounded height viewport editor lays out', (tester) async {
      await tester.pumpWidget(
        _frame(
          ObjectFormPromptDialog<String>(
            initialValue: null,
            editorBuilder:
                (BuildContext context, ObjectFormHandler<String> h) => ListView(
                  shrinkWrap: true,
                  children: const <Widget>[
                    SizedBox(height: 40, child: Text('a')),
                    SizedBox(height: 40, child: Text('b')),
                  ],
                ),
            onPrompt: (_) {},
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.byKey(kObjectFormDialogSurfaceKey), findsOneWidget);
    });

    testWidgets('small editor still shrink-wraps above the floor', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          ObjectFormPromptDialog<String>(
            initialValue: null,
            editorBuilder:
                (BuildContext context, ObjectFormHandler<String> h) =>
                    const SizedBox(width: 50, height: 20, child: Text('hi')),
            onPrompt: (_) {},
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      final Rect card = tester.getRect(find.byKey(kObjectFormDialogSurfaceKey));
      expect(card.width, greaterThanOrEqualTo(240));
      expect(card.width, lessThanOrEqualTo(480));
    });
  });
}
