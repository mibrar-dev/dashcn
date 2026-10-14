// `/docs/material` — using dashcn alongside Material: the clashing names,
// the `as ui` / `hide` escapes, a mixed-app example, and the root choice
// (`DashcnApp` vs `MaterialApp`).
//
// Every Dart figure on this page comes from [kMaterialDartSamples], so the
// sample test parses exactly what the reader sees. The samples are strings:
// this file never imports Material itself (the kit stays widgets-only).

import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
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
    return DocsLayout(
      child: DocsArticle(
        title: 'Using dashcn alongside Material',
        description:
            'The clashing names, the import escapes, a mixed-app example, '
            'and the root choice between DashcnApp and MaterialApp.',
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          const TypesetParagraph(
            'dashcn is widgets-only: it never imports Material, and a pure '
            'dashcn app never needs it. Inside an existing Material app the '
            'components still work — only a few names collide.',
          ),
          const HeadingAnchor(id: 'clashes', title: 'The clashing names'),
          const TypesetParagraph(
            'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, '
            'Tooltip, showDialog and showMenu exist in both libraries. '
            'Import one side with a prefix or hide the names you do not use:',
          ),
          DocsCodeFigure(code: kMaterialDartSamples[0], language: 'dart'),
          DocsCodeFigure(code: kMaterialDartSamples[1], language: 'dart'),
          const HeadingAnchor(id: 'mixed-example', title: 'A mixed example'),
          const TypesetParagraph(
            'With the prefix, both sets stay usable in one build method: '
            'Material owns the scaffold, dashcn owns the action.',
          ),
          DocsCodeFigure(code: kMaterialDartSamples[2], language: 'dart'),
          const HeadingAnchor(id: 'themed', title: 'Theming the island'),
          const TypesetParagraph(
            'Wrap the dashcn subtree in its Theme so tokens resolve even '
            'when the root app is Material-owned:',
          ),
          DocsCodeFigure(code: kMaterialDartSamples[3], language: 'dart'),
          const HeadingAnchor(id: 'root', title: 'DashcnApp vs MaterialApp'),
          const TypesetParagraph(
            'One root owns the app: use DashcnApp for a full dashcn app '
            '(localizations, theme mode and navigation come from the kit) '
            'and MaterialApp when Material owns the shell with dashcn '
            'islands inside. Never nest one root inside the other.',
          ),
          const HeadingAnchor(id: 'touch-targets', title: 'Touch targets'),
          const TypesetParagraph(
            'On phones dashcn grows desktop-density controls with transparent '
            'hit padding (iOS 44, Android 48) without changing the painted '
            'visuals. Dense rows and joined groups can opt out per app with '
            'ThemeData(touchTargets: TouchTargets.shrinkWrap).',
          ),
        ],
      ),
    );
  }
}
