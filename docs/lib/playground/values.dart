// Playground values: the typed control state behind the live props panel.
//
// A [PlaygroundValues] holds one entry per *editable* control of a
// [ComponentControls] spec, seeded from the spec defaults. Values serialize
// to URL query parameters (`p.<name>=...`, only non-default entries) so a
// configured preview is shareable; [fromQuery] restores them.

import '../generated/docs_controls.dart';

/// Typed control state for one component's playground.
class PlaygroundValues {
  /// Creates values, optionally pre-filled (missing keys read as null).
  PlaygroundValues([Map<String, Object?>? initial])
    : _values = <String, Object?>{...?initial};

  /// Seeds every editable control from the spec defaults.
  factory PlaygroundValues.defaults(ComponentControls spec) {
    final PlaygroundValues values = PlaygroundValues();
    values._spec = spec;
    for (final ControlSpec control in spec.controls) {
      if (control.isEditable) {
        values._values[control.name] = _decodeDefault(control);
      }
    }
    return values;
  }

  /// Restores values from URL query parameters (`p.<name>` entries).
  ///
  /// Unknown keys are ignored; unparsable values fall back to the default.
  factory PlaygroundValues.fromQuery(
    ComponentControls spec,
    Map<String, String> query,
  ) {
    final PlaygroundValues values = PlaygroundValues.defaults(spec);
    for (final ControlSpec control in spec.controls) {
      if (!control.isEditable) {
        continue;
      }
      final String? raw = query['p.${control.name}'];
      if (raw == null) {
        continue;
      }
      values._values[control.name] = _decodeQuery(control, raw);
    }
    return values;
  }

  final Map<String, Object?> _values;

  /// The spec these values were seeded from (null for hand-built values).
  ComponentControls? _spec;

  /// Raw value (null when unset).
  Object? valueOf(String name) => _values[name];

  /// Sets one control's value.
  void set(String name, Object? value) => _values[name] = value;

  /// Sets several controls at once (test companions, query seeds).
  void addAll(Map<String, Object?> entries) => _values.addAll(entries);

  /// Resets every editable control to the spec defaults.
  void reset(ComponentControls spec) {
    _spec = spec;
    _values
      ..clear()
      ..addAll(PlaygroundValues.defaults(spec)._values);
  }

  /// Nullable bool (`toggle`, `enabled`).
  bool? getBool(String name) => _values[name] as bool?;

  /// Non-null bool with [fallback].
  bool getBoolOr(String name, bool fallback) => getBool(name) ?? fallback;

  /// Nullable string (`text`).
  String? getString(String name) => _values[name] as String?;

  /// Non-null string with [fallback].
  String getStringOr(String name, String fallback) =>
      getString(name) ?? fallback;

  /// Decoded text default of [name] from the seeding spec, or null when the
  /// control has no literal text default (or the values are hand-built).
  String? defaultText(String name) {
    final ComponentControls? spec = _spec;
    if (spec == null) {
      return null;
    }
    for (final ControlSpec control in spec.controls) {
      if (control.name == name && control.kind == ControlKind.text) {
        final String? source = control.defaultValue;
        if (source == null || source == 'null') {
          return null;
        }
        return _unquote(source);
      }
    }
    return null;
  }

  /// Text value with spec-default fallback; null only when both are missing.
  String? textOrNull(String name) => getString(name) ?? defaultText(name);

  /// Non-null text with spec-default fallback (`''` only when the spec
  /// carries no default, e.g. hand-built values in tests).
  String textOr(String name) => textOrNull(name) ?? '';

  /// Nullable int (`slider` with [ControlSpec.isInt]).
  int? getInt(String name) {
    final Object? value = _values[name];
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.round();
    }
    return null;
  }

  /// Nullable double (`slider`).
  double? getDouble(String name) {
    final Object? value = _values[name];
    if (value is num) {
      return value.toDouble();
    }
    return null;
  }

  /// Nullable enum value name (`select`).
  String? getEnum(String name) => _values[name] as String?;

  /// Nullable theme token name (`colorToken`).
  String? getToken(String name) => _values[name] as String?;

  /// Whether [name] currently holds its spec default.
  bool isDefault(ComponentControls spec, String name) {
    final ControlSpec control = spec.controls.firstWhere(
      (ControlSpec c) => c.name == name,
    );
    return _values[name] == _decodeDefault(control);
  }

  /// URL query parameters (`p.<name>`), only for non-default entries.
  Map<String, String> toQuery(ComponentControls spec) {
    final Map<String, String> out = <String, String>{};
    for (final ControlSpec control in spec.controls) {
      if (!control.isEditable || isDefault(spec, control.name)) {
        continue;
      }
      final String? encoded = _encodeQuery(control, _values[control.name]);
      if (encoded != null) {
        out['p.${control.name}'] = encoded;
      }
    }
    return out;
  }

  @override
  String toString() => 'PlaygroundValues($_values)';
}

