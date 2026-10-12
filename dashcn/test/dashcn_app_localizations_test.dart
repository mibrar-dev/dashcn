import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/primitives/localizations/localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DashcnApp exposes ComponentLocalizations to descendants', (
    tester,
  ) async {
    await tester.pumpWidget(
      const DashcnApp(locale: Locale('en'), home: _LocalizationsProbe()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Must be at least 4 characters.'), findsOneWidget);
  });
}

class _LocalizationsProbe extends StatelessWidget {
  const _LocalizationsProbe();

  @override
  Widget build(BuildContext context) {
    final localizations = ComponentLocalizations.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(localizations.formLengthLessThan(4)),
    );
  }
}
