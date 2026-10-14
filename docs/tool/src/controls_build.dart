// Derives playground `ControlSpec` rows from the extracted constructor API.
//
// Mapping (documented here and in the kit's `dashcn/tool/registry/README.md`
// `playground` section):
//  * `bool`/`bool?` -> toggle (default from the literal, else null).
//  * kit enum (resolved by `scanEnumValues`) -> select with the enum values.
//  * `String`/`String?` -> text (stored quoted; a missing literal default
//    synthesizes one — the display name, a typing prompt, or a short
//    sentence — so previews never open empty).
//  * `int`/`double` (nullable or not) -> slider; bounds come from the
//    `playground.ranges` override, else the name heuristics in `rangeFor`,
//    else int 0..100 step 1 / double 0..10 step 0.1.
//  * `Color`/`Color?` -> token picker over the theme token names.
//  * `Widget`/`Widget?` named child/label/title/content/placeholder/hint/
//    text/separator/message -> text (the builder wraps it in `Text`;
//    like `String`, a missing literal default synthesizes one).
//  * `WidgetBuilder` named tooltip -> text (the builder wraps it in a
//    closure returning `Text`).
//  * `VoidCallback?` named onPressed/onLongPress -> one shared `enabled`
//    toggle per component (null vs no-op); a bool param named exactly
//    `enabled` folds into it.
//  * infrastructure (key, BuildContext, FocusNode, controllers, theme and
//    style objects) -> skipped silently.
//  * everything else -> read-only with a reason (widget slot, callback,
//    complex type, unresolved enum, builder-owned).
//
// Output order is the API extraction order (required first), so the file is
// deterministic. `playground.exclude` drops params entirely; `defaults` and
// `labels` override the extracted default/label.

import 'dart:io';

import 'api_model.dart';
import 'controls_decode.dart';
import 'controls_scan.dart';
import 'literals.dart';
import 'registry_scan.dart';

/// One derived control row (tool-side shape of the generated `ControlSpec`).
class ControlFacts {
  /// Creates the row.
  const ControlFacts({
    required this.name,
    required this.label,
    required this.kind,
    required this.type,
    required this.isRequired,
    this.defaultValue,
    this.options = const <String>[],
    this.min,
    this.max,
    this.step,
    this.isInt = false,
    this.isBuilder = false,
    this.readOnlyReason,
  });

  /// Parameter name (`variant`, or `enabled` for the shared press toggle).
  final String name;

  /// Human label (`Variant`).
  final String label;

  /// `toggle`, `select`, `text`, `slider`, `colorToken`, `enabled`,
  /// `readOnly`.
  final String kind;

  /// Declared type (`ButtonVariant`), or the synthetic type for `enabled`.
  final String type;

  /// Whether the parameter is required (always emitted, even by default).
  final bool isRequired;

  /// Default in Dart-source shape, or null when unknown/non-literal.
  final String? defaultValue;

  /// Select values or theme token names.
  final List<String> options;

  /// Slider lower bound (null unless [kind] is `slider`).
  final double? min;

  /// Slider upper bound.
  final double? max;

  /// Slider step, or null for the kind default.
  final double? step;

  /// Whether the slider value is an int.
  final bool isInt;

  /// Whether a text control renders inside a builder closure
  /// (`tooltip: (context) => Text(...)`).
  final bool isBuilder;

  /// Why a read-only row cannot be edited (null unless `readOnly`).
  final String? readOnlyReason;
}

/// One component's derived controls (tool-side shape of `ComponentControls`).
class ComponentControlsFacts {
  /// Creates the facts.
  const ComponentControlsFacts({
    required this.componentId,
    required this.symbol,
    required this.import,
    required this.isConst,
    this.controls = const <ControlFacts>[],
  });

  /// Registry id.
  final String componentId;

  /// Primary class/function name (`Button`, `showDialog`).
  final String symbol;

  /// User-facing import (`package:dashcn/components/<id>.dart`).
  final String import;

  /// Whether the primary constructor is const.
  final bool isConst;

  /// Controls in API order.
  final List<ControlFacts> controls;
}

/// Derives every component's controls from the API extraction.
Map<String, ComponentControlsFacts> buildControls(
  RegistryScan scan,
  Map<String, ApiFacts> api,
) {
  final Map<String, List<String>> enums = scanEnumValues(scan.root);
  final List<String> tokens = <String>[
    for (final ThemeTokenFacts token in scan.themeTokens) token.name,
  ];
  final Map<String, ComponentControlsFacts> out =
      <String, ComponentControlsFacts>{};
  for (final ComponentFacts component in scan.components) {
    final ApiFacts facts = api[component.id]!;
    final PlaygroundOverrides overrides = readPlaygroundOverrides(
      scan.root,
      component.id,
    );
    out[component.id] = _componentControls(
      scan.root,
      component,
      facts,
      enums,
      tokens,
      overrides,
    );
  }
  return out;
}

