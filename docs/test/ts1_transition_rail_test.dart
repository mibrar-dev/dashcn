// P7-TS1 bug 5 (rail wiring): the `Transition` row's picker commits the
// tapped kind to the site model.
//
// Split from `ts1_transition_test.dart` (which owns the kinds in isolation)
// for the ~400-line rule. A double `pumpWidget` reuses the shell element
// while the harness global moves on, so every shell test here pumps exactly
// once — otherwise the rail commits to a stale model and the assertions go
// vacuously green.

import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/state/docs_storage.dart';
import 'package:docs/ui/dashcn/components/menu/menu.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/rail_pickers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

SiteThemeModel _model() {
  final SiteThemeModel model = SiteThemeModel(
    storage: MemoryDocsStorage(<String, String>{}),
  );
  addTearDown(model.dispose);
  return model;
}

Future<DocsRouterDelegate> _delegate(WidgetTester tester) =>
    pumpDocsApp(tester).then((DocsRouterDelegate d) async {
      await goTo(tester, d, '/themes');
      return d;
    });

void main() {
  group('rail transition row', () {
    testWidgets('the picker commits the tapped kind', (tester) async {
      final SiteThemeModel model = _model();
      DocsThemeTransition? picked;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1400, 900)),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Theme(
              data: model.themeFor(Brightness.light),
              child: Overlay(
                initialEntries: <OverlayEntry>[
                  OverlayEntry(
                    builder: (BuildContext context) => Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => showTransitionPicker(
                          context,
                          () => DocsThemeTransition.fade,
                          onChanged: (DocsThemeTransition kind) =>
                              picked = kind,
                        ),
                        child: const Text('open'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsOneWidget);
      final Finder circular = find.descendant(
        of: find.byType(MenuPopup),
        matching: find.text('Circular'),
      );
      expect(circular, findsOneWidget);
      await tester.ensureVisible(circular);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      await tester.tap(circular);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(picked, DocsThemeTransition.circular);
      expect(find.byType(MenuPopup), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('picking a kind commits it to the model', (tester) async {
      await goTo(tester, await _delegate(tester), '/themes');
      final Finder transitionRow = find.byKey(
        const ValueKey<String>('rail-row-transition'),
      );
      expect(transitionRow, findsOneWidget);
      // The row sits last in a scrolling rail; bring it into view first.
      await tester.ensureVisible(transitionRow);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      await tester.tap(transitionRow);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsOneWidget);
      final Finder circular = find.descendant(
        of: find.byType(MenuPopup),
        matching: find.text('Circular'),
      );
      expect(circular, findsOneWidget);
      // The popup reveals the committed row on mount; scroll the pick into
      // view first, exactly as a user would.
      await tester.ensureVisible(circular);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      await tester.tap(circular);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      expect(docsState.themeModel.transition, DocsThemeTransition.circular);
      expect(tester.takeException(), isNull);
    });
  });
}