/// Decodes a spec `defaultValue` source into a typed value.
///
/// Unknown or non-literal defaults fall back to the kind default; required
/// params without a literal default get a zero value from the spec (first
/// option, empty text, range minimum) so builders and code emission never
/// see an invalid null.
Object? _decodeDefault(ControlSpec control) {
  final Object? literal = _decodeLiteral(control);
  if (literal != null) {
    return literal;
  }
  if (!control.isRequired) {
    return _defaultForKind(control);
  }
  return switch (control.kind) {
    ControlKind.toggle => false,
    ControlKind.enabled => true,
    ControlKind.select => control.options.firstOrNull,
    ControlKind.text => '',
    ControlKind.slider =>
      control.isInt ? control.min?.round() ?? 0 : control.min ?? 0.0,
    ControlKind.colorToken => null,
    ControlKind.readOnly => null,
  };
}

/// Decodes a literal `defaultValue` source, or null when absent/non-literal.
Object? _decodeLiteral(ControlSpec control) {
  final String? source = control.defaultValue;
  if (source == null || source == 'null') {
    return null;
  }
  switch (control.kind) {
    case ControlKind.toggle:
    case ControlKind.enabled:
      if (source == 'true') {
        return true;
      }
      if (source == 'false') {
        return false;
      }
      return _defaultForKind(control);
    case ControlKind.select:
      final String name = _stripPrefix(control.type, source);
      return control.options.contains(name) ? name : _defaultForKind(control);
    case ControlKind.text:
      return _unquote(source) ?? _defaultForKind(control);
    case ControlKind.slider:
      final num? number = num.tryParse(source);
      if (number == null) {
        return _defaultForKind(control);
      }
      return control.isInt ? number.round() : number.toDouble();
    case ControlKind.colorToken:
      return control.options.contains(source) ? source : null;
    case ControlKind.readOnly:
      return null;
  }
}

/// Kind fallback when no literal default exists: `enabled` plays on.
Object? _defaultForKind(ControlSpec control) {
  return control.kind == ControlKind.enabled ? true : null;
}

/// Decodes one URL query value with the same rules as the defaults.
Object? _decodeQuery(ControlSpec control, String raw) {
  switch (control.kind) {
    case ControlKind.toggle:
    case ControlKind.enabled:
      if (raw == 'true') {
        return true;
      }
      if (raw == 'false') {
        return false;
      }
      if (raw == 'null') {
        return control.kind == ControlKind.enabled ? true : null;
      }
      return _decodeDefault(control);
    case ControlKind.select:
      return control.options.contains(raw) ? raw : _decodeDefault(control);
    case ControlKind.text:
      return raw;
    case ControlKind.slider:
      final num? number = num.tryParse(raw);
      if (number == null) {
        return _decodeDefault(control);
      }
      return control.isInt ? number.round() : number.toDouble();
    case ControlKind.colorToken:
      return control.options.contains(raw) ? raw : _decodeDefault(control);
    case ControlKind.readOnly:
      return null;
  }
}

/// Encodes one non-default value for the URL query.
String? _encodeQuery(ControlSpec control, Object? value) {
  if (value == null) {
    return 'null';
  }
  switch (control.kind) {
    case ControlKind.toggle:
    case ControlKind.enabled:
      return (value as bool) ? 'true' : 'false';
    case ControlKind.select:
    case ControlKind.text:
    case ControlKind.colorToken:
      return '$value';
    case ControlKind.slider:
      return value is double ? _formatDouble(value) : '$value';
    case ControlKind.readOnly:
      return null;
  }
}

/// `Type.name` -> `name`; bare names pass through.
String _stripPrefix(String type, String source) {
  final String base = type.endsWith('?')
      ? type.substring(0, type.length - 1)
      : type;
  if (source.startsWith('$base.')) {
    return source.substring(base.length + 1);
  }
  return source;
}

/// The enum type without nullability, for qualified emission.
String enumBaseType(String type) =>
    type.endsWith('?') ? type.substring(0, type.length - 1) : type;

/// Unquotes a single-quoted source literal, or null.
String? _unquote(String source) {
  if (source.length >= 2 && source.startsWith("'") && source.endsWith("'")) {
    return source
        .substring(1, source.length - 1)
        .replaceAll(r"\'", "'")
        .replaceAll(r'\n', '\n')
        .replaceAll(r'\\', r'\');
  }
  return null;
}

/// Doubles without exponent noise (`2.0`, never `2`).
String _formatDouble(double value) {
  final String text = value.toString();
  return text.contains('.') || text.contains('e') ? text : '$text.0';
}
