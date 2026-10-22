import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/main.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/state/docs_strings.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/components/navigation_bar/navigation_bar.dart';
import 'package:docs/ui/dashcn/primitives/clickable.dart';
import 'package:docs/ui/dashcn/primitives/localizations/localizations.dart';
import 'package:docs/widgets/component_sections.dart';
import 'package:docs/widgets/copy_button.dart';
import 'package:docs/widgets/docs_header.dart';
import 'package:docs/widgets/docs_sidebar.dart';
import 'package:docs/widgets/docs_toc.dart';
import 'package:docs/widgets/typeset_tables.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

const List<String> kCaptureDirs = <String>[
  '../scratchpad/ui/round2/docsusage/captures',
];

Future<void> _saveCapture(
  WidgetTester tester,
  GlobalKey key,
  String name,
) async {
  await tester.pump();
  final RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final ui.Image image = await boundary.toImage();
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    image.dispose();
    final Uint8List data = bytes!.buffer.asUint8List(
      bytes.offsetInBytes,
      bytes.lengthInBytes,
    );
    for (final String dir in kCaptureDirs) {
      try {
        Directory(dir).createSync(recursive: true);
        await File('$dir/$name.png').writeAsBytes(data, flush: true);
      } catch (_) {}
    }
  });
}

void main() {
  group('Docs Usage parameters table & Switcher & Chrome Sizing', () {
    testWidgets(
      '1. Usage section displays parameters table with headers and dividers',
      (WidgetTester tester) async {
        final GlobalKey key = GlobalKey();
        tester.view.physicalSize = const Size(1280, 1000);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        docsState = DocsState(storage: MemoryDocsStorage());
        addTearDown(docsState.dispose);

        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: DocsApp(state: docsState),
          ),
        );
        await tester.pumpAndSettle();

        final DocsRouterDelegate delegate = tester
            .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
            .delegate;
        await goTo(tester, delegate, '/docs/components/button');
        await tester.pumpAndSettle();

        // Verify the Usage section is rendered
        final Finder usageFinder = find.byType(ComponentUsageSection);
        expect(usageFinder, findsOneWidget);

        // Verify the install line is present
        expect(find.textContaining('dashcn add button'), findsOneWidget);

        // Verify coloured snippet with copy button is present
        expect(
          find.descendant(of: usageFinder, matching: find.byType(CopyButton)),
          findsOneWidget,
        );

        // Verify key parameters table exists
        final Finder usageTableFinder = find.descendant(
          of: usageFinder,
          matching: find.byType(TypesetTable),
        );
        expect(usageTableFinder, findsOneWidget);

        final TypesetTable usageTable = tester.widget<TypesetTable>(
          usageTableFinder,
        );
        expect(usageTable.headers, <String>[
          'Parameter',
          'Type',
          'Default',
          'Description',
        ]);
        expect(usageTable.rows.length, 5); // keyParams.take(5)

        // Verify dividers (bottom borders on table rows).
        // Fitted layout uses TableRow decorations; stacked layout uses
        // Containers with a full border. Accept either.
        final Iterable<Container> tableContainers = tester
            .widgetList<Container>(
              find.descendant(
                of: usageTableFinder,
                matching: find.byType(Container),
              ),
            );
        final bool hasContainerDividers = tableContainers.any(
          (c) =>
              (c.decoration is BoxDecoration) &&
              (((c.decoration as BoxDecoration).border?.bottom != null) ||
                  (c.decoration as BoxDecoration).border?.isUniform == false ||
                  (c.decoration as BoxDecoration).border != null),
        );
        final Iterable<Table> tables = tester.widgetList<Table>(
          find.descendant(of: usageTableFinder, matching: find.byType(Table)),
        );
        bool hasTableDividers = false;
        for (final Table table in tables) {
          for (final TableRow row in table.children) {
            final Decoration? decoration = row.decoration;
            if (decoration is BoxDecoration &&
                decoration.border?.bottom != null) {
              hasTableDividers = true;
              break;
            }
          }
          if (hasTableDividers) {
            break;
          }
        }
        expect(hasContainerDividers || hasTableDividers, isTrue);

        // Verify descriptions render without raw markup: no backticks or
        // square brackets survive in the table text.
        final Iterable<Text> tableTexts = tester.widgetList<Text>(
          find.descendant(of: usageTableFinder, matching: find.byType(Text)),
        );
        for (final Text text in tableTexts) {
          final String? plain = text.data;
          if (plain != null) {
            expect(plain.contains('`'), isFalse, reason: plain);
            // Headers and mono cells never contain brackets; description
            // cells render them as chips (WidgetSpans), not raw text.
            if (text.style?.fontFamily == null ||
                !text.style!.fontFamily!.toLowerCase().contains('mono')) {
              // Allow the em dash placeholder.
              if (plain != '—') {
                expect(plain.contains('['), isFalse, reason: plain);
                expect(plain.contains(']'), isFalse, reason: plain);
              }
            }
          }
          final InlineSpan? span = text.textSpan;
          if (span != null) {
            void checkSpan(InlineSpan s) {
              if (s is TextSpan) {
                final String? t = s.text;
                if (t != null) {
                  expect(t.contains('`'), isFalse, reason: t);
                }
                final List<InlineSpan>? children = s.children;
                if (children != null) {
                  for (final InlineSpan child in children) {
                    checkSpan(child);
                  }
                }
              }
            }

            checkSpan(span);
          }
        }

        // Capture light usage table
        await _saveCapture(tester, key, 'usage-table-light');

        // Switch to dark mode and capture
        docsState.toggleBrightness();
        await tester.pumpAndSettle();
        await _saveCapture(tester, key, 'usage-table-dark');
      },
    );

    testWidgets(
      '2. Language switcher shows current language code in 32px header control and lists all locales',
      (WidgetTester tester) async {
        final GlobalKey key = GlobalKey();
        tester.view.physicalSize = const Size(1280, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        docsState = DocsState(storage: MemoryDocsStorage());
        addTearDown(docsState.dispose);

        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: DocsApp(state: docsState),
          ),
        );
        await tester.pumpAndSettle();

        final Finder switcherFinder = find.byKey(
          const ValueKey<String>('docs-locale-switcher'),
        );
        expect(switcherFinder, findsOneWidget);

        // Verify size of the language switcher control is 32 px in height
        final Size switcherSize = tester.getSize(switcherFinder);
        expect(switcherSize.height, 32.0);

        // Verify it displays the globe icon and "EN"
        expect(
          find.descendant(of: switcherFinder, matching: find.text('EN')),
          findsOneWidget,
        );
        expect(
          find.descendant(of: switcherFinder, matching: find.byType(Icon)),
          findsOneWidget,
        );

        // Capture closed state with 32px header controls
        await _saveCapture(tester, key, 'header-controls-32px');

        // Open the language switcher popup
        await tester.tap(switcherFinder);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 600));

        // Verify every supported locale is listed with its native name
        for (final Locale locale in ComponentLocalizations.supportedLocales) {
          expect(
            find.text(docsLocaleNativeName(locale)),
            findsOneWidget,
            reason: 'Missing native name for ${docsLocaleTag(locale)}',
          );
        }

        // Verify popup rows are 32 px
        final Finder firstRow = find.text(
          docsLocaleNativeName(ComponentLocalizations.supportedLocales.first),
        );
        final Finder rowContainer = find
            .ancestor(of: firstRow, matching: find.byType(SizedBox))
            .first;
        expect(tester.getSize(rowContainer).height, 32.0);

        // Capture OPEN state
        await _saveCapture(tester, key, 'locale-switcher-open');
      },
    );

    testWidgets(
      '3. Header is built on kit NavigationBar and shows blurred content when scrolled',
      (WidgetTester tester) async {
        final GlobalKey key = GlobalKey();
        tester.view.physicalSize = const Size(1280, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        docsState = DocsState(storage: MemoryDocsStorage());
        addTearDown(docsState.dispose);

        // Set translucent surface opacity and blur on theme
        docsState.themeModel.setSurfaceOpacity(0.6);
        docsState.themeModel.setSurfaceBlur(12);

        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: DocsApp(state: docsState),
          ),
        );
        await tester.pumpAndSettle();

        final DocsRouterDelegate delegate = tester
            .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
            .delegate;
        await goTo(tester, delegate, '/docs/components/button');
        await tester.pumpAndSettle();

        // Confirm header is built on kit NavigationBar
        final Finder headerNavBar = find.descendant(
          of: find.byType(DocsHeader),
          matching: find.byType(NavigationBar),
        );
        expect(headerNavBar, findsOneWidget);

        // Confirm GlassSurface with BackdropFilter is present
        final Finder backdrop = find.descendant(
          of: headerNavBar,
          matching: find.byType(BackdropFilter),
        );
        expect(backdrop, findsWidgets);

        // Confirm translucent background
        final ColoredBox surfaceBox = tester.widget<ColoredBox>(
          find
              .descendant(of: headerNavBar, matching: find.byType(ColoredBox))
              .first,
        );
        expect(surfaceBox.color.a, lessThanOrEqualTo(0.7));

        // Scroll content so it scrolls behind the header
        final ScrollableState scrollable = tester.state<ScrollableState>(
          find.byType(Scrollable).first,
        );
        scrollable.position.jumpTo(600);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        // Capture scrolled blur state
        await _saveCapture(tester, key, 'header-blurred-scrolled');
      },
    );

    testWidgets(
      '4. Docs chrome sizing: sidebar items 32px, TOC items 28px, header controls 32px',
      (WidgetTester tester) async {
        final GlobalKey key = GlobalKey();
        tester.view.physicalSize = const Size(1400, 900);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        docsState = DocsState(storage: MemoryDocsStorage());
        addTearDown(docsState.dispose);

        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: DocsApp(state: docsState),
          ),
        );
        await tester.pumpAndSettle();

        final DocsRouterDelegate delegate = tester
            .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
            .delegate;
        await goTo(tester, delegate, '/docs/components/button');
        await tester.pumpAndSettle();

        // Sidebar item size: 32 px
        final Finder sidebarFinder = find.byType(DocsSidebar);
        expect(sidebarFinder, findsOneWidget);

        final Finder buttonSidebarItem = find.descendant(
          of: sidebarFinder,
          matching: find.ancestor(
            of: find.text('Button'),
            matching: find.byType(Clickable),
          ),
        );
        expect(buttonSidebarItem, findsOneWidget);
        final Size sidebarItemSize = tester.getSize(buttonSidebarItem);
        expect(sidebarItemSize.height, 32.0);

        // TOC item size: 28 px
        final Finder tocFinder = find.byType(DocsToc);
        expect(tocFinder, findsOneWidget);

        final Finder usageTocLink = find.descendant(
          of: tocFinder,
          matching: find.ancestor(
            of: find.text('Usage'),
            matching: find.byType(Clickable),
          ),
        );
        expect(usageTocLink, findsOneWidget);
        final Size tocLinkSize = tester.getSize(usageTocLink);
        expect(tocLinkSize.height, 28.0);

        // Header controls: 32 px
        final Finder searchTrigger = find.byKey(
          const ValueKey<String>('docs-search-trigger'),
        );
        expect(tester.getSize(searchTrigger).height, 32.0);

        final Finder localeSwitcher = find.byKey(
          const ValueKey<String>('docs-locale-switcher'),
        );
        expect(tester.getSize(localeSwitcher).height, 32.0);

        final Finder ctaButton = find.text('Get Started');
        expect(
          tester
              .getSize(
                find.ancestor(of: ctaButton, matching: find.byType(Button)),
              )
              .height,
          32.0,
        );

        // Capture sidebar and TOC sizing
        await _saveCapture(tester, key, 'sidebar-toc-sizing');
      },
    );

    testWidgets(
      '5. Mobile 375x812: 32px header control with EN and open popup state',
      (WidgetTester tester) async {
        final GlobalKey key = GlobalKey();
        tester.view.physicalSize = const Size(375, 812);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        docsState = DocsState(storage: MemoryDocsStorage());
        addTearDown(docsState.dispose);

        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: DocsApp(state: docsState),
          ),
        );
        await tester.pumpAndSettle();

        final Finder localeSwitcher = find.byKey(
          const ValueKey<String>('docs-locale-switcher'),
        );
        expect(localeSwitcher, findsOneWidget);
        expect(tester.getSize(localeSwitcher).height, 32.0);
        expect(
          find.descendant(of: localeSwitcher, matching: find.text('EN')),
          findsOneWidget,
        );

        // Mobile closed capture
        await _saveCapture(tester, key, 'mobile-header-switcher-375');

        // Open popup on mobile
        await tester.tap(localeSwitcher);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 600));

        // Mobile open capture
        await _saveCapture(tester, key, 'mobile-locale-open-375');
      },
    );
  });
}
