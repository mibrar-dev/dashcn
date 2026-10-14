// D5 keyboard-focus audit: the docs-only interactive elements (sidebar items,
// TOC links, install tabs, theme rail rows, index links, mobile-nav links,
// footer links) are tab-reachable and paint the visible focus ring.
//
// Every one of them is a registry `Clickable` (or `Button`), which owns the
// keyboard activation contract; this test proves the wiring end to end.

import 'package:docs/main.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/ui/dashcn/primitives/focus_outline.dart';
import 'package:docs/widgets/component_link_grid.dart';
import 'package:docs/widgets/docs_footer.dart';
import 'package:docs/widgets/docs_header.dart';
import 'package:docs/widgets/docs_sidebar.dart';
import 'package:docs/widgets/docs_toc.dart';
import 'package:docs/widgets/theme_rail.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

const ValueKey<String> _searchKey = ValueKey<String>('docs-search-trigger');

bool _isAncestorOf(Element ancestor, Element node) {
  bool found = false;
  node.visitAncestorElements((Element candidate) {
    if (identical(candidate, ancestor)) {
      found = true;
      return false;
    }
    return true;
  });
  return found;
}

bool _focusedWithin(Finder target) {
  final Element? focused =
      FocusManager.instance.primaryFocus?.context as Element?;
  if (focused == null) {
    return false;
  }
  for (final Element element in target.evaluate()) {
    // The `Focus` element owned by `Clickable`/`Button` sits inside the
    // interactive widget, so either side can be the ancestor of the other.
    if (identical(element, focused) ||
        _isAncestorOf(focused, element) ||
        _isAncestorOf(element, focused)) {
      return true;
    }
  }
  return false;
}

Future<void> _tabUntil(
  WidgetTester tester,
  Finder target, {
  int maxTabs = 300,
}) async {
  for (int i = 0; i < maxTabs; i++) {
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    if (_focusedWithin(target)) {
      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is FocusOutline && widget.focused,
        ),
        findsWidgets,
        reason: 'visible focus ring for $target',
      );
      return;
    }
  }
  fail('$target not reachable by Tab within $maxTabs tabs');
}