ComponentControlsFacts _componentControls(
  String registryRoot,
  ComponentFacts component,
  ApiFacts facts,
  Map<String, List<String>> enums,
  List<String> tokens,
  PlaygroundOverrides overrides,
) {
  final List<ApiParamFacts> params = <ApiParamFacts>[
    ...facts.params,
    for (final ApiMemberFacts member in facts.members) ...member.params,
  ];
  final bool pressToggle = params.any(
    (ApiParamFacts p) =>
        (p.name == 'onPressed' || p.name == 'onLongPress') &&
        _base(p.type) == 'VoidCallback',
  );
  final List<ControlFacts> controls = <ControlFacts>[];
  if (pressToggle) {
    controls.add(
      ControlFacts(
        name: 'enabled',
        label: overrides.labels['enabled'] ?? 'Enabled',
        kind: 'enabled',
        type: 'bool',
        // Always emitted (`onPressed: () {}` vs omitted): the playground
        // preview is interactive by default, and the snippet must match.
        isRequired: true,
        defaultValue: overrides.defaults['enabled'] ?? 'true',
      ),
    );
  }
  for (final ApiParamFacts param in params) {
    if (overrides.exclude.contains(param.name)) {
      continue;
    }
    if (pressToggle &&
        (param.name == 'onPressed' ||
            param.name == 'onLongPress' ||
            param.name == 'enabled')) {
      continue;
    }
    final ControlFacts? row = _controlFor(
      param,
      enums,
      tokens,
      overrides,
      component.name,
    );
    if (row != null) {
      controls.add(row);
    }
  }
  bool isConst = false;
  if (facts.symbol.isNotEmpty && facts.members.isEmpty) {
    final File entry = File('$registryRoot/${component.entry}');
    if (entry.existsSync()) {
      isConst = isPrimaryConstructorConst(
        entry.readAsStringSync(),
        facts.symbol,
      );
    }
  }
  return ComponentControlsFacts(
    componentId: component.id,
    symbol: facts.symbol,
    import: 'package:dashcn/components/${component.id}.dart',
    isConst: isConst,
    controls: controls,
  );
}

/// The declared type without nullability (`VoidCallback?` -> `VoidCallback`).
String _base(String type) =>
    type.endsWith('?') ? type.substring(0, type.length - 1) : type;

/// The declared type without nullability or type arguments
/// (`RadioSetController<T>` -> `RadioSetController`).
String _rawBase(String type) {
  final String base = _base(type);
  final int generics = base.indexOf('<');
  return generics < 0 ? base : base.substring(0, generics);
}

/// Derives one row, or null for silently skipped infrastructure params.
ControlFacts? _controlFor(
  ApiParamFacts param,
  Map<String, List<String>> enums,
  List<String> tokens,
  PlaygroundOverrides overrides,
  String displayName,
) {
  final String base = _base(param.type);
  final String raw = _rawBase(param.type);
  final String? overrideDefault = overrides.defaults[param.name];
  final String label =
      overrides.labels[param.name] ?? humanizeLabel(param.name);

  // Infrastructure: never a control.
  if (param.name == 'key' ||
      base == 'BuildContext' ||
      base == 'FocusNode' ||
      base == 'UndoHistoryController' ||
      base == 'WidgetStatesController' ||
      raw.endsWith('Controller') ||
      param.name == 'theme' ||
      raw.endsWith('Theme') ||
      raw.endsWith('Style')) {
    return null;
  }
  String? decodedDefault(String? source) =>
      overrideDefault ?? decodeDefault(param.type, source);

  if (base == 'bool') {
    return ControlFacts(
      name: param.name,
      label: label,
      kind: 'toggle',
      type: param.type,
      isRequired: param.isRequired,
      defaultValue: decodedDefault(param.defaultValue),
    );
  }
  if (enums.containsKey(base)) {
    return ControlFacts(
      name: param.name,
      label: label,
      kind: 'select',
      type: param.type,
      isRequired: param.isRequired,
      defaultValue: decodedDefault(param.defaultValue),
      options: enums[base]!,
    );
  }
  if (base == 'String') {
    return ControlFacts(
      name: param.name,
      label: label,
      kind: 'text',
      type: param.type,
      isRequired: param.isRequired,
      defaultValue: _textDefault(param, overrides, displayName),
    );
  }
  if (base == 'int' || base == 'double') {
    final bool isInt = base == 'int';
    final SliderRange range = overrides.ranges[param.name] != null
        ? SliderRange(
            min: overrides.ranges[param.name]!.min,
            max: overrides.ranges[param.name]!.max,
            step: overrides.ranges[param.name]!.step,
          )
        : rangeFor(param.name, isInt);
    return ControlFacts(
      name: param.name,
      label: label,
      kind: 'slider',
      type: param.type,
      isRequired: param.isRequired,
      defaultValue: decodedDefault(param.defaultValue),
      min: range.min,
      max: range.max,
      step: range.step,
      isInt: isInt,
    );
  }
  if (base == 'Color') {
    return ControlFacts(
      name: param.name,
      label: label,
      kind: 'colorToken',
      type: param.type,
      isRequired: param.isRequired,
      defaultValue: decodedDefault(param.defaultValue),
      options: tokens,
    );
  }
  if ((base == 'Widget' && _isTextSlot(param.name)) ||
      (base == 'WidgetBuilder' && param.name == 'tooltip')) {
    return ControlFacts(
      name: param.name,
      label: label,
      kind: 'text',
      type: param.type,
      isRequired: param.isRequired,
      defaultValue: _textDefault(param, overrides, displayName),
      isBuilder: base == 'WidgetBuilder',
    );
  }
  return ControlFacts(
    name: param.name,
    label: label,
    kind: 'readOnly',
    type: param.type,
    isRequired: param.isRequired,
    defaultValue: param.defaultValue,
    readOnlyReason: _readOnlyReason(base, param.name),
  );
}

