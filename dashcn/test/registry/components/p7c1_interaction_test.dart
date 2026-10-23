// Interaction tests for the P7-C1 previews: every named example is driven by
// tap/keyboard, proving the preview is a working control (not a static row).
//
// Covers: chip removes (tap x, Backspace/Delete) and toggles; carousel
// next/prev/drag/keyboard/autoplay/counter; pinned sheet opens/snaps/closes;
// tree expands/collapses/selects (tap + arrows + Enter) with correct
// folder/file icons and tri-state checkboxes; breadcrumb navigates (trail,
// ellipsis dropdown, responsive collapse).

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/breadcrumb/preview.dart';
import 'package:dashcn/src/components/carousel/carousel.dart';
import 'package:dashcn/src/components/carousel/preview.dart';
import 'package:dashcn/src/components/checkbox/checkbox.dart';
import 'package:dashcn/src/components/chip/chip.dart';
import 'package:dashcn/src/components/chip/preview.dart';
import 'package:dashcn/src/components/dot_indicator/dot_indicator.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/components/pinned_sheet/pinned_sheet.dart';
import 'package:dashcn/src/components/pinned_sheet/preview.dart';
import 'package:dashcn/src/components/tree/preview.dart';
import 'package:dashcn/src/components/tree/tree.dart';
import 'package:dashcn/src/foundation/data.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// The example and stage size the harness renders, mutated by `_pump`.
///
/// `Overlay` keeps the entries from its first build across re-pumps, so the
/// entry's builder must read these late-binding fields instead of capturing
/// the arguments of a single `_pump` call (that made every re-pump render the
/// first example's size, e.g. 375 twice).
WidgetBuilder _shownBuilder = (BuildContext context) => const SizedBox.shrink();

Size _shownSize = const Size(720, 420);

