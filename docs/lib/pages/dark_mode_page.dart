// `/docs/dark-mode` (spec §1/§2.6): how brightness works, how to set the
// mode, how to toggle it and how to follow the system. Structure mirrors the
// reference page; the framework-picker cards do not exist here (one
// implementation), so the page is prose + code figures.

import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_pages.dart';
import '../state/docs_content_prose2.dart';
import '../widgets/code_figure.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_samples.dart';
import '../widgets/docs_shell.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/typeset.dart';

/// `/docs/dark-mode`.
class DarkModePage extends StatelessWidget {
  /// Creates the dark-mode page.
  const DarkModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs/dark-mode');
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return DocsLayout(
      child: DocsArticle(
        title: docsContentPage(locale, 'pageDarkModeTitle'),
        description: docsContentPage(locale, 'pageDarkModeDesc'),
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          TypesetParagraph(docsProse2(locale, 'proseDarkP1')),
          HeadingAnchor(
            id: 'how-it-works',
            title: docsProse2(locale, 'proseDarkH1'),
          ),
          TypesetParagraph.rich(<InlineSpan>[
            TextSpan(text: docsProse2(locale, 'proseDarkP2a')),
            typesetInlineCodeSpan('Theme.of(context).brightness'),
            TextSpan(text: docsProse2(locale, 'proseDarkP2b')),
          ]),
          DocsCodeFigure(
            code: kDarkModeSamples['read-brightness']!.code,
            language: 'dart',
          ),
          HeadingAnchor(
            id: 'setting-the-mode',
            title: docsProse2(locale, 'proseDarkH2'),
          ),
          TypesetParagraph.rich(<InlineSpan>[
            TextSpan(text: docsProse2(locale, 'proseDarkP3a')),
            typesetInlineCodeSpan('ThemeMode'),
            TextSpan(text: docsProse2(locale, 'proseDarkP3b')),
            typesetInlineCodeSpan('ThemeMode.system'),
            const TextSpan(text: ' '),
          ]),
          DocsCodeFigure(
            code: kDarkModeSamples['app-themes']!.code,
            language: 'dart',
          ),
          HeadingAnchor(
            id: 'toggling',
            title: docsProse2(locale, 'proseDarkH3'),
          ),
          TypesetParagraph(docsProse2(locale, 'proseDarkP4')),
          DocsCodeFigure(
            code: kDarkModeSamples['toggle']!.code,
            language: 'dart',
          ),
          HeadingAnchor(
            id: 'following-the-system',
            title: docsProse2(locale, 'proseDarkH4'),
          ),
          TypesetParagraph.rich(<InlineSpan>[
            TextSpan(text: docsProse2(locale, 'proseDarkP5a')),
            typesetLinkSpan(
              docsProse2(locale, 'proseDarkP5a').contains('theme')
                  ? 'theme toggle'
                  : 'theme toggle',
              () => DocsRouterScope.of(context).go(context, '/docs/theming'),
            ),
            TextSpan(text: docsProse2(locale, 'proseDarkP5b')),
          ]),
        ],
      ),
    );
  }
}