/// Widget slots that read naturally as a line of text.
bool _isTextSlot(String name) => const <String>{
  'child',
  'label',
  'title',
  'content',
  'placeholder',
  'hint',
  'text',
  'separator',
  'message',
}.contains(name);

/// Display-name params: visible text that demos the component itself.
const Set<String> _displayNameParams = <String>{
  'child',
  'label',
  'title',
  'text',
  'content',
  'message',
  'initials',
  'actionLabel',
  'tooltip',
  'data',
  'initialValue',
};

/// Derives a `text` default in Dart-source (quoted) shape.
///
/// Literal text first: an explicit `meta.json` override (literal text or
/// quoted source), then the extracted constructor default (`decodeDefault`
/// unquotes `String` literals, so they are quoted again for storage).
/// Otherwise a display default is synthesized — the component's registry
/// display name for demo text, a typing prompt for placeholders, a short
/// sentence for descriptions — so the playground never opens empty. Stored
/// quoted so `PlaygroundValues` round-trips it; technical text
/// (barrier/semantic labels, separators, routes) keeps no default.
String? _textDefault(
  ApiParamFacts param,
  PlaygroundOverrides overrides,
  String displayName,
) {
  final String? override = overrides.defaults[param.name];
  if (override != null) {
    if (override == 'null') {
      return null;
    }
    return _isSingleQuoted(override) ? override : dartString(override);
  }
  final String? decoded = decodeDefault(param.type, param.defaultValue);
  if (decoded != null) {
    return _base(param.type) == 'String' ? dartString(decoded) : decoded;
  }
  if (_displayNameParams.contains(param.name)) {
    return dartString(displayName);
  }
  if (param.name == 'placeholder' ||
      param.name == 'hint' ||
      param.name == 'hintText') {
    return dartString('Type here…');
  }
  if (param.name == 'description') {
    return dartString('A short description.');
  }
  return null;
}

/// Whether [source] is already a single-quoted Dart string literal.
bool _isSingleQuoted(String source) =>
    source.length >= 2 && source.startsWith("'") && source.endsWith("'");

String _readOnlyReason(String base, String name) {
  if (base.startsWith('ValueChanged') ||
      base.startsWith('ValueSetter') ||
      base == 'VoidCallback' ||
      base.endsWith('Callback') ||
      base.endsWith('Builder') ||
      base == 'WidgetBuilder') {
    return 'callback';
  }
  if (base == 'Widget' || base.startsWith('List<')) {
    return 'widget slot';
  }
  if (base == 'T' || base.contains('<')) {
    return 'generic';
  }
  if (base == 'DateTime' ||
      base == 'Duration' ||
      base.startsWith('EdgeInsets') ||
      base.startsWith('BorderRadius') ||
      base.startsWith('Alignment') ||
      base == 'TextStyle' ||
      base == 'BoxDecoration' ||
      base == 'ThemedColor' ||
      base == 'ColorRef') {
    return 'complex type';
  }
  if (name.startsWith('_')) {
    return 'builder-owned';
  }
  return 'unresolved type';
}
