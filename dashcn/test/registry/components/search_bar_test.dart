// Widget tests for the `search_bar` component.
//
// Covers the field contract (controller/initialValue, immediate + debounced
// onChanged, clear bypassing the delay, onCleared, submit, clear button,
// Escape, leading icon, validator, disabled/read-only, theme precedence,
// dark tokens and RTL) and the ranked list (tiered filtering, tap select,
// keyboard navigation, highlight spans, empty state, groups, cancel, and no
// overflow at 320 px).

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/components/search_bar/search_bar.dart';
import 'package:dashcn/src/components/search_bar/search_bar_theme.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/input_features/input_features.dart';
import 'package:dashcn/src/primitives/overlay_manager.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const List<String> _fruits = <String>['Apple', 'Banana', 'Apricot', 'Avocado'];

/// Keeps a single `OverlayEntry` so repumping the frame updates its child.
class _OverlayHost extends StatefulWidget {
  const _OverlayHost({required this.child});

  final Widget child;

  @override
  State<_OverlayHost> createState() => _OverlayHostState();
}

class _OverlayHostState extends State<_OverlayHost> {
  late final OverlayEntry _entry = OverlayEntry(
    builder: (_) => Center(child: widget.child),
  );

  @override
  void didUpdateWidget(covariant _OverlayHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    _entry.markNeedsBuild();
  }

