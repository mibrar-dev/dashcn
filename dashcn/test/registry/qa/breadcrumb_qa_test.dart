// QA for `breadcrumb` previews (P7-Q1).
//
// Regression cover for: the chevron separator not mirroring in RTL.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/breadcrumb/breadcrumb.dart';
import 'package:dashcn/src/components/breadcrumb/preview.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  double? width,
}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: direction,
      child: Center(
        child: width == null ? child : SizedBox(width: width, child: child),
      ),
    ),
  );
}

const Breadcrumb _trail = Breadcrumb(
  children: <Widget>[Text('Home'), Text('Library'), Text('Data')],
);

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in breadcrumbPreviews) {
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

  testWidgets('chevron points right in LTR and left in RTL', (tester) async {
    await tester.pumpWidget(_frame(_trail));
    await tester.pump();
    Icon icon = tester.widget<Icon>(find.byType(Icon).first);
    expect(icon.icon, LucideIcons.chevronRight);

    await tester.pumpWidget(_frame(_trail, direction: TextDirection.rtl));
    await tester.pump();
    icon = tester.widget<Icon>(find.byType(Icon).first);
    expect(icon.icon, LucideIcons.chevronLeft);
  });

  testWidgets('long trail scrolls instead of overflowing at 375px', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        const Breadcrumb(
          children: <Widget>[
            Text('Home'),
            Text('Components'),
            Text('Library'),
            Text('Data'),
            Text('Current page'),
          ],
        ),
        width: 375,
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
