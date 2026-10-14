// Widget tests for the `page_route` component.
//
// Covers push/pop, the transition widget at t = 0 / t = 1, the declarative
// `AppPage`, the renamed duration constant and two regressions: the old
// `canTransitionTo` suppressed the exit transition when a non-page route was
// pushed on top, and `debugLabel` printed `PageRoute(null)`.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/page_route/page_route.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Align(alignment: Alignment.topLeft, child: child),
    ),
  );
}

Widget _navigator({required Widget home}) {
  return _host(
    Navigator(
      onGenerateRoute: (settings) =>
          AppPageRoute<void>(settings: settings, builder: (context) => home),
    ),
  );
}

Widget _recordingNavigator(List<AppPageRoute<void>> routes) {
  return _host(
    Navigator(
      onGenerateRoute: (settings) {
        final AppPageRoute<void> route = AppPageRoute<void>(
          settings: settings,
          builder: (context) => const Text('home'),
        );
        routes.add(route);
        return route;
      },
    ),
  );
}

void main() {
  group('AppPageRoute', () {
    testWidgets('push and pop a page', (tester) async {
      final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        _host(
          Navigator(
            key: navigator,
            onGenerateRoute: (settings) => AppPageRoute<void>(
              settings: settings,
              builder: (context) => const Text('page one'),
            ),
          ),
        ),
      );
      expect(find.text('page one'), findsOneWidget);

      navigator.currentState!.push(
        AppPageRoute<void>(builder: (context) => const Text('page two')),
      );
      await tester.pump();
      await tester.pump(kPageTransitionDuration);
      expect(find.text('page two'), findsOneWidget);

      navigator.currentState!.pop();
      await tester.pump();
      await tester.pump(kPageTransitionDuration);
      expect(find.text('page one'), findsOneWidget);
    });

    testWidgets('default transition duration is 300ms', (tester) async {
      final List<AppPageRoute<void>> routes = <AppPageRoute<void>>[];
      await tester.pumpWidget(_recordingNavigator(routes));
      expect(routes.single.transitionDuration, kPageTransitionDuration);
      expect(kPageTransitionDuration, const Duration(milliseconds: 300));
    });

    testWidgets('opaque and maintainState default to true', (tester) async {
      final List<AppPageRoute<void>> routes = <AppPageRoute<void>>[];
      await tester.pumpWidget(_recordingNavigator(routes));
      final AppPageRoute<void> route = routes.single;
      expect(route.opaque, isTrue);
      expect(route.maintainState, isTrue);
      expect(route.barrierColor, isNull);
    });

    testWidgets('regression: an unnamed route does not print (null)', (
      tester,
    ) async {
      final List<AppPageRoute<void>> routes = <AppPageRoute<void>>[];
      await tester.pumpWidget(_recordingNavigator(routes));
      expect(routes.single.debugLabel, isNot(contains('null')));
    });

    testWidgets('regression: a named route reports its name', (tester) async {
      final AppPageRoute<void> named = AppPageRoute<void>(
        settings: const RouteSettings(name: 'detail'),
        builder: (context) => const Text('x'),
      );
      expect(named.debugLabel, contains('detail'));
    });

    testWidgets('regression: any next route may transition in', (tester) async {
      // The old `canTransitionTo` answered `nextRoute is AppPageRoute`, so
      // pushing a dialog/drawer over a page skipped the page's exit transition.
      final AppPageRoute<void> page = AppPageRoute<void>(
        builder: (context) => const Text('page'),
      );
      final AppPageRoute<void> other = AppPageRoute<void>(
        builder: (context) => const Text('other'),
      );
      expect(page.canTransitionTo(other), isTrue);
    });
  });

  group('AppPageTransition', () {
    testWidgets('at t = 1 the page sits at its final position', (tester) async {
      await tester.pumpWidget(
        _host(
          const AppPageTransition(
            animation: AlwaysStoppedAnimation<double>(1),
            child: Text('page'),
          ),
        ),
      );
      expect(find.byType(FadeTransition), findsOneWidget);
      final SlideTransition slide = tester.widget<SlideTransition>(
        find.byType(SlideTransition),
      );
      expect(slide.position.value, Offset.zero);
    });

    testWidgets('at t = 0 the slide starts 2% low', (tester) async {
      await tester.pumpWidget(
        _host(
          const AppPageTransition(
            animation: AlwaysStoppedAnimation<double>(0),
            child: Text('page'),
          ),
        ),
      );
      final SlideTransition slide = tester.widget<SlideTransition>(
        find.byType(SlideTransition),
      );
      expect(slide.position.value, const Offset(0, 0.02));
    });
  });

  group('AppPage', () {
    testWidgets('creates a AppPageRoute carrying its own duration', (
      tester,
    ) async {
      const AppPage<String> page = AppPage<String>(
        key: ValueKey<String>('k'),
        child: Text('body'),
        transitionDuration: Duration(milliseconds: 42),
      );
      late Route<String> route;
      await tester.pumpWidget(
        _host(
          Builder(
            builder: (context) {
              route = page.createRoute(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(route, isA<AppPageRoute<String>>());
      expect(
        (route as AppPageRoute<String>).transitionDuration,
        const Duration(milliseconds: 42),
      );
    });

    testWidgets('renders declarative pages through the Navigator', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          Navigator(
            pages: const <Page<void>>[
              AppPage<void>(child: Text('first')),
              AppPage<void>(key: ValueKey<String>('b'), child: Text('second')),
            ],
            onDidRemovePage: (Page<void> page) {},
          ),
        ),
      );
      await tester.pump();
      await tester.pump(kPageTransitionDuration);
      expect(find.text('second'), findsOneWidget);
    });
  });

  group('tokens', () {
    for (final (String name, ThemeColors colors) in <(String, ThemeColors)>[
      ('light', ThemeColors.lightFallback),
      ('dark', ThemeColors.darkFallback),
    ]) {
      testWidgets('builds under $name tokens', (tester) async {
        await tester.pumpWidget(
          Theme(
            data: ThemeData(colors: colors),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: _navigator(home: const Text('home')),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        expect(find.text('home'), findsOneWidget);
      });
    }
  });
}
