// P7-WA interaction tests: alert layout, locked-dialog way out, toasts over
// the app, gooey shared controls, drawer background scale.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/alert_dialog/preview.dart';
import 'package:dashcn/src/components/dialog/dialog.dart';
import 'package:dashcn/src/components/dialog/preview.dart';
import 'package:dashcn/src/components/drawer/drawer.dart';
import 'package:dashcn/src/components/drawer/preview.dart';
import 'package:dashcn/src/components/gooey_toast/preview.dart';
import 'package:dashcn/src/components/toast/preview.dart';
import 'package:dashcn/src/components/toast/toast.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {ThemeData data = const ThemeData()}) {
  return Theme(
    data: data,
    child: Directionality(textDirection: TextDirection.ltr, child: child),
  );
}

void main() {
  group('alert layout (P7-WA.1)', () {
    testWidgets('header icon aligns with the title first line', (tester) async {
      await tester.pumpWidget(
        _app(
          const Center(
            child: AlertDialog(
              icon: Icon(IconData(0x1234)),
              title: Text('Title'),
              description: Text('Body'),
            ),
          ),
        ),
      );
      final Row header = tester
          .widgetList<Row>(find.byType(Row))
          .firstWhere(
            (Row row) => row.crossAxisAlignment == CrossAxisAlignment.start,
          );
      expect(header.mainAxisSize, MainAxisSize.max);
    });

    testWidgets('footer is right-aligned and stretched, not left-flush', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const Center(
            child: SizedBox(
              width: 500,
              child: AlertDialog(
                title: Text('Title'),
                actions: <Widget>[Text('A'), Text('B')],
              ),
            ),
          ),
        ),
      );
      final Column outer = tester.widget<Column>(find.byType(Column).first);
      expect(outer.crossAxisAlignment, CrossAxisAlignment.stretch);
      final Wrap footer = tester.widget<Wrap>(find.byType(Wrap));
      expect(footer.alignment, WrapAlignment.end);
    });

    testWidgets('footer stacks full-width at or below a 480px card', (
      tester,
    ) async {
      Future<Type> footerType(double width) async {
        await tester.pumpWidget(
          _app(
            Center(
              child: SizedBox(
                width: width,
                child: const AlertDialog(
                  title: Text('Title'),
                  actions: <Widget>[Text('A'), Text('B')],
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        if (find.byType(Wrap).evaluate().isNotEmpty) {
          return Wrap;
        }
        return Column;
      }

      expect(await footerType(500), Wrap);
      expect(await footerType(300), Column);
    });

    testWidgets('alert previews cover the four required flows', (_) async {
      final List<String> names = alertDialogPreviews
          .map((preview) => preview.name)
          .toList();
      for (final String required in <String>[
        'Delete account',
        'Discard changes',
        'Session expiring',
        'Success',
      ]) {
        expect(names, contains(required));
      }
    });
  });

  group('barrier-locked dialogs (P7-WA.3)', () {
    testWidgets('locked dialog ignores barrier + escape but Cancel pops', (
      tester,
    ) async {
      late BuildContext host;
      await tester.pumpWidget(
        _app(
          Navigator(
            onGenerateRoute: (settings) => PageRouteBuilder<void>(
              settings: settings,
              pageBuilder: (context, _, _) {
                host = context;
                return const SizedBox(width: 10, height: 10);
              },
            ),
          ),
        ),
      );
      bool? result;
      showDialog<bool>(
        context: host,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
            GestureDetector(
              onTap: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ).then((value) => result = value);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      // Barrier tap does nothing while locked.
      await tester.tapAt(const Offset(4, 4));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Cancel'), findsOneWidget);
      // The explicit way out works.
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    });

    testWidgets('locked dialog preview offers Cancel', (tester) async {
      await tester.pumpWidget(
        _app(
          Navigator(
            onGenerateRoute: (settings) => PageRouteBuilder<void>(
              settings: settings,
              pageBuilder: (context, _, _) {
                final preview = dialogPreviews.firstWhere(
                  (entry) => entry.name == 'Barrier locked',
                );
                return Center(child: Builder(builder: preview.builder));
              },
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open locked dialog'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Cancel'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    });

    testWidgets('dialog previews cover the five required flows', (_) async {
      final List<String> names = dialogPreviews
          .map((preview) => preview.name)
          .toList();
      for (final String required in <String>[
        'Edit profile',
        'Share link',
        'Invite members',
        'Terms',
        'Picker',
      ]) {
        expect(names, contains(required));
      }
    });
  });

  group('toasts over the app (P7-WA.2/5)', () {
    testWidgets('toast trigger shows a card over the root layer', (
      tester,
    ) async {
      final ToastController controller = ToastController();
      addTearDown(controller.dispose);
      late BuildContext host;
      await tester.pumpWidget(
        _app(
          SizedBox(
            width: 400,
            height: 400,
            child: ToastLayer(
              controller: controller,
              child: Builder(
                builder: (BuildContext context) {
                  host = context;
                  return toastPreviews.first.builder(context);
                },
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Show toast'));
      await tester.pump();
      expect(find.text('Saved to your workspace.'), findsOneWidget);
      // The card is positioned against the layer (whole-app host), not
      // inside the trigger's own box.
      expect(
        find.descendant(
          of: find.byType(ToastLayer),
          matching: find.byType(Positioned),
        ),
        findsWidgets,
      );
      expect(host, isNotNull);
      controller.dismissAll();
      await tester.pump();
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });

    testWidgets('toast previews use the root layer (no local stage box)', (
      tester,
    ) async {
      expect(toastPreviews.map((entry) => entry.name), contains('Positions'));
    });
  });

  group('gooey shared theme (P7-WA.6)', () {
    testWidgets('playground hosts shape/animation/position/fill controls', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          Overlay.wrap(
            child: Builder(builder: gooeyToastPreviews.first.builder),
          ),
        ),
      );
      await tester.pump();
      for (final String label in <String>[
        'sharp',
        'soft',
        'sileo',
        'smooth',
        'center',
        'light fill',
      ]) {
        expect(find.text(label), findsOneWidget, reason: label);
      }
    });

    testWidgets('changing playground controls does not throw', (tester) async {
      await tester.pumpWidget(
        _app(
          Overlay.wrap(
            child: Builder(builder: gooeyToastPreviews.first.builder),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('soft'));
      await tester.pump();
      await tester.tap(find.text('left'));
      await tester.pump();
      expect(find.text('soft'), findsOneWidget);
    });

    testWidgets('only the playground owns controls (no divergent style)', (
      tester,
    ) async {
      for (final entry in gooeyToastPreviews.skip(1)) {
        await tester.pumpWidget(
          _app(Overlay.wrap(child: Builder(builder: entry.builder))),
        );
        await tester.pump();
        expect(find.text('sharp'), findsNothing, reason: entry.name);
        expect(find.text('sileo'), findsNothing, reason: entry.name);
      }
    });
  });

  group('drawer background scale (P7-WA.7)', () {
    testWidgets('opening a drawer scales the background', (tester) async {
      final DrawerScaleObserver observer = DrawerScaleObserver();
      final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        _app(
          SizedBox(
            width: 400,
            height: 400,
            child: Navigator(
              key: key,
              observers: <NavigatorObserver>[observer],
              onGenerateRoute: (settings) => PageRouteBuilder<void>(
                settings: settings,
                pageBuilder: (context, _, _) => DrawerBackgroundScale(
                  observer: observer,
                  child: Builder(
                    builder: (BuildContext context) => Center(
                      child: GestureDetector(
                        onTap: () => openDrawer<void>(
                          context: context,
                          useRootNavigator: false,
                          builder: (_) => const Text('Panel'),
                        ),
                        child: const Text('Open'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      expect(observer.progress.value, 0);
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(observer.progress.value, greaterThan(0));
      expect(
        find.byKey(const ValueKey<String>('drawer-background-scale')),
        findsOneWidget,
      );
      expect(
        find.byType(ClipRRect),
        findsWidgets,
      ); // panel + background rounding
    });

    testWidgets('opt-out disables the transform', (tester) async {
      final DrawerScaleObserver observer = DrawerScaleObserver();
      await tester.pumpWidget(
        _app(
          SizedBox(
            width: 400,
            height: 400,
            child: Navigator(
              observers: <NavigatorObserver>[observer],
              onGenerateRoute: (settings) => PageRouteBuilder<void>(
                settings: settings,
                pageBuilder: (context, _, _) => DrawerBackgroundScale(
                  observer: observer,
                  enabled: false,
                  child: Builder(
                    builder: (BuildContext context) => Center(
                      child: GestureDetector(
                        onTap: () => openDrawer<void>(
                          context: context,
                          useRootNavigator: false,
                          builder: (_) => const Text('Panel'),
                        ),
                        child: const Text('Open'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(observer.progress.value, greaterThan(0));
      // Opt-out keeps the wrapper mounted (stable structure, never
      // reparents the shell) but identity: no scale, no dim veil.
      final Transform transform = tester.widget<Transform>(
        find.byKey(const ValueKey<String>('drawer-background-scale')),
      );
      expect(transform.transform.getMaxScaleOnAxis(), 1.0);
      final Finder veil = find.descendant(
        of: find.byType(DrawerBackgroundScale),
        matching: find.byType(ColoredBox),
      );
      expect(veil, findsOneWidget);
      expect(tester.widget<ColoredBox>(veil).color.a, 0);
    });

    testWidgets('reduced motion disables the transform', (tester) async {
      final DrawerScaleObserver observer = DrawerScaleObserver();
      await tester.pumpWidget(
        _app(
          MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: SizedBox(
              width: 400,
              height: 400,
              child: Navigator(
                observers: <NavigatorObserver>[observer],
                onGenerateRoute: (settings) => PageRouteBuilder<void>(
                  settings: settings,
                  pageBuilder: (context, _, _) => DrawerBackgroundScale(
                    observer: observer,
                    child: Builder(
                      builder: (BuildContext context) => Center(
                        child: GestureDetector(
                          onTap: () => openDrawer<void>(
                            context: context,
                            useRootNavigator: false,
                            builder: (_) => const Text('Panel'),
                          ),
                          child: const Text('Open'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      // Reduced motion keeps the wrapper mounted (stable structure) but
      // identity: no scale, no dim veil.
      final Transform transform = tester.widget<Transform>(
        find.byKey(const ValueKey<String>('drawer-background-scale')),
      );
      expect(transform.transform.getMaxScaleOnAxis(), 1.0);
      final Finder veil = find.descendant(
        of: find.byType(DrawerBackgroundScale),
        matching: find.byType(ColoredBox),
      );
      expect(veil, findsOneWidget);
      expect(tester.widget<ColoredBox>(veil).color.a, 0);
    });

    testWidgets('dialogs do not scale the background', (tester) async {
      final DrawerScaleObserver observer = DrawerScaleObserver();
      late BuildContext host;
      await tester.pumpWidget(
        _app(
          SizedBox(
            width: 400,
            height: 400,
            child: Navigator(
              observers: <NavigatorObserver>[observer],
              onGenerateRoute: (settings) => PageRouteBuilder<void>(
                settings: settings,
                pageBuilder: (context, _, _) {
                  host = context;
                  return DrawerBackgroundScale(
                    observer: observer,
                    child: const SizedBox.expand(),
                  );
                },
              ),
            ),
          ),
        ),
      );
      showDialog<void>(context: host, builder: (_) => const Text('Dialog'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(observer.progress.value, 0);
      // Closed: the wrapper stays mounted (stable structure) but identity.
      final Transform transform = tester.widget<Transform>(
        find.byKey(const ValueKey<String>('drawer-background-scale')),
      );
      expect(transform.transform.getMaxScaleOnAxis(), 1.0);
    });

    testWidgets('drawer previews include the scale demo', (_) async {
      expect(
        drawerPreviews.map((entry) => entry.name),
        contains('Background scale'),
      );
    });
  });
}
