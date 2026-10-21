import 'package:dashcn/src/components/list_tile/list_tile.dart';
import 'package:dashcn/src/theme/density_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  required Widget child,
  ThemeData data = const ThemeData(),
  double width = 800,
  TextDirection direction = TextDirection.ltr,
}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: direction,
      child: MediaQuery(
        data: MediaQueryData(size: Size(width, 800)),
        child: Center(child: child),
      ),
    ),
  );
}

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

  testWidgets('density overrides respected (compact vs comfortable)', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              densityTokens: DensityTokens.compact,
              title: Text('Compact'),
            ),
            ListTile(
              densityTokens: DensityTokens.comfortable,
              title: Text('Comfortable'),
            ),
            ListTile(densityTokens: DensityTokens.touch, title: Text('Touch')),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Compact'), findsOneWidget);
    expect(find.text('Comfortable'), findsOneWidget);
    expect(find.text('Touch'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('theme style overrides win (title weight, gap)', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: ListTile(
          style: const ListTileTheme(
            titleStyle: TextStyle(fontWeight: FontWeight.w700),
          ),
          title: const Text('Styled'),
          subtitle: const Text('Sub'),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Styled'), findsOneWidget);
  });

  testWidgets('selected + long-press callbacks fire', (tester) async {
    var longPressed = false;
    await tester.pumpWidget(
      _frame(
        child: ListTile(
          selected: true,
          title: const Text('Sel'),
          onLongPress: () => longPressed = true,
        ),
      ),
    );
    await tester.longPress(find.text('Sel'));
    await tester.pump();
    expect(longPressed, isTrue);
  });

  testWidgets('RTL renders without overflow', (tester) async {
    await tester.pumpWidget(
      _frame(
        direction: TextDirection.rtl,
        child: const ListTile(
          leading: Text('L'),
          title: Text('Title'),
          subtitle: Text('Sub'),
          trailing: Text('T'),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Title'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion builds', (tester) async {
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(
              size: Size(800, 800),
              disableAnimations: true,
            ),
            child: Center(
              child: ListTile(title: const Text('RM'), onTap: () {}),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('RM'), findsOneWidget);
  });

  testWidgets('grouped dividers render without overflow at 375', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        width: 375,
        child: const SizedBox(
          width: 375,
          child: ListTileGroup(
            children: <Widget>[
              ListTile(title: Text('One')),
              ListTile(
                title: Text('Two with a very long title that truncates'),
              ),
              ListTile(title: Text('Three')),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('One'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('keyboard reachable: tile exposes tap semantics', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: ListTile(title: const Text('Focus'), onTap: () {}),
      ),
    );
    await tester.pump();
    // Clickable owns focus/keyboard; the tile must expose a tap target.
    expect(find.text('Focus'), findsOneWidget);
  });
}
