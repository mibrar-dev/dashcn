// Playground code emission: the current values as idiomatic Dart.
//
// [emitCode] renders one component call from its [ComponentControls] spec and
// [PlaygroundValues]: only non-default editable arguments (required params
// without a default are always emitted), enums qualified (`ButtonVariant
// .outline`), strings escaped, `const` when every argument is const, one
// argument per line with trailing commas past 80 columns, and the
// user-facing import on top. `Text`/`Theme` come from `package:flutter
// /widgets.dart` and the dashcn theme, which the docs page already imports.
//
// Synthetic playground-only controls are interpreted, never emitted
// verbatim: `hasIcon` + `iconPosition` become `leading:`/`trailing:` with a
// default icon, `fullWidth` wraps the call in a full-width `SizedBox`, and
// `iconPosition` alone never emits.

import '../generated/docs_controls.dart';
import 'values.dart';

/// Emits the Dart snippet for the current playground values.
String emitCode(ComponentControls spec, PlaygroundValues values) {
  final List<_Arg> args = <_Arg>[];
  for (final ControlSpec control in spec.controls) {
    if (!control.isEditable) {
      continue;
    }
    // Synthetic controls never emit verbatim (see below); `iconPosition`
    // only matters together with `hasIcon`, `fullWidth` wraps the call.
    if (control.name == 'iconPosition' || control.name == 'fullWidth') {
      continue;
    }
    if (control.name == 'hasIcon') {
      final _Arg? iconArg = _renderIconArg(spec, values);
      if (iconArg != null) {
        args.add(iconArg);
      }
      continue;
    }
    // Required params are always emitted (omitting them would not compile);
    // optional params only when they differ from the default.
    if (!control.isRequired && values.isDefault(spec, control.name)) {
      continue;
    }
    final _Arg? arg = _renderArg(control, values);
    if (arg != null) {
      args.add(arg);
    }
  }
  final bool useConst = spec.isConst && args.every((_Arg arg) => arg.isConst);
  final String head = '${useConst ? 'const ' : ''}${spec.symbol}';
  String call = _renderCall(head, args);
  if (_isFullWidth(spec, values)) {
    // Full-width wrapper stays const when the inner call is const
    // (`double.infinity` is a compile-time constant).
    final String inner = call.startsWith('const ')
        ? call.substring('const '.length)
        : call;
    final String wrapped = 'SizedBox(width: double.infinity, child: $inner)';
    call = useConst ? 'const $wrapped' : wrapped;
  }
  return "import '${spec.import}';\n\n$call\n";
}

class _Arg {
  const _Arg(this.source, {required this.isConst});

  final String source;
  final bool isConst;
}

/// Whether the synthetic `fullWidth` toggle is on for this spec/values.
bool _isFullWidth(ComponentControls spec, PlaygroundValues values) {
  final bool hasControl = spec.controls.any(
    (ControlSpec c) => c.name == 'fullWidth' && c.isEditable,
  );
  if (!hasControl) {
    return false;
  }
  return values.getBoolOr('fullWidth', false);
}

/// Synthetic `hasIcon` + `iconPosition` as a leading/trailing Icon arg.
///
/// Returns null when the spec has no synthetic icon controls, when the
/// toggle is off/default, or when the position is unknown. The icon itself
/// is const; the docs page already imports the icon set.
_Arg? _renderIconArg(ComponentControls spec, PlaygroundValues values) {
  final bool hasIconControl = spec.controls.any(
    (ControlSpec c) => c.name == 'hasIcon' && c.isEditable,
  );
  if (!hasIconControl) {
    return null;
  }
  if (!values.getBoolOr('hasIcon', false)) {
    return null;
  }
  final String position = values.getEnum('iconPosition') ?? 'leading';
  if (position == 'trailing') {
    return const _Arg(
      'trailing: const Icon(LucideIcons.chevronRight, size: 16)',
      isConst: true,
    );
  }
  return const _Arg(
    'leading: const Icon(LucideIcons.plus, size: 16)',
    isConst: true,
  );
}

_Arg? _renderArg(ControlSpec control, PlaygroundValues values) {
  switch (control.kind) {
    case ControlKind.toggle:
      final bool? value = values.getBool(control.name);
      if (value == null) {
        return null;
      }
      return _Arg('${control.name}: $value', isConst: true);
    case ControlKind.enabled:
      // `true` plays a no-op press; `false`/`null` omit the callback (the
      // constructor default is already null).
      if (values.getBoolOr(control.name, true)) {
        return const _Arg('onPressed: () {}', isConst: false);
      }
      return null;
    case ControlKind.select:
      final String? value = values.getEnum(control.name);
      if (value == null) {
        return null;
      }
      return _Arg(
        '${control.name}: ${enumBaseType(control.type)}.$value',
        isConst: true,
      );
    case ControlKind.text:
      final String? value = values.getString(control.name);
      if (value == null) {
        return null;
      }
      final String literal = _quote(value);
      if (control.type == 'String') {
        return _Arg('${control.name}: $literal', isConst: true);
      }
      final String text = 'Text($literal)';
      if (control.isBuilder) {
        return _Arg('${control.name}: (context) => $text', isConst: false);
      }
      return _Arg('${control.name}: $text', isConst: true);
    case ControlKind.slider:
      final Object? raw = values.valueOf(control.name);
      if (raw is! num) {
        return null;
      }
      final String literal = control.isInt
          ? '${raw.round()}'
          : _formatDouble(raw.toDouble());
      return _Arg('${control.name}: $literal', isConst: true);
    case ControlKind.colorToken:
      final String? token = values.getToken(control.name);
      if (token == null) {
        return null;
      }
      return _Arg(
        '${control.name}: Theme.of(context).colors.$token',
        isConst: false,
      );
    case ControlKind.readOnly:
      return null;
  }
}

/// Renders `head(args)`: one line within 80 columns, else tall with trailing
/// commas.
String _renderCall(String head, List<_Arg> args) {
  if (args.isEmpty) {
    return '$head()';
  }
  final String flat = '$head(${args.map((_Arg arg) => arg.source).join(', ')})';
  if (flat.length <= 80) {
    return flat;
  }
  final StringBuffer out = StringBuffer('$head(\n');
  for (final _Arg arg in args) {
    out.writeln('  ${arg.source},');
  }
  out.write(')');
  return out.toString();
}

/// Single-quoted literal: escapes `\`, `'`, `$` and newlines.
String _quote(String value) {
  final String escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\r\n', r'\n')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\n');
  return "'$escaped'";
}

/// Doubles round-trip exactly (`2.0`, never `2` or `2e0`).
String _formatDouble(double value) {
  final String text = value.toString();
  if (text.contains('.')) {
    return text;
  }
  return text.contains('e') ? value.toStringAsFixed(1) : '$text.0';
}
