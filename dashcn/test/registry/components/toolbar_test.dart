// Widget tests for the `toolbar` component.
//
// Covers rendering, the two axes, groups and separators, toggle items
// (controlled and uncontrolled), the callbacks, the arrow-key roving focus,
// the responsive overflow menu, the style/theme overrides, RTL and the
// 375 px phone width.

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/toolbar/toolbar.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection direction = TextDirection.ltr,
  bool overlay = false,
  required Widget child,
}) {
  final Widget inner = Shortcuts(
    // The app shell normally binds Tab; the test frame does it too so the
    // focus traversal can be driven from the keyboard.
    shortcuts: const <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.tab): NextFocusIntent(),
    },
    child: Center(child: child),
  );
  Widget content = inner;
  if (overlay) {
    content = Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(builder: (BuildContext context) => inner),
      ],
    );
  }
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(textDirection: direction, child: content),
    ),
  );
}

ToolbarItem _item(String label, {VoidCallback? onPressed}) {
  return ToolbarItem(
    tooltip: label,
    semanticLabel: label,
    onPressed: onPressed ?? _noop,
    child: Icon(label == 'a' ? LucideIcons.plus : LucideIcons.copy),
  );
}

/// Every accessible name in the tree under the tester.
List<String> _semanticLabels(WidgetTester tester) {
  final List<String> labels = <String>[];
  void visit(SemanticsNode node) {
    final String label = node.getSemanticsData().label;
    if (label.isNotEmpty) {
      labels.add(label);
    }
    node.visitChildren((SemanticsNode child) {
      visit(child);
      return true;
    });
  }

  for (final RenderView view in tester.binding.renderViews) {
    final SemanticsNode? root = view.owner?.semanticsOwner?.rootSemanticsNode;
    if (root != null) {
      visit(root);
    }
  }
  return labels;
}

