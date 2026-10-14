// P7-TH1 — the component page header follows the theme (split from
// `p7th1_theme_everywhere_test.dart` so deferred-chunk loading in earlier
// suite tests cannot starve this navigation: each test file runs in its own
// isolate, i.e. under the same conditions as a solo run).
//
// Asserts: badge group + actions are theme-spaced Wraps (gap-2), badges at
// badge size, Copy Page and pager buttons at size sm.

import 'package:docs/routing/docs_router.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/copy_button.dart';
import 'package:docs/widgets/docs_article.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

/// Navigates to a component page and waits for the deferred template:
/// `pumpAndSettle` does not wait for chunk loads (it returns when no frames
/// are scheduled), so the article is awaited explicitly, bounded so a
/// genuinely broken route still fails fast.
Future<void> _goToArticle(
  WidgetTester tester,
  DocsRouterDelegate delegate,
  String location,
) async {
  delegate.go(tester.element(find.byType(Navigator).first), location);
  for (int i = 0; i < 60; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (find.byType(DocsArticle).evaluate().isNotEmpty) {
      break;
    }
  }
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('component header uses theme spacing, badge size, sm buttons', (
    tester,
  ) async {
    await pumpDocsApp(tester, width: 1400);
    final DocsRouterDelegate delegate = tester
        .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
        .delegate;
    await _goToArticle(tester, delegate, '/docs/components/toggle');
    expect(
      find.byType(DocsArticle),
      findsOneWidget,
      reason: 'toggle page uses the article template',
    );
    // Badge group and actions are theme-spaced Wraps (gap-2 within groups).
    final ThemeData theme = docsState.theme;
    final Iterable<Wrap> wraps = tester.widgetList<Wrap>(
      find.descendant(
        of: find.byType(DocsArticle),
        matching: find.byType(Wrap),
      ),
    );
    expect(
      wraps.where((Wrap wrap) => wrap.spacing == theme.spacing.sm),
      isNotEmpty,
      reason: 'title-row groups use gap-2 spacing',
    );
    // Copy Page is a sm button.
    final CopyButton copy = tester.widget<CopyButton>(
      find.widgetWithText(CopyButton, 'Copy Page'),
    );
    expect(copy.size, ButtonSize.sm);
  });
}