void main() {
  setUp(() {
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
  });

  tearDown(() {
    FocusManager.instance.highlightStrategy = FocusHighlightStrategy.automatic;
  });

  testWidgets('header search trigger is tab-reachable with a focus ring', (
    WidgetTester tester,
  ) async {
    await pumpDocsApp(tester, width: 1400, height: 900);
    await _tabUntil(tester, find.byKey(_searchKey));
  });

  testWidgets('sidebar items are tab-reachable with a focus ring', (
    WidgetTester tester,
  ) async {
    final delegate = await pumpDocsApp(tester, width: 1400, height: 900);
    await goTo(tester, delegate, '/docs');
    await _tabUntil(
      tester,
      find.descendant(
        of: find.byType(DocsSidebar),
        matching: find.text('Installation'),
      ),
    );
  });

  testWidgets('install tabs are tab-reachable', (WidgetTester tester) async {
    final delegate = await pumpDocsApp(tester, width: 1400, height: 900);
    await goTo(tester, delegate, '/docs/components/button');
    await _tabUntil(tester, find.text('Own the code'));
  });

  testWidgets('TOC links are tab-reachable with a focus ring', (
    WidgetTester tester,
  ) async {
    final delegate = await pumpDocsApp(tester, width: 1400, height: 900);
    await goTo(tester, delegate, '/docs/components/button');
    await tester.pumpAndSettle();
    await _tabUntil(
      tester,
      find.descendant(of: find.byType(DocsToc), matching: find.text('Usage')),
    );
  });

  testWidgets('theme rail rows are tab-reachable', (WidgetTester tester) async {
    final delegate = await pumpDocsApp(tester, width: 1400, height: 900);
    await goTo(tester, delegate, '/themes');
    await tester.pumpAndSettle();
    // The rail rows (and the footer actions behind them) are one tab ring.
    await _tabUntil(
      tester,
      find.descendant(
        of: find.byType(ThemeRail),
        matching: find.text('Base colour'),
      ),
    );
    // Only the rows that precede the canvas in reading order are asserted:
    // once focus enters the canvas it cannot leave again, because the
    // registry `Slider` marks every KeyDownEvent as handled (including Tab).
    // Reported as a registry accessibility gap in P6-D7.md; D5 owns the
    // keyboard audit.
  });

  testWidgets('components index links are tab-reachable below lg', (
    WidgetTester tester,
  ) async {
    final delegate = await pumpDocsApp(tester, width: 1000, height: 900);
    await goTo(tester, delegate, '/docs/components');
    await _tabUntil(
      tester,
      find.descendant(
        of: find.byType(ComponentLinkGrid),
        matching: find.text('Accordion'),
      ),
    );
  });

  testWidgets('mobile nav links are tab-reachable after opening the popper', (
    WidgetTester tester,
  ) async {
    final delegate = await pumpDocsApp(tester, width: 800, height: 900);
    await goTo(tester, delegate, '/docs/theming');
    await tester.tap(find.text('Menu'));
    await tester.pumpAndSettle();
    await _tabUntil(
      tester,
      find.descendant(
        of: find.byType(DocsMobileNav),
        matching: find.text('Home'),
      ),
    );
  });

  testWidgets('footer links are tab-reachable', (WidgetTester tester) async {
    final delegate = await pumpDocsApp(tester, width: 1280, height: 900);
    await goTo(tester, delegate, '/not-found');
    await _tabUntil(
      tester,
      find.descendant(of: find.byType(DocsFooter), matching: find.text('Docs')),
    );
  });

  testWidgets('fresh app: the first Tab lands in the header', (
    WidgetTester tester,
  ) async {
    await pumpDocsApp(tester, width: 1400, height: 900);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(_focusedWithin(find.byType(DocsHeader)), isTrue);
  });

  testWidgets('shell Tab order is header, sidebar, content, TOC', (
    WidgetTester tester,
  ) async {
    final delegate = await pumpDocsApp(tester, width: 1400, height: 900);
    await goTo(tester, delegate, '/docs/components/button');
    await tester.pumpAndSettle();

    final Set<Element> header = find.byType(DocsHeader).evaluate().toSet();
    final Set<Element> sidebar = find.byType(DocsSidebar).evaluate().toSet();
    final Set<Element> toc = find.byType(DocsToc).evaluate().toSet();

    bool within(Element node, Set<Element> roots) {
      for (final Element root in roots) {
        if (identical(root, node) ||
            _isAncestorOf(root, node) ||
            _isAncestorOf(node, root)) {
          return true;
        }
      }
      return false;
    }

    String regionOf(Element? focused) {
      if (focused == null) {
        return '';
      }
      if (within(focused, header)) {
        return 'header';
      }
      if (within(focused, sidebar)) {
        return 'sidebar';
      }
      if (within(focused, toc)) {
        return 'toc';
      }
      return 'content';
    }

    // Walk Tab until each of the four regions has been seen, recording the
    // region transitions. `OrderedTraversalPolicy` + the `FocusTraversalOrder`
    // slots make the cycle header → sidebar → content → TOC; the default
    // reading order interleaved the article and TOC columns and reached the
    // header (outside the page navigator) only after the article.
    final List<String> order = <String>[];
    for (int i = 0; i < 400 && order.length < 4; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      final Element? focused =
          FocusManager.instance.primaryFocus?.context as Element?;
      final String region = regionOf(focused);
      if (region.isNotEmpty && (order.isEmpty || order.last != region)) {
        order.add(region);
      }
    }
    // Rotate the cycle so it starts at the header, then assert the order.
    final int start = order.indexOf('header');
    expect(start, isNonNegative, reason: 'header region never reached');
    final List<String> rotated = <String>[
      ...order.sublist(start),
      ...order.sublist(0, start),
    ];
    expect(rotated, <String>['header', 'sidebar', 'content', 'toc']);
  });

  testWidgets('real startup order: first Tab lands in the header', (
    WidgetTester tester,
  ) async {
    // P7I-fix-focus: simulates the real web startup order as closely as the
    // harness allows — a direct pump with no isolate warm, then the deferred
    // landing hero chunk arriving late (as over the network) before the first
    // Tab. The harness cannot reproduce the release-browser failure (first
    // Tab jumping straight into the hero Email field, skipping the header):
    // widget tests run in debug (asserts on, readable labels), use FakeAsync
    // pumps, never dispatch the engine's pre-first-frame view-focus event,
    // and resolve deferred chunks synchronously enough that the header anchor
    // keeps focus. This test pins the contract (header-first Tab) and stays
    // green; the release-browser check (`browser_check.mjs` shot
    // `13-tab-once`) is the ground truth for the regression.
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    docsState = DocsState(
      storage: MemoryDocsStorage(),
      systemBrightness: Brightness.dark,
    );
    addTearDown(docsState.dispose);
    await tester.pumpWidget(DocsApp(state: docsState));
    await tester.pumpAndSettle();
    final DocsRouterDelegate delegate = tester
        .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
        .delegate;
    await drainLandingHero(tester, delegate);
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(_focusedWithin(find.byType(DocsHeader)), isTrue);
  });
}