void main() {
  group('Toolbar', () {
    testWidgets('renders its items', (tester) async {
      await tester.pumpWidget(
        _frame(child: Toolbar(children: <Widget>[_item('a'), _item('b')])),
      );
      expect(find.byType(ToolbarItem), findsNWidgets(2));
      expect(find.byIcon(LucideIcons.plus), findsOneWidget);
      expect(find.byIcon(LucideIcons.copy), findsOneWidget);
    });

    testWidgets('lays its items out in a row or a column', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const Toolbar(
            children: <Widget>[
              ToolbarItem(child: Icon(LucideIcons.plus)),
              ToolbarItem(child: Icon(LucideIcons.copy)),
            ],
          ),
        ),
      );
      final int horizontal = tester
          .getCenter(find.byIcon(LucideIcons.plus))
          .dx
          .compareTo(tester.getCenter(find.byIcon(LucideIcons.copy)).dx);

      await tester.pumpWidget(
        _frame(
          child: const Toolbar(
            axis: ToolbarAxis.vertical,
            children: <Widget>[
              ToolbarItem(child: Icon(LucideIcons.plus)),
              ToolbarItem(child: Icon(LucideIcons.copy)),
            ],
          ),
        ),
      );
      final int vertical = tester
          .getCenter(find.byIcon(LucideIcons.plus))
          .dy
          .compareTo(tester.getCenter(find.byIcon(LucideIcons.copy)).dy);
      expect(horizontal, lessThan(0));
      expect(vertical, lessThan(0));
    });

    testWidgets('renders groups and separators', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const Toolbar(
            children: <Widget>[
              ToolbarGroup(
                children: <Widget>[
                  ToolbarItem(child: Icon(LucideIcons.bold)),
                  ToolbarItem(child: Icon(LucideIcons.italic)),
                ],
              ),
              ToolbarSeparator(),
              ToolbarItem(child: Icon(LucideIcons.copy)),
            ],
          ),
        ),
      );
      expect(find.byType(ToolbarGroup), findsOneWidget);
      expect(find.byType(ToolbarSeparator), findsOneWidget);
    });

    testWidgets('calls the item callback', (tester) async {
      int taps = 0;
      await tester.pumpWidget(
        _frame(
          child: Toolbar(
            children: <Widget>[_item('a', onPressed: () => taps++)],
          ),
        ),
      );
      await tester.tap(find.byIcon(LucideIcons.plus));
      expect(taps, 1);
    });

    testWidgets('a toggle item reports its next value', (tester) async {
      bool? next;
      await tester.pumpWidget(
        _frame(
          child: Toolbar(
            children: <Widget>[
              ToolbarToggleItem(
                value: false,
                onChanged: (bool value) => next = value,
                child: const Icon(LucideIcons.bold),
              ),
            ],
          ),
        ),
      );
      await tester.tap(find.byIcon(LucideIcons.bold));
      expect(next, isTrue);
    });

    testWidgets('a controller-driven toggle owns its value', (tester) async {
      final ToolbarToggleController controller = ToolbarToggleController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          child: Toolbar(
            children: <Widget>[
              ToolbarToggleItem(
                controller: controller,
                child: const Icon(LucideIcons.bold),
              ),
            ],
          ),
        ),
      );
      await tester.tap(find.byIcon(LucideIcons.bold));
      await tester.pump();
      expect(controller.value, isTrue);
    });

    testWidgets('the arrow keys walk the items', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: Toolbar(
            children: <Widget>[_item('a'), _item('b'), _item('c')],
          ),
        ),
      );
      _focusItem(tester, 0);
      await tester.pump();
      expect(_focusedIndex(tester), 0);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(_focusedIndex(tester), 1);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(_focusedIndex(tester), 2);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      expect(_focusedIndex(tester), 1);
    });

    testWidgets('the arrow map is mirrored in RTL', (tester) async {
      await tester.pumpWidget(
        _frame(
          direction: TextDirection.rtl,
          child: Toolbar(children: <Widget>[_item('a'), _item('b')]),
        ),
      );
      _focusItem(tester, 0);
      await tester.pump();
      expect(_focusedIndex(tester), 0);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      // In RTL the left arrow walks forward, so the focus lands on the last
      // item instead of the first.
      expect(_focusedIndex(tester), 1);
    });

    testWidgets('moves the trailing items into an overflow menu', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: SizedBox(
            width: 180,
            child: Toolbar(
              children: <Widget>[
                _item('a'),
                _item('b'),
                _item('c'),
                _item('d'),
                _item('e'),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(LucideIcons.ellipsis), findsOneWidget);
      // Three items plus the overflow button stay on the bar.
      expect(find.byType(ToolbarItem), findsNWidgets(4));
    });

    testWidgets('the overflow menu holds the trailing items', (tester) async {
      await tester.pumpWidget(
        _frame(
          overlay: true,
          child: const SizedBox(
            width: 180,
            child: Toolbar(
              children: <Widget>[
                ToolbarItem(child: Icon(LucideIcons.plus)),
                ToolbarItem(child: Icon(LucideIcons.copy)),
                ToolbarItem(child: Icon(LucideIcons.share)),
                ToolbarItem(child: Icon(LucideIcons.trash)),
                ToolbarItem(child: Icon(LucideIcons.save)),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(LucideIcons.ellipsis), findsOneWidget);
      await tester.tap(find.byIcon(LucideIcons.ellipsis));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(MenuPopup), findsOneWidget);
    });

    testWidgets('the overflow rows carry the name of their item', (
      tester,
    ) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _frame(
          overlay: true,
          child: const SizedBox(
            width: 180,
            child: Toolbar(
              children: <Widget>[
                ToolbarItem(
                  tooltip: 'Undo',
                  semanticLabel: 'Undo',
                  child: Icon(LucideIcons.plus),
                ),
                ToolbarItem(
                  tooltip: 'Redo',
                  semanticLabel: 'Redo',
                  child: Icon(LucideIcons.copy),
                ),
                ToolbarItem(
                  tooltip: 'Share',
                  semanticLabel: 'Share',
                  child: Icon(LucideIcons.share),
                ),
                ToolbarItem(
                  tooltip: 'Delete',
                  semanticLabel: 'Delete',
                  child: Icon(LucideIcons.trash),
                ),
                ToolbarItem(
                  tooltip: 'Save',
                  semanticLabel: 'Save',
                  child: Icon(LucideIcons.save),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      await tester.tap(find.byIcon(LucideIcons.ellipsis));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      // The rows are icons only, so the menu has to name them itself.
      expect(_semanticLabels(tester), contains('Share'));
      handle.dispose();
    });

    testWidgets('honours a widget-leg style override', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: Toolbar(
            style: ToolbarStyle(
              background: ThemedColor.ref(ColorRef.secondary),
              gap: 2,
            ),
            children: <Widget>[_item('a')],
          ),
        ),
      );
      final DecoratedBox box = tester.widget<DecoratedBox>(
        find
            .descendant(
              of: find.byType(Toolbar),
              matching: find.byType(DecoratedBox),
            )
            .first,
      );
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
    });

    testWidgets('honours an app-level theme override', (tester) async {
      await tester.pumpWidget(
        _frame(
          app: const <ComponentThemeData>[
            ToolbarTheme(
              container: ToolbarStyle(
                background: ThemedColor.ref(ColorRef.destructive),
              ),
            ),
          ],
          child: Toolbar(children: <Widget>[_item('a')]),
        ),
      );
      final DecoratedBox box = tester.widget<DecoratedBox>(
        find
            .descendant(
              of: find.byType(Toolbar),
              matching: find.byType(DecoratedBox),
            )
            .first,
      );
      final BoxDecoration decoration = box.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
    });

    testWidgets('fits a 375 px phone width without overflowing', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        _frame(
          child: Toolbar(
            children: <Widget>[
              _item('a'),
              _item('b'),
              _item('c'),
              _item('d'),
              _item('e'),
              _item('f'),
            ],
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });
}

void _noop() {}

/// Moves the keyboard focus to the toolbar item at [index].
void _focusItem(WidgetTester tester, int index) {
  final List<Clickable> clickables = tester
      .widgetList<Clickable>(
        find.descendant(
          of: find.byType(ToolbarItem),
          matching: find.byType(Clickable),
        ),
      )
      .toList();
  clickables[index].focusNode?.requestFocus();
}

/// The index of the toolbar item that currently holds the focus.
int _focusedIndex(WidgetTester tester) {
  final List<Clickable> clickables = tester
      .widgetList<Clickable>(
        find.descendant(
          of: find.byType(ToolbarItem),
          matching: find.byType(Clickable),
        ),
      )
      .toList();
  for (int i = 0; i < clickables.length; i++) {
    if (clickables[i].focusNode?.hasFocus ?? false) {
      return i;
    }
  }
  return -1;
}
