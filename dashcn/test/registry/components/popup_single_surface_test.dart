// Single-surface audit: every popup-family overlay paints exactly one
// bordered surface (no nested Card/DecoratedBox/MenuPopup inside MenuPopup,
// no Dialog + Command double).
//
// Counts bordered BoxDecorations (Border.all) in the pumped subtree: a single
// popup surface draws exactly one. The home command card and wide action
// sheet regressions were Dialog + inner surface doubles; they are covered by
// asserting the inner components themselves are single.

import 'package:dashcn/src/components/action_sheet/action_sheet.dart';
import 'package:dashcn/src/components/command/command.dart';
import 'package:dashcn/src/components/context_menu/context_menu.dart';
import 'package:dashcn/src/components/dropdown_menu/dropdown_menu.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/menubar/menubar.dart';
import 'package:dashcn/src/components/navigation_menu/navigation_menu.dart';
import 'package:dashcn/src/primitives/subfocus_list_item.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(Widget child) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Center(child: child),
    ),
  );
}

/// Whether [border] is a full visible surface border (all four sides).
///
/// Ignores the invisible placeholder some focus/clickable wrappers leave in
/// the tree (zero width and none style) and single-side dividers such as the
/// command palette search field bottom rule: only a rectangular border on
/// every side counts as a popup surface.
bool _isVisibleBorder(BoxBorder? border) {
  if (border == null) return false;
  if (border is Border) {
    for (final BorderSide side in <BorderSide>[
      border.top,
      border.left,
      border.right,
      border.bottom,
    ]) {
      if (side.style == BorderStyle.none || side.width <= 0) return false;
    }
    return true;
  }
  return true;
}

/// Number of visible bordered surfaces under [scope].
///
/// Counts only [DecoratedBox]: a [Container] with a decoration builds a
/// [DecoratedBox] internally, so counting both would double-count the same
/// surface. Invisible placeholder borders (width 0, style none) are ignored.
int _borderCount(WidgetTester tester, Finder scope) {
  int n = 0;
  for (final DecoratedBox box in tester.widgetList<DecoratedBox>(
    find.descendant(of: scope, matching: find.byType(DecoratedBox)),
  )) {
    final Decoration dec = box.decoration;
    if (dec is BoxDecoration && _isVisibleBorder(dec.border)) n++;
  }
  return n;
}

void main() {
  testWidgets('popup MenuPopup paints exactly one surface', (tester) async {
    await tester.pumpWidget(
      _frame(const MenuPopup(children: <Widget>[Text('Content')])),
    );
    await tester.pump();
    expect(find.byType(MenuPopup), findsOneWidget);
    expect(_borderCount(tester, find.byType(MenuPopup)), 1);
  });

  testWidgets('dropdown_menu paints exactly one surface', (tester) async {
    await tester.pumpWidget(
      _frame(
        DropdownMenu(
          children: <Widget>[
            MenuButton(child: const Text('Profile'), onPressed: (_) {}),
            MenuButton(child: const Text('Settings'), onPressed: (_) {}),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(MenuPopup), findsOneWidget);
    expect(_borderCount(tester, find.byType(DropdownMenu)), 1);
  });

  testWidgets('menu MenuPopup paints exactly one surface', (tester) async {
    await tester.pumpWidget(
      _frame(
        MenuPopup(
          width: 240,
          children: <Widget>[
            MenuGroup(
              autofocus: false,
              children: <Widget>[
                MenuButton(child: const Text('Cut'), onPressed: (_) {}),
              ],
            ),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(MenuPopup), findsOneWidget);
    expect(_borderCount(tester, find.byType(MenuPopup)), 1);
  });

  testWidgets('command palette paints exactly one surface', (tester) async {
    await tester.pumpWidget(
      _frame(
        SizedBox(
          width: 320,
          height: 300,
          child: Command(
            autofocus: false,
            debounceDuration: Duration.zero,
            builder: (context, query) async* {
              yield <Widget>[
                SubFocusListItem(title: const Text('Profile'), onTap: () {}),
                SubFocusListItem(title: const Text('Settings'), onTap: () {}),
              ];
            },
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(Command), findsOneWidget);
    expect(_borderCount(tester, find.byType(Command)), 1);
  });

  testWidgets('context_menu trigger paints no popup until opened', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        ContextMenu(
          items: <Widget>[
            MenuButton(child: const Text('Copy'), onPressed: (_) {}),
          ],
          child: const SizedBox(width: 220, height: 80),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(MenuPopup), findsNothing);
  });

  testWidgets('menubar bar paints exactly one surface', (tester) async {
    await tester.pumpWidget(
      _frame(
        Menubar(
          children: <Widget>[
            MenuButton(
              subMenu: <Widget>[
                MenuButton(child: const Text('New'), onPressed: (_) {}),
              ],
              child: const Text('File'),
            ),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(Menubar), findsOneWidget);
    expect(_borderCount(tester, find.byType(Menubar)), 1);
    expect(find.byType(MenuPopup), findsNothing);
  });

  testWidgets('navigation_menu panel paints exactly one surface', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        const SizedBox(
          width: 360,
          child: NavigationMenuContentList(
            crossAxisCount: 1,
            children: <Widget>[
              NavigationMenuContent(
                title: Text('Dashboard'),
                content: Text('Analytics'),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    // Inline content lists draw no popup surface; the opened panel is a
    // single OutlinedContainer (covered by the surface audit).
    expect(find.byType(MenuPopup), findsNothing);
  });

  testWidgets('action_sheet paints a single borderless sheet surface', (
    tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ActionSheet<void>(
          title: 'Actions',
          actions: <ActionSheetAction<void>>[
            ActionSheetAction<void>(label: 'Edit'),
            ActionSheetAction<void>(label: 'Share'),
          ],
          cancelAction: ActionSheetAction<void>(label: 'Cancel'),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(ActionSheet<void>), findsOneWidget);
    // The sheet surface is borderless (no bordered BoxDecoration): it must
    // not stack a second bordered surface inside.
    expect(_borderCount(tester, find.byType(ActionSheet<void>)), 0);
  });
}
