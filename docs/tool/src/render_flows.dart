// Renderers for the flow-shaped generated files (P9-3b):
// `docs_flows.dart` (the catalog, main bundle) and `flow_sources.dart`
// (every flow file's source + highlight classes, loaded with the deferred
// Flows pages so the landing route never ships them).

import 'dart_highlight.dart';
import 'literals.dart';
import 'registry_scan.dart';
import 'render_common.dart';

/// The install-root-relative Dart files of [flow], entry first.
List<String> _flowFiles(RegistryScan scan, FlowFacts flow) => <String>[
  for (final String file in flow.files) '${scan.installRoot}/$file',
];

/// Renders `lib/generated/docs_flows.dart`: the flow catalog and nothing
/// else — no sources.
String renderDocsFlows(DocsModel model) {
  final RegistryScan scan = model.scan;
  final List<String> literals = <String>[
    for (final FlowFacts flow in scan.flows)
      _flowLiteral(scan, flow, model.flowClasses[flow.id] ?? flow.id),
  ];
  final StringBuffer out = StringBuffer()
    ..write(
      banner(
        sources: const <String>[
          'dashcn/lib/src/manifests/registry.json',
          'dashcn/lib/src/flows/<id>/meta.json',
        ],
        regenerate: kRegenerateCommand,
        notes: <String>[
          'Every flow and flow file list is derived from the',
          'registry manifest; the Flows pages never hard-code flow facts.',
          'Flow sources (code view) live in lib/flows/flow_sources.dart,',
          'loaded with the deferred Flows pages.',
        ],
      ),
    )
    ..writeln()
    ..writeln('/// One installable flow, generated from the registry manifest.')
    ..writeln('class DocsFlow {')
    ..writeln('  /// Creates a flow entry.')
    ..writeln('  const DocsFlow({')
    ..writeln('    required this.id,')
    ..writeln('    required this.name,')
    ..writeln('    required this.description,')
    ..writeln('    required this.viewport,')
    ..writeln('    required this.screens,')
    ..writeln('    required this.install,')
    ..writeln('    required this.import,')
    ..writeln('    required this.entryClass,')
    ..writeln('    required this.files,')
    ..writeln('    required this.deps,')
    ..writeln('    required this.blockDeps,')
    ..writeln('    required this.tags,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Registry id / route segment (`/docs/flows/<id>`).')
    ..writeln('  final String id;')
    ..writeln()
    ..writeln('  /// Display name (`Auth 01`).')
    ..writeln('  final String name;')
    ..writeln()
    ..writeln('  /// One-line description from the manifest.')
    ..writeln('  final String description;')
    ..writeln()
    ..writeln('  /// Viewport hint from `meta.json` (`desktop`, `mobile`).')
    ..writeln('  final String viewport;')
    ..writeln()
    ..writeln('  /// Display screen names from `meta.json` (`Sign in`, …).')
    ..writeln('  final List<String> screens;')
    ..writeln()
    ..writeln('  /// `dashcn add flow:<id>` from the manifest.')
    ..writeln('  final String install;')
    ..writeln()
    ..writeln('  /// Corrected import line for the installed layout.')
    ..writeln('  final String import;')
    ..writeln()
    ..writeln('  /// Entry widget class from the flow entry file.')
    ..writeln('  final String entryClass;')
    ..writeln()
    ..writeln('  /// Install-root-relative Dart files, entry first.')
    ..writeln('  final List<String> files;')
    ..writeln()
    ..writeln('  /// Component ids the flow composes (manifest `deps`).')
    ..writeln('  final List<String> deps;')
    ..writeln()
    ..writeln('  /// Block ids the flow composes (manifest `deps.blocks`).')
    ..writeln('  final List<String> blockDeps;')
    ..writeln()
    ..writeln('  /// Manifest tags, sorted.')
    ..writeln('  final List<String> tags;')
    ..writeln()
    ..writeln('  /// Whether the flow targets a phone viewport.')
    ..writeln('  bool get isMobile => viewport == \'mobile\';')
    ..writeln('}');

  out
    ..writeln()
    ..writeln('/// All ${scan.flows.length} installable flows, ordered by id.')
    ..writeln('const List<DocsFlow> kFlows = <DocsFlow>[');
  for (final String literal in literals) {
    out.writeln('  $literal,');
  }
  out.writeln('];');
  return out.toString();
}

