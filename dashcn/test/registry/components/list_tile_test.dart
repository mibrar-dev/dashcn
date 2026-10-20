import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/list_tile/list_tile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ListTile renders title', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ListTile(title: Text('Hello')),
      ),
    );
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('ListTile tap callback fires', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: ListTile(title: const Text('Tap'), onTap: () => tapped = true),
      ),
    );
    await tester.tap(find.text('Tap'));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('ListTile disabled renders', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ListTile(title: Text('Disabled'), enabled: false),
      ),
    );
    expect(find.text('Disabled'), findsOneWidget);
  });

  testWidgets('ListTile phone width no overflow', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          width: 375,
          child: ListTile(
            leading: Text('L'),
            title: Text('Title'),
            subtitle: Text('Sub'),
            trailing: Text('T'),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
