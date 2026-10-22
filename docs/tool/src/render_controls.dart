// Renderer for `docs_controls.dart`: per-component playground control specs.
//
// The generated file declares the `ControlKind`/`ControlSpec`/
// `ComponentControls` model inline (like `docs_api.dart` declares its model)
// plus `kControlSpecs` keyed by component id. The playground library
// (`lib/playground/`) reads this file; nothing hand-written duplicates it.

import 'controls_build.dart';
import 'literals.dart';
import 'registry_scan.dart';
import 'render_common.dart';

/// Renders `lib/generated/docs_controls.dart`.
String renderDocsControls(DocsModel model) {
  final Map<String, ComponentControlsFacts> specs = buildControls(
    model.scan,
    model.api,
  );
  final StringBuffer out = StringBuffer()
    ..write(
      banner(
        sources: const <String>[
          'dashcn/lib/src/manifests/registry.json',
          'dashcn/lib/src/components/<id>/<entry>.dart',
          'dashcn/lib/src/components/<id>/meta.json',
        ],
        regenerate: kRegenerateCommand,
        notes: <String>[
          'Control specs are derived from the constructor API extraction:',
          'bool -> toggle, kit enum -> select, String -> text, int/double',
          '-> slider, Color -> theme-token picker, text-like Widget slots ->',
          'text, onPressed/onLongPress -> one shared `enabled` toggle.',
          'Text without a literal default synthesizes one (the display',
          'name, a typing prompt, or a short sentence) so previews never',
          'open empty.',
          'Infrastructure params (key, context, controllers, theme/style)',
          'are skipped; everything else is read-only with a reason.',
          'Synthetic playground-only controls (hasIcon/iconPosition for',
          'leading/trailing slots, fullWidth for button) are injected by',
          'the generator; the builder renders them and the emitter writes',
          'them as leading/trailing Icon and a SizedBox wrapper.',
          'Per-component `playground: {exclude, ranges, defaults, labels}`',
          'overrides live in the component meta.json (see the kit registry',
          'README). Enum values resolve by scanning lib/src/**.',
        ],
      ),
    )
    ..writeln()
    ..writeln('/// The editable kind of one playground control.')
    ..writeln('enum ControlKind {')
    ..writeln('  /// On/off switch (`bool`).')
    ..writeln('  toggle,')
    ..writeln()
    ..writeln('  /// One-of-many (`enum`, options carry the value names).')
    ..writeln('  select,')
    ..writeln()
    ..writeln('  /// Free text (`String`, or a text-like `Widget` slot).')
    ..writeln('  text,')
    ..writeln()
    ..writeln('  /// Bounded number (`int`/`double`).')
    ..writeln('  slider,')
    ..writeln()
    ..writeln('  /// Theme colour (`Color`, options carry token names).')
    ..writeln('  colorToken,')
    ..writeln()
    ..writeln('  /// Shared press toggle (null vs no-op callbacks).')
    ..writeln('  enabled,')
    ..writeln()
    ..writeln('  /// Shown but not editable (`readOnlyReason` says why).')
    ..writeln('  readOnly,')
    ..writeln('}')
    ..writeln()
    ..writeln('/// One playground control of one component.')
    ..writeln('class ControlSpec {')
    ..writeln('  /// Creates a control spec.')
    ..writeln('  const ControlSpec({')
    ..writeln('    required this.name,')
    ..writeln('    required this.label,')
    ..writeln('    required this.kind,')
    ..writeln('    required this.type,')
    ..writeln('    required this.isRequired,')
    ..writeln('    this.defaultValue,')
    ..writeln('    this.options = const <String>[],')
    ..writeln('    this.min,')
    ..writeln('    this.max,')
    ..writeln('    this.step,')
    ..writeln('    this.isInt = false,')
    ..writeln('    this.isBuilder = false,')
    ..writeln('    this.readOnlyReason,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Parameter name (`variant`, or `enabled`).')
    ..writeln('  final String name;')
    ..writeln()
    ..writeln('  /// Human label (`Variant`).')
    ..writeln('  final String label;')
    ..writeln()
    ..writeln('  /// Editable kind.')
    ..writeln('  final ControlKind kind;')
    ..writeln()
    ..writeln('  /// Declared type (`ButtonVariant`).')
    ..writeln('  final String type;')
    ..writeln()
    ..writeln('  /// Whether the parameter is required (always emitted).')
    ..writeln('  final bool isRequired;')
    ..writeln()
    ..writeln('  /// Default in Dart-source shape, or null when unknown.')
    ..writeln('  final String? defaultValue;')
    ..writeln()
    ..writeln('  /// Select values or theme token names.')
    ..writeln('  final List<String> options;')
    ..writeln()
    ..writeln('  /// Slider lower bound (null unless `slider`).')
    ..writeln('  final double? min;')
    ..writeln()
    ..writeln('  /// Slider upper bound.')
    ..writeln('  final double? max;')
    ..writeln()
    ..writeln('  /// Slider step, or null for the kind default.')
    ..writeln('  final double? step;')
    ..writeln()
    ..writeln('  /// Whether the slider value is an int.')
    ..writeln('  final bool isInt;')
    ..writeln()
    ..writeln('  /// Whether a text control renders inside a builder closure.')
    ..writeln('  final bool isBuilder;')
    ..writeln()
    ..writeln('  /// Why a read-only row cannot be edited.')
    ..writeln('  final String? readOnlyReason;')
    ..writeln()
    ..writeln('  /// Whether the panel can edit this control.')
    ..writeln('  bool get isEditable => kind != ControlKind.readOnly;')
    ..writeln('}')
    ..writeln()
    ..writeln("/// One component's playground controls.")
    ..writeln('class ComponentControls {')
    ..writeln('  /// Creates the controls.')
    ..writeln('  const ComponentControls({')
    ..writeln('    required this.componentId,')
    ..writeln('    required this.symbol,')
    ..writeln('    required this.import,')
    ..writeln('    required this.isConst,')
    ..writeln('    this.controls = const <ControlSpec>[],')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Registry id.')
    ..writeln('  final String componentId;')
    ..writeln()
    ..writeln('  /// Primary class/function name.')
    ..writeln('  final String symbol;')
    ..writeln()
    ..writeln('  /// User-facing import.')
    ..writeln('  final String import;')
    ..writeln()
    ..writeln('  /// Whether the primary constructor is const.')
    ..writeln('  final bool isConst;')
    ..writeln()
    ..writeln('  /// Controls in API order.')
    ..writeln('  final List<ControlSpec> controls;')
    ..writeln()
    ..writeln('  /// Only the editable controls.')
    ..writeln('  List<ControlSpec> get editable =>')
    ..writeln('      <ControlSpec>[for (final ControlSpec c in controls)')
    ..writeln('        if (c.isEditable) c];')
    ..writeln('}')
    ..writeln();
  out
    ..writeln('/// Playground controls keyed by component id.')
    ..writeln(
      'const Map<String, ComponentControls> kControlSpecs = '
      '<String, ComponentControls>{',
    );
  for (final ComponentFacts component in model.scan.components) {
    out.writeln(
      '  ${dartString(component.id)}: '
      '${_componentLiteral(specs[component.id]!)},',
    );
  }
  out.writeln('};');
  return out.toString();
}

