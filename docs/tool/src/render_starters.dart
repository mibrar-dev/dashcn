// Renderer for the starter-shaped generated file (P9-Z2):
// `docs_starters.dart` (the catalog, main bundle). Template sources are
// never embedded: the pages show the rendered-template *file list* (targets)
// and link to the source on GitHub.

import 'literals.dart';
import 'registry_scan.dart';
import 'render_common.dart';
import 'starter_scan.dart';

/// Renders `lib/generated/docs_starters.dart`: the starter catalog.
String renderDocsStarters(RegistryScan scan) {
  final StringBuffer out = StringBuffer()
    ..write(
      banner(
        sources: const <String>[
          'dashcn/lib/src/manifests/registry.json',
          'dashcn/lib/src/starters/<id>/starter.json',
          'dashcn/lib/src/starters/<id>/README.md',
        ],
        regenerate: kRegenerateCommand,
        notes: <String>[
          'Every starter and starter file list is derived from the',
          'registry manifest; the Starters pages never hard-code them.',
          'Only rendered-template targets are emitted (never raw `.tmpl`',
          'text); template sources are linked on GitHub from the pages.',
        ],
      ),
    )
    ..writeln()
    ..writeln('/// One starter route: an app path backed by a flow, block or')
    ..writeln('/// starter-owned page.')
    ..writeln('class DocsStarterRoute {')
    ..writeln('  /// Creates a route entry.')
    ..writeln('  const DocsStarterRoute({')
    ..writeln('    required this.path,')
    ..writeln('    required this.title,')
    ..writeln('    required this.kind,')
    ..writeln('    required this.ref,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// App path (`/signin`).')
    ..writeln('  final String path;')
    ..writeln()
    ..writeln('  /// Display title (`Sign in`).')
    ..writeln('  final String title;')
    ..writeln()
    ..writeln('  /// `flow`, `block` or `page`.')
    ..writeln('  final String kind;')
    ..writeln()
    ..writeln('  /// Flow/block id or starter-owned page ref.')
    ..writeln('  final String ref;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// One rendered-template file: registry template + app target.')
    ..writeln('class DocsStarterFile {')
    ..writeln('  /// Creates a file entry.')
    ..writeln(
      '  const DocsStarterFile({required this.template, required this.target});',
    )
    ..writeln()
    ..writeln('  /// Registry-relative template (`starters/saas/…tmpl`).')
    ..writeln('  final String template;')
    ..writeln()
    ..writeln('  /// App-relative target (`lib/app.dart`).')
    ..writeln('  final String target;')
    ..writeln('}')
    ..writeln()
    ..writeln(
      '/// One installable starter, generated from the registry manifest.',
    )
    ..writeln('class DocsStarter {')
    ..writeln('  /// Creates a starter entry.')
    ..writeln('  const DocsStarter({')
    ..writeln('    required this.id,')
    ..writeln('    required this.name,')
    ..writeln('    required this.description,')
    ..writeln('    required this.themePreset,')
    ..writeln('    required this.platforms,')
    ..writeln('    required this.flows,')
    ..writeln('    required this.blocks,')
    ..writeln('    required this.components,')
    ..writeln('    required this.routes,')
    ..writeln('    required this.files,')
    ..writeln('    required this.tags,')
    ..writeln('    required this.install,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Registry id / route segment (`/docs/starters/<id>`).')
    ..writeln('  final String id;')
    ..writeln()
    ..writeln('  /// Display name (`SaaS starter`).')
    ..writeln('  final String name;')
    ..writeln()
    ..writeln('  /// One-line description from the manifest.')
    ..writeln('  final String description;')
    ..writeln()
    ..writeln('  /// Default theme preset id (`neutral`).')
    ..writeln('  final String themePreset;')
    ..writeln()
    ..writeln('  /// Supported platforms, in manifest order.')
    ..writeln('  final List<String> platforms;')
    ..writeln()
    ..writeln('  /// Flow ids the starter composes.')
    ..writeln('  final List<String> flows;')
    ..writeln()
    ..writeln('  /// Block ids the starter composes.')
    ..writeln('  final List<String> blocks;')
    ..writeln()
    ..writeln('  /// Component ids the starter composes.')
    ..writeln('  final List<String> components;')
    ..writeln()
    ..writeln('  /// App routes, in manifest order.')
    ..writeln('  final List<DocsStarterRoute> routes;')
    ..writeln()
    ..writeln('  /// Rendered-template files, in manifest order.')
    ..writeln('  final List<DocsStarterFile> files;')
    ..writeln()
    ..writeln('  /// Manifest tags, sorted.')
    ..writeln('  final List<String> tags;')
    ..writeln()
    ..writeln('  /// `dashcn create <id> my_app` from the manifest.')
    ..writeln('  final String install;')
    ..writeln('}');
  out
    ..writeln()
    ..writeln(
      '/// All ${scan.starters.length} installable starters, ordered by id.',
    )
    ..writeln('const List<DocsStarter> kStarters = <DocsStarter>[');
  for (final StarterFacts starter in scan.starters) {
    out.writeln('  ${_starterLiteral(starter)},');
  }
  out.writeln('];');
  return out.toString();
}

String _starterLiteral(StarterFacts starter) {
  return callExpr('DocsStarter', <String>[
    'id: ${dartString(starter.id)}',
    'name: ${dartString(starter.name)}',
    'description: ${dartStringSmart(starter.description)}',
    'themePreset: ${dartString(starter.themePreset)}',
    'platforms: ${stringList(starter.platforms, indent: '    ', appended: 2)}',
    'flows: ${stringList(starter.flows, indent: '    ', appended: 2)}',
    'blocks: ${stringList(starter.blocks, indent: '    ', appended: 2)}',
    'components: ${stringList(starter.components, indent: '    ', appended: 2)}',
    'routes: ${_routesLiteral(starter.routes)}',
    'files: ${_filesLiteral(starter.files)}',
    'tags: ${stringList(starter.tags, indent: '    ', appended: 2)}',
    'install: ${dartString(starter.install)}',
  ], indent: '  ');
}

String _routesLiteral(List<StarterRouteFacts> routes) {
  if (routes.isEmpty) {
    return 'const <DocsStarterRoute>[]';
  }
  final StringBuffer out = StringBuffer()..writeln('<DocsStarterRoute>[');
  for (final StarterRouteFacts route in routes) {
    out.writeln(
      '      ${callExpr('DocsStarterRoute', <String>['path: ${dartString(route.path)}', 'title: ${dartString(route.title)}', 'kind: ${dartString(route.kind)}', 'ref: ${dartString(route.ref)}'], indent: '      ')},',
    );
  }
  out.write('    ]');
  return out.toString();
}

String _filesLiteral(List<StarterFileFacts> files) {
  if (files.isEmpty) {
    return 'const <DocsStarterFile>[]';
  }
  final StringBuffer out = StringBuffer()..writeln('<DocsStarterFile>[');
  for (final StarterFileFacts file in files) {
    out.writeln(
      '      ${callExpr('DocsStarterFile', <String>['template: ${dartString(file.template)}', 'target: ${dartString(file.target)}'], indent: '      ')},',
    );
  }
  out.write('    ]');
  return out.toString();
}
