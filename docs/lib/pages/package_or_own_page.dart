// `/docs/package-or-own` — when to depend on the package and when to own
// the sources, how `dashcn eject` bridges the two, and how updates differ.
//
// Every Dart figure on this page comes from [kPackageOrOwnDartSamples], so
// the sample test parses exactly what the reader sees.

import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
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
    return DocsLayout(
      child: DocsArticle(
        title: 'Package or own the code?',
        description:
            'Two ways to use the same components: depend on the package '
            'or copy the sources. How to choose, how eject bridges them, '
            'and how updates differ.',
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          const TypesetParagraph(
            'Every component ships twice from the same source: as the '
            'published dashcn package and as copyable files the CLI installs '
            'into your app. Both render the same widgets from the same '
            'theme tokens; they differ only in who owns the bytes.',
          ),
          const HeadingAnchor(id: 'which-one', title: 'Which one?'),
          const TypesetParagraph(
            'Choose the package when you want semver updates and lean '
            'imports. Choose own-the-code when you want to read, edit and '
            'commit every line.',
          ),
          const DocsCodeFigure(code: kPackageAddCommand, language: 'bash'),
          DocsCodeFigure(code: kPackageOrOwnDartSamples[0], language: 'dart'),
          DocsCodeFigure(code: kPackageOrOwnDartSamples[1], language: 'dart'),
          const TypesetParagraph(
            'Per-component imports keep package-mode builds lean; only the '
            'components you import are compiled in.',
          ),
          DocsCodeFigure(code: kPackageOrOwnDartSamples[2], language: 'dart'),
          const DocsCodeFigure(code: kOwnCodeGettingStarted, language: 'bash'),
          DocsCodeFigure(code: kPackageOrOwnDartSamples[3], language: 'dart'),
          const HeadingAnchor(id: 'eject', title: 'How eject works'),
          TypesetParagraph.rich(<InlineSpan>[
            const TextSpan(text: 'Started on the package and outgrew it? '),
            typesetInlineCodeSpan('dashcn eject button'),
            const TextSpan(
              text:
                  ' copies that component (plus its closure) into your app '
                  'and rewrites the app imports to match. ',
            ),
            typesetInlineCodeSpan('dashcn eject button --with-deps'),
            const TextSpan(
              text: ' also ejects its transitive component dependencies.',
            ),
          ]),
          const HeadingAnchor(id: 'updates', title: 'How updates differ'),
          const TypesetBullets(
            items: <List<InlineSpan>>[
              <InlineSpan>[
                TextSpan(
                  text: 'Package: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text:
                      'update with the package manager; breaking changes '
                      'arrive as new major versions.',
                ),
              ],
              <InlineSpan>[
                TextSpan(
                  text: 'Own the code: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text:
                      'run dashcn update. Unchanged files are overwritten, '
                      'locally edited files are reported and skipped, and '
                      'user-owned *_theme.dart files are never touched.',
                ),
              ],
            ],
          ),
          const HeadingAnchor(id: 'lock-file', title: 'The lock file'),
          const TypesetParagraph(
            'dashcn.lock (v2) records the registry reference, the install '
            'root, the theme selection and — per component — whether it is '
            'a package dependency or owned sources. .dashcn/config.json '
            'holds the install path and registry source. Commit both.',
          ),
        ],
      ),
    );
  }
}
