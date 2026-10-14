// QA for `alert` previews (P7-Q1): contract, spacing, theme, widths.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert/alert.dart';
import 'package:dashcn/src/components/alert/preview.dart';
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

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in alertPreviews) {
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

  testWidgets('compact preview fits 375px with no overflow', (tester) async {
    await tester.pumpWidget(
      _frame(Builder(builder: alertPreviews[2].builder), width: 375),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('padding matches dashcn px-4 py-3 at default density', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(const Alert(title: Text('t'), content: Text('c'))),
    );
    await tester.pump();
    final Padding padding = tester.widget<Padding>(
      find
          .descendant(of: find.byType(Alert), matching: find.byType(Padding))
          .first,
    );
    final EdgeInsets resolved = padding.padding.resolve(TextDirection.ltr);
    expect(resolved.left, 16);
    expect(resolved.top, 12);
  });

  testWidgets('long title wraps instead of overflowing at 375px', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        const Alert(
          title: Text(
            'A very long alert title that must wrap onto several lines '
            'instead of overflowing the narrow phone stage',
          ),
          content: Text('content'),
        ),
        width: 375,
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
