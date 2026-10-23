// `/docs` — the introduction (spec §2.3 prose inside the docs shell).
// Original wording; every number comes from the generated registry facts.

import 'package:flutter/widgets.dart';

import '../generated/docs_data.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_pages.dart';
import '../state/docs_content_prose1.dart';
import '../state/docs_strings.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/typeset.dart';

/// `/docs` — introduction.
class IntroductionPage extends StatelessWidget {
  /// Creates the introduction page.
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs');
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return DocsLayout(
      child: DocsArticle(
        title: docsContentPage(locale, 'pageIntroTitle'),
        description: docsContentPage(locale, 'pageIntroDesc'),
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          TypesetParagraph(docsProse1(locale, 'proseIntroP1')),
          TypesetParagraph(docsProse1(locale, 'proseIntroP2')),
          HeadingAnchor(
            id: 'source-you-own',
            title: docsProse1(locale, 'proseIntroH1'),
          ),
          TypesetParagraph(docsProse1(locale, 'proseIntroP3')),
          TypesetBullets(
            items: <List<InlineSpan>>[
              <InlineSpan>[
                TextSpan(
                  text: docsProse1(locale, 'proseIntroB1t'),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: docsProse1(locale, 'proseIntroB1b')),
              ],
              <InlineSpan>[
                TextSpan(
                  text: docsProse1(locale, 'proseIntroB2t'),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: docsProse1(locale, 'proseIntroB2b')),
              ],
              <InlineSpan>[
                TextSpan(
                  text: docsProse1(locale, 'proseIntroB3t'),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: docsFill(
                    docsProse1(locale, 'proseIntroB3b'),
                    count: kStats.listedComponents,
                  ),
                ),
              ],
            ],
          ),
          HeadingAnchor(
            id: 'one-command-install',
            title: docsProse1(locale, 'proseIntroH2'),
          ),
          TypesetParagraph.rich(<InlineSpan>[
            TextSpan(text: docsProse1(locale, 'proseIntroP4a')),
            typesetInlineCodeSpan('dashcn add <component>'),
            TextSpan(text: docsProse1(locale, 'proseIntroP4b')),
          ]),
          HeadingAnchor(
            id: 'presets',
            title: docsProse1(locale, 'proseIntroH3'),
          ),
          TypesetParagraph(
            docsProse1(locale, 'proseIntroP5')
                .replaceAll('{presets}', '${kStats.presets}')
                .replaceAll('{modes}', '${kStats.modes}'),
          ),
          TypesetParagraph(docsProse1(locale, 'proseIntroP6')),
        ],
      ),
    );
  }
}
