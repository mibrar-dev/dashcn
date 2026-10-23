// `/docs/package-or-own` — when to depend on the package and when to own
// the sources, how `dashcn eject` bridges the two, and how updates differ.
//
// Every Dart figure on this page comes from [kPackageOrOwnDartSamples], so
// the sample test parses exactly what the reader sees.

import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_pages.dart';
import '../state/docs_content_prose1.dart';
import '../widgets/code_figure.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/install_commands.dart';
import '../widgets/typeset.dart';

/// Every Dart sample rendered on the package-or-own page, verbatim.
///
/// The sample test parses each entry with the analyzer: entries that are a
/// full unit (imports, declarations) must parse directly; statements and
/// expressions must parse inside a function body.
const List<String> kPackageOrOwnDartSamples = <String>[
  "import 'package:dashcn/dashcn.dart';",
  'void main() {\n'
      '  runApp(const DashcnApp(home: SizedBox.shrink()));\n'
      '}',
  "import 'package:dashcn/components/button.dart';",
  'final Button save = Button(onPressed: _save, child: Text(\'Save\'));\n'
      'void _save() {}',
];

/// `/docs/package-or-own` — package or own the code?
class PackageOrOwnPage extends StatelessWidget {
  /// Creates the page.
  const PackageOrOwnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs/package-or-own');
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return DocsLayout(
      child: DocsArticle(
        title: docsContentPage(locale, 'pagePackageTitle'),
        description: docsContentPage(locale, 'pagePackageDesc'),
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          TypesetParagraph(docsProse1(locale, 'prosePackageP1')),
          HeadingAnchor(
            id: 'which-one',
            title: docsProse1(locale, 'prosePackageH1'),
          ),
          TypesetParagraph(docsProse1(locale, 'prosePackageP2')),
          const DocsCodeFigure(code: kPackageAddCommand, language: 'bash'),
          DocsCodeFigure(code: kPackageOrOwnDartSamples[0], language: 'dart'),
          DocsCodeFigure(code: kPackageOrOwnDartSamples[1], language: 'dart'),
          TypesetParagraph(docsProse1(locale, 'prosePackageP3')),
          DocsCodeFigure(code: kPackageOrOwnDartSamples[2], language: 'dart'),
          const DocsCodeFigure(code: kOwnCodeGettingStarted, language: 'bash'),
          DocsCodeFigure(code: kPackageOrOwnDartSamples[3], language: 'dart'),
          HeadingAnchor(
            id: 'eject',
            title: docsProse1(locale, 'prosePackageH2'),
          ),
          TypesetParagraph.rich(<InlineSpan>[
            TextSpan(text: docsProse1(locale, 'prosePackageEjectA')),
            typesetInlineCodeSpan('dashcn eject button'),
            TextSpan(text: docsProse1(locale, 'prosePackageEjectB')),
            typesetInlineCodeSpan('dashcn eject button --with-deps'),
            TextSpan(text: docsProse1(locale, 'prosePackageEjectC')),
          ]),
          HeadingAnchor(
            id: 'updates',
            title: docsProse1(locale, 'prosePackageH3'),
          ),
          TypesetBullets(
            items: <List<InlineSpan>>[
              <InlineSpan>[
                TextSpan(
                  text: docsProse1(locale, 'prosePackageB1t'),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: docsProse1(locale, 'prosePackageB1b')),
              ],
              <InlineSpan>[
                TextSpan(
                  text: docsProse1(locale, 'prosePackageB2t'),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: docsProse1(locale, 'prosePackageB2b')),
              ],
            ],
          ),
          HeadingAnchor(
            id: 'lock-file',
            title: docsProse1(locale, 'prosePackageH4'),
          ),
          TypesetParagraph(docsProse1(locale, 'prosePackageP4')),
        ],
      ),
    );
  }
}
