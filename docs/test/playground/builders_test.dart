// Playground builder tests: the registry holds the expected builders, every
// builder pumps its defaults without throwing, and changing each editable
// control changes the emitted code (which always parses as valid Dart).
//
// Widget-side assertions live in the `builders_*_test.dart` companions: each
// control is read back through finders and widget properties.

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:docs/generated/docs_controls.dart';
import 'package:docs/playground/builder.dart';
import 'package:docs/playground/builders.dart';
import 'package:docs/playground/code.dart';
import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// The 28 components with a hand-written builder (`toggle_group` and `label`
/// have no registry component and stay absent).
const List<String> _builderIds = <String>[
  'accordion',
  'alert',
  'avatar',
  'badge',
  'breadcrumb',
  'button',
  'calendar',
  'card',
  'checkbox',
  'date_picker',
  'dialog',
  'divider',
  'dropdown_menu',
  'form',
  'input',
  'keyboard_shortcut',
  'pagination',
  'popup',
  'progress',
  'radio_group',
  'select',
  'skeleton',
  'slider',
  'spinner',
  'switch',
  'tabs',
  'text_area',
  'toggle',
  'tooltip',
];

/// Companion values shared by the base and probed pumps of [componentId].
///
/// They keep the probed widget in a valid, observable state: the slider
/// triple stays ordered, pagination keeps the page inside its total,
/// progress shows a determinate value. The obscure toggle reveals the
/// masking character; autofocus reveals the focus ring. Button's synthetic
/// `iconPosition` only affects the emitted code when `hasIcon` is on, so
/// its probe context enables the icon.
Map<String, Object?> _contextFor(String componentId, String probed) {
  if ((componentId == 'input' || componentId == 'text_area') &&
      probed == 'obscuringCharacter') {
    return <String, Object?>{'obscureText': true};
  }
  if ((componentId == 'input' || componentId == 'text_area') &&
      probed == 'showFocusRing') {
    return <String, Object?>{'autofocus': true};
  }
  if (componentId == 'button' && probed == 'iconPosition') {
    return <String, Object?>{'hasIcon': true};
  }
  return switch (componentId) {
    'slider' => <String, Object?>{'value': 5.0, 'min': 0.0, 'max': 10.0},
    'pagination' => <String, Object?>{'totalPages': 10},
    'progress' => <String, Object?>{'value': 0.5},
    _ => <String, Object?>{},
  };
}

/// A probe for [control] that differs from its [base] value and keeps the
/// component's cross-param invariants (slider ordering, page range).
Object? _probeFor(String componentId, ControlSpec control, Object? base) {
  if (componentId == 'slider') {
    return switch (control.name) {
      'value' => 8.0,
      'min' => 2.0,
      'max' => 7.0,
      _ => _genericProbe(control, base),
    };
  }
  if (componentId == 'pagination' && control.name == 'page') {
    return 5;
  }
  if (componentId == 'pagination' && control.name == 'totalPages') {
    return 7;
  }
  if (componentId == 'date_picker' && control.name == 'mode') {
    // The effective default is `dialog`; only `popover` is observable.
    return 'popover';
  }
  if (componentId == 'date_picker' && control.name == 'initialViewType') {
    // The effective default is `date`.
    return 'month';
  }
  return _genericProbe(control, base);
}

/// A probe that differs from [base] (null when the control has no options).
Object? _genericProbe(ControlSpec control, Object? base) {
  switch (control.kind) {
    case ControlKind.toggle:
    case ControlKind.enabled:
      // Null usually matches the on-state visually (enabled, unfilled);
      // probe off first and let the test retry on when the tree is equal.
      return base == false ? true : false;
    case ControlKind.select:
      for (final String option in control.options) {
        if (option != base) {
          return option;
        }
      }
      return null;
    case ControlKind.text:
      return base == 'Playground probe' ? 'Probe text' : 'Playground probe';
    case ControlKind.slider:
      if (control.isInt) {
        final int max = control.max?.round() ?? 100;
        final int min = control.min?.round() ?? 0;
        return base == max ? min : max;
      }
      final double max = control.max ?? 10.0;
      final double min = control.min ?? 0.0;
      return base == max ? min : max;
    case ControlKind.colorToken:
      return base == 'primary' ? 'destructive' : 'primary';
    case ControlKind.readOnly:
      return null;
  }
}

Widget _frame(Widget child) {
  return Theme(
    data: const ThemeData(),
    child: ComponentThemes(
      themes: const <ComponentThemeData>[],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: child),
      ),
    ),
  );
}

Future<void> _pumpBuilder(
  WidgetTester tester,
  PlaygroundBuilder builder,
  PlaygroundValues values,
) async {
  await tester.pumpWidget(
    _frame(
      Builder(builder: (BuildContext context) => builder(context, values)),
    ),
  );
  await tester.pump();
}

void _expectValidDart(String code) {
  // Snippets are expressions: wrap the call in a function body so the
  // compilation-unit parser checks syntax (unresolved identifiers are
  // fine; only syntax errors surface).
  final int split = code.indexOf('\n\n');
  expect(split, isNot(-1), reason: 'missing import/call split: $code');
  final String unit =
      '${code.substring(0, split)}\n'
      'void _playgroundProbe() {\n'
      '  ${code.substring(split).trim()};\n'
      '}\n';
  final parse = parseString(content: unit, throwIfDiagnostics: false);
  expect(parse.errors, isEmpty, reason: code);
}

void main() {
  test('registry holds exactly the expected builders', () {
    expect(kPlaygroundBuilders.keys.toSet(), _builderIds.toSet());
    for (final String id in _builderIds) {
      expect(kControlSpecs[id], isNotNull, reason: id);
    }
  });

  for (final String id in _builderIds) {
    group('builder $id', () {
      testWidgets('builds defaults and emits valid code', (
        WidgetTester tester,
      ) async {
        final ComponentControls spec = kControlSpecs[id]!;
        final PlaygroundBuilder builder = kPlaygroundBuilders[id]!;
        final PlaygroundValues values = PlaygroundValues.defaults(spec);
        final String code = emitCode(spec, values);
        _expectValidDart(code);
        expect(code, startsWith("import 'package:dashcn/components/$id.dart'"));
        // Pumping must not throw (asserts, missing params, bad defaults).
        await _pumpBuilder(tester, builder, values);
      });

      for (final ControlSpec control in kControlSpecs[id]!.editable) {
        test('control ${control.name} changes the emitted code', () {
          final ComponentControls spec = kControlSpecs[id]!;
          final PlaygroundValues base = PlaygroundValues.defaults(spec);
          base.addAll(_contextFor(id, control.name));
          final PlaygroundValues probed = PlaygroundValues.defaults(spec);
          probed.addAll(_contextFor(id, control.name));
          final Object? probe = _probeFor(
            id,
            control,
            probed.valueOf(control.name),
          );
          expect(probe, isNotNull, reason: '${control.name} has no probe');
          probed.set(control.name, probe);

          final String baseCode = emitCode(spec, base);
          final String probedCode = emitCode(spec, probed);
          expect(probedCode, isNot(equals(baseCode)), reason: 'code');
          _expectValidDart(probedCode);
        });
      }
    });
  }
}