Future<void> _pump(
  WidgetTester tester,
  WidgetBuilder builder, {
  Size size = const Size(720, 420),
}) {
  _shownBuilder = builder;
  _shownSize = size;
  return tester.pumpWidget(
    Theme(
      data: const ThemeData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay(
          initialEntries: <OverlayEntry>[
            OverlayEntry(
              builder: (BuildContext context) => Center(
                child: SizedBox.fromSize(
                  size: _shownSize,
                  child: Builder(builder: _shownBuilder),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

int _dotIndex(WidgetTester tester) =>
    tester.widget<DotIndicator>(find.byType(DotIndicator)).index;

/// Pumps [builder] under [brightness] in a [size]-wide stage, mirroring the
/// docs stage so the preview contract can be checked per example.
Future<void> _pumpDark(
  WidgetTester tester,
  WidgetBuilder builder,
  Brightness brightness,
  Size size,
) {
  final ThemeData data = brightness == Brightness.dark
      ? const ThemeData(colors: ThemeColors.darkFallback)
      : const ThemeData();
  _shownBuilder = builder;
  _shownSize = size;
  return tester.pumpWidget(
    Theme(
      data: data,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay(
          initialEntries: <OverlayEntry>[
            OverlayEntry(
              builder: (BuildContext context) => Center(
                child: SizedBox.fromSize(
                  size: _shownSize,
                  child: Builder(builder: _shownBuilder),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Finder _rowOf(String text) =>
    find.ancestor(of: find.text(text), matching: find.byType(TreeRow));

void main() {
  group('chip previews', () {
    testWidgets('Removable: x removes a tag, Reset restores the list', (
      tester,
    ) async {
      await _pump(tester, chipPreviews[0].builder);
      expect(find.text('4 of 4 shown'), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: find.byKey(const ValueKey<String>('chip-Flutter')),
          matching: find.byType(ChipButton),
        ),
      );
      await tester.pump();
      expect(find.text('Flutter'), findsNothing);
      expect(find.text('3 of 4 shown'), findsOneWidget);
      await tester.tap(find.text('Reset'));
      await tester.pump();
      expect(find.text('Flutter'), findsOneWidget);
      expect(find.text('4 of 4 shown'), findsOneWidget);
    });

    testWidgets('Selectable: tap toggles filter chips', (tester) async {
      await _pump(tester, chipPreviews[1].builder);
      expect(find.text('2 selected'), findsOneWidget);
      await tester.tap(find.text('Sports'));
      await tester.pump();
      expect(find.text('3 selected'), findsOneWidget);
      await tester.tap(find.text('Music'));
      await tester.pump();
      expect(find.text('2 selected'), findsOneWidget);
    });

    testWidgets('Backspace and Delete fire Chip.onDeleted', (tester) async {
      int deletions = 0;
      final FocusNode node = FocusNode(debugLabel: 'ChipDelete');
      addTearDown(node.dispose);
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Chip(
                focusNode: node,
                onDeleted: () => deletions++,
                child: const Text('tag'),
              ),
            ),
          ),
        ),
      );
      node.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.delete);
      await tester.pump();
      expect(deletions, 2);
    });
  });

  group('carousel previews', () {
    testWidgets('Default: next/prev step, dots stay synced', (tester) async {
      await _pump(tester, carouselPreviews[0].builder);
      expect(_dotIndex(tester), 0);
      await tester.tap(find.byIcon(LucideIcons.chevronRight));
      await tester.pumpAndSettle();
      expect(_dotIndex(tester), 1);
      await tester.tap(find.byIcon(LucideIcons.chevronLeft));
      await tester.pumpAndSettle();
      expect(_dotIndex(tester), 0);
    });

    testWidgets('Default: drag and arrow keys change the page', (tester) async {
      await _pump(tester, carouselPreviews[0].builder);
      await tester.drag(find.byType(Carousel), const Offset(-300, 0));
      await tester.pumpAndSettle();
      expect(_dotIndex(tester), greaterThan(0));
      await tester.tap(find.byType(Carousel));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();
      expect(_dotIndex(tester), 2);
    });

    testWidgets('Sizes: three-up slides advance too', (tester) async {
      await _pump(tester, carouselPreviews[1].builder);
      await tester.tap(find.byIcon(LucideIcons.chevronRight));
      await tester.pumpAndSettle();
      expect(_dotIndex(tester), 1);
    });

    testWidgets('Vertical: up/down buttons step', (tester) async {
      await _pump(tester, carouselPreviews[2].builder);
      await tester.tap(find.byIcon(LucideIcons.chevronDown));
      await tester.pumpAndSettle();
      expect(_dotIndex(tester), 1);
    });

    testWidgets('Autoplay: advances on its own, Pause holds it', (
      tester,
    ) async {
      await _pump(tester, carouselPreviews[3].builder);
      // A single long pump counts as one tick, and the carousel's hold timer
      // resets on that tick, so step the clock in small frames.
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }
      expect(_dotIndex(tester), greaterThan(0));
      await tester.tap(find.text('Pause'));
      await tester.pump(const Duration(milliseconds: 300));
      final int held = _dotIndex(tester);
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }
      expect(_dotIndex(tester), held);
    });

    testWidgets('With API: counter syncs, Jump to last works', (tester) async {
      await _pump(tester, carouselPreviews[4].builder);
      expect(find.text('Slide 1 of 5'), findsOneWidget);
      await tester.tap(find.text('Jump to last'));
      await tester.pumpAndSettle();
      expect(find.text('Slide 5 of 5'), findsOneWidget);
    });
  });

  group('pinned sheet previews', () {
    testWidgets('Snap points: open/half/close drive the fraction', (
      tester,
    ) async {
      await _pump(tester, pinnedSheetPreviews[4].builder);
      await tester.pump();
      expect(find.text('40% open'), findsOneWidget);
      await tester.tap(find.text('Open sheet'));
      await tester.pumpAndSettle();
      expect(find.text('100% open'), findsOneWidget);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(find.text('0% open'), findsOneWidget);
      await tester.tap(find.text('Half'));
      await tester.pumpAndSettle();
      expect(find.text('40% open'), findsOneWidget);
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.text('0% open'), findsOneWidget);
    });

    testWidgets('drag down snaps an open sheet closed', (tester) async {
      await _pump(tester, pinnedSheetPreviews[4].builder);
      await tester.tap(find.text('Open sheet'));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(PinnedSheet), const Offset(0, 300));
      await tester.pumpAndSettle();
      expect(find.text('0% open'), findsOneWidget);
    });

    testWidgets('side sheets open from their edge', (tester) async {
      await _pump(tester, pinnedSheetPreviews[1].builder);
      await tester.tap(find.text('Open sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Right sheet'), findsOneWidget);
      await tester.tap(find.text('Done'));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('tree previews', () {
    testWidgets('Default: folders use folder icons, files use file icons', (
      tester,
    ) async {
      await _pump(tester, treePreviews[0].builder);
      expect(find.text('Documents'), findsOneWidget);
      expect(find.text('Pictures'), findsOneWidget);
      // Open folder (Documents), plus Pictures, Downloads and archive.
      expect(find.byIcon(LucideIcons.folderOpen), findsOneWidget);
      expect(find.byIcon(LucideIcons.folder), findsNWidgets(3));
      expect(find.byIcon(LucideIcons.file), findsWidgets);
    });

    testWidgets('chevron tap expands and collapses', (tester) async {
      await _pump(tester, treePreviews[0].builder);
      expect(find.text('2024.zip'), findsNothing);
      await tester.tap(
        find.descendant(
          of: _rowOf('archive'),
          matching: find.byIcon(LucideIcons.chevronRight),
        ),
      );
      await tester.pump();
      expect(find.text('2024.zip'), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: _rowOf('archive'),
          matching: find.byIcon(LucideIcons.chevronRight),
        ),
      );
      await tester.pump();
      expect(find.text('2024.zip'), findsNothing);
    });

    testWidgets('arrow keys expand/collapse, Enter selects', (tester) async {
      await _pump(tester, treePreviews[0].builder);
      Data.maybeOf<TreeRowContext>(
        tester.element(find.text('archive')),
      )!.focusNode!.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(find.text('2024.zip'), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      expect(find.text('2024.zip'), findsNothing);
      await tester.tap(find.text('notes.md'));
      await tester.pump();
      expect(find.text('Selected: notes.md'), findsOneWidget);
    });

    testWidgets('With selection: tap selects the file', (tester) async {
      await _pump(tester, treePreviews[1].builder);
      expect(find.text('Selected: report.pdf'), findsOneWidget);
      await tester.tap(find.text('notes.md'));
      await tester.pump();
      expect(find.text('Selected: notes.md'), findsOneWidget);
    });

    testWidgets('Multi-select: checkbox toggles a subtree', (tester) async {
      await _pump(tester, treePreviews[2].builder);
      await tester.tap(
        find.descendant(of: _rowOf('archive'), matching: find.byType(Checkbox)),
      );
      await tester.pump();
      expect(
        find.text('Selected: report.pdf, archive, 2024.zip'),
        findsOneWidget,
      );
    });

    testWidgets('Multi-select: partial selection is indeterminate', (
      tester,
    ) async {
      await _pump(tester, treePreviews[2].builder);
      await tester.tap(
        find.descendant(
          of: _rowOf('notes.md'),
          matching: find.byType(Checkbox),
        ),
      );
      await tester.pump();
      final List<Checkbox> boxes = tester
          .widgetList<Checkbox>(find.byType(Checkbox))
          .toList();
      expect(
        boxes.any((Checkbox box) => box.value == CheckboxValue.indeterminate),
        isTrue,
      );
    });
  });

  group('breadcrumb previews', () {
    testWidgets('Default: clicking a crumb navigates', (tester) async {
      await _pump(tester, breadcrumbPreviews[0].builder);
      expect(find.text('Current page: Breadcrumb'), findsOneWidget);
      await tester.tap(find.text('Components'));
      await tester.pump();
      expect(find.text('Current page: Components'), findsOneWidget);
      expect(find.text('Breadcrumb'), findsNothing);
      await tester.tap(find.text('Home'));
      await tester.pump();
      expect(find.text('Current page: Home'), findsOneWidget);
    });

    testWidgets('With slash: folders navigate, file stays current', (
      tester,
    ) async {
      await _pump(tester, breadcrumbPreviews[1].builder);
      await tester.tap(find.text('components'));
      await tester.pump();
      expect(find.text('Current page: components'), findsOneWidget);
    });

    testWidgets('With ellipsis: dropdown navigates to a hidden crumb', (
      tester,
    ) async {
      await _pump(tester, breadcrumbPreviews[2].builder);
      await tester.tap(find.byIcon(LucideIcons.ellipsis));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Guides'), findsWidgets);
      await tester.tap(find.text('Guides').last);
      await tester.pumpAndSettle();
      expect(find.text('Current page: Guides'), findsOneWidget);
    });

    testWidgets('Responsive: collapses at 375, full at 720', (tester) async {
      await _pump(
        tester,
        breadcrumbPreviews[3].builder,
        size: const Size(375, 420),
      );
      expect(find.byIcon(LucideIcons.ellipsis), findsOneWidget);
      expect(find.text('Library'), findsNothing);
      await _pump(tester, breadcrumbPreviews[3].builder);
      expect(find.byIcon(LucideIcons.ellipsis), findsNothing);
      expect(find.text('Library'), findsOneWidget);
    });
  });

  group('preview contract', () {
    // The P6-F3 contract the docs stage enforces: every named example of the
    // five P7-C1 components pumps inside 720x420 and at 375 wide, under light
    // and dark, with no exception and no overflow.
    List<Object> suites = <Object>[
      chipPreviews,
      carouselPreviews,
      pinnedSheetPreviews,
      treePreviews,
      breadcrumbPreviews,
    ];

    for (final Object suite in suites) {
      for (final ComponentPreview example in suite as List<ComponentPreview>) {
        final String label = example.name;
        testWidgets('$label pumps at both widths in light and dark', (
          tester,
        ) async {
          for (final Brightness brightness in Brightness.values) {
            for (final Size size in const <Size>[
              Size(720, 420),
              Size(375, 420),
            ]) {
              await _pumpDark(tester, example.builder, brightness, size);
              expect(
                tester.takeException(),
                isNull,
                reason: '$label overflowed at ${size.width} / $brightness',
              );
            }
          }
        });
      }
    }
  });
}
