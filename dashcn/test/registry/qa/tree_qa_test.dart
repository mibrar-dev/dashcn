// QA for `tree` previews (P7-Q2, updated for the P7-C1 examples): behaviour,
// spacing, functionality.
//
// Drives every `treePreviews` example like a user. Every pump keys its example
// subtree: several examples are the same `_FileTree` widget type, so an unkeyed
// re-pump would reuse the previous example's State and silently test the same
// tree twice (Flutter reuses an element by runtime type + key).
//
// The row context and the unchecked keyboard/guide behaviour are pinned in
// `tree_test.dart`.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/tree/preview.dart';
import 'package:dashcn/src/components/tree/tree.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const List<ThemeColors> _modes = <ThemeColors>[
  ThemeColors.lightFallback,
  ThemeColors.darkFallback,
];

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  double width = 360,
  Key? key,
}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: direction,
      child: Center(
        child: SizedBox(
          key: const ValueKey<String>('stage'),
          width: width,
          child: KeyedSubtree(key: key, child: child),
        ),
      ),
    ),
  );
}

Future<void> _pumpPreview(
  WidgetTester tester,
  ComponentPreview preview, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  double width = 360,
}) async {
  await tester.pumpWidget(
    _frame(
      Builder(builder: preview.builder),
      data: data,
      direction: direction,
      width: width,
      key: ValueKey<String>(preview.name),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  expect(
    tester.takeException(),
    isNull,
    reason: 'preview "${preview.name}" threw',
  );
}

/// Centre of [box] in global coordinates.
Offset _centre(RenderBox box) =>
    box.localToGlobal(box.size.center(Offset.zero));

/// The chevron of row [index], which toggles that row's children.
Finder _chevronAt(int index) => find
    .descendant(
      of: find.byType(TreeRow).at(index),
      matching: find.byIcon(LucideIcons.chevronRight),
    )
    .first;

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in treePreviews) {
      for (int i = 0; i < _modes.length; i++) {
        await tester.pumpWidget(
          _frame(
            Builder(builder: preview.builder),
            data: ThemeData(colors: _modes[i]),
            key: ValueKey<String>('${preview.name}-$i'),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          tester.takeException(),
          isNull,
          reason: '${preview.name} mode $i',
        );
      }
    }
  });

  testWidgets('Default preview: expanded subtree and selection render', (
    tester,
  ) async {
    await _pumpPreview(tester, treePreviews[0]);
    expect(find.text('Documents'), findsOneWidget);
    expect(find.text('report.pdf'), findsOneWidget);
    expect(find.text('notes.md'), findsOneWidget);
    // `archive` starts collapsed, so its child stays hidden.
    expect(find.text('archive'), findsOneWidget);
    expect(find.text('2024.zip'), findsNothing);
    expect(find.text('Pictures'), findsOneWidget);
  });

  testWidgets('Default preview: taps are safe without throwing', (
    tester,
  ) async {
    await _pumpPreview(tester, treePreviews[0]);
    await tester.tap(find.text('notes.md'));
    await tester.pump();
    await tester.tap(find.text('Documents'));
    await tester.pump();
    expect(tester.takeException(), isNull);
    // A row tap selects; it does not collapse the subtree.
    expect(find.text('report.pdf'), findsOneWidget);
  });

  testWidgets('Collapsing a folder hides its children', (tester) async {
    await _pumpPreview(tester, treePreviews[0]);
    expect(find.text('report.pdf'), findsOneWidget);
    // Collapse `Documents` from its own chevron.
    await tester.tap(_chevronAt(0));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Documents'), findsOneWidget);
    expect(find.text('report.pdf'), findsNothing);
    expect(find.text('notes.md'), findsNothing);
    // And it opens again, so the example stays re-runnable.
    await tester.tap(_chevronAt(0));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('report.pdf'), findsOneWidget);
  });

  testWidgets('With selection and Multi-select previews render', (
    tester,
  ) async {
    await _pumpPreview(tester, treePreviews[1]);
    expect(find.text('Documents'), findsOneWidget);
    expect(find.text('report.pdf'), findsOneWidget);
    // `archive` is collapsed here, so its child stays hidden.
    expect(find.text('2024.zip'), findsNothing);
    await _pumpPreview(tester, treePreviews[2]);
    expect(find.text('Documents'), findsOneWidget);
    // The multi-select example starts with `archive` expanded and one file
    // preselected; tapping a parent checkbox is pinned in
    // `p7c1_interaction_test.dart`.
    expect(find.text('2024.zip'), findsOneWidget);
    expect(find.text('Selected: report.pdf'), findsOneWidget);
  });

  testWidgets('indent guides paint a hairline under the parent chevron', (
    tester,
  ) async {
    await _pumpPreview(tester, treePreviews[0]);
    final double scaling = Theme.of(
      tester.element(find.byType(TreeRow).first),
    ).scaling;
    // `report.pdf` is one level deep, so its row carries exactly one guide:
    // the vertical line and its tick towards the row.
    final List<RenderBox> guides = find
        .descendant(
          of: find.byType(TreeRow).at(1),
          matching: find.byType(ColoredBox),
        )
        .evaluate()
        .map((Element e) => e.renderObject! as RenderBox)
        .toList();
    expect(guides, hasLength(2));
    final RenderBox line = guides.first;
    final RenderBox tick = guides.last;
    expect(
      line.size.width,
      lessThanOrEqualTo(scaling + 0.001),
      reason: 'a guide line is the 1px border token, never the indent box',
    );
    expect(
      line.size.height,
      greaterThan(line.size.width * 4),
      reason: 'the line spans the whole row',
    );
    expect(
      tick.size.height,
      lessThanOrEqualTo(scaling + 0.001),
      reason: 'the tick is a hairline too',
    );
    // Centred under the parent row's chevron (the parent's own chevron box).
    expect(
      (_centre(line).dx -
              _centre(tester.renderObject<RenderBox>(_chevronAt(0))).dx)
          .abs(),
      lessThanOrEqualTo(0.5),
      reason: 'the guide sits under the parent row chevron',
    );
  });

  testWidgets('previews mirror in RTL with no exception', (tester) async {
    for (final preview in treePreviews) {
      await _pumpPreview(tester, preview, direction: TextDirection.rtl);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: '${preview.name} RTL');
    }
  });
}
