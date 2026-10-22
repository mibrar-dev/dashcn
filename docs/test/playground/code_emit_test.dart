// Code emission unit tests: defaults omitted, enum qualification, string
// escaping, const handling, 80-column wrapping and the import line.
//
// Fixtures are hand-built so the tests pin the emitter contract without
// depending on the generated specs; one test pins the real button spec.

import 'package:docs/generated/docs_controls.dart';
import 'package:docs/playground/code.dart';
import 'package:docs/playground/values.dart';
import 'package:flutter_test/flutter_test.dart';

ComponentControls _spec({
  String symbol = 'Button',
  bool isConst = true,
  List<ControlSpec> controls = const <ControlSpec>[],
}) {
  return ComponentControls(
    componentId: 'button',
    symbol: symbol,
    import: 'package:dashcn/components/button.dart',
    isConst: isConst,
    controls: controls,
  );
}

const ControlSpec _variant = ControlSpec(
  name: 'variant',
  label: 'Variant',
  kind: ControlKind.select,
  type: 'ButtonVariant',
  isRequired: false,
  defaultValue: 'primary',
  options: <String>['primary', 'outline'],
);

const ControlSpec _enabled = ControlSpec(
  name: 'enabled',
  label: 'Enabled',
  kind: ControlKind.enabled,
  type: 'bool',
  isRequired: true,
  defaultValue: 'true',
);

void main() {
  group('emitCode', () {
    test('omits defaults and keeps the import line', () {
      final ComponentControls spec = _spec(controls: <ControlSpec>[_variant]);
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        'const Button()\n',
      );
    });

    test('qualifies enums and drops const for callbacks', () {
      final ComponentControls spec = _spec(
        controls: <ControlSpec>[_variant, _enabled],
      );
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('variant', 'outline');
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        'Button(variant: ButtonVariant.outline, onPressed: () {})\n',
      );
    });

    test('disabled omits the press callback and stays const', () {
      final ComponentControls spec = _spec(
        controls: <ControlSpec>[_variant, _enabled],
      );
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('enabled', false);
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        'const Button()\n',
      );
    });

    test('escapes strings', () {
      const ControlSpec label = ControlSpec(
        name: 'label',
        label: 'Label',
        kind: ControlKind.text,
        type: 'String',
        isRequired: false,
      );
      final ComponentControls spec = _spec(controls: <ControlSpec>[label]);
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('label', "it's \$5\nok\\");
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        r"const Button(label: 'it\'s \$5\nok\\')"
        '\n',
      );
    });

    test('wraps widget text in Text', () {
      const ControlSpec child = ControlSpec(
        name: 'child',
        label: 'Child',
        kind: ControlKind.text,
        type: 'Widget',
        isRequired: true,
      );
      final ComponentControls spec = _spec(controls: <ControlSpec>[child]);
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        "const Button(child: Text(''))\n",
      );
    });

    test('wraps builder text in a closure without const', () {
      const ControlSpec tip = ControlSpec(
        name: 'tooltip',
        label: 'Tooltip',
        kind: ControlKind.text,
        type: 'WidgetBuilder',
        isRequired: true,
        isBuilder: true,
      );
      final ComponentControls spec = _spec(controls: <ControlSpec>[tip]);
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('tooltip', 'Hi');
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        "Button(tooltip: (context) => Text('Hi'))\n",
      );
    });

    test('emits tokens and doubles exactly', () {
      const ControlSpec color = ControlSpec(
        name: 'color',
        label: 'Color',
        kind: ControlKind.colorToken,
        type: 'Color?',
        isRequired: false,
        options: <String>['primary', 'destructive'],
      );
      const ControlSpec size = ControlSpec(
        name: 'size',
        label: 'Size',
        kind: ControlKind.slider,
        type: 'double?',
        isRequired: false,
        min: 0,
        max: 64,
        step: 1,
      );
      final ComponentControls spec = _spec(
        controls: <ControlSpec>[color, size],
      );
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('color', 'primary');
      values.set('size', 32.0);
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        'Button(color: Theme.of(context).colors.primary, size: 32.0)\n',
      );
    });

    test('wraps past 80 columns with trailing commas', () {
      const ControlSpec first = ControlSpec(
        name: 'first',
        label: 'First',
        kind: ControlKind.text,
        type: 'String',
        isRequired: false,
      );
      const ControlSpec second = ControlSpec(
        name: 'second',
        label: 'Second',
        kind: ControlKind.text,
        type: 'String',
        isRequired: false,
      );
      final ComponentControls spec = _spec(
        controls: <ControlSpec>[first, second],
      );
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('first', 'a fairly long first value here');
      values.set('second', 'another long second value here');
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        'const Button(\n'
        "  first: 'a fairly long first value here',\n"
        "  second: 'another long second value here',\n"
        ')\n',
      );
    });

    test('single line within 80 columns', () {
      final ComponentControls spec = _spec(controls: <ControlSpec>[_variant]);
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('variant', 'outline');
      final String code = emitCode(spec, values);
      expect(code, contains('const Button(variant: ButtonVariant.outline)'));
      expect(code, isNot(contains(',\n')));
    });

    test('button spec: defaults emit only child and press callback', () {
      final ComponentControls spec = kControlSpecs['button']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      expect(
        emitCode(spec, values),
        "import 'package:dashcn/components/button.dart';\n\n"
        "Button(onPressed: () {}, child: Text('Button'))\n",
      );
    });

    test('button synthetic hasIcon/iconPosition/fullWidth/status emit', () {
      final ComponentControls spec = kControlSpecs['button']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      // Icon off by default: no leading/trailing.
      expect(emitCode(spec, values), isNot(contains('leading:')));
      expect(emitCode(spec, values), isNot(contains('trailing:')));
      // Icon on (leading default) emits leading.
      values.set('hasIcon', true);
      expect(
        emitCode(spec, values),
        contains('leading: const Icon(LucideIcons.plus, size: 16)'),
      );
      // Trailing position emits trailing instead.
      values.set('iconPosition', 'trailing');
      final String trailingCode = emitCode(spec, values);
      expect(
        trailingCode,
        contains('trailing: const Icon(LucideIcons.chevronRight, size: 16)'),
      );
      expect(trailingCode, isNot(contains('leading:')));
      // Full width wraps the call.
      values.set('iconPosition', 'leading');
      values.set('fullWidth', true);
      expect(
        emitCode(spec, values),
        contains('SizedBox(width: double.infinity, child: Button('),
      );
      // Loading status emits the enum.
      values.set('fullWidth', false);
      values.set('hasIcon', false);
      values.set('status', 'loading');
      expect(emitCode(spec, values), contains('status: ButtonStatus.loading'));
    });

    test('optional text at its default is omitted', () {
      final ComponentControls spec = kControlSpecs['select']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      // The placeholder defaults to the typing prompt; at its default the
      // snippet omits it, and a custom value emits it.
      expect(values.getString('placeholder'), 'Type here…');
      expect(emitCode(spec, values), isNot(contains('placeholder')));
      values.set('placeholder', 'Pick one');
      expect(emitCode(spec, values), contains("placeholder: Text('Pick one')"));
    });
  });
}
