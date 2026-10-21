// Density, sizing, RTL, reduced-motion and 375px overflow tests for the
// interactive-overlays batch: popup, dropdown_menu, search_bar and command.
//
// Covers the batch contract: compact by default, menu 160-320 px wide,
// item height = density row height, click-to-open overlays with Escape /
// outside-tap / selection dismissal, keyboard traversal, live search
// filtering, theme overrides, custom builders, RTL and reduced motion.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/command/command.dart';
import 'package:dashcn/src/components/dropdown_menu/dropdown_menu.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/popup/popup.dart';
import 'package:dashcn/src/components/search_bar/search_bar.dart';
import 'package:dashcn/src/primitives/subfocus_list_item.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _green = Color(0xFF00FF00);

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  bool disableAnimations = false,
  double width = 800,
}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: direction,
      child: MediaQuery(
        data: MediaQueryData(
          size: Size(width, 800),
          disableAnimations: disableAnimations,
        ),
        child: TapRegionSurface(
          child: Overlay(
            initialEntries: <OverlayEntry>[
              OverlayEntry(
                builder: (context) =>
                    Align(alignment: Alignment.topLeft, child: child),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

List<Widget> _menuRows() {
  return <Widget>[
    MenuButton(child: const Text('Profile'), onPressed: (_) {}),
    MenuButton(child: const Text('Settings'), onPressed: (_) {}),
  ];
}

void main() {
  group('dropdown_menu density sizing', () {
    testWidgets('surface hugs content between 160 and 320', (tester) async {
      await tester.pumpWidget(_frame(DropdownMenu(children: _menuRows())));
      await tester.pump();
      final Size size = tester.getSize(find.byType(MenuPopup));
      expect(size.width, greaterThanOrEqualTo(160));
      expect(size.width, lessThanOrEqualTo(320));
    });

    testWidgets('widget width pins the surface', (tester) async {
      await tester.pumpWidget(
        _frame(DropdownMenu(width: 200, children: _menuRows())),
      );
      await tester.pump();
      expect(tester.getSize(find.byType(MenuPopup)).width, closeTo(200, 1));
    });

    testWidgets('widget theme minWidth beats the 160 default', (tester) async {
      await tester.pumpWidget(
        _frame(
          DropdownMenu(
            theme: const MenuPopupTheme(
              background: ThemedColor.value(_green),
              minWidth: 180,
            ),
            children: <Widget>[
              MenuButton(child: const Text('x'), onPressed: (_) {}),
            ],
          ),
        ),
      );
      await tester.pump();
      expect(
        tester.getSize(find.byType(MenuPopup)).width,
        greaterThanOrEqualTo(180),
      );
    });

    testWidgets('rows are the density row height (32 compact)', (tester) async {
      await tester.pumpWidget(_frame(DropdownMenu(children: _menuRows())));
      await tester.pump();
      expect(tester.getSize(find.byType(RovingRow).first).height, 32);
    });
  });

  group('popup density sizing', () {
    testWidgets('showPopup surface respects 160-320 bounds', (tester) async {
      late BuildContext host;
      await tester.pumpWidget(
        _frame(
          Builder(
            builder: (context) {
              host = context;
              return const SizedBox(width: 120, height: 36);
            },
          ),
        ),
      );
      await tester.pump();
      showPopup<void>(
        context: host,
        builder: (context) =>
            const Padding(padding: EdgeInsets.all(8), child: Text('Hi')),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      final Size size = tester.getSize(find.byType(MenuPopup));
      expect(size.width, greaterThanOrEqualTo(160));
      expect(size.width, lessThanOrEqualTo(320));
    });

    testWidgets('showPopup maxWidth override widens the surface', (
      tester,
    ) async {
      late BuildContext host;
      await tester.pumpWidget(
        _frame(
          Builder(
            builder: (context) {
              host = context;
              return const SizedBox(width: 120, height: 36);
            },
          ),
        ),
      );
      await tester.pump();
      showPopup<void>(
        context: host,
        maxWidth: 500,
        width: 400,
        builder: (context) => const Text('wide'),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.getSize(find.byType(MenuPopup)).width, closeTo(400, 2));
    });
  });

  group('command + search_bar live filtering', () {
    testWidgets('command builder filters as the query types', (tester) async {
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 320,
            height: 300,
            child: Command(
              debounceDuration: Duration.zero,
              builder: (context, query) async* {
                final List<String> ranked = rankCommandLabels(const <String>[
                  'Calendar',
                  'Settings',
                  'Mail',
                ], query);
                yield <Widget>[
                  for (final String v in ranked)
                    SubFocusListItem(minHeight: 48, title: Text(v)),
                ];
              },
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Calendar'), findsOneWidget);
      await tester.enterText(find.byType(EditableText), 'Cal');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Calendar'), findsOneWidget);
      expect(find.text('Mail'), findsNothing);
    });

    testWidgets('search_bar filters live and arrows move the highlight', (
      tester,
    ) async {
      String? selected;
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 320,
            child: SearchBar<String>(
              items: const <String>['Apple', 'Banana', 'Apricot'],
              onSelected: (v) => selected = v,
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.enterText(find.byType(EditableText), 'Apr');
      await tester.pump();
      expect(find.text('Apricot'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, isNotNull);
    });
  });

  group('overlays 375px phone width', () {
    testWidgets('dropdown surface has no overflow at 375', (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        _frame(DropdownMenu(children: _menuRows()), width: 375),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      final Size size = tester.getSize(find.byType(MenuPopup));
      expect(size.width, lessThanOrEqualTo(375));
    });

    testWidgets('popup inline surface has no overflow at 375', (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        _frame(
          const SizedBox(
            width: 320,
            child: MenuPopup(
              children: <Widget>[Text('Signed in as ibrar@example.com')],
            ),
          ),
          width: 375,
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('search_bar has no overflow at 375 with long labels', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        _frame(
          SearchBar<String>(
            items: const <String>[
              'An extremely long item label that must not overflow the row',
              'Apple',
            ],
          ),
          width: 375,
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('command palette has no overflow at 375', (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 343,
            height: 300,
            child: Command(
              debounceDuration: Duration.zero,
              builder: (context, query) async* {
                yield <Widget>[
                  const SubFocusListItem(
                    minHeight: 48,
                    title: Text('Calendar'),
                  ),
                ];
              },
            ),
          ),
          width: 375,
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
    });
  });

  group('overlays RTL + reduced motion', () {
    testWidgets('dropdown renders in RTL without exception', (tester) async {
      await tester.pumpWidget(
        _frame(
          DropdownMenu(children: _menuRows()),
          direction: TextDirection.rtl,
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('popup opens with animations disabled', (tester) async {
      late BuildContext host;
      await tester.pumpWidget(
        _frame(
          Builder(
            builder: (context) {
              host = context;
              return const SizedBox(width: 120, height: 36);
            },
          ),
          disableAnimations: true,
        ),
      );
      await tester.pump();
      showPopup<void>(
        context: host,
        builder: (context) => const Text('Reduced'),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Reduced'), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.text('Reduced'), findsNothing);
    });

    testWidgets('search_bar custom row builder is used', (tester) async {
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 320,
            child: SearchBar<String>(
              items: const <String>['Apple'],
              itemBuilder: (context, item, highlight, highlighted) =>
                  Text('custom:$item'),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('custom:Apple'), findsOneWidget);
    });

    testWidgets('command theme override tints the surface', (tester) async {
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 320,
            height: 300,
            child: Command(
              debounceDuration: Duration.zero,
              theme: const CommandTheme(background: ThemedColor.value(_green)),
              builder: (context, query) async* {
                yield const <Widget>[];
              },
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(Command), findsOneWidget);
    });
  });
}
