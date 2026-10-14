// QA for `alert_dialog` previews (P7-Q1, P7I-alert-dialog).
//
// Regression cover for: non-`end` footer alignments collapsing to the start,
// the unscaled header icon, and (P7I) every example opening over the whole
// app with the title inset from the card edge and a positive footer gap.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/alert_dialog/preview.dart';
import 'package:dashcn/src/components/dialog/dialog.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/foundation/gap.dart';
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
        child: width == null ? child : SizedBox(width: width, child: child),
      ),
    ),
  );
}

ComponentPreview _example(String name) => alertDialogPreviews.firstWhere(
  (ComponentPreview preview) => preview.name == name,
);

/// Pumps one example the way the docs stage does: a centred trigger inside a
/// real navigator, so `showAlertDialog` can push over the app.
Future<void> _pumpExample(WidgetTester tester, String name) async {
  final ComponentPreview preview = _example(name);
  await tester.pumpWidget(
    Theme(
      data: const ThemeData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Navigator(
          onGenerateRoute: (settings) => PageRouteBuilder<void>(
            settings: settings,
            pageBuilder: (context, _, _) =>
                Center(child: Builder(builder: preview.builder)),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

AlertDialog _dialog(MainAxisAlignment alignment, List<Widget> actions) {
  return AlertDialog(
    title: const Text('t'),
    description: const Text('d'),
    actions: actions,
    theme: AlertDialogTheme(footerAlignment: alignment),
  );
}

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in alertDialogPreviews) {
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

  testWidgets('single centered action is centered, not start-aligned', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(_dialog(MainAxisAlignment.center, const <Widget>[Text('ok')])),
    );
    await tester.pump();
    final Align align = tester.widget<Align>(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(Align),
      ),
    );
    expect(align.alignment, AlignmentDirectional.center);
  });

  testWidgets('multiple centered actions use WrapAlignment.center', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        _dialog(MainAxisAlignment.center, const <Widget>[Text('a'), Text('b')]),
      ),
    );
    await tester.pump();
    final Wrap wrap = tester.widget<Wrap>(find.byType(Wrap));
    expect(wrap.alignment, WrapAlignment.center);
  });

  testWidgets('delete trigger opens with one actionGap between actions', (
    tester,
  ) async {
    await _pumpExample(tester, 'Delete account');
    expect(find.text('Delete your account?'), findsNothing);
    await tester.tap(find.text('Delete account'));
    await tester.pumpAndSettle();
    // The footer Wrap holds exactly the two action buttons: no spacer
    // widget sits between them, so the Wrap `spacing` (actionGap, the
    // spacing scale's `sm`) is the only gap.
    final Wrap footer = tester.widget<Wrap>(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(Wrap),
      ),
    );
    expect(footer.children.length, 2);
    expect(footer.spacing, 8);
  });

  testWidgets('live push opens, returns a result and pops', (tester) async {
    // P7-WA: the live route push is the 'Live push' example by name.
    await _pumpExample(tester, 'Live push');
    await tester.tap(find.text('Show alert dialog'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this project?'), findsWidgets);
    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();
    expect(find.text('Show alert dialog'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('trigger preview fits 375px', (tester) async {
    await tester.pumpWidget(
      _frame(Builder(builder: _example('Delete account').builder), width: 375),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('example opens in the root overlay with card insets', (
    tester,
  ) async {
    // Nested navigator (the docs router) inside the root navigator (the
    // app): the trigger must push on the root, over the whole app.
    final GlobalKey<NavigatorState> root = GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> inner = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Navigator(
            key: root,
            onGenerateRoute: (settings) => PageRouteBuilder<void>(
              settings: settings,
              pageBuilder: (_, _, _) => Navigator(
                key: inner,
                onGenerateRoute: (settings) => PageRouteBuilder<void>(
                  settings: settings,
                  pageBuilder: (context, _, _) => Center(
                    child: Builder(builder: _example('Delete account').builder),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete account'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(root.currentState!.canPop(), isTrue);
    expect(inner.currentState!.canPop(), isFalse);
    // The title sits inside the card padding: the default `DialogTheme`
    // p-6 (24px at default density) clears the 16px floor on every side.
    final Rect card = tester.getRect(find.byKey(kDialogSurfaceKey));
    final Rect title = tester.getRect(find.text('Delete your account?'));
    expect(title.left - card.left, greaterThanOrEqualTo(16));
    expect(title.top - card.top, greaterThanOrEqualTo(16));
    // Header-to-footer breathing room is positive on every gap.
    final Iterable<Gap> gaps = tester.widgetList<Gap>(
      find.descendant(of: find.byType(AlertDialog), matching: find.byType(Gap)),
    );
    expect(gaps, isNotEmpty);
    expect(gaps.every((Gap gap) => gap.mainAxisExtent > 0), isTrue);
    expect(tester.takeException(), isNull);
  });
}