String _flowLiteral(RegistryScan scan, FlowFacts flow, String entryClass) {
  return callExpr('DocsFlow', <String>[
    'id: ${dartString(flow.id)}',
    'name: ${dartString(flow.name)}',
    'description: ${dartStringSmart(flow.description)}',
    'viewport: ${dartString(flow.viewport)}',
    'screens: ${stringList(flow.screens, indent: '    ', appended: 2)}',
    'install: ${dartString(flow.install)}',
    'import: ${dartStringSmart(flow.import)}',
    'entryClass: ${dartString(entryClass)}',
    'files: ${stringList(_flowFiles(scan, flow), indent: '    ', appended: 2)}',
    'deps: ${stringList(flow.deps['components'] ?? const <String>[], indent: '    ', appended: 2)}',
    'blockDeps: ${stringList(flow.deps['blocks'] ?? const <String>[], indent: '    ', appended: 2)}',
    'tags: ${stringList(flow.tags, indent: '    ', appended: 2)}',
  ], indent: '  ');
}

/// Renders `lib/flows/flow_sources.dart`: every flow file's verbatim source
/// plus its 4-class highlight map, keyed by flow id.
///
/// Imported by the deferred Flows pages only.
String renderFlowSources(
  RegistryScan scan,
  Map<String, List<FlowFileFacts>> flowSources,
) {
  final StringBuffer out = StringBuffer()
    ..write(
      banner(
        sources: const <String>['dashcn/lib/src/flows/<id>/<file>.dart'],
        regenerate: kRegenerateCommand,
        notes: <String>[
          'The Flows code view: one file per flow, verbatim, with the same',
          '4-class highlight map the README snippets use (`p`/`c`/`k`/`s`,',
          'one class per character). Imported by the deferred Flows pages.',
        ],
      ),
    )
    ..writeln()
    ..writeln()
    ..writeln('/// One flow file: its install-root-relative path and source.')
    ..writeln('class DocsFlowFile {')
    ..writeln('  /// Creates a flow file entry.')
    ..writeln('  const DocsFlowFile({')
    ..writeln('    required this.path,')
    ..writeln('    required this.code,')
    ..writeln('    required this.tokenClasses,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Install-root-relative path (`lib/ui/dashcn/flows/…`).')
    ..writeln('  final String path;')
    ..writeln()
    ..writeln('  /// File source, verbatim.')
    ..writeln('  final String code;')
    ..writeln()
    ..writeln('  /// One highlight class per character of [code].')
    ..writeln('  final String tokenClasses;')
    ..writeln()
    ..writeln('  /// File name without its flow-directory prefix.')
    ..writeln('  String get name => path.split(\'/\').last;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// Flow files keyed by flow id, in manifest `files` order.')
    ..writeln(
      'const Map<String, List<DocsFlowFile>> kFlowFileSources = '
      '<String, List<DocsFlowFile>>{',
    );
  for (final FlowFacts flow in scan.flows) {
    final List<FlowFileFacts> files =
        flowSources[flow.id] ?? const <FlowFileFacts>[];
    out.writeln('  ${dartString(flow.id)}: <DocsFlowFile>[');
    for (final FlowFileFacts file in files) {
      out
        ..writeln('    DocsFlowFile(')
        ..writeln(
          '      path: ${dartString('${scan.installRoot}/${file.path}')},',
        )
        ..writeln('      code: ${dartCodeString(file.code)},')
        ..writeln(
          '      tokenClasses: ${dartString(classifySnippet('dart', file.code))},',
        )
        ..writeln('    ),');
    }
    out.writeln('  ],');
  }
  out.writeln('};');
  return out.toString();
}