  @override
  void dispose() {
    _entry
      ..remove()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Overlay(initialEntries: [_entry]);
}

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  SearchBarTheme? scoped,
  TextDirection direction = TextDirection.ltr,
  double width = 480,
  required Widget child,
}) {
  Widget body = child;
  if (scoped != null) {
    body = ComponentTheme<SearchBarTheme>(data: scoped, child: body);
  }
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
          textDirection: direction,
          child: AppLayer(
            child: DefaultTextEditingShortcuts(
              child: _OverlayHost(
                child: SizedBox(width: width, child: body),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

EditableText _editable(WidgetTester tester) =>
    tester.widget<EditableText>(find.byType(EditableText));

Future<void> _type(WidgetTester tester, String text) async {
  await tester.enterText(find.byType(EditableText), text);
  await tester.pump();
}

/// Whether any row paints a semibold highlight span.
bool _hasHighlightSpan(WidgetTester tester) {
  bool found = false;
  void visit(InlineSpan? span) {
    if (span is TextSpan) {
      if (span.style?.fontWeight == FontWeight.w600) {
        found = true;
      }
      span.children?.forEach(visit);
    }
  }

  for (final RichText text in tester.widgetList<RichText>(
    // Raw-type check: matches `SearchBar<T>` for any `T`, unlike `byType`
    // which needs the exact instantiation.
    find.descendant(
      of: find.byWidgetPredicate(
        (Widget widget) =>
            widget.runtimeType.toString().startsWith('SearchBar'),
      ),
      matching: find.byType(RichText),
    ),
  )) {
    visit(text.text);
  }
  return found;
}

void main() {
  group('field', () {
    testWidgets('renders hint and search icon with semantics label', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(child: const SearchBar()));
      await tester.pump();
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byIcon(LucideIcons.search), findsOneWidget);
      final Semantics semantics = tester.widget<Semantics>(
        find
            .ancestor(of: find.byType(Input), matching: find.byType(Semantics))
            .first,
      );
      expect(semantics.properties.label, 'Search');
    });

    testWidgets('controller and initialValue seed the text', (tester) async {
      await tester.pumpWidget(
        _frame(child: const SearchBar(initialValue: 'dashcn')),
      );
      await tester.pump();
      expect(_editable(tester).controller.text, 'dashcn');

      final TextEditingController controller = TextEditingController(
        text: 'hello',
      );
      addTearDown(controller.dispose);
      await tester.pumpWidget(_frame(child: SearchBar(controller: controller)));
      await tester.pump();
      expect(_editable(tester).controller.text, 'hello');
    });

    testWidgets('onChanged fires immediately with a zero debounce', (
      tester,
    ) async {
      final List<String> seen = <String>[];
      await tester.pumpWidget(
        _frame(
          child: SearchBar(debounce: Duration.zero, onChanged: seen.add),
        ),
      );
      await tester.pump();
      await _type(tester, 'a');
      expect(seen, <String>['a']);
      await _type(tester, 'ab');
      expect(seen, <String>['a', 'ab']);
    });

    testWidgets('the default debounce waits 120ms', (tester) async {
      final List<String> seen = <String>[];
      await tester.pumpWidget(_frame(child: SearchBar(onChanged: seen.add)));
      await tester.pump();
      await _type(tester, 'a');
      expect(seen, isEmpty);
      await tester.pump(const Duration(milliseconds: 130));
      expect(seen, <String>['a']);
    });

    testWidgets('debounce delays onChanged but clear bypasses it', (
      tester,
    ) async {
      final List<String> seen = <String>[];
      await tester.pumpWidget(
        _frame(
          child: SearchBar(
            debounce: const Duration(milliseconds: 300),
            onChanged: seen.add,
          ),
        ),
      );
      await tester.pump();
      await _type(tester, 'a');
      expect(seen, isEmpty);
      await tester.pump(const Duration(milliseconds: 200));
      expect(seen, isEmpty);
      await tester.pump(const Duration(milliseconds: 150));
      expect(seen, <String>['a']);
      // Clearing emits immediately even with a pending debounce.
      await _type(tester, 'ab');
      await _type(tester, '');
      expect(seen.last, '');
    });

    testWidgets('onCleared fires when the text becomes empty', (tester) async {
      int cleared = 0;
      await tester.pumpWidget(
        _frame(
          child: SearchBar(initialValue: 'x', onCleared: () => cleared++),
        ),
      );
      await tester.pump();
      await _type(tester, '');
      expect(cleared, 1);
    });

    testWidgets('onSubmitted fires on the search action', (tester) async {
      final List<String> submitted = <String>[];
      await tester.pumpWidget(
        _frame(child: SearchBar(onSubmitted: submitted.add)),
      );
      await tester.pump();
      await tester.tap(find.byType(EditableText));
      await tester.pump();
      await _type(tester, 'query');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();
      expect(submitted, <String>['query']);
    });

    testWidgets('clear button empties the field', (tester) async {
      await tester.pumpWidget(
        _frame(child: const SearchBar(initialValue: 'hello')),
      );
      await tester.pump();
      // The clear button shows while text is non-empty.
      final Finder clear = find.byType(InputFeatureIconButton);
      expect(clear, findsWidgets);
      await tester.tap(clear.first);
      await tester.pump();
      expect(_editable(tester).controller.text, isEmpty);
    });

    testWidgets('escape clears the field', (tester) async {
      await tester.pumpWidget(
        _frame(child: const SearchBar(initialValue: 'hello')),
      );
      await tester.pump();
      await tester.tap(find.byType(EditableText));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      expect(_editable(tester).controller.text, isEmpty);
    });

    testWidgets('escape on an empty field cancels', (tester) async {
      int cancelled = 0;
      await tester.pumpWidget(
        _frame(child: SearchBar(onCancelled: () => cancelled++)),
      );
      await tester.pump();
      await tester.tap(find.byType(EditableText));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      expect(cancelled, 1);
    });

    testWidgets('cancel button clears and reports', (tester) async {
      int cancelled = 0;
      await tester.pumpWidget(
        _frame(
          child: SearchBar(
            initialValue: 'hello',
            showCancelButton: true,
            onCancelled: () => cancelled++,
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('Cancel'));
      await tester.pump();
      expect(_editable(tester).controller.text, isEmpty);
      expect(cancelled, 1);
    });

    testWidgets('showLeading false hides the search icon', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const SearchBar(theme: SearchBarTheme(showLeading: false)),
        ),
      );
      await tester.pump();
      expect(find.byIcon(LucideIcons.search), findsNothing);
    });

    testWidgets('custom leading replaces the search icon', (tester) async {
      await tester.pumpWidget(
        _frame(child: const SearchBar(leading: Icon(LucideIcons.filter))),
      );
      await tester.pump();
      expect(find.byIcon(LucideIcons.filter), findsOneWidget);
      expect(find.byIcon(LucideIcons.search), findsNothing);
    });

    testWidgets('showClear false hides the clear button', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const SearchBar(
            initialValue: 'hello',
            theme: SearchBarTheme(showClear: false),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(InputFeatureIconButton), findsNothing);
    });

    testWidgets('validator paints an error while text is invalid', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: SearchBar(
            validator: (String? value) =>
                (value ?? '').isNotEmpty && value!.length < 3
                ? 'Too short.'
                : null,
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Too short.'), findsNothing);
      await _type(tester, 'ab');
      expect(find.text('Too short.'), findsOneWidget);
      await _type(tester, 'abcd');
      // The cleared error plays its collapse exit before unmounting.
      await tester.pumpAndSettle();
      expect(find.text('Too short.'), findsNothing);
    });

    testWidgets('disabled and read-only fields do not accept input', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(child: const SearchBar(enabled: false, initialValue: 'x')),
      );
      await tester.pump();
      expect(_editable(tester).readOnly, isTrue);

      await tester.pumpWidget(
        _frame(child: const SearchBar(readOnly: true, initialValue: 'x')),
      );
      await tester.pump();
      expect(_editable(tester).readOnly, isTrue);
    });

    testWidgets('theme precedence: widget > scoped > app > defaults', (
      tester,
    ) async {
      Future<double?> iconSize({
        List<ComponentThemeData> app = const <ComponentThemeData>[],
        SearchBarTheme? scoped,
        SearchBarTheme? widgetTheme,
      }) async {
        await tester.pumpWidget(
          _frame(
            app: app,
            scoped: scoped,
            child: SearchBar(theme: widgetTheme),
          ),
        );
        await tester.pump();
        final Icon icon = tester.widget<Icon>(find.byIcon(LucideIcons.search));
        return icon.size;
      }

      expect(await iconSize(), searchBarDefaultIconSize);
      expect(
        await iconSize(
          app: const <ComponentThemeData>[SearchBarTheme(iconSize: 20)],
        ),
        20,
      );
      expect(await iconSize(scoped: const SearchBarTheme(iconSize: 22)), 22);
      expect(
        await iconSize(
          app: const <ComponentThemeData>[SearchBarTheme(iconSize: 20)],
          scoped: const SearchBarTheme(iconSize: 22),
          widgetTheme: const SearchBarTheme(iconSize: 24),
        ),
        24,
      );
    });

    testWidgets('pumps in dark mode without exception', (tester) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(colors: ThemeColors.darkFallback),
          child: const SearchBar(initialValue: 'dark'),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('mirrors layout in RTL', (tester) async {
      await tester.pumpWidget(
        _frame(
          direction: TextDirection.rtl,
          child: const SearchBar(initialValue: 'rtl'),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.byType(SearchBar), findsOneWidget);
    });

    test('defaults carry the documented tokens', () {
      expect(searchBarDefaultIconSize, 16);
      // Icon size is token-driven: the null default resolves
      // densityTokens.iconSize (16 compact) at build.
      expect(searchBarDefaults.iconSize, isNull);
      expect(searchBarDefaults.showLeading, isTrue);
      expect(searchBarDefaults.showClear, isTrue);
      expect(searchBarThemeOverrides, const SearchBarTheme());
    });
  });

  group('ranked list', () {
    testWidgets('an empty query shows every item unfiltered', (tester) async {
      await tester.pumpWidget(
        _frame(child: const SearchBar<String>(items: _fruits)),
      );
      await tester.pump();
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(_hasHighlightSpan(tester), isFalse);
    });

    testWidgets('typing filters by rank: prefix before fuzzy', (tester) async {
      final List<String> selected = <String>[];
      await tester.pumpWidget(
        _frame(
          child: SearchBar<String>(items: _fruits, onSelected: selected.add),
        ),
      );
      await tester.pump();
      await _type(tester, 'ap');
      // Prefix hits stay; the fuzzy-only 'Banana' (no 'p') drops out.
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Apricot'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
      expect(_hasHighlightSpan(tester), isTrue);
      // The first row is highlighted: Enter selects without moving.
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, <String>['Apple']);
    });

    testWidgets('tapping a row selects it', (tester) async {
      String? selected;
      await tester.pumpWidget(
        _frame(
          child: SearchBar<String>(
            items: _fruits,
            onSelected: (item) => selected = item,
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('Banana'));
      await tester.pump();
      expect(selected, 'Banana');
    });

    testWidgets('arrow keys move the highlight and wrap', (tester) async {
      final List<String> selected = <String>[];
      await tester.pumpWidget(
        _frame(
          child: SearchBar<String>(items: _fruits, onSelected: selected.add),
        ),
      );
      await tester.pump();
      await _type(tester, 'ap');
      // Ranked rows: Apple, Apricot (Avocado has no 'p' before... 'Avocado':
      // a-v-o-c-a-d-o has no 'p', so it drops out).
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, <String>['Apricot']);
      // Wrapping upwards from the first row lands on the last.
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, <String>['Apricot', 'Apricot']);
    });

    testWidgets('enter with no rows submits the query', (tester) async {
      final List<String> submitted = <String>[];
      await tester.pumpWidget(
        _frame(
          child: SearchBar<String>(items: _fruits, onSubmitted: submitted.add),
        ),
      );
      await tester.pump();
      await _type(tester, 'zzz');
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(submitted, <String>['zzz']);
    });

    testWidgets('no matches show the empty state', (tester) async {
      await tester.pumpWidget(
        _frame(child: const SearchBar<String>(items: _fruits)),
      );
      await tester.pump();
      await _type(tester, 'zzz');
      expect(find.text('No results found'), findsOneWidget);
    });

    testWidgets('a custom empty builder replaces the default', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: SearchBar<String>(
            items: _fruits,
            emptyBuilder: (context) => const Text('Nothing here'),
          ),
        ),
      );
      await tester.pump();
      await _type(tester, 'zzz');
      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('No results found'), findsNothing);
    });

    testWidgets('groups render headings and filter as units', (tester) async {
      const List<SearchBarGroup<String>> groups = <SearchBarGroup<String>>[
        SearchBarGroup<String>(
          label: 'Fruit',
          items: <String>['Apple', 'Banana'],
        ),
        SearchBarGroup<String>(label: 'Veg', items: <String>['Carrot']),
      ];
      await tester.pumpWidget(
        _frame(child: const SearchBar<String>(groups: groups)),
      );
      await tester.pump();
      expect(find.text('Fruit'), findsOneWidget);
      expect(find.text('Veg'), findsOneWidget);
      await _type(tester, 'app');
      expect(find.text('Fruit'), findsOneWidget);
      expect(find.text('Veg'), findsNothing);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Carrot'), findsNothing);
    });

    testWidgets('a custom row builder is used', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: SearchBar<String>(
            items: _fruits,
            itemBuilder: (context, item, highlight, highlighted) =>
                Text('row:$item'),
          ),
        ),
      );
      await tester.pump();
      await _type(tester, 'ban');
      expect(find.text('row:Banana'), findsOneWidget);
    });

    testWidgets('no overflow at 320 px with long labels and groups', (
      tester,
    ) async {
      const List<SearchBarGroup<String>> groups = <SearchBarGroup<String>>[
        SearchBarGroup<String>(
          label: 'A very long group heading that must ellipsize',
          items: <String>[
            'An extremely long item label that must not overflow the row',
            'Another considerably lengthy label for the narrow stage',
          ],
        ),
      ];
      await tester.pumpWidget(
        _frame(
          width: 320,
          child: SearchBar<String>(
            groups: groups,
            showCancelButton: true,
            cancelLabel: 'Cancel',
          ),
        ),
      );
      await tester.pump();
      await _type(tester, 'extremely long label');
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.byType(SearchBar<String>), findsOneWidget);
    });
  });
}
