// `/docs/material` — using dashcn alongside Material: the clashing names,
// the `as ui` / `hide` escapes, a mixed-app example, and the root choice
// (`DashcnApp` vs `MaterialApp`).
//
// Every Dart figure on this page comes from [kMaterialDartSamples], so the
// sample test parses exactly what the reader sees. The samples are strings:
// this file never imports Material itself (the kit stays widgets-only).

import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_pages.dart';
import '../state/docs_content_prose1.dart';
import '../widgets/code_figure.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/typeset.dart';

/// Every Dart sample rendered on the Material interop page, verbatim.
///
/// The sample test parses each entry with the analyzer: entries that are a
/// full unit (imports, declarations) must parse directly; statements and
/// expressions must parse inside a function body.
const List<String> kMaterialDartSamples = <String>[
  "import 'package:dashcn/dashcn.dart' as ui;",
  "import 'package:flutter/material.dart' hide Theme, ThemeData, Card;",
  'ui.Button(onPressed: _save, child: Text(\'Save\'))',
  'void main() {\n'
      '  runApp(\n'
      '    ui.Theme(\n'
      '      data: lightTheme,\n'
      '      child: ui.Button(onPressed: _save, child: Text(\'Save\')),\n'
      '    ),\n'
      '  );\n'
      '}\n'
      'void _save() {}',
];

/// `/docs/material` — using dashcn alongside Material.
class MaterialInteropPage extends StatelessWidget {
  /// Creates the page.
  const MaterialInteropPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs/material');
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return DocsLayout(
      child: DocsArticle(
        title: docsContentPage(locale, 'pageMaterialTitle'),
        description: docsContentPage(locale, 'pageMaterialDesc'),
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          TypesetParagraph(docsProse1(locale, 'proseMaterialP1')),
          HeadingAnchor(
            id: 'clashes',
            title: docsProse1(locale, 'proseMaterialH1'),
          ),
          TypesetParagraph(docsProse1(locale, 'proseMaterialP2')),
          DocsCodeFigure(code: kMaterialDartSamples[0], language: 'dart'),
          DocsCodeFigure(code: kMaterialDartSamples[1], language: 'dart'),
          HeadingAnchor(
            id: 'mixed-example',
            title: docsProse1(locale, 'proseMaterialH2'),
          ),
          TypesetParagraph(docsProse1(locale, 'proseMaterialP3')),
          DocsCodeFigure(code: kMaterialDartSamples[2], language: 'dart'),
          HeadingAnchor(
            id: 'themed',
            title: docsProse1(locale, 'proseMaterialH3'),
          ),
          TypesetParagraph(docsProse1(locale, 'proseMaterialP4')),
          DocsCodeFigure(code: kMaterialDartSamples[3], language: 'dart'),
          HeadingAnchor(
            id: 'root',
            title: docsProse1(locale, 'proseMaterialH4'),
          ),
          TypesetParagraph(docsProse1(locale, 'proseMaterialP5')),
          HeadingAnchor(
            id: 'touch-targets',
            title: docsProse1(locale, 'proseMaterialH5'),
          ),
          TypesetParagraph(docsProse1(locale, 'proseMaterialP6')),
        ],
      ),
    );
  }
}