String _componentLiteral(ComponentControlsFacts facts) {
  return callExpr('ComponentControls', <String>[
    'componentId: ${dartString(facts.componentId)}',
    'symbol: ${dartString(facts.symbol)}',
    'import: ${dartString(facts.import)}',
    'isConst: ${facts.isConst}',
    'controls: ${listExpr('<ControlSpec>', <String>[for (final ControlFacts c in facts.controls) _controlLiteral(c)], indent: '    ', appended: 1)}',
  ], indent: '  ');
}

String _controlLiteral(ControlFacts control) {
  return callExpr('ControlSpec', <String>[
    'name: ${dartString(control.name)}',
    'label: ${dartString(control.label)}',
    'kind: ControlKind.${control.kind}',
    'type: ${dartString(control.type)}',
    'isRequired: ${control.isRequired}',
    if (control.defaultValue != null)
      'defaultValue: ${dartString(control.defaultValue!)}',
    if (control.options.isNotEmpty)
      'options: ${stringList(control.options, indent: '      ', appended: 1)}',
    if (control.min != null) 'min: ${control.min}',
    if (control.max != null) 'max: ${control.max}',
    if (control.step != null) 'step: ${control.step}',
    if (control.isInt) 'isInt: true',
    if (control.isBuilder) 'isBuilder: true',
    if (control.readOnlyReason != null)
      'readOnlyReason: ${dartString(control.readOnlyReason!)}',
  ], indent: '      ');
}
