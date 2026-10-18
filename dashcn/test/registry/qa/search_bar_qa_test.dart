// QA for `search_bar` previews: contract, behaviour, robustness.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/search_bar/preview.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  double width = 480,
}) {
  final Widget entry = Center(
    child: SizedBox(
      width: width,
      child: DefaultTextEditingShortcuts(child: child),
    ),
  );
  return Theme(
    data: data,
    child: Directionality(
      textDirection: direction,
      child: Overlay(
        initialEntries: <OverlayEntry>[OverlayEntry(builder: (_) => entry)],
      ),
    ),
  );
}

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in searchBarPreviews) {
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
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 130));
        expect(
          tester.takeException(),
          isNull,
          reason: '${preview.name} light/dark',
        );
      }
    }
  });

  testWidgets('every preview pumps in RTL with no exception', (tester) async {
    for (final preview in searchBarPreviews) {
      await tester.pumpWidget(
        _frame(Builder(builder: preview.builder), direction: TextDirection.rtl),
      );
      await tester.pump();
      expect(tester.takeException(), isNull, reason: '${preview.name} rtl');
    }
  });

  testWidgets('every preview pumps at 320 px with no exception', (
    tester,
  ) async {
    for (final preview in searchBarPreviews) {
      await tester.pumpWidget(
        _frame(Builder(builder: preview.builder), width: 320),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 130));
      expect(tester.takeException(), isNull, reason: '${preview.name} 320px');
    }
  });

  testWidgets('first preview exposes a semantic search field', (tester) async {
    await tester.pumpWidget(
      _frame(Builder(builder: searchBarPreviews.first.builder)),
    );
    await tester.pump();
    expect(
      find.byWidgetPredicate(
        (Widget w) => w.runtimeType.toString().startsWith('SearchBar'),
      ),
      findsOneWidget,
    );
    expect(find.byType(EditableText), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('typing then clearing resets the echoed query', (tester) async {
    await tester.pumpWidget(
      _frame(Builder(builder: searchBarPreviews.first.builder)),
    );
    await tester.pump();
    final Finder field = find.byType(EditableText).first;
    await tester.enterText(field, 'ap');
    await tester.pump(const Duration(milliseconds: 150));
    await tester.pump();
    expect(find.textContaining('query:'), findsOneWidget);
    await tester.enterText(field, '');
    await tester.pump();
    expect(find.text('Type to filter'), findsOneWidget);
  });
}
