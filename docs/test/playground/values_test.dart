// Playground values tests: spec defaults and the URL query round-trip.
//
// `p.<name>` carries only non-default entries; unknown keys are ignored and
// unparsable values fall back to the spec default.

import 'package:docs/generated/docs_controls.dart';
import 'package:docs/playground/values.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlaygroundValues', () {
    test('seeds defaults from the button spec', () {
      final ComponentControls spec = kControlSpecs['button']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      expect(values.getBool('enabled'), isTrue);
      expect(values.getEnum('variant'), 'primary');
      expect(values.getEnum('size'), 'md');
      expect(values.getString('child'), 'Button');
      expect(values.getBool('autofocus'), isFalse);
      expect(values.toQuery(spec), isEmpty);
    });

    test('round-trips non-default values through the query', () {
      final ComponentControls spec = kControlSpecs['button']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values
        ..set('variant', 'outline')
        ..set('child', 'Save')
        ..set('enabled', false);
      final Map<String, String> query = values.toQuery(spec);
      expect(query, <String, String>{
        'p.enabled': 'false',
        'p.child': 'Save',
        'p.variant': 'outline',
      });
      final PlaygroundValues restored = PlaygroundValues.fromQuery(spec, query);
      expect(restored.toQuery(spec), query);
      expect(restored.getEnum('variant'), 'outline');
      expect(restored.getString('child'), 'Save');
      expect(restored.getBool('enabled'), isFalse);
    });

    test('ignores unknown keys and falls back on garbage', () {
      final ComponentControls spec = kControlSpecs['slider']!;
      final PlaygroundValues values = PlaygroundValues.fromQuery(
        spec,
        <String, String>{
          'p.value': 'nope',
          'p.variant': 'soft',
          'p.unknown': 'x',
        },
      );
      expect(values.getDouble('value'), 0.0);
      expect(values.getEnum('variant'), 'soft');
      expect(values.toQuery(spec), <String, String>{'p.variant': 'soft'});
    });

    test('round-trips sliders, tokens and toggles', () {
      final ComponentControls spec = kControlSpecs['spinner']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values
        ..set('size', 32.0)
        ..set('strokeWidth', 6.0)
        ..set('color', 'destructive');
      final Map<String, String> query = values.toQuery(spec);
      expect(query['p.size'], '32.0');
      expect(query['p.strokeWidth'], '6.0');
      expect(query['p.color'], 'destructive');
      final PlaygroundValues restored = PlaygroundValues.fromQuery(spec, query);
      expect(restored.getDouble('size'), 32.0);
      expect(restored.getDouble('strokeWidth'), 6.0);
      expect(restored.getToken('color'), 'destructive');
      expect(restored.toQuery(spec), query);
    });

    test('round-trips int sliders and nullable toggles', () {
      final ComponentControls spec = kControlSpecs['pagination']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      expect(values.getInt('page'), 1);
      values
        ..set('page', 4)
        ..set('showLabel', true);
      final Map<String, String> query = values.toQuery(spec);
      expect(query, <String, String>{'p.page': '4', 'p.showLabel': 'true'});
      final PlaygroundValues restored = PlaygroundValues.fromQuery(spec, query);
      expect(restored.getInt('page'), 4);
      expect(restored.getBool('showLabel'), isTrue);
    });

    test('reset restores defaults', () {
      final ComponentControls spec = kControlSpecs['badge']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('showAsDot', true);
      expect(values.toQuery(spec), isNotEmpty);
      values.reset(spec);
      expect(values.toQuery(spec), isEmpty);
      expect(values.getBool('showAsDot'), isFalse);
    });
  });
}
