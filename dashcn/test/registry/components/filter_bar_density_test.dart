// Density, style overrides, uncontrolled mode, builder slots and keyboard tests
// for the redesigned `filter_bar` component.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/filter_bar/filter_bar.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const List<FilterSortOption> _kSorts = <FilterSortOption>[
  FilterSortOption(id: 'popular', label: 'Popular'),
  FilterSortOption(id: 'recent', label: 'Recent'),
];

Widget _testFrame(
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
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
            settings: settings,
            pageBuilder: (BuildContext context, _, _) => Align(
              alignment: Alignment.topLeft,
              child: SizedBox(width: width, child: child),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('filter_bar uncontrolled mode', () {
    testWidgets('pumps without controller or state, search input updates', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testFrame(
          const FilterBar(
            sortOptions: _kSorts,
            presentation: FilterBarPresentation.inline,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FilterBar), findsOneWidget);
      expect(find.byType(FilterBarSearchField), findsOneWidget);
      expect(find.byType(FilterBarSortControl), findsOneWidget);

      await tester.enterText(find.byType(EditableText), 'dashcn query');
      await tester.pumpAndSettle();

      expect(find.text('dashcn query'), findsOneWidget);
    });
  });

  group('filter_bar density and style overrides', () {
    testWidgets('style overrides controlWidth, controlHeight, and iconSize', (
      tester,
    ) async {
      const FilterBarStyle customStyle = FilterBarStyle(
        controlWidth: 150,
        controlHeight: 32,
        iconSize: 14,
        padding: EdgeInsets.all(16),
      );

      await tester.pumpWidget(
        _testFrame(
          const FilterBar(
            sortOptions: _kSorts,
            style: customStyle,
            presentation: FilterBarPresentation.inline,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final Size sortSize = tester.getSize(find.byType(FilterBarSortControl));
      expect(sortSize.width, 150);
      expect(sortSize.height, 32);

      final Size searchSize = tester.getSize(find.byType(FilterBarSearchField));
      expect(searchSize.height, 32);
    });

    testWidgets('compact density tokens apply by default', (tester) async {
      await tester.pumpWidget(
        _testFrame(
          const FilterBar(
            sortOptions: _kSorts,
            presentation: FilterBarPresentation.inline,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FilterBar), findsOneWidget);
      final Size searchSize = tester.getSize(find.byType(FilterBarSearchField));
      expect(searchSize.width, 220);
      expect(searchSize.height, 36);
    });
  });

  group('filter_bar builder slots', () {
    testWidgets('renders custom leading, trailing, and chip builders', (
      tester,
    ) async {
      final FilterBarController controller = FilterBarController(
        const FilterState(
          chips: <FilterChipData>[
            FilterChipData(key: 'tag1', label: 'Custom Chip'),
          ],
        ),
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _testFrame(
          FilterBar(
            controller: controller,
            leading: const Text('CUSTOM_LEADING'),
            trailing: const Text('CUSTOM_TRAILING'),
            chipBuilder:
                (BuildContext ctx, FilterChipData chip, VoidCallback onRemove) {
                  return GestureDetector(
                    onTap: onRemove,
                    child: Text('SLOT_${chip.label}'),
                  );
                },
            presentation: FilterBarPresentation.inline,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('CUSTOM_LEADING'), findsOneWidget);
      expect(find.text('CUSTOM_TRAILING'), findsOneWidget);
      expect(find.text('SLOT_Custom Chip'), findsOneWidget);

      await tester.tap(find.text('SLOT_Custom Chip'));
      await tester.pumpAndSettle();
      expect(controller.value.chips, isEmpty);
    });
  });

  group('filter_bar overflow menu and keyboard accessibility', () {
    testWidgets(
      'opens overflow menu on compact width and dismisses on Escape',
      (tester) async {
        final FilterBarController controller = FilterBarController(
          const FilterState(sortId: 'popular'),
        );
        addTearDown(controller.dispose);

        await tester.pumpWidget(
          _testFrame(
            FilterBar(
              controller: controller,
              sortOptions: _kSorts,
              resultsCount: 99,
              presentation: FilterBarPresentation.autoMenu,
            ),
            width: 375,
          ),
        );
        await tester.pumpAndSettle();

        // Trigger button should be shown for overflow content
        expect(find.byType(FilterBarOverflowTrigger), findsOneWidget);

        // Tap to open menu
        await tester.tap(find.byType(FilterBarOverflowTrigger));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        expect(find.byType(FilterBarOverflowMenu), findsOneWidget);
        expect(find.textContaining('Filters'), findsWidgets);
        expect(find.text('Clear all'), findsOneWidget);
        expect(find.text('99 results'), findsOneWidget);

        // Press Escape to dismiss
        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        expect(find.byType(FilterBarOverflowMenu), findsNothing);
      },
    );

    testWidgets('Escape dismisses overflow menu via keyboard shortcut', (
      tester,
    ) async {
      final FilterBarController controller = FilterBarController(
        const FilterState(
          chips: <FilterChipData>[
            FilterChipData(key: 'status:active', label: 'Active'),
          ],
        ),
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _testFrame(
          FilterBar(
            controller: controller,
            sortOptions: _kSorts,
            presentation: FilterBarPresentation.menu,
          ),
          width: 500,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FilterBarOverflowTrigger));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(FilterBarOverflowMenu), findsOneWidget);

      // Dismiss with Escape
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(FilterBarOverflowMenu), findsNothing);
    });
  });

  group('filter_bar 375px phone layout and reduced motion', () {
    testWidgets('375px width has no RenderFlex overflow with full controls', (
      tester,
    ) async {
      final FilterBarController controller = FilterBarController(
        const FilterState(
          search: 'query',
          sortId: 'recent',
          chips: <FilterChipData>[
            FilterChipData(key: 'k1', label: 'Chip 1'),
            FilterChipData(key: 'k2', label: 'Chip 2'),
          ],
        ),
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _testFrame(
          FilterBar(
            controller: controller,
            sortOptions: _kSorts,
            resultsCount: 15,
            showClearAllWhenEmpty: true,
          ),
          width: 375,
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(FilterBar), findsOneWidget);
    });

    testWidgets('operates safely when animations are disabled', (tester) async {
      final FilterBarController controller = FilterBarController(
        const FilterState(sortId: 'popular'),
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _testFrame(
          FilterBar(
            controller: controller,
            sortOptions: _kSorts,
            presentation: FilterBarPresentation.autoMenu,
          ),
          disableAnimations: true,
          width: 375,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FilterBarOverflowTrigger));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(FilterBarOverflowMenu), findsOneWidget);
    });

    testWidgets('RTL text direction renders overflow trigger and controls', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testFrame(
          const FilterBar(
            sortOptions: _kSorts,
            presentation: FilterBarPresentation.autoMenu,
          ),
          direction: TextDirection.rtl,
          width: 375,
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(FilterBar), findsOneWidget);
    });
  });
}
